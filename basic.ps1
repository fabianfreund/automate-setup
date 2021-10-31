if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

#START BATCH INSTALLATION
#------------------------------------------------------------------

Write-Host "Starting Batchinstallation for TrueVR Client" 
Write-Host "------------------------------------" 
Write-Host "3" -NoNewline
Start-Sleep 1
Write-Host "...2" -NoNewline
Start-Sleep 1
Write-Host "...1" -NoNewline
Start-Sleep 1

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
    "Microsoft.XboxApp",
    "Microsoft.GamingApp",
    "Microsoft.Print3D",
    "king.com.CandyCrushSaga",
    "Microsoft.Office.Word"
)

foreach ($uwp in $preinstalledApps) {
    Write-Host "Try to remove: " $uwp 
    Get-AppxPackage -Name $uwp | Remove-AppxPackage
}

Write-Host ""
Write-Host "All possible apps removed" -ForegroundColor Green

#------------------------------------------------------------------