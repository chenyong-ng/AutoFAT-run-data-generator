@Title [%computername%] RapidHIT ID Powershell Automation and Troubleshooting Tools
@echo off
:0
set RHID_Workstation=SGSI11-59FKK13
set RHID_Devel=SGSI11-B6BZP73
set InstFolder=U:\%computername%\Internal\"RapidHIT ID\Results\Data %computername%"
set InstResultTXT=U:\%computername%\Internal\"RapidHIT ID\Results\%computername% Result.TXT"
if %computername% == (%RHID_Devel% OR %RHID_Workstation%) set InstResultTXT=NUL

If Exist "%~dp0\Modules\Report_Automation.ps1" (
	if not exist %InstFolder% mkdir %InstFolder%
	powershell -Command "& {Set-ExecutionPolicy unrestricted -Scope CurrentUser}"
	powershell -sta -ExecutionPolicy ByPass -File "%~dp0\Modules\Report_Automation.ps1" > %InstResultTXT%
)
:2
@echo Press any key to Clear Console screen and refresh test result.
Pause
goto 0