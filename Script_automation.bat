@Title [%computername%] RapidHIT ID Powershell Automation and Troubleshooting Tools
@echo off
:1
If Exist "%~dp0\Modules\Report_Automation.ps1" (
	Powershell -sta -ExecutionPolicy ByPass -File "%~dp0\Modules\Report_Automation.ps1"
)
@echo [Batch Script] : Press any key to Clear Console screen and refresh test result.
@Pause>:nul
goto 1