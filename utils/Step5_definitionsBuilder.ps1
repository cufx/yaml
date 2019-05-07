#  Definition builder for some reason failed to copy all of the lines for the nested complex type. Re-running the script corrected the error. 

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


#$filelist = Get-ChildItem -path D:\CUFX work folder\CUFX_4_2_1\CUFX_4.1_Schemas\MasterReference.uniquesorted.txt"

$filenameOut = "MasterDefinitionAssembly.txt"
Remove-Item -Path "D:\CUFX work folder\CUFX_4_2_1\CUFX_4.2_Schemas\MasterDefinitionAssembly.txt"
 
$filelist =  "D:\CUFX work folder\CUFX_4_2_1\CUFX_4.2_Schemas\MasterReference.uniquesorted.txt"


$outputLine =  "definitions:" 
$outputLine | Out-File $filenameOut

$content = Get-Content $filelist

foreach ($item in $content)
{

  #  echo $item

    $file2 = $item

    echo $file2 
    $content2 = Get-Content $file2

    foreach ($line2 in $content2)
    {

   $outputLine = $line2
   $outputLine | Out-File $filenameOut -Append

      }
}


#foreach ($line1 in $filelist) 
#{   
#echo "line 1 : $line1"
#            
#$content2 = Get-Content $line1
                 #$counter = 1


# }

