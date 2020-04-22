
::  Description:	Script 1 for configuring Autologon for Windows 10
::  Author:			Jonathan Conway
::  Modified:       11/03/2020
::  Version:		1.0

:: Create Scheduled Task to restart device after 2 minutes
schtasks.exe /create /ru system /rl highest /tn Script_2 /tr "C:\Windows\Temp\AutoLogon\Script_2.bat" /sc onstart
shutdown.exe /r /f /t 120