@Title [%computername%] RapidHIT ID Powershell Automation and Troubleshooting Tools
@echo off
:1

rem "DESKTOP-FR43358" "LENOVO-R76800HS" 	Powershell -mta -ExecutionPolicy ByPass -File "%~dp0\Modules\Report_Automation.ps1"
pushd "%~dp0%"
rem Pushd does not work with folder name containts dash symbol, as it will fail to work
If Exist "%~dp0\Modules\Report_Automation.ps1" (
	Powershell -Command "& { if ($env:computername -notmatch {RHID-\d\d\d\d}) { pwsh.exe -mta -ExecutionPolicy ByPass -File "%~dp0\Modules\Report_Automation.ps1"} else { Powershell -mta -ExecutionPolicy ByPass -File "%~dp0\Modules\Report_Automation.ps1"}}"
rem Inline Powershell Workaround for different Powershell version in Workstation environment and the Instruments
)
@echo [Batch Script] : Press any key to Clear Console screen and refresh test result.
@Pause>:nul
goto 1