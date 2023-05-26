@Title [%computername%] RapidHIT ID Powershell Automation and Troubleshooting Tools
@echo off
rem Temporary workaround to avoid powershell missing connsole capture, until XML export is implemented
:0
set InstFolder=U:\%computername%\Internal\"RapidHIT ID\Results\Data %computername%"
set InstResultTXT=U:\%computername%\Internal\"RapidHIT ID\Results\%computername% Result.TXT"

set RHID_Workstation=SGSI11-59FKK13
rem set RHID_Devel=SGSI11-B6BZP73
set RHID_Devel=LENOVO-R76800HS
if "%computername%" == "%RHID_Devel%" (goto 1)
If Exist "%~dp0\Modules\Report_Automation.ps1" (
	if not exist %InstFolder% mkdir %InstFolder%
	powershell -Command "& {Set-ExecutionPolicy unrestricted -Scope CurrentUser}"
	powershell -sta -ExecutionPolicy ByPass -File "%~dp0\Modules\Report_Automation.ps1" > %InstResultTXT%
	goto 3
)
:1
If Exist "%~dp0\Modules\Report_Automation.ps1" (
	powershell -Command "& {Set-ExecutionPolicy unrestricted -Scope CurrentUser}"
	powershell -sta -ExecutionPolicy ByPass -File "%~dp0\Modules\Report_Automation.ps1"
)
:3
@echo Press any key to Clear Console screen and refresh test result.
Pause
goto 0