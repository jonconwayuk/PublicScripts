
::  Description:	Script 2 for configuring Autologon for Windows 10
::  Author:			Jonathan Conway
::  Modified:       11/03/2020
::  Version:		1.0

:: Adds AutoLogon registry keys to allow the Adult account to automatically log into the device after the next reboot
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "AutoAdminLogon" /t "REG_SZ" /d "1" /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "AutoLogonCount" /t "REG_DWORD" /d "1" /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "DefaultPassword" /t "REG_SZ" /d "L1braries123" /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "DefaultUserName" /t "REG_SZ" /d "w7_pat_adultuser" /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "DefaultDomainName" /t "REG_SZ" /d "lni.net" /f

:: Deletes disclaimer notice registry keys
REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "legalnoticecaption" /f
REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "legalnoticetext" /f

:: Creates a Scheduled Task to run after the next reboot; then reboots the device after 10 seconds to start it
schtasks.exe /create /ru system /rl highest /tn Script_3 /tr "C:\Windows\Temp\AutoLogon\Script_3.bat" /sc onstart
shutdown.exe /r /f /t 10