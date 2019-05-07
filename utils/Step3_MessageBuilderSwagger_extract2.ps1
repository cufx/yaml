
# Step 3 - updates MasterReference.uniquesorted.txt and MasterTags.uniquesorted.txt
# builds masterpaths segment

$switch = 'OFF'
$DocuSwitch = 'OFF'
$seperator = '"'
$seperator2 = '.'
$seperator3 = ':'
$parts4 =''
$counter = 0
# $content = Get-Content Ar*.xsd
$outputLine = ''
$printSwitch ='NO'
$DocumentationPart = ''
$filename = ''
$formatType = ''
$enumIndex = 0
$enumIndexMax = 0
[string[]]$SimpleEnum = @(1..400)
[string[]]$CRUD = @('post', 'put', 'delete','get')
$Specification =''
$SimpleName =''
$LookUpFileName=''
$ComplexName =''
$SimpleType =''
$ComplexType =''
$ElementName ='' 
$ElementType = ''
$minOccurs = ''
$maxOccurs = ''
$FirstElement='TRUE'
# >> moved to Step 2
# $outputLine2 = 'messagecontext.xsd.messagecontext' 
# $outputLine2 | Out-File MasterReference.txt
# >> moved to Step 2 

#Remove-Item -Path "D:\CUFX work folder\RFC NEXT\CUFX_3.3_Schemas\MasterReference.txt"

Remove-Item -Path "D:\CUFX work folder\CUFX_4_2_1\CUFX_4.2_Schemas\MasterTags.txt"
Remove-Item -Path "D:\CUFX work folder\CUFX_4_2_1\CUFX_4.2_Schemas\MasterTags.uniquesorted.txt"

# $filelist = Get-ChildItem -path "D:\CUFX work folder\CUFX.Demo.4.0\CUFX_4.0_Schemas\*.xsd"
#$filelist = Get-ChildItem -path "D:\CUFX work folder\CUFX_4_2_1\CUFX_4.2_Schemas\AccountMessage.xsd"

$filelist = Get-ChildItem -path "D:\CUFX work folder\CUFX_4_2_1\CUFX_4.2_Schemas\*Message.xsd"
$filename = 'MasterPaths.txt'

#Write first line of the file
$outputLine = "paths:"
$outputLine | Out-File $filename

foreach ($item in $filelist)
{


if (($item.attributees -ne "Directory") -and ($item.Name -ne "SecureMessage.xsd"))
    {
    # Write Message xsd to reference 
    # $outputLine2 = $item.Name 
    # $outputLine2 | Out-File MasterReference.txt -append
    $forth ="FALSE"
    echo $item.Name
    $TempItemName = $item.Name
    #<< content of file>>
     
    $contentX = Get-Content $item.Name

     $Specification =  $item.Name
     $parts2 = $Specification.split($seperator2)
    # echo $parts2[0]
     

     $outputLine =  "  " + "/" + $parts2[0] + ":"   

   #  echo $outputLine
     
     $MessageName = $parts2[0]
        
     $outputLine | Out-File $filename -Append

    }

  foreach ($line in $contentX)
  { 

     $parts3 = $line.split($seperator)     # $seperator = '"'
     $parts4 = $parts3[3]                  # Get the reference:type component

     if ($parts4 -Match  ':')              #if it is a reference field
     {
     $parts5 = $parts4.split($seperator3)    # spilt into parts by $seperator3 = ':'
     }

    if (($line -Match $parts2[0]) -and  ($line -Match  '<xs:element'))
     {
     $SpecMessageDoco = "True"
     }

    if  ($line -Match  '"messageContext"')
     {
     $messageContextDoco = "TRUE"
     }
    if  (($line -Match  '<xs:element') -and ($line -Match  'Filter"'))
     {
     $filterName1 = $parts3[1]
     $filterName2 = $parts5[1]

     $filterDoco = "TRUE"
                     #Fix Abbreviations
                     $LookupSpec = $filterName1

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


     $outputLineTemp = $LookupSpec + ".xsd." + $filterName2 + ".txt"
            

     $outputLine2 = $outputLineTemp.ToLower()
    # echo $outputLine2

     $outputLine2 | Out-File MasterReference.txt -Append
     }

    if  (($line -Match  '<xs:element') -and -NOT (($line -Match  'List"') -or ($line -Match  'Filter"') -or ($line -Match  'messageContext"') -or ($line -Match  'Message"')))
     {
     echo $line
     echo "Forth element"
     $forth ="TRUE"
     $forthNameReference = $parts3[1]
     $forthName1 = $parts5[0]
     $forthName2 = $parts5[1]
     $forthDoco = "TRUE"

                          #Fix Abbreviations
                     $forthLookupSpec = $forthName1
  
                     if ($forthLookupSpec -eq 'credential')
                     {
                       $forthLookupSpec = "CredentialGroup"
                     }
                     if ($forthLookupSpec -eq 'question')
                     {
                       $forthLookupSpec = "QuestionList"
                     }
                     if ($forthLookupSpec -eq 'credit')
                     {
                       $forthLookupSpec = "CreditReport"
                     }
                     if ($forthLookupSpec -eq 'isoCountryCodeType')
                     {
                       $forthLookupSpec = "ISOCountryCodeType-V2006"
                     }
                     if ($forthLookupSpec -eq 'eligibility')
                     {
                       $forthLookupSpec = "EligibilityRequirement"
                     }
                     if ($forthLookupSpec -eq 'overdraftPriority')
                     {
                       $forthLookupSpec = "OverdraftPriorityList"
                     }
                     if ($forthLookupSpec -eq 'overdraftPriorityFilter')
                     {
                       $forthLookupSpec = "OverdraftPriorityListFilter"
                     }
                     if ($forthLookupSpec -eq 'overdraft')
                     {
                       $forthLookupSpec = "OverdraftPriorityList"
                     }

                     #FIX Abbreviations end

     $outputLineTemp = $forthLookupSpec + ".xsd." + $forthName2 + ".txt"

     $outputLine2 = $outputLineTemp.ToLower()
     $outputLine2 | Out-File MasterReference.txt -Append

     }

         if  (($line -Match  '<xs:element') -and ($line -Match  'List"'))
     {
     $listNameReference = $parts3[1]
     $listName1 = $parts5[0]
     $listName2 = $parts5[1]
     $listDoco = "TRUE"

                          #Fix Abbreviations
                     $LookupSpec = $listName1
  
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

     $outputLineTemp = $LookupSpec + ".xsd." + $listName2 + ".txt"

     $outputLine2 = $outputLineTemp.ToLower()
     $outputLine2 | Out-File MasterReference.txt -Append

     }
    
    
    
    if ($line -Match  '</xs:documentation')
    { 
    $DocuSwitch = 'OFF'
    # Set which documentation is getting set

        if ($SpecMessageDoco -Match  'TRUE')
          {
          $SpecMessageDocoContent  = $DocumentationPart
          }    
        
        if  ($messageContextDoco -Match  'TRUE')
          {
          $messageContextDocoContent  = $DocumentationPart
          }
        if  ($filterDoco -Match  'TRUE')
          {
          $filterDocoContent = $DocumentationPart
          }

        if  ($listDoco -Match  'TRUE')
          {
          $listDocoContent = $DocumentationPart
          }
         
         $SpecMessageDoco = "FALSE" 
         $messageContextDoco = "FALSE" 
         $filterDoco = "FALSE" 
         $listDoco = "FALSE" 
         $DocumentationPart = ""
              

    }

    if ($DocuSwitch -match 'ON' ) # -and $switch -match 'ON')
    {
    $DocumentationPart = $DocumentationPart + $line.Trim() + " "

    }
  
    if ($line -Match '<xs:documentation')
       {$DocuSwitch = 'ON'}


  }
 
 If ($item.Name -ne "SecureMessage.xsd")
 {
   foreach ($line2 in $CRUD)
   { 
# Write-Host "Line: " $line

     if ($line2 -match 'get' )
     {
         $outputLine =  "  " + "/" + $parts2[0] + "/Get:"   

   #  Write out the extra path level and override to a post
     
         $MessageName = $parts2[0]
        
          $outputLine | Out-File $filename -Append
          $outputLine =  "  " + "  " + "post:"         #CRUD
     }
     else
     {
          $outputLine =  "  " + "  " + $line2 + ":"         #CRUD
     }
     $outputLine | Out-File $filename -Append 

     $outputLine =  "  " + "  " + "  " + "tags:"                   #tags
     $outputLine | Out-File $filename -Append

     $outputLine =  "  " + "  " + "  " + "  " + "- " +  $parts2[0]       #Message tag
     $outputLine | Out-File $filename -Append

     # Write a mastertags file
     $outputLine3 = $parts2[0] 
     $outputLine3  | Out-File MasterTags.txt -Append


     $outputLine =  "  " + "  " + "  " + "summary: 'Example of $line2 operation for " + $parts2[0] + "'"                #Summary
     $outputLine | Out-File $filename -Append

     if ( $SpecMessageDocoContent -ne "") 
     {

       ## Remove quoations and special characters
          $SpecMessageDocoContent = $SpecMessageDocoContent -replace "[']",''
          $SpecMessageDocoContent = $SpecMessageDocoContent -replace '["]'.''

     $outputLine =  "  " + "  " + "  " + "description: '" + $SpecMessageDocoContent + "'"            #description
     $outputLine | Out-File $filename -Append

     #$outputLine =  "  " + "  " + "  " + "  " +  $SpecMessageDocoContent           #Message Doco
     #$outputLine | Out-File $filename -Append

     }

     $outputLine =  "  " + "  " + "  " + "operationId: " + $line2 + $parts2[0] #operationID
     $outputLine | Out-File $filename -Append
     
     $outputLine =  "  " + "  " + "  " + "consumes:"               #consumes
     $outputLine | Out-File $filename -Append
     $outputLine =  "  " + "  " + "  " + "  " + "- application/json"                   
     $outputLine | Out-File $filename -Append
     
     $outputLine =  "  " + "  " + "  " + "produces:"               #produces
     $outputLine | Out-File $filename -Append
     $outputLine =  "  " + "  " + "  " + "  " + "- application/json"                   
     $outputLine | Out-File $filename -Append

     $outputLine =  "  " + "  " + "  " + "parameters:"             #parameters          
     $outputLine | Out-File $filename -Append

     $outputLine =  "  " + "  " + "  " + "  " + "- in: body"                   
     $outputLine | Out-File $filename -Append
     
     $outputLine =  "  " + "  " + "  " + "  " + "  " + "name: " +  $parts2[0]                   
     $outputLine | Out-File $filename -Append
     
     $outputLine =  "  " + "  " + "  " +"  " + "  " + "description: '" +  $parts2[0] + " Specification'"       #Description
     $outputLine | Out-File $filename -Append
      
     $outputLine =  "  " + "  " + "  " +"  " +"  " + "required: true"         #Required
     $outputLine | Out-File $filename -Append

     $outputLine =  "  " + "  " + "  " + "  " + "  " + "schema:"                #Schema
     $outputLine | Out-File $filename -Append

     $outputLine =  "  " + "  " + "  " + "  " + "  " + "  " + "type: object"         #schema type
     $outputLine | Out-File $filename -Append
          
   
     $outputLine =  "  " + "  " + "  " +"  " + "  " + "  " + "properties:"          #list properties 
     $outputLine | Out-File $filename -Append

     $outputOperationName = $parts2[0]
     $outputOperationName = $outputOperationName.substring(0,1).tolower()+$outputOperationName.substring(1)

     $outputLine =  "  " + "  " + "  " + "  " + "  " + "  " + "  " + "$outputOperationName" + ":"         #In all Messages

     #***** 
     $outputOperation = $line2
     $outputOperation = $outputOperation.substring(0,1).toupper()+$outputOperation.substring(1).tolower()


     $outputLine | Out-File $filename -Append
     $outputLine =  "  " + "  " + "  " + "  " + "  " + "  " + "  " + "  " + "$" + "ref: '#/definitions/" + $parts2[0] + $outputOperation + "'"         #In all Messages
     $outputLine | Out-File $filename -Append

     #Filters
     
     
     if ($line2 -match 'post' )
     {   
       #Write one post output 
       #    *** write post block and add to master reference 
     
     # reference name 
     $refernenceName = $MessageName + ".post" + ".txt"
  

     $outputLineTemp = $refernenceName           
     $outputLine2 = $outputLineTemp.ToLower()
    # echo $outputLine2
     $outputLine2 | Out-File MasterReference.txt -Append

     $refernenceName = $outputLine2 

    

     $outputLine =  $MessageName + "Post:"
     $outputLine | Out-File $refernenceName 
     
     $outputLine =  "  " +  "type: object"  
     $outputLine | Out-File $refernenceName -Append

     $outputLine =  "  " + "description: " + "'" + "Post definition for " + $MessageName + "'"   
     $outputLine | Out-File $refernenceName -Append

     $outputLine =  "  " + "properties:"   
     $outputLine | Out-File $refernenceName -Append

     $outputLine =  "  " + "  " + "messageContext:"   
     $outputLine | Out-File $refernenceName -Append

     $outputLine =   "  " +"  " +"  " + "$" + "ref: '#/definitions/" + "MessageContext" + "'"                       
     $outputLine | Out-File $refernenceName -Append
     
     $outputLine =  "  " + "  " + $listNameReference + ":"   
     $outputLine | Out-File $refernenceName -Append

     $outputLine =   "  " +"  " +"  " + "$" + "ref: '#/definitions/" + $listName2  + "'"                       
     $outputLine | Out-File $refernenceName -Append

     if ($forth -eq "TRUE")
     {
     $outputLine =  "  " + "  " + $forthNameReference + ":"   
     $outputLine | Out-File $refernenceName -Append

     $outputLine =   "  " +"  " +"  " + "$" + "ref: '#/definitions/" + $forthName2  + "'"                       
     $outputLine | Out-File $refernenceName -Append

     }




     }

     if ($line2 -match 'put' )
     {   
            #Write one put output 
       #    *** write put block and add to master reference 
     
     # reference name 
     $refernenceName = $MessageName + ".put" + ".txt"
  

     $outputLineTemp = $refernenceName           
     $outputLine2 = $outputLineTemp.ToLower()
     echo $outputLine2
     $outputLine2 | Out-File MasterReference.txt -Append

     $refernenceName = $outputLine2 

    

     $outputLine =  $MessageName + "Put:"
     $outputLine | Out-File $refernenceName 
     
     $outputLine =  "  " +  "type: object"  
     $outputLine | Out-File $refernenceName -Append

     $outputLine =  "  " + "description: " + "'" + "Put definition for " + $MessageName + "'"   
     $outputLine | Out-File $refernenceName -Append

     $outputLine =  "  " + "properties:"   
     $outputLine | Out-File $refernenceName -Append

     $outputLine =  "  " + "  " + "messageContext:"   
     $outputLine | Out-File $refernenceName -Append

     $outputLine =   "  " +"  " +"  " + "$" + "ref: '#/definitions/" + "MessageContext" + "'"                       
     $outputLine | Out-File $refernenceName -Append

     $outputLine =  "  " + "  " + $filterName1 + ":"   
     $outputLine | Out-File $refernenceName -Append

     $outputLine =   "  " +"  " +"  " + "$" + "ref: '#/definitions/" + $filterName2  + "'"                       
     $outputLine | Out-File $refernenceName -Append
     
     $outputLine =  "  " + "  " + $listNameReference  + ":"   
     $outputLine | Out-File $refernenceName -Append

     $outputLine =   "  " +"  " +"  " + "$" + "ref: '#/definitions/" + $listName2  + "'"                       
     $outputLine | Out-File $refernenceName -Append
     }

      if ($line2 -match 'delete' )
     {     
        #Write one delete output 
       #    *** write delete block and add to master reference 
     
     # reference name 
     $refernenceName = $MessageName + ".delete" + ".txt"
  

     $outputLineTemp = $refernenceName           
     $outputLine2 = $outputLineTemp.ToLower()
     echo $outputLine2
     $outputLine2 | Out-File MasterReference.txt -Append

     $refernenceName = $outputLine2 

    

     $outputLine =  $MessageName + "Delete:"
     $outputLine | Out-File $refernenceName 
     
     $outputLine =  "  " +  "type: object"  
     $outputLine | Out-File $refernenceName -Append

     $outputLine =  "  " + "description: " + "'" + "Delete definition for " + $MessageName + "'"   
     $outputLine | Out-File $refernenceName -Append

     $outputLine =  "  " + "properties:"   
     $outputLine | Out-File $refernenceName -Append

     $outputLine =  "  " + "  " + "messageContext:"   
     $outputLine | Out-File $refernenceName -Append

     $outputLine =   "  " +"  " +"  " + "$" + "ref: '#/definitions/" + "MessageContext" + "'"                       
     $outputLine | Out-File $refernenceName -Append

     $outputLine =  "  " + "  " + $filterName1 + ":"   
     $outputLine | Out-File $refernenceName -Append

     $outputLine =   "  " +"  " +"  " + "$" + "ref: '#/definitions/" + $filterName2  + "'"                       
     $outputLine | Out-File $refernenceName -Append
     
     $outputLine =  "  " + "  " + $listNameReference + ":"   
     $outputLine | Out-File $refernenceName -Append

     $outputLine =   "  " +"  " +"  " + "$" + "ref: '#/definitions/" + $listName2  + "'"                       
     $outputLine | Out-File $refernenceName -Append

     }

      if ($line2 -match 'get')
     {   
                 #Write one get output 
       #    *** write get block and add to master reference 
     
     # reference name 
     $refernenceName = $MessageName + ".get" + ".txt"
 

     $outputLineTemp = $refernenceName           
     $outputLine2 = $outputLineTemp.ToLower()
     echo $outputLine2
     $outputLine2 | Out-File MasterReference.txt -Append

     $refernenceName = $outputLine2 

    

     $outputLine =  $MessageName + "Get:"
     $outputLine | Out-File $refernenceName 
     
     $outputLine =  "  " +  "type: object"  
     $outputLine | Out-File $refernenceName -Append

     $outputLine =  "  " + "description: " + "'" + "Get definition for " + $MessageName + "'"   
     $outputLine | Out-File $refernenceName -Append

     $outputLine =  "  " + "properties:"   
     $outputLine | Out-File $refernenceName -Append

     $outputLine =  "  " + "  " + "messageContext:"   
     $outputLine | Out-File $refernenceName -Append

     $outputLine =   "  " +"  " +"  " + "$" + "ref: '#/definitions/" + "MessageContext" + "'"                       
     $outputLine | Out-File $refernenceName -Append

     $outputLine =  "  " + "  " + $filterName1 + ":"   
     $outputLine | Out-File $refernenceName -Append

     $outputLine =   "  " +"  " +"  " + "$" + "ref: '#/definitions/" + $filterName2  + "'"                       
     $outputLine | Out-File $refernenceName -Append
     
          if ($forth -eq "TRUE")
     {
     $outputLine =  "  " + "  " + $forthNameReference + ":"   
     $outputLine | Out-File $refernenceName -Append

     $outputLine =   "  " +"  " +"  " + "$" + "ref: '#/definitions/" + $forthName2  + "'"                       
     $outputLine | Out-File $refernenceName -Append

     }

       #Write one response output 
       #    *** write Response block and add to master reference 
     
     # reference name 

     $refernenceName = $MessageName + ".response" + ".txt"
 

     $outputLineTemp = $refernenceName           
     $outputLine2 = $outputLineTemp.ToLower()
     echo $outputLine2
     $outputLine2 | Out-File MasterReference.txt -Append

     $refernenceName = $outputLine2 

    

     $outputLine =  $MessageName + "Response:"
     $outputLine | Out-File $refernenceName 
     
     $outputLine =  "  " +  "type: object"  
     $outputLine | Out-File $refernenceName -Append

     $outputLine =  "  " + "description: " + "'" + "Response definition for " + $MessageName + "'"   
     $outputLine | Out-File $refernenceName -Append

     $outputLine =  "  " + "properties:"   
     $outputLine | Out-File $refernenceName -Append

     $outputLine =  "  " + "  " + "messageContext:"   
     $outputLine | Out-File $refernenceName -Append

     $outputLine =   "  " +"  " +"  " + "$" + "ref: '#/definitions/" + "MessageContext" + "'"                       
     $outputLine | Out-File $refernenceName -Append


     $outputLine =  "  " + "  " + $listNameReference + ":"  
     $outputLine | Out-File $refernenceName -Append

     $outputLine =   "  " +"  " +"  " + "$" + "ref: '#/definitions/" + $listName2  + "'"                       
     $outputLine | Out-File $refernenceName -Append

     }


     #Main list 
     
#***** update more here for additonal responses  constant format

     $outputLine =  "  " + "  " + "  " + "responses:"             #responses         
     $outputLine | Out-File $filename -Append

     $outputLine =  "  " + "  " + "  " + "  " + "'200':"             #200          
     $outputLine | Out-File $filename -Append
     $outputLine =  "  " + "  " + "  " + "  " + "  " + "description: OK"                      
     $outputLine | Out-File $filename -Append
     $outputLine =  "  " + "  " +"  " + "  " + "  " + "schema:"                      
     $outputLine | Out-File $filename -Append
     $outputLine =  "  " + "  " + "  " + "  " + "  " +"  " + "type: object"                      
     $outputLine | Out-File $filename -Append
     $outputLine =  "  " + "  " +"  " + "  " +"  " + "  " + "properties:"                       
     $outputLine | Out-File $filename -Append
     $outputLine =  "  " + "  " +"  " + "  " +"  " + "  " + "  " + $outputOperationName + ":"                       
     $outputLine | Out-File $filename -Append
     $outputLine =  "  " + "  " + "  " +"  " +"  " + "  " +"  " +"  " + "$" + "ref: '#/definitions/" + $parts2[0] +"Response" + "'"                        
     $outputLine | Out-File $filename -Append



}
}

# Sort and remove duplicates


  gc MasterReference.txt | sort | Get-Unique > MasterReference.uniquesorted.txt

  gc MasterTags.txt | sort | Get-Unique > MasterTags.uniquesorted.txt

}



