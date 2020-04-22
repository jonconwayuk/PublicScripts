
::  Description:	Script 5 for configuring Autologon for Windows 10
::  Author:			Jonathan Conway
::  Modified:       11/03/2020
::  Version:		1.0

:: Stops and removes the Script_3 Scheduled Task
schtasks.exe /end /tn Script_4
schtasks.exe /delete /tn Script_4 /f

:: Adds registry keys to disable AutoLogon and remove the last logged on user from the Lock Screen
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "AutoAdminLogon" /t "REG_SZ" /d "0" /f
REG ADD "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "dontdisplaylastusername" /t "REG_DWORD" /d "1" /f

:: Deletes AutoLogon registry keys to prevent the Child account automtically logging into the device after the next reboot
REG DELETE "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "DefaultDomainName" /f
REG DELETE "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "DefaultPassword" /f
REG DELETE "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "DefaultUserName" /f
REG DELETE "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "LastUsedUsername" /f

:: Adds RunOnce registry entries to clean up files and Scheduled Tasks
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Currentversion\RunOnce" /v "DelAutoLogonOnNextReboot" /d "cmd.exe /c RD /S /Q C:\Windows\Temp\AutoLogon"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Currentversion\RunOnce" /v "DelScript_5OnNextReboot" /d "cmd.exe /c schtasks.exe /delete /tn Script_5 /f"

:: Reboots the device after 5 seconds
shutdown.exe /r /f /t 2