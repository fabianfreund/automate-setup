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
    "king.com.CandyCrushSodaSaga",
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

    Write-Host "- uninstalling apps..." 
    Write-Host "" 

    if (Get-AppxPackage -Name $uwp) {
        Write-Host "Try to remove: "  $uwp
        Get-AppxPackage -Name $uwp | Remove-AppxPackage
    }
}

foreach ($uwp in $preinstalledApps) {

    Write-Host "- check uninstalled apps..." 
    Write-Host "" 

    if (!Get-AppxPackage -Name $uwp) {
        Write-Host "Removeed: "  $uwp
    }

}

Write-Host ""
Write-Host "All possible apps removed" -ForegroundColor Green