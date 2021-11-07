Write-Host ""
Write-Host "Removing Preinstalled Software..." 
Write-Host "------------------------------------" 


$preinstalledSoftware = @(
    "ExpressVPN"
)


foreach ($software in $preinstalledSoftware) {

    if (Get-AppxPackage -Name $software) {
        Write-Host "Try to remove: "  $software
        $application = Get-WmiObject -Class Win32_Product -Filter "Name = '" $software "'"
        $application.Uninstall()
    }
    
}




Write-Host ""
Write-Host "All possible software removed" -ForegroundColor Green