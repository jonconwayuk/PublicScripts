
::  Description:	Script 4 for configuring Autologon for Windows 10
::  Author:			Jonathan Conway
::  Modified:       11/03/2020
::  Version:		1.0

:: Stops and removes the Script_3 Scheduled Task
schtasks.exe /end /tn Script_3
schtasks.exe /delete /tn Script_3 /f

:: Waits for 6 minutes to allow Child profile to be fully created
TIMEOUT /T 360

:: Creates a Scheduled Task to run after the next reboot; then reboots the device after 2 seconds to start it
schtasks.exe /create /ru system /rl highest /tn Script_5 /tr "C:\Windows\Temp\AutoLogon\Script_5.bat" /sc onstart
shutdown.exe /r /f /t 2