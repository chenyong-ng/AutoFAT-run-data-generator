@Title [%computername%] RapidHIT ID Powershell Automation and Troubleshooting Tools
@echo off
:1
If %computername%==DESKTOP-FR43358 (
	set Powershell_version=Pwsh.exe
) else (
	set Powershell_version=Powershell.exe )
rem "DESKTOP-FR43358" "LENOVO-R76800HS"
pushd %~dp0
If Exist "%~dp0\Modules\Report_Automation.ps1" (
	%Powershell_version% -mta -ExecutionPolicy ByPass -File "%~dp0\Modules\Report_Automation.ps1"
)
@echo [Batch Script] : Press any key to Clear Console screen and refresh test result.
@Pause>:nul
goto 1