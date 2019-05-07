# Uncomment run comment again. run twice. verify loandisbursement : Loanid specifically. 
 
 #Remove-Item -Path "D:\CUFX work folder\CUFX_4_2_1\CUFX_4.2_Schemas\*.txt"

# STEP 1 Build all the simple types

$switch = 'OFF'
$DocuSwitch = 'OFF'
$seperator = '"'
$seperator2 = '>'
$seperator3 = '<'
$seperator4 = ':'
$counter = 0
# $content = Get-Content *.xsd
$outputLine = ''
$printedSwitch =' No'
$DocumentationPart = ''
$filename = ''
$formatType = ''
$enumIndex = 0
$enumIndexMax = 0
[string[]]$SimpleEnum = @(1..400)

$Specification =''
$SimpleName =''
$SimpleType ='BROKEN'
$minOccurs = ''
$maxOccurs = ''
$LookUpFileName=''






#$filelist = Get-ChildItem -path "D:\CUFX work folder\CUFX_4_2_1\CUFX_4.2_Schemas\Loandisbursement.xsd"
$filelist = Get-ChildItem -path "D:\CUFX work folder\CUFX_4_2_1\CUFX_4.2_Schemas\*.xsd"

foreach ($item in $filelist)
{
if ($item.attributees -ne "Directory")
    {
    echo $item.Name
    $content = Get-Content $item.Name
    $Specification = $item.Name
    }
 


foreach ($line in $content)
{ 
# Write-Host "Line: " $line

    
  
  if ($line -match '<xs:simpleType')
  {
     $switch = "On"  # in the simple type
     $parts = $line.split($seperator)
     #echo $parts[0] 
     #echo $parts[1]# element name
     #echo $parts[2] 
     #echo $parts[3]# Type
     #echo $parts[4]
     $outputLine = ''
     #$outputLine = $item.Name + "|" + $parts[1] + "|" + "simpleType" 
     $LookUpType = $parts[3]
     $SimpleName = $parts[1]    # set the Simple name
     $SimpleType = ''

     If ($SimpleName -eq 'ExtendedAction')
       {
        # this is a patch for union of action and extended action. which is an enumerated string with pattern extension. yaml does not handle patterns.  
        $SimpleType = 'type: string'
        }  
     $printedSwitch =' No' # reset print switch
     $DocumentationPart = ''
      }

  if ($line -match 'xs:restriction base')
  {
     $parts = $line.split($seperator)
     #echo $parts[1]# element name
     #$outputLine = $item.Name + "|" + $parts[1] + "|" + "simpleType" 
     $LookUpType = $parts[1]
      }

  if ($line -Match  '</xs:documentation')
    { 
    $DocuSwitch = 'OFF'
    }

  if ($line -Match  '</xs:simpleType')
    { $switch = 'OFF'
   

       # Write out the entire defintion

       $filenameTemp =  $Specification + "." + $SimpleName + ".txt"

       $filename = $filenameTemp.ToLower()

       echo $filename
      # Uncomment to verify Simple type name in the file 
       
       $outputLine = $SimpleName + ":"
       $outputLine | Out-File $filename


       #*****
       if ($SimpleType -ne "")
       {
         $outputLine = "  " + $Simpletype
         $outputLine | Out-File $filename -Append
           
            }
       else 
       {
       Echo "***  Fixed  :  $SimpleName"
       #Echo "*** Lookuptype  $LookUpType"

                    IF ($LookUpType -Match  ':')
                    {
                     
                     
                     $parts4 = $LookUpType.split($seperator4)

                     #Fix Abbreviations
                     $LookupSpec = $parts4[0]
                     if ($LookupSpec -eq 'credential')
                     {
                       $LookupSpec = "CredentialGroup"
                     }
                     if ($LookupSpec -eq 'question')
                     {
                       $LookupSpec = "QuestionList"
                     }
                     if ($LookupSpec -eq 'credit')
                     {
                       $LookupSpec = "CreditReport"
                     }
                     if ($LookupSpec -eq 'isoCountryCodeType')
                     {
                       $LookupSpec = "ISOCountryCodeType-V2006"
                     }
                     if ($LookupSpec -eq 'eligibility')
                     {
                       $LookupSpec = "EligibilityRequirement"
                     }
                     if ($LookupSpec -eq 'overdraftPriority')
                     {
                       $LookupSpec = "OverdraftPriorityList"
                     }
                     if ($LookupSpec -eq 'overdraftPriorityFilter')
                     {
                       $LookupSpec = "OverdraftPriorityListFilter"
                     }
                     if ($LookupSpec -eq 'overdraft')
                     {
                       $LookupSpec = "OverdraftPriorityList"
                     }

                     #FIX Abbreviations end


                     $LookUpFileName= $LookupSpec + ".xsd." + $parts4[1] + ".txt"
                     $LookUpTypeTemp = $parts4[1]

                    }
                 else
                    {
                     $LookUpFileName= $Specification + "." + $LookUpType + ".txt"
                     $LookUpTypeTemp = $LookUpType
                    }

                 $LookUpFileName = $LookUpFileName.ToLower()

                 $LookUpFileNameTemp = $LookUpFileName 
                  
                 echo  "LookUpFileNameTemp : $LookUpFileNameTemp "
                          
                 $content7 = Get-Content $LookUpFileNameTemp
                 #echo $content7
                 $counter = 0
                 foreach ($line7 in $content7)
                     {
                     #   echo  $line7
                        $skipline = 'FALSE'
                        $counter = $counter + 1
                        #IF (($counter -eq  '1') -or ($counter -eq  '2'))
                        IF ($counter -eq  '1') 
                            {
                             # Skip the header line                      
                             $skipline = 'TRUE'
                             }
                        IF (($counter -eq  '3') -or ($counter -eq  '4') -or ($counter -eq  '5'))
                            {
                             IF (($line7 -Match  'properties:') -or ($line7 -Match  'description:'))
                              { 
                              $skipline = 'TRUE'
                              }
                             }
                        IF ($skipline -Match  'FALSE')
                            {
                             # Print the rest of the file adjusting indent by 2
                             $outputLine =  $line7
                             $outputLine | Out-File $filename -Append
                            }
                     }
       }
       #*****


 

      $SimpleType = 'BROKEN'

       if ($formatType -ne "")
            {
             $outputLine =  "  " + $formatType
             $outputLine | Out-File $filename -Append
             $formatType = ''

            }

       
       if ($DocumentationPart -ne "")
         {
           ## Remove quoations and special characters
          $DocumentationPart = $DocumentationPart -replace "[']",''
          $DocumentationPart = $DocumentationPart -replace '["]'.''

          $outputLine =  "  " + "description: '" + $DocumentationPart + "'"
          $outputLine | Out-File $filename -Append
  
         # $outputLine =  "    " + $DocumentationPart
         # $outputLine | Out-File $filename -Append
          $DocumentationPart = ''
          }
       $enumIndex = 0
       if ($enumIndexMax -gt 0)
   #     
         { 
            $outputLine =  "  " + "enum:"
            $outputLine | Out-File $filename -Append
            for ($enumIndex=0; $enumIndex -lt $enumIndexMax;$enumIndex++)
            {
              $outputLine =  "  " + "- " + $SimpleEnum[$enumIndex]
              $outputLine | Out-File $filename -Append

            }

         }

       #reset the enum index
       $enumIndexMax = 0
       $enumIndex = 0

    }
    
# Format type conversions.
    if ($line -Match  'restriction base="xs:string')
    { 
       
       $SimpleType = 'type: string'
  
       # echo $SimpleType
  
    }

    if ($line -Match  'restriction base = "xs:string')
    { 
       
       $SimpleType = 'type: string'
  
       # echo $SimpleType
  
    }

  if ($line -Match  '<xs:restriction base="xs:string"')
    { 
       
       $SimpleType = 'type: string'
  
       # echo $SimpleType
  
    }

  if ($line -Match  '<xs:restriction base ="xs:string"')
    { 
       
       $SimpleType = 'type: string'

       # echo $SimpleType

    }
  if ($line -Match  '<xs:restriction base= "xs:string"')
    { 
       
       $SimpleType = 'type: string'

       # echo $SimpleType

    }

  if ($line -Match  '<xs:restriction base="xs:boolean"')
    { 
       
       $SimpleType = 'type: boolean'
  
      # echo $SimpleType
  
    }

  if ($line -Match  '<xs:restriction base ="xs:boolean" />')
    { 
       
       $SimpleType = 'type: boolean'

      # echo $SimpleType

    }
  if ($line -Match  '<xs:restriction base= "xs:boolean" />')
    { 
       
       $SimpleType = 'type: boolean'

      # echo $SimpleType

    }
  if ($line -Match  '<xs:restriction base="xs:dateTime"')
    { 
       
       $SimpleType = 'type: string'
       $formatType = 'format: datetime'
  
   #    echo $SimpleType
  
    }
  if ($line -Match  '<xs:restriction base= "xs:dateTime"')
    { 
       
       $SimpleType = 'type: string'
       $formatType = 'format: datetime'
  
   #    echo $SimpleType
  
    }
  if ($line -Match  '<xs:restriction base ="xs:dateTime"')
    { 
       
       $SimpleType = 'type: string'
       $formatType = 'format: datetime'
  
   #    echo $SimpleType
  
    }

  if ($line -Match  '<xs:restriction base="xs:decimal"')
    { 
       
       $SimpleType = 'type: number'
       $formatType = 'format: decimal'

      # echo $SimpleType

    }

  if ($line -Match  '<xs:restriction base ="xs:decimal"')
    { 
       
       $SimpleType = 'type: number'
       $formatType = 'format: decimal'

      # echo $SimpleType

    }
  if ($line -Match  '<xs:restriction base= "xs:decimal"')
    { 
       
       $SimpleType = 'type: number'
       $formatType = 'format: decimal'

      # echo $SimpleType

    }
  if ($line -Match  '<xs:restriction base="xs:integer"')
    { 
       
       $SimpleType = 'type: integer'


      # echo $SimpleType

    }

  if ($line -Match  '<xs:restriction base ="xs:integer"')
    { 
       
       $SimpleType = 'type: integer'

      # echo $SimpleType

    }
  if ($line -Match  '<xs:restriction base= "xs:integer"')
    { 
       
       $SimpleType = 'type: integer'

      # echo $SimpleType

    }
  if ($line -Match  '<xs:restriction base="xs:int"')
    { 
       
       $SimpleType = 'type: integer'


      # echo $SimpleType

    }

  if ($line -Match  '<xs:restriction base ="xs:int"')
    { 
       
       $SimpleType = 'type: integer'

      # echo $SimpleType

    }
  if ($line -Match  '<xs:restriction base= "xs:int"')
    { 
       
       $SimpleType = 'type: integer'

      # echo $SimpleType

    }

  if ($line -Match  '<xs:restriction base="xs:NMTOKEN"')
    { 
       
       $SimpleType = 'type: string'
       $formatType = 'format: NMTOKEN'
  
   #    echo $SimpleType
  
    }
  if ($line -Match  '<xs:restriction base ="xs:NMTOKEN"')
    { 
       
       $SimpleType = 'type: string'
       $formatType = 'format: NMTOKEN'
  
   #    echo $SimpleType
  
    }
  if ($line -Match  '<xs:restriction base= "xs:NMTOKEN"')
    { 
       
       $SimpleType = 'type: string'
       $formatType = 'format: NMTOKEN'
  
   #    echo $SimpleType
  
    }
  if ($line -Match  '<xs:restriction base="xs:anyURI"')
    { 
       
       $SimpleType = 'type: string'
       $formatType = 'format: anyURI'
  
   #    echo $SimpleType
  
    }
  if ($line -Match  '<xs:restriction base ="xs:anyURI"')
    { 
       
       $SimpleType = 'type: string'
       $formatType = 'format: anyURI'
  
   #    echo $SimpleType
  
    }
  if ($line -Match  '<xs:restriction base= "xs:anyURI"')
    { 
       
       $SimpleType = 'type: string'
       $formatType = 'format: anyURI'
  
   #    echo $SimpleType
  
    }
  if ($line -Match  '<xs:restriction base="xs:float"')
    { 
       
       $SimpleType = 'type: number'
       $formatType = 'format: float'

      # echo $SimpleType

    }

  if ($line -Match  '<xs:restriction base ="xs:float"')
    { 
       
       $SimpleType = 'type: number'
       $formatType = 'format: float'

      # echo $SimpleType

    }
  if ($line -Match  '<xs:restriction base= "xs:float"')
    { 
       
       $SimpleType = 'type: number'
       $formatType = 'format: float'

      # echo $SimpleType

    }
  if ($line -Match  '<xs:restriction base="xs:NMTOKEN"')
    { 
       
       $SimpleType = 'type: string'
       $formatType = 'format: NMTOKEN'

      # echo $SimpleType

    }

  if ($line -Match  '<xs:restriction base ="xs:NMTOKEN"')
    { 
       
       $SimpleType = 'type: string'
       $formatType = 'format: NMTOKEN'

      # echo $SimpleType

    }
  if ($line -Match  '<xs:restriction base= "xs:NMTOKEN"')
    { 
       
       $SimpleType = 'type: string'
       $formatType = 'format: NMTOKEN'

      # echo $SimpleType

    }
   if ($line -Match  '<xs:restriction base="xs:TOKEN"')
    { 
       
       $SimpleType = 'type: string'
       $formatType = 'format: TOKEN'

      # echo $SimpleType

    }
   if ($line -Match  '<xs:restriction base= "xs:TOKEN"')
    { 
       
       $SimpleType = 'type: string'
       $formatType = 'format: TOKEN'

      # echo $SimpleType

    }


  if ($line -Match  '<xs:enumeration')
    { 

    $parts = $line.split($seperator)
  #  echo $parts[1]
    
    $SimpleEnum[$enumIndex] = $parts[1]  
 #   echo 'index : ' $enumIndex  

  #  echo $SimpleEnum[$enumIndex] 
 
    $enumIndex = $enumIndex + 1
    $enumIndexMax = $enumIndex
 #   echo 'index Max : ' $enumIndexMax 
    }

#Write-Host "switch: " $switch

  if ($DocuSwitch -match 'ON' -and $switch -match 'ON')
    {
    $DocumentationPart = $DocumentationPart + $line.Trim() + " "
    # $line | Out-File 'SwaggerOutput.txt' -Append
    }
  
  if ($line -Match '<xs:documentation')
    {$DocuSwitch = 'ON'
    
       if ($line -Match '</xs:documentation' -and $switch -match 'ON')
       {
       # Single line comment open/closing tags     
       $part2 = $line.split($seperator2)
       $DocoSegement1 = $part2[1]
       $DocumentationPart = $DocoSegement1.split($seperator3) 

      # $outputLine =  "description: >-"
      # $outputLine | Out-File $filename -Append

      # $outputLine =  "  " + $DocumentationPart
      # $outputLine | Out-File $filename -Append
       $DocuSwitch = 'OFF'
       $switch = 'OFF'
       }
    
    }


 }
 
 } 