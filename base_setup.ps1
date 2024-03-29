if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

$versionNumber = 34;
$startTime = Get-Date

#START BATCH INSTALLATION
#------------------------------------------------------------------

Write-Host "  "                                      
Write-Host "                                      /(((((((           (((("                                   
Write-Host "                                  (((((((/////////   ///////("                       
Write-Host "                              (((((((////////////(((###//////                 ,(#"           
Write-Host "                          ((((((/(//////////*/((((((#((((((*/                 ,(/*/"       
Write-Host "                      (((((((((/////////*////((((/    ((((///                 *"       
Write-Host "                  (((((((((((///////////(((((.            ///       (*(("     
Write-Host "              (((((((((((((((//,(((((((((                             /%          ((/" 
Write-Host "         ,((((((((((((((((/,(((((((((                                         (((((**" 
Write-Host "     (##(((((((((((((((*########(                  //                             ///"
Write-Host "     ###((((((((((((#########                 ./****/////            //                     /#("
Write-Host "     ###(((((((##########                 /(///********/////(.       /**(((                 #"
Write-Host "     ###(((((((((******////                  ((((((/((((((#          /*##"
Write-Host "     ###(((((((((((((*/////////                  (((((*                            ("  
Write-Host "       /#((((((((((((((((*/////////                                            ////("    
Write-Host "           .(((((((((((((((//,///((((((                         *#                **"      
Write-Host "                ((((((((((((/////*(((((((((                 //***#(((("        
Write-Host "                    (((((((((((////////(((((((#*        /////////(((((((//"        
Write-Host "                        ((((((((//////////*(########((((/////,//////////(((,**."         
Write-Host "                            ((((((/////////////#####(((((,////////////(((((*"           
Write-Host "                                (((((//////////////#/////////////((((((."             
Write-Host "                                    ((((((/(////       (//////((((("                
Write-Host "                                        /(((               (((("                  
Write-Host " "

Write-Host ""
Write-Host "TRUEVR BATCHINSTALLATION BASIC" -ForegroundColor Green
Write-Host "------------------------------------" 
Write-Host "Version: " $versionNumber
Write-Host "Start Time: " $startTime
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

#Set highperformance mode
#------------------------------------------------------------------

Write-Host ""
Write-Host "Setting Highperformance mode..." 
Write-Host "------------------------------------" 

Write-Host "- Add mode: 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c..." 

powercfg.exe /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c

Write-Host ""
Write-Host "Highperformance mode set" -ForegroundColor Green

#Install C++ Redistributables
#------------------------------------------------------------------

Write-Host ""
Write-Host "Install C++ Redistributables..." 
Write-Host "------------------------------------" 
Write-Host ""


Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://vcredist.com/install.ps1'))

Write-Host ""
Write-Host "C++ Redistributables installed" 

#Disable Sleep mode
#------------------------------------------------------------------

Write-Host ""
Write-Host "Disable Sleep mode..." 
Write-Host "------------------------------------" 
Write-Host ""

powercfg.exe -x -monitor-timeout-ac 0
powercfg.exe -x -monitor-timeout-dc 0
powercfg.exe -x -disk-timeout-ac 0
powercfg.exe -x -disk-timeout-dc 0
powercfg.exe -x -standby-timeout-ac 0
powercfg.exe -x -standby-timeout-dc 0
powercfg.exe -x -hibernate-timeout-ac 0
powercfg.exe -x -hibernate-timeout-dc 0

Write-Host ""
Write-Host "Sleep mode diabled" 

#REMOVE PREINSTALLED SOFTWARE
#------------------------------------------------------------------
#install from url: https://stackoverflow.com/questions/33205298/how-to-use-powershell-to-download-a-script-file-then-execute-it-with-passing-in

. { iwr -useb https://raw.githubusercontent.com/fabianfreund/automate-setup/main/remove_tiles.ps1 } | iex; 
. { iwr -useb https://raw.githubusercontent.com/fabianfreund/automate-setup/main/uninstall_uwp_app.ps1 } | iex; 
. { iwr -useb https://raw.githubusercontent.com/fabianfreund/automate-setup/main/uninstall_software.ps1 } | iex; 
. { iwr -useb https://raw.githubusercontent.com/fabianfreund/automate-setup/main/uninstall_office.ps1 } | iex; 


Write-Host ""
Write-Host "Client setup completed" -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green

$finalTime = Get-Date
Write-Host "This setup run for $($finalTime - $startTime) (HH:MM:SS)"
Write-Host ""


#------------------------------------------------------------------