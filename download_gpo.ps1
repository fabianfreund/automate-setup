
$url = 'https://raw.githubusercontent.com/fabianfreund/automate-setup/main/GPO.zip' 
$ZipFile = 'C:\TrueVRtemp\' + $(Split-Path -Path $Url -Leaf) 
$Destination= 'C:\Windows\System32\GroupPolicy' 

New-Item -ItemType Directory -Force -Path $ZipFile
New-Item -ItemType Directory -Force -Path $Destination

Write-Host ""
Write-Host "Start installing GPO settings..." 
Write-Host "------------------------------------" 
Write-Host "- clear GPO folder" 

 
Invoke-WebRequest -Uri $Url -OutFile $ZipFile 
 
$ExtractShell = New-Object -ComObject Shell.Application 
$Files = $ExtractShell.Namespace($ZipFile).Items() 
$ExtractShell.NameSpace($Destination).CopyHere($Files) 
Start-Process $Destination

Write-Host "Press any key to continue ..."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

Write-Host ""
Write-Host "GPO installed" -ForegroundColor Green

