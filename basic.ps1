if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

#START BATCH INSTALLATION
#------------------------------------------------------------------

Write-Host "Starting Batchinstallation" -ForegroundColor Green
Write-Host "----------------------------------------" -ForegroundColor Green
Start-Sleep 1

#DISABLE STANDBY
#------------------------------------------------------------------

Write-Host ""
Write-Host "Disable Sleep on AC Power..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
Powercfg /Change monitor-timeout-ac 0
Powercfg /Change standby-timeout-ac 0

#REMOVE PREINSTALLED SOFTWARE
#------------------------------------------------------------------
#detailed app list: https://gal.vin/posts/removing-uwp-apps-mdt/

Write-Host "Removing Preinstalled Apps..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green

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
    "Microsoft.GetHelp"
)

foreach ($uwp in $preinstalledApps) {
    Get-AppxPackage -Name $uwp | Remove-AppxPackage
}

#------------------------------------------------------------------