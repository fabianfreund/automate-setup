if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

$versionNumber = 2;

#START BATCH INSTALLATION
#------------------------------------------------------------------

Write-Host ""
Write-Host "TRUEVR BATCHINSTALLATION BASIC" -ForegroundColor Green
Write-Host "------------------------------------" 
#Write-Host "3" -NoNewline
#Start-Sleep 1
#Write-Host "...2" -NoNewline
#Start-Sleep 1
#Write-Host "...1"
Start-Sleep 1
Write-Host $versionNumber

#DISABLE STANDBY
#------------------------------------------------------------------

Write-Host ""
Write-Host "Disable Sleep on AC Power..." 
Write-Host "------------------------------------" 
Write-Host "- change monitor timeout to 0" 
Powercfg /Change monitor-timeout-ac 0
Write-Host "- change standby timeout to 0" 
Powercfg /Change standby-timeout-ac 0

Write-Host ""
Write-Host "Disable sleep completed" -ForegroundColor Green

#Set highperformance mode
#------------------------------------------------------------------

Write-Host ""
Write-Host "Setting Highperformance mode..." 
Write-Host "------------------------------------" 

Write-Host "Add mode: 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c..." 

powercfg.exe /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c

Write-Host ""
Write-Host "Highperformance mode set" -ForegroundColor Green

#REMOVE PREINSTALLED SOFTWARE
#------------------------------------------------------------------
#detailed app list: https://gal.vin/posts/removing-uwp-apps-mdt/
#get list of installed apps ond a computer: "Get-AppxPackage –AllUsers"

Write-Host ""
Write-Host "Removing Preinstalled Apps..." 
Write-Host "------------------------------------" 

$preinstalledApps = @(
    "Microsoft.Messaging",
    "king.com.CandyCrushSaga",
    "Microsoft.BingNews",
    "Microsoft.BingWeather",
    "Microsoft.MicrosoftSolitaireCollection",
    "Microsoft.People",
    "Microsoft.WindowsFeedbackHub",
    "Microsoft.YourPhone",
    "Microsoft.MicrosoftOfficeHub",
    "Fitbit.FitbitCoach",
    "4DF9E0F8.Netflix",
    "Microsoft.GetHelp",
    "Microsoft.MicrosoftOfficeHub",
    "Microsoft.SkypeApp",
    "Microsoft.Office.OneNote",
    "Microsoft.Office.Desktop",
    "Microsoft.XboxApp",
    "Microsoft.GamingApp",
    "Microsoft.Print3D"
)

foreach ($uwp in $preinstalledApps) {

    Write-Host "Try to remove: "  $uwp
    Get-AppxPackage -Name $uwp | Remove-AppxPackage

}

Write-Host ""
Write-Host "All possible apps removed" -ForegroundColor Green

#UNINSTALLING OFFICE
#------------------------------------------------------------------
#find proframms: https://www.majorgeeks.com/content/page/uninstall_command_prompt.html

Write-Host ""
Write-Host "Try to uninstall office... "
Write-Host "------------------------------------" 


#(Get-WMIObject Win32_Product -Filter 'name="Office 16 Click-to-Run Licensing Component"').Uninstall()
#(Get-WMIObject Win32_Product -Filter 'name="Office 16 Click-to-Run Localization Component"').Uninstall()
#(Get-WMIObject Win32_Product -Filter 'name="Office 16 Click-to-Run Extensibility Component"').Uninstall()

$App = (
    "Microsoft Office 365 - en-us"
)

gwmi win32_product|
    where { $App -contains $_.Name }|
    foreach { $_.Uninstall() } | out-nul

Write-Host "Tried to uninstall office" -ForegroundColor Green



#------------------------------------------------------------------