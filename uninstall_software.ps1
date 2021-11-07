#REMOVE PREINSTALLED SOFTWARE
#------------------------------------------------------------------
# How to get installed software: "Get-WmiObject -Class Win32_Product | Format-List -Property Name"


Write-Host ""
Write-Host "Removing Preinstalled Software..." 
Write-Host "------------------------------------" 



$preinstalledSoftware = @(
    "ExpressVPN",
    "HP Wolf Security",
    "HP Notifications",
    "Office 16 Click-to-Run Licensing Component",
    "Office 16 Click-to-Run Localization Component",
    "Office 16 Click-to-Run Localization Component",
    "Office 16 Click-to-Run Localization Component",
    "Office 16 Click-to-Run Extensibility Component"
)


foreach ($software in $preinstalledSoftware) {

    Write-Host "Try to remove: "  $software
    $name = "Name = '" + $software + "'"
    $application = Get-WmiObject -Class Win32_Product -Filter $name

    if ($application) {
        Write-Host "Start uninstalling: "  $software
        $application.Uninstall()
        Write-Host $software " removed" -ForegroundColor Green
        Write-Host ""
    }else{
        Write-Host "Not installed: "  $software -ForegroundColor Green
        Write-Host ""
    }

    
}




Write-Host ""
Write-Host "All possible software removed" -ForegroundColor Green