#cd ..#  Master File buidling scripts.  Assemble all parts into a single YAML file
# run from D:\CUFX work folder\CUFX_4_2\>
#           


$outputLine = ''
$line = ''

Remove-Item -Path "D:\CUFX work folder\CUFX_4_2_1\CUFX.4.2.Swagger.txt"

# set output file
$filenameOut = "CUFX.4.2.Swagger.txt"

#get the first block
#get the first block  

# $LookUpFileName= "D:\CUFX work folder\CUFX_4_2\SwaggerHeader.txt"
$LookUpFileName= "SwaggerHeader.txt"

$content = Get-Content $LookUpFileName

foreach ($line in $content)
 {
   $outputLine =  $line
   $outputLine | Out-File $filenameOut -Append 
   }

# Add tags block
# Add tags block

$LookUpFileName= "D:\CUFX work folder\CUFX_4_2_1\CUFX_4.2_Schemas\MasterTagsAssembly.txt"

$content = Get-Content $LookUpFileName

foreach ($line in $content)
 {
   $outputLine =  $line
   $outputLine | Out-File $filenameOut -Append 
   }

# Add schema block
# Add schema block

# $outputLine =  "schemas:"
# $outputLine | Out-File $filenameOut -Append 

# $outputLine =  "  " + "- https"
#cd  $outputLine | Out-File $filenameOut -Append 

# Add Paths block
# Add Paths block

$LookUpFileName= "D:\CUFX work folder\CUFX_4_2_1\CUFX_4.2_Schemas\MasterPaths.txt"

$content = Get-Content $LookUpFileName

foreach ($line in $content)
 {
   $outputLine =  $line
   $outputLine | Out-File $filenameOut -Append 
   }


# Add SecurityDefinitions Block

# $outputLine =  "securityDefinitions:"
# $outputLine | Out-File $filenameOut -Append 
# $outputLine =  "  " + "cufxstore_auth:"
# $outputLine | Out-File $filenameOut -Append 
# $outputLine =  "  " + "  " + "type: oauth2"
# $outputLine | Out-File $filenameOut -Append 
# $outputLine =  "  " + "  " + "authorizationUrl: 'http://cufxstandards.com/oauth"
# $outputLine | Out-File $filenameOut -Append 
# $outputLine =  "  " + "  " +  "flow: implicit"
# $outputLine | Out-File $filenameOut -Append 
# $outputLine =  "  " + "  " + "scopes:"
# $outputLine | Out-File $filenameOut -Append 
# $outputLine =  "  " + "  " + "'write:example': modify"
# $outputLine | Out-File $filenameOut -Append 
# $outputLine =  "  " + "  " + "'read:example': read"
# $outputLine | Out-File $filenameOut -Append 
# $outputLine =  "  " + "api_key:"
# $outputLine | Out-File $filenameOut -Append 
# $outputLine =  "  " + "  " + "type: apiKey"
# $outputLine | Out-File $filenameOut -Append
# $outputLine =  "  " + "  " + "name: api_Key"
# $outputLine | Out-File $filenameOut -Append
# $outputLine =  "  " + "  " + "in: header"
# $outputLine | Out-File $filenameOut -Append

 # Add definitions Block

 $outputLine =  "definitions:"
 $outputLine | Out-File $filenameOut -Append 


$LookUpFileName= "D:\CUFX work folder\CUFX_4_2_1\CUFX_4.2_Schemas\MasterReference.uniquesorted.txt"

$content = Get-Content $LookUpFileName

foreach ($line in $content)
 {
   $LookUpFileName2 = "D:\CUFX work folder\CUFX_4_2_1\CUFX_4.2_Schemas\" + $line 
   
   $content2  = Get-Content $LookUpFileName2
   foreach ($line2 in $content2)
     {
     $outputLine =  "  " + $line2
     $outputLine | Out-File $filenameOut -Append 
   }
  }

# externalDocs sections


$outputLine =  "externalDocs:"
$outputLine | Out-File $filenameOut -Append 

$outputLine =  "  " + "description: Find out more about CUFX"
$outputLine | Out-File $filenameOut -Append 
$outputLine =  "  " + "url: 'http://www.cufxstandards.com'"
$outputLine | Out-File $filenameOut -Append 

echo "DONE"