#REMOVE PREINSTALLED Office
#------------------------------------------------------------------
# https://www.reddit.com/r/sysadmin/comments/jjtpnp/script_to_silently_uninstall_builtin_office_365/


Write-Host ""
Write-Host "Removing Office..." 
Write-Host "------------------------------------" 



$preinstalledSoftware = @(
    "Microsoft 365 - en-us",
    "Microsoft 365 - de-de",
    "Microsoft 365 - fr-fr",
    "Microsoft 365 - it-it"
)


foreach ($DisplayName in $preinstalledSoftware) {

    Write-Host "Start removing: " $DisplayName

    $OfficeUninstallStrings = (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where {$_.DisplayName -like "*$DisplayName*"} | Select UninstallString).UninstallString
        ForEach ($UninstallString in $OfficeUninstallStrings) {
            $UninstallEXE = ($UninstallString -split '"')[1]
            $UninstallArg = ($UninstallString -split '"')[2] + " DisplayLevel=False"
            Start-Process -FilePath $UninstallEXE -ArgumentList $UninstallArg -Wait
        } 

    Write-Host "Removed: " $DisplayName

    
}


Write-Host ""
Write-Host "All possible software removed" -ForegroundColor Green