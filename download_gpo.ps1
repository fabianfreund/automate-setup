$Url = 'https://raw.githubusercontent.com/fabianfreund/automate-setup/main/GPO.zip' 
$ZipFile = 'C:\TrueVRtemp\' + $(Split-Path -Path $Url -Leaf) 
$Destination= 'C:\Windows\System32\GroupPolicy' 

New-Item -ItemType Directory -Force -Path $ZipFile

Write-Host ""
Write-Host "Start installing GPO settings..." 
Write-Host "------------------------------------" 
Write-Host "- clear GPO folder" 
Remove-Item -path C:\Windows\System32\GroupPolicy -recurse -force

 
Invoke-WebRequest -UseBasicParsing -Uri $Url -OutFile $ZipFile 

Write-Host "- download GPO files" 

$ExtractShell = New-Object -ComObject Shell.Application 
$Files = $ExtractShell.Namespace($ZipFile).Items() 

Write-Host "- extract files" 

$ExtractShell.NameSpace($Destination).CopyHere($Files) 
Start-Process $Destination

Remove-Item –path $ZipFile

Write-Host ""
Write-Host "GPO installed" -ForegroundColor Green

