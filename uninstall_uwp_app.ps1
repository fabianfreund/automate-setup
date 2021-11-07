#REMOVE PREINSTALLED UWP APPS
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
    "king.com.CandyCrushFriends",
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
    "Microsoft.Office.Sway",
    "Microsoft.XboxApp",
    "Microsoft.GamingApp",
    "Microsoft.Print3D",
    "Microsoft.Microsoft3DViewer",
    "Microsoft.Whiteboard",
    "Microsoft.Todos",
    "king.com.FarmHeroesSaga",
    "HuluLLC.HuluPlus",
    "King.com.CandyCrushFriends"
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
Write-Host "- Disable consumer apps..-" 


REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /F

Write-Host ""
Write-Host "All possible apps removed" -ForegroundColor Green