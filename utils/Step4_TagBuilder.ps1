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
$ElementType = ''
$minOccurs = ''
$maxOccurs = ''
$FirstElement='TRUE'



$filelist = Get-ChildItem -path "D:\CUFX work folder\CUFX_4_2_1\CUFX_4.2_Schemas\MasterTags.uniquesorted.txt"

$filenameOut = "MasterTagsAssembly.txt"
                 
$content2 = Get-Content $filelist
                 #$counter = 1


$outputLine =  "tags:" 
$outputLine | Out-File $filenameOut

foreach ($line2 in $content2)
 {

   $outputLine =  "  " + "- name: " + $line2
   $outputLine | Out-File $filenameOut -Append
   
  # $outputLine =  "  " + "  " + "description: " + "'" + $line2 + "'"
  # $outputLine | Out-File $filenameOut -Append

   $outputLine =  "  " + "  " + "externalDocs:"
   $outputLine | Out-File $filenameOut -Append

   $outputLine =  "  " + "  " + "  " + "description: 'CUFX release 4.2 specification documents library'"
   $outputLine | Out-File $filenameOut -Append

   $outputLine =  "  " + "  " + "  " + "url: 'http://cufxstandards.com/Portals/0/CUFX_4.2_Specifications.zip'"
   $outputLine | Out-File $filenameOut -Append

 
 }

 echo "Done"