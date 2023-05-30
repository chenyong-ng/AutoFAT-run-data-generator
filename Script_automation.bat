@Title [%computername%] RapidHIT ID Powershell Automation and Troubleshooting Tools
@echo off
:1
If Exist "%~dp0\Modules\Report_Automation.ps1" (
	rem powershell -Command "& {Set-ExecutionPolicy unrestricted -Scope CurrentUser}"
	powershell -sta -ExecutionPolicy ByPass -File "%~dp0\Modules\Report_Automation.ps1"
)
@echo Press any key to Clear Console screen and refresh test result.
Pause
goto 1