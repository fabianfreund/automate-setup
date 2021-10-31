$Url = 'https://raw.githubusercontent.com/fabianfreund/automate-setup/main/GPO.zip' 
$ZipFile = 'C:\temp\' + $(Split-Path -Path $Url -Leaf) 
$Destination= 'C:\Windows\System32\GroupPolicy' 

Write-Host ""
Write-Host "Start installing GPO settings..." 
Write-Host "------------------------------------" 
 
Invoke-WebRequest -UseBasicParsing -Uri $Url -OutFile $ZipFile 
 
$ExtractShell = New-Object -ComObject Shell.Application 
$Files = $ExtractShell.Namespace($ZipFile).Items() 
$ExtractShell.NameSpace($Destination).CopyHere($Files) 
Start-Process $Destination

Write-Host ""
Write-Host "GPO installed" -ForegroundColor Green

