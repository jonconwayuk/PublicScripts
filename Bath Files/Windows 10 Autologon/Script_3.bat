
::  Description:	Script 3 for configuring Autologon for Windows 10
::  Author:			Jonathan Conway
::  Modified:       11/03/2020
::  Version:		1.0

:: Stops and removes the Script_2 Scheduled Task
schtasks.exe /end /tn Script_2
schtasks.exe /delete /tn Script_2 /f

:: Waits for 6 minutes to allow Adult profile to be fully created
TIMEOUT /T 360

:: Adds AutoLogon registry keys to allow the Child account to automtically log into the device after the next reboot
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "AutoAdminLogon" /t "REG_SZ" /d "1" /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "AutoLogonCount" /t "REG_DWORD" /d "1" /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "DefaultPassword" /t "REG_SZ" /d "L1braries123" /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "DefaultUserName" /t "REG_SZ" /d "w7_pat_childuser" /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "DefaultDomainName" /t "REG_SZ" /d "testlab.local" /f

:: Deletes disclaimer notice registry keys
REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "legalnoticecaption" /f
REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "legalnoticetext" /f

:: Creates a Scheduled Task to run after the next reboot; then reboots the device after 10 seconds to start it
schtasks.exe /create /ru system /rl highest /tn Script_4 /tr "C:\Windows\Temp\AutoLogon\Script_4.bat" /sc onstart
shutdown.exe /r /f /t 10