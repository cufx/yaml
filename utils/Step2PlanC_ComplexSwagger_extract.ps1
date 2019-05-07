# Step 2 build the complex types;  run (6) SIX  times for a clean execution

$switch = 'OFF'
$DocuSwitch = 'OFF'
$seperator = '"'
$seperator3 = ':'
$counter = 0
# $content = Get-Content Ar*.xsd
$outputLine = ''
$printSwitch ='NO'
$DocumentationPart = ''
$filename = ''
$formatType = ''
$enumIndex = 0
$enumIndexMax = 0
[string[]]$SimpleEnum = @(1..500)
$PrintOneDocuLine = 'TRUE'
$Specification =''
$SimpleName =''
$LookUpFileName=''
$ComplexName =''
$SimpleType =''
$ComplexType =''
$ElementName ='' 
$IsByReference = "FALSE"
$IsChoice = "FALSE"
$ElementType = ''
$minOccurs = ''
$maxOccurs = ''
$FirstElement='TRUE'
$extensionSwitch ='FALSE'

#  Create MasterReference 
$outputLine2 = 'messagecontext.xsd.messagecontext.txt' 
$outputLine2 | Out-File MasterReference.txt 


#filelist = Get-ChildItem -path "D:\CUFX work folder\CUFX_4_2_1\CUFX_4.2_Schemas\Loandisbursement.xsd"
$filelist = Get-ChildItem -path "D:\CUFX work folder\CUFX_4_2_1\CUFX_4.2_Schemas\*.xsd"
foreach ($item in $filelist)
{
if ($item.attributees -ne "Directory")
    {
    echo $item.Name
    $content = Get-Content $item.Name
    $Specification = $item.Name

    #echo "XSD File >> " $Specification
    }
 
 #$counter =0

foreach ($line in $content)
{ 
 #echo "XSD File >> " $line

 #$counter = $counter +1
 #echo "line number: $counter"  
    
  if ($line -match '<xs:extension base')
    {
    $extensionSwitch = 'TRUE'
    $Extensionparts = $line.split($seperator)
    $ExtensionLookUpType = $Extensionparts[1]
    }

 #if ($line -match '<xs:choice')
 #   {
 #    $IsChoice = "TRUE"
 #
 #    }

  if ($line -match '<xs:complexType')
  {
     $IsChoice = "FALSE" 
     $switch = "ON"  # in the complex type
     $parts = $line.split($seperator)
     #echo $parts[0] 
     #echo $parts[1]# element name
     #echo $parts[2] 
     #echo $parts[3]# Type
     #echo $parts[4]
     #$outputLine = ''
     #$outputLine = $item.Name + "|" + $parts[1] + "|" + "simpleType" 
     
     $ComplexName = $parts[1]    # set the Simple name
     $ComplexType = ''
     #echo 'ComplexName:' $ComplexName

     #reset the enum index
       $enumIndexMax = 0
       $enumIndex = 0
     $printSwitch ='YES'
     $DocumentationPart = ''
     $FirstElement = 'TRUE'
     #set output file name

     $filenameTemp =  $Specification + "." + $ComplexName + ".txt"

     $filename = $filenameTemp.ToLower()

#########################
     # If message write to reference

     #if ($filename -Match  'message.txt') 
      #   {   
       #   $outputLine2 = $Specification + "." + $ComplexName
        #  $outputLine2 | Out-File MasterReference.txt -append
        # }

############################

     #Remove-Item -Path "C:\Users\dlacroix\Documents\CUFX\RFC 3_3 Work area\CUFX_3.3_Schemas\$filename"

     echo 'FILENAME:' $filename 
     $outputLine = $ComplexName + ":"
     $outputLine | Out-File $filename

        # Need more on type  object versus Array

     #$outputLine = "  " + "type: object"
     #$outputLine | Out-File $filename -Append
   

     #$outputLine = "  " + "properties:"
     #$outputLine | Out-File $filename -Append


      }

   if ($line -Match  '<xs:element') 
    { 
          $IsShortElement = "FALSE"
          if ($line -Match  '/>')
          {
          echo "broken here fix later"
          $IsShortElement = "TRUE"
          }
       $SimpleType = '' 
       $minOccurs = ''
       $maxOccurs = ''
       $IsByReference = 'FALSE'

        $parts = $line.split($seperator)
        #echo $parts[0] 
        #echo $parts[1]# element name
        #echo $parts[2] 
      #  echo "Type is : " $parts[3] # Type
       # echo   $parts[4]
       # echo "Minimum : "$parts[5]
       # echo   $parts[6]
       # echo "Maximun : "$parts[7]

       $LookUpType = $parts[3]
       $minOccurs = $parts[5]
       $maxOccurs = $parts[7]

       $IsArray = 'FALSE'
       if ($maxOccurs -eq 'UNBOUNDED')
            {
            $IsArray = 'TRUE' 
            }

        #$outputLine = ''   
       $ElementName = $parts[1]    # set the Simple name

     #echo "element name :" $ElementName
     #echo "Type :" $LookUpType

  if ($line -Match  'type="xs:string"')
    { 
       
       $SimpleType = 'type: string'
  
     #  echo $SimpleType
  
    }

  if ($line -Match  'type= "xs:string"')
    { 
       
       $SimpleType = 'type: string'

      # echo $SimpleType

    }
  if ($line -Match  'type ="xs:string"')
    { 
       
       $SimpleType = 'type: string'

      # echo $SimpleType

    }

  if ($line -Match  'type="xs:boolean"')
    { 
       
       $SimpleType = 'type: boolean'
  
      # echo $SimpleType
  
    }

  if ($line -Match  'type= "xs:boolean"')
    { 
       
       $SimpleType = 'type: boolean'

      # echo $SimpleType

    }
  if ($line -Match  'type ="xs:boolean"')
    { 
       
       $SimpleType = 'type: boolean'

      # echo $SimpleType

    }
  if ($line -Match  'type="xs:dateTime"')
    { 
       
       $SimpleType = 'type: string'
       $formatType = 'format: datetime'
  
      # echo $SimpleType
  
    }

  if ($line -Match  '<type= "xs:dateTime"')
    { 
       
       $SimpleType = 'type: string'
       $formatType = 'format: datetime'

      # echo $SimpleType

    }
  if ($line -Match  '<type ="xs:dateTime"')
    { 
       
       $SimpleType = 'type: string'
       $formatType = 'format: datetime'

      # echo $SimpleType

    }

  if ($line -Match  'type="xs:date"')
    { 
       
       $SimpleType = 'type: string'
       $formatType = 'format: date'
  
      # echo $SimpleType
  
    }

  if ($line -Match  '<type= "xs:date"')
    { 
       
       $SimpleType = 'type: string'
       $formatType = 'format: date'

      # echo $SimpleType

    }
  if ($line -Match  '<type ="xs:date"')
    { 
       
       $SimpleType = 'type: string'
       $formatType = 'format: date'

      # echo $SimpleType

    }

  if ($line -Match  'type="xs:positiveInteger"')
    { 
       
       $SimpleType = 'type: integer'
       $formatType = 'format: positiveInteger'
  
       #echo $SimpleType
  
    }

  if ($line -Match  '<type= "xs:positiveInteger"')
    { 
       
       $SimpleType = 'type: integer'
       $formatType = 'format: positiveInteger'

      # echo $SimpleType

    }
  if ($line -Match  '<type ="xs:positiveInteger"')
    { 
       
       $SimpleType = 'type: integer'
       $formatType = 'format: positiveInteger'

      # echo $SimpleType

    }

  if ($line -Match  'type="xs:nonNegativeInteger"')
    { 
       
       $SimpleType = 'type: integer'
       $formatType = 'format: nonNegativeInteger'
  
       #echo $SimpleType
  
    }

  if ($line -Match  '<type= "xs:nonNegativeInteger"')
    { 
       
       $SimpleType = 'type: integer'
       $formatType = 'format: nonNegativeInteger'

      # echo $SimpleType

    }
  if ($line -Match  '<type ="xs:nonNegativeInteger"')
    { 
       
       $SimpleType = 'type: integer'
       $formatType = 'format: nonNegativeInteger'

      # echo $SimpleType

    }
  if ($line -Match  'type="xs:decimal"')
    { 
       
       $SimpleType = 'type: number'
  
       #echo $SimpleType
  
    }

  if ($line -Match  'type= "xs:decimal"')
    { 
       
       $SimpleType = 'type: number'

      # echo $SimpleType

    }
  if ($line -Match  'type ="xs:decimal"')
    { 
       
       $SimpleType = 'type: number'

      # echo $SimpleType

    }
  if ($line -Match  'type="xs:integer"')
    { 
       
       $SimpleType = 'type: integer'

  
       #echo $SimpleType
  
    }

  if ($line -Match  'type= "xs:integer"')
    { 
       
       $SimpleType = 'type: integer'


      # echo $SimpleType

    }
  if ($line -Match  'type ="xs:integer"')
    { 
       
       $SimpleType = 'type: integer'


      # echo $SimpleType

    }
  if ($line -Match  'type="xs:int"')
    { 
       
       $SimpleType = 'type: integer'

  
       #echo $SimpleType
  
    }

  if ($line -Match  'type= "xs:int"')
    { 
       
       $SimpleType = 'type: integer'


      # echo $SimpleType

    }
  if ($line -Match  'type ="xs:int"')
    { 
       
       $SimpleType = 'type: integer'


      # echo $SimpleType

    }
  if ($line -Match  'type="xs:anyURI"')
    { 
       
       $SimpleType = 'type: string'
       $formatType = 'format: anyURI'
  
       #echo $SimpleType
  
    }

  if ($line -Match  'type= "xs:anyURI"')
    { 
       
       $SimpleType = 'type: string'
       $formatType = 'format: anyURI'

      # echo $SimpleType

    }
  if ($line -Match  'type ="xs:anyURI"')
    { 
       
       $SimpleType = 'type: string'
       $formatType = 'format: anyURI'

      # echo $SimpleType

    }
  if ($line -Match  'type="xs:duration"')
    { 
       
       $SimpleType = 'type: string'
       $formatType = 'format: duration'
  
       #echo $SimpleType
  
    }

  if ($line -Match  'type= "xs:duration"')
    { 
       
       $SimpleType = 'type: string'
       $formatType = 'format: duration'

      # echo $SimpleType

    }
  if ($line -Match  'type ="xs:duration"')
    { 
       
       $SimpleType = 'type: string'
       $formatType = 'format: duration'

      # echo $SimpleType

    }
  if ($line -Match  'type="xs:base64Binary"')
    { 
       
       $SimpleType = 'type: string'
       $formatType = 'format: base64Binary'
  
       #echo $SimpleType
  
    }

  if ($line -Match  '<type= "xs:base64Binary"')
    { 
       
       $SimpleType = 'type: string'
       $formatType = 'format: base64Binary'

      # echo $SimpleType

    }
  if ($line -Match  '<type ="xs:base64Binary"')
    { 
       
       $SimpleType = 'type: string'
       $formatType = 'format: base64Binary'

      # echo $SimpleType

    }
  if ($line -Match  'type="xs:float"')
    { 
       
       $SimpleType = 'type: number'
       $formatType = 'format: float'
  
       #echo $SimpleType
  
    }

  if ($line -Match  'type= "xs:float"')
    { 
       
       $SimpleType = 'type: number'
       $formatType = 'format: float'

      # echo $SimpleType

    }
  if ($line -Match  'type ="xs:float"')
    { 
       
       $SimpleType = 'type: number'
       $formatType = 'format: float'

      # echo $SimpleType

    }
  if ($line -Match  'type="xs:NMTOKEN"')
    { 
       
       $SimpleType = 'type: string'
       $formatType = 'format: NMTOKEN'
  
      # echo $SimpleType
  
    }

  if ($line -Match  'type= "xs:NMTOKEN"')
    { 
       
       $SimpleType = 'type: string'
       $formatType = 'format: NMTOKEN'

      # echo $SimpleType

    }
    if ($line -Match  'type ="xs:NMTOKEN"')
    { 
       
       $SimpleType = 'type: string'
       $formatType = 'format: NMTOKEN'

      # echo $SimpleType

    }
      if ($line -Match  'type="xs:TOKEN"')
    { 
       
       $SimpleType = 'type: string'
       $formatType = 'format: TOKEN'
  
      # echo $SimpleType
  
    }

  if ($line -Match  'type= "xs:TOKEN"')
    { 
       
       $SimpleType = 'type: string'
       $formatType = 'format: TOKEN'

      # echo $SimpleType

    }
    if ($line -Match  'type ="xs:TOKEN"')
    { 
       
       $SimpleType = 'type: string'
       $formatType = 'format: TOKEN'

      # echo $SimpleType

    }

    if ($line -Match 'type ="xs:time"')
    { 
       
       $SimpleType = 'type: string'
       $formatType = 'format: time'

      # echo $SimpleType

    }
       if ($line -Match 'type= "xs:time"')
    { 
       
       $SimpleType = 'type: string'
       $formatType = 'format: time'

      # echo $SimpleType

    }
        if ($line -Match 'type="xs:time"')
    { 
       
       $SimpleType = 'type: string'
       $formatType = 'format: time'

      # echo $SimpleType

    }

     if ($switch -Match 'ON')
        { 
        if ($FirstElement -match 'TRUE')
          {
          $FirstElement = 'FALSE'
          #Write First part of the file block

          #$outputLine = $ComplexName + ":"
          #$outputLine | Out-File $filename

          # Need more on type  object versus Array

          #$outputLine = "  type: object"
          #$outputLine | Out-File $filename

          $outputLine = "  " + "type: object"
          $outputLine | Out-File $filename -Append

            if ($DocumentationPart -ne "")
                {

              ## Remove quoations and special characters 
              $DocumentationPart = $DocumentationPart -replace "[']",''
              $DocumentationPart = $DocumentationPart -replace '["]'.''

                #$outputLine =  "  " + "description: >-"
                $outputLine =  "  " +  "description: '" + $DocumentationPart + "'"
                $outputLine | Out-File $filename -Append

               # $outputLine =  "  "  + "  " + $DocumentationPart
               # $outputLine | Out-File $filename -Append

                $DocumentationPart = ''
                }

          $outputLine = "  " + "properties:"
          $outputLine | Out-File $filename -Append

    #      if ($IsChoice -eq "TRUE")    #Open API 3 feature
    #        {
    #        $outputLine = "  " + "  " + "oneOf:"
    #        $outputLine | Out-File $filename -Append 
    #        
    #        }

            if ($extensionSwitch -match 'TRUE') 
               {
               # Write the extension now
               $extensionSwitch = 'FALSE'
             #  Write in the extension elements in line 

             #  $outputLine = "  "  + "  " + $ExtensionElementName + ":"
             #  $outputLine | Out-File $filename -Append
             #
             #  $outputLine =  "  "  + "  " + "  "  + "$" + "ref: '#/definitions/" + $ExtensionElementName +"'"
             #  $outputLine | Out-File $filename -Append

#             $ExtensionLookUpType
             ######
                    $LookUpType6 = $ExtensionLookUpType
                    #echo "extension $LookUpType6 " $LookUpType6

                  IF ($LookUpType6 -Match  ':')
                    {
                     $parts4 = $LookUpType6.split($seperator3)

                     #Fix Abbreviations
                     $LookupSpec6 = $parts4[0]
                     if ($LookupSpec6 -eq 'credential')
                     {
                       $LookupSpec6 = "CredentialGroup"
                     }
                     if ($LookupSpec6 -eq 'question')
                     {
                       $LookupSpec6 = "QuestionList"
                     }
                     if ($LookupSpec6 -eq 'credit')
                     {
                       $LookupSpec6 = "CreditReport"
                     }
                     if ($LookupSpec6 -eq 'isoCountryCodeType')
                     {
                       $LookupSpec6 = "ISOCountryCodeType-V2006"
                     }
                     if ($LookupSpec6 -eq 'eligibility')
                     {
                       $LookupSpec6 = "EligibilityRequirement"
                     }
                     if ($LookupSpec6 -eq 'overdraftPriority')
                     {
                       $LookupSpec6 = "OverdraftPriorityList"
                     }
                     if ($LookupSpec6 -eq 'overdraftPriorityFilter')
                     {
                       $LookupSpec6 = "OverdraftPriorityListFilter"
                     }
                     if ($LookupSpec6 -eq 'overdraft')
                     {
                       $LookupSpec6 = "OverdraftPriorityList"
                     }

                     #FIX Abbreviations end


                     $LookUpFileName= $LookupSpec6 + ".xsd." + $parts4[1] + ".txt"
                      
                    }
                 else
                    {
                     $LookUpFileName= $Specification + "." + $LookUpType6 + ".txt"
                    }

                  #echo  $LookUpFileName
          

                #echo $LookUpFileName
                 # $pathfile = "C:\Users\dlacroix\Documents\CUFX\RFC NEXT\" + $LookUpFileName
              #   Echo "extension file name of : " $LookUpFileName  
                   $LookUpFileName = $LookUpFileName.ToLower()

                   $LookUpFileNameTemp = $LookUpFileName 
                          
                 $content7 = Get-Content $LookUpFileNameTemp
                 $counter = 0
                 foreach ($line7 in $content7)
                     {
                     #   echo  $line7
                        $skipline = 'FALSE'
                        $counter = $counter + 1
                        IF (($counter -eq  '1') -or ($counter -eq  '2'))
                            {
                             # Skip the header line and 2nd line                     
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
             ######

               }


            }

        #$switch = "On"  # in the complex type



       $ElementType = ''
       $DocumentationPart = ''

       # Format type conversions.

        }
    }
  
  if ($line -Match  '</xs:documentation')
    { 
    $DocuSwitch = 'OFF'
    }

  if ($line -Match  '</xs:complexType')
    { 
      if ($switch -Match 'ON')
        { 
        if (($FirstElement -match 'TRUE') -and ($extensionSwitch -Match 'TRUE'))  # if still true then no elements in the complextype Write extension base if present
          {
          $outputLine = "  " + "type: object"
          $outputLine | Out-File $filename -Append

            if ($DocumentationPart -ne "")
                {

              ## Remove quoations and special characters 
              $DocumentationPart = $DocumentationPart -replace "[']",''
              $DocumentationPart = $DocumentationPart -replace '["]'.''

                #$outputLine =  "  " + "description: >-"
                $outputLine =  "  " +  "description: '" + $DocumentationPart + "'"
                $outputLine | Out-File $filename -Append

               # $outputLine =  "  "  + "  " + $DocumentationPart
               # $outputLine | Out-File $filename -Append

                $DocumentationPart = ''
                }

          $outputLine = "  " + "properties:"
          $outputLine | Out-File $filename -Append

    #      if ($IsChoice -eq "TRUE")    #Open API 3 feature
    #        {
    #        $outputLine = "  " + "  " + "oneOf:"
    #        $outputLine | Out-File $filename -Append 
    #        
    #        }

               # Write the extension now
               $PrintExtension = 'FALSE'
 
#             $ExtensionLookUpType
             ######
                    $LookUpType6 = $ExtensionLookUpType
                    #echo "extension $LookUpType6 " $LookUpType6

                  IF ($LookUpType6 -Match  ':')
                    {
                     $parts4 = $LookUpType6.split($seperator3)

                     #Fix Abbreviations
                     $LookupSpec6 = $parts4[0]
                     if ($LookupSpec6 -eq 'credential')
                     {
                       $LookupSpec6 = "CredentialGroup"
                     }
                     if ($LookupSpec6 -eq 'question')
                     {
                       $LookupSpec6 = "QuestionList"
                     }
                     if ($LookupSpec6 -eq 'credit')
                     {
                       $LookupSpec6 = "CreditReport"
                     }
                     if ($LookupSpec6 -eq 'isoCountryCodeType')
                     {
                       $LookupSpec6 = "ISOCountryCodeType-V2006"
                     }
                     if ($LookupSpec6 -eq 'eligibility')
                     {
                       $LookupSpec6 = "EligibilityRequirement"
                     }
                     if ($LookupSpec6 -eq 'overdraftPriority')
                     {
                       $LookupSpec6 = "OverdraftPriorityList"
                     }
                     if ($LookupSpec6 -eq 'overdraftPriorityFilter')
                     {
                       $LookupSpec6 = "OverdraftPriorityListFilter"
                     }
                     if ($LookupSpec6 -eq 'overdraft')
                     {
                       $LookupSpec6 = "OverdraftPriorityList"
                     }

                     #FIX Abbreviations end


                     $LookUpFileName= $LookupSpec6 + ".xsd." + $parts4[1] + ".txt"
                      
                    }
                 else
                    {
                     $LookUpFileName= $Specification + "." + $LookUpType6 + ".txt"
                    }

                  #echo  $LookUpFileName
          

                #echo $LookUpFileName
                 # $pathfile = "C:\Users\dlacroix\Documents\CUFX\RFC NEXT\" + $LookUpFileName
              #   Echo "extension file name of : " $LookUpFileName  
                   $LookUpFileName = $LookUpFileName.ToLower()

                   $LookUpFileNameTemp = $LookUpFileName 
                          
                 $content7 = Get-Content $LookUpFileNameTemp
                 $counter = 0
                 foreach ($line7 in $content7)
                     {
                     #   echo  $line7
                        $skipline = 'FALSE'
                        $counter = $counter + 1
                        IF (($counter -eq  '1') -or ($counter -eq  '2'))
                            {
                             # Skip the header line and 2nd line                     
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
             #####

       $ElementType = ''
       $DocumentationPart = ''

       # Format type conversions.

        }
    }

     $switch = 'OFF'
     $FirstElement = 'TRUE'

    }


  if (($line -Match  '</xs:element' -and $switch -Match 'ON') -or ($IsShortElement -Match "TRUE" -and $switch -Match 'ON'))
    { 
       $IsShortElement ="FALSE"

       # Write out the entire defintione

       $outputLine = "  "  + "  " + $ElementName + ":"
       $outputLine | Out-File $filename -Append

 
      # $outputLine = $ElementType
      # $outputLine | Out-File $filename -Append

       if ($SimpleType -ne "")
            {
           # $outputLine = "  "  + "  " + $ElementName + ":"
           # $outputLine | Out-File $filename -Append
            $outputLine =  "  "  + "  "  + "  "  + $SimpleType
            $outputLine | Out-File $filename -Append
            }
       else 
            {
            ### Always write a reference 


             if ($IsArray -eq "TRUE" )
                {
            #    $outputLine = "  "  + "  " + $ElementName + ":"
            #    $outputLine | Out-File $filename -Append
                $outputLine =  "  "  + "  "  + "  "  + "type: array"
                $outputLine | Out-File $filename -Append
                
               # $outputLine =  "  "  + "  "  + "  "  + "items:"
               # $outputLine | Out-File $filename -Append

                $SpecificationTemp = $Specification
                $LookUpTypeTemp = $LookUpType

                if ($LookUpType -Match  ':')              #if it is a reference field
                 {
                    $parts5 = $LookUpType.split($seperator3)    # spilt into parts by $seperator3 = ':'
                    
                    $SpecificationTemp = $parts5[0] + ".xsd"  # set reference specification
                    $LookUpTypeTemp = $parts5[1]    # set LookUpType

                 }

                ##  Write file reference

                
                
                $outputLineTemp = $SpecificationTemp + "." + $LookUpTypeTemp + ".txt"
                $outputLine = $outputLineTemp.ToLower()

                #echo "LOOKUP" $LookUpFileName 
                #echo "OUTPUT" $outputLine

                $outputLine | Out-File MasterReference.txt -Append
                ##  Write file reference


            #    $outputLine =  "  "  + "  "  + "  "  + "  "  + "$" + "ref: '#/definitions/" + $LookUpTypeTemp +"'"
            #    $outputLine | Out-File $filename -Append


                }

             else
                {
              
               # echo "Get File Data" Write Object Reference

                IF ($LookUpType -Match  ':')
                    {
                     $parts4 = $LookUpType.split($seperator3)

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


                  #echo "by refernce" $LookUpFileName

                  #  $outputLine =  "  "  + "  "  + "  "  + "type: object"
                  #  $outputLine | Out-File $filename -Append
                
                    # $outputLine =  "  "  + "  "  + "  "  + "items:"
                    # $outputLine | Out-File $filename -Append

                  #  $SpecificationTemp = $Specification
                  #  $LookUpTypeTemp = $LookUpType

                  #  if ($LookUpType -Match  ':')              #if it is a reference field
                  #  {
                  #     $parts5 = $LookUpType.split($seperator3)    # spilt into parts by $seperator3 = ':'
                  #  
                  #     $SpecificationTemp = $parts5[0] + ".xsd"  # set reference specification
                  #     $LookUpTypeTemp = $parts5[1]    # set LookUpType
                  #
                  #   }

                      ##  Write file reference
                    
                   if (($LookUpTypeTemp -eq 'Account') -or ($LookUpTypeTemp -eq 'Deposit') -or ($LookUpTypeTemp -eq 'Investment') -or ($LookUpTypeTemp -eq 'Loan') -or ($LookUpTypeTemp -eq 'Party'))     
                    {
                    echo  "lookuptypetemp" $LookUpTypeTemp
                      
                     # $outputLineTemp = $SpecificationTemp + "." + $LookUpTypeTemp
                     
                   #   Echo  "TEMP" $outputLineTemp
                    #  Echo  "LookUP" $LookUpFileName

                      $outputLine = $LookUpFileName.ToLower()

                      $outputLine | Out-File MasterReference.txt -Append
                      ##  Write file reference
                      
                      
                      # set is array TRUE to force reference 
                      $IsByReference = "TRUE"
                     } #  end Look up references 


                 If ($IsByReference -ne "TRUE")
                 {
             #    $outputLine = "  "  + "  " + $ElementName + ":"
             #    $outputLine | Out-File $filename -Append
                 $pathfile = "D:\CUFX work folder\CUFX.Demo.4.0\CUFX_4.0_Schemas\" + $LookUpFileName
            
                 $content2 = Get-Content $LookUpFileName
                 $counter = 0
                 foreach ($line2 in $content2)
                     { 
                       $counter = $counter + 1
                        IF ($line2 -Match  'description: ')
                            {
                            $PrintOneDocuLine = 'FALSE'
                            }
                        IF ($counter -eq  '1')
                            {
                             # Skip the header line
             
                             }
                        Else
                            {
                             # Print the rest of the file adjusting indent by 2
                             $outputLine =  "  "  + "  "  + $line2
                             $outputLine | Out-File $filename -Append
                            }
                     }

                   }
                }   
            }


       
       if ($formatType -ne "")
            {

#  >>> not sure about indent
             $outputLine =  "  " + "  " + "  " + $formatType
             $outputLine | Out-File $filename -Append
             $formatType = ''

            }
       if ($DocumentationPart -ne "" -and $PrintOneDocuLine -eq "TRUE" -and $IsByReference -ne "TRUE")
            {

           ## Remove quoations and special characters
              $DocumentationPart = $DocumentationPart -replace "[']",''
              $DocumentationPart = $DocumentationPart -replace '["]'.''

             #$outputLine =  "  " + "  " + "  "  + "description: >-"
             $outputLine =  "  " + "  " + "  "  + "description: '" + $DocumentationPart + "'"
             $outputLine | Out-File $filename -Append
            
          #   $outputLine =  "  " + "  " + "  " + "  " + $DocumentationPart
          #   $outputLine | Out-File $filename -Append
            }


            If (($IsArray -eq "TRUE") -and ($SimpleType -eq ""))
               {
                # print reference after the description
                 $outputLine =  "  "  + "  "  + "  "  + "items:"
                 $outputLine | Out-File $filename -Append
                 $outputLine =  "  "  + "  "  + "  "  + "  "  + "$" + "ref: '#/definitions/" + $LookUpTypeTemp +"'"
                 $outputLine | Out-File $filename -Append
               }

             If (($IsByReference -eq "TRUE") -and ($SimpleType -eq ""))
               {
                # print reference after the description

               if ($IsChoice -eq "TRUE")   #open Api 3 feature
                   {
                      $outputLine =  "  "  + "  "  + "  "  +"- $" + "ref: '#/definitions/" + $LookUpTypeTemp +"'"
                      $outputLine | Out-File $filename -Append 
            
                   }
                else
                {

                 $outputLine =  "  "  + "  " + "  "  + "$" + "ref: '#/definitions/" + $LookUpTypeTemp +"'"
                 $outputLine | Out-File $filename -Append

                 }

              }
       $PrintOneDocuLine = 'TRUE'

       $enumIndex = 0
       if ($enumIndexMax -gt 0)
   #    
         { 
            $outputLine =  "  " + "  "  + "enum:"
            $outputLine | Out-File $filename -Append
            for ($enumIndex=0; $enumIndex -lt $enumIndexMax;$enumIndex++)
            {
              $outputLine =  "  " + "  "  + "- " + $SimpleEnum[$enumIndex]
              $outputLine | Out-File $filename -Append

            }

         }

     #  if ((($minOccurs -eq "1" -or $minOccurs -eq "0" -or $minOccurs -eq "2") -and ($maxOccurs -ne "UNBOUNDED") -and ($IsByReference -eq "FALSE")) -or 
     #      (($minOccurs -eq "1" -or $minOccurs -eq "0" -or $minOccurs -eq "2" ) -and ($maxOccurs -eq "UNBOUNDED" -and $SimpleType -ne "") -and ($IsByReference -eq "FALSE") ) )
     #       {
     #        $outputLine =  "  " + "  " + "  " + "minimum: " + $minOccurs
     #        $outputLine | Out-File $filename -Append
     #        $formatType = ''
     #       }
     #
     #  if  (($maxOccurs -eq "1" -or $maxOccurs -eq "0" -or $maxOccurs -eq "2") -and ($maxOccurs -ne "UNBOUNDED") -and ($IsByReference -eq "FALSE")) 
     #       {
     #        $outputLine =  "  " + "  " + "  " + "maximum: " + $maxOccurs
     #        $outputLine | Out-File $filename -Append
     #        $formatType = ''
     #       }

       #reset the enum index
       $enumIndexMax = 0
       $enumIndex = 0
       $DocumentationPart=''

    }



  if ($line -Match  '<xs:enumeration')
    { 

    $parts = $line.split($seperator)
  #  echo $parts[1]
    
    $SimpleEnum[$enumIndex] = $parts[1]  
  #  echo 'index : ' $enumIndex  

  #  echo $SimpleEnum[$enumIndex] 
 
    $enumIndex = $enumIndex + 1
    $enumIndexMax = $enumIndex
   # echo 'index Max : ' $enumIndexMax 
    }


# may not want this sections as i am writing in line. 
###
#  if ($extensionSwitch -Match 'TRUE') 
#    {
#     # Write out the reference defintion
#     $extensionSwitch = 'FALSE'
#     $PrintExtension = 'TRUE'
#     
#     $ExtensionElementName = $ExtensionLookUpType  
#
#
#     IF ($ExtensionLookUpType -Match  ':')      
#        { 
#         $ExtensionParts = $ExtensionLookUpType.split($seperator3) 
#         $ExtensionElementName = $ExtensionParts[1]
#
#                     #Fix Abbreviations
#                     $LookupSpec = $ExtensionParts[0]
#                     if ($LookupSpec -eq 'credential')
#                     {
#                       $LookupSpec = "CredentialGroup"
#                     }
#                     if ($LookupSpec -eq 'question')
#                     {
#                       $LookupSpec = "QuestionList"
#                     }
#                     if ($LookupSpec -eq 'credit')
#                     {
#                       $LookupSpec = "CreditReport"
#                     }
#                     if ($LookupSpec -eq 'isoCountryCodeType')
#                     {
#                       $LookupSpec = "ISOCountryCodeType-V2006"
#                     }
#                     if ($LookupSpec -eq 'eligibility')
#                     {
#                       $LookupSpec = "EligibilityRequirement"
#                     }
#                     if ($LookupSpec -eq 'overdraftPriority')
#                     {
#                       $LookupSpec = "OverdraftPriorityList"
#                     }
#                     if ($LookupSpec -eq 'overdraftPriorityFilter')
#                     {
#                       $LookupSpec = "OverdraftPriorityListFilter"
#                     }
#                     if ($LookupSpec -eq 'overdraft')
#                     {
#                       $LookupSpec = "OverdraftPriorityList"
#                     }
#
#                     $LookUpFileName= $LookupSpec + ".xsd." + $ExtensionParts[1] + ".txt"
#
#                }
#           else
#                {
#                   $LookUpFileName= $Specification + "." + $ExtensionLookUpType + ".txt"
#                }
#
# 
#         ##  Write file reference
#
#           $outputLineTemp = $LookUpFileName
#           $outputLine = $outputLineTemp.ToLower()
#           $outputLine | Out-File MasterReference.txt -Append
#           ##  Write file reference
#          
#
#    ##Extension end
#    }
###
#Write-Host "switch: " $switch

  if ($DocuSwitch -match 'ON' -and $switch -match 'ON')
    {
    $DocumentationPart = $DocumentationPart + $line.Trim() + " "
    # $line | Out-File 'SwaggerOutput.txt' -Append
    }
  
  if ($line -Match '<xs:documentation')
    {$DocuSwitch = 'ON'}
 }
 
 } 