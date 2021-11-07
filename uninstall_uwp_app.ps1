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
    "Microsoft.Print3D",
    "Microsoft.Microsoft3DViewer",
    "Microsoft.Whiteboard"
)

Write-Host "- uninstalling apps..." 
Write-Host ""

foreach ($uwp in $preinstalledApps) {

    if (Get-AppxPackage -Name $uwp) {
        Write-Host "Try to remove: "  $uwp
        Get-AppxPackage -Name $uwp | Remove-AppxPackage
    }
    
}

Write-Host ""
Write-Host "- check uninstalled apps..." 
Write-Host "" 

foreach ($uwp in $preinstalledApps) {

    if (Get-AppxPackage -Name $uwp) {
        Write-Host "Not Removed: "  $uwp
    }else{
        Write-Host "Removeed: "  $uwp
    }

}

Write-Host ""
Write-Host "All possible apps removed" -ForegroundColor Green