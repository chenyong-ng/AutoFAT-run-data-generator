@Title RapidHIT ID Automation and Troubleshooting Script [Main Branch v31JAN2023]
@echo off
:1
@REM This batch file invokes the local powershell scripts with elevated privileges
If Exist "%~dp0\Modules\automation.ps1" (
	powershell -Command "& {Set-ExecutionPolicy unrestricted -Scope CurrentUser}"
	powershell -sta -ExecutionPolicy ByPass -File "%~dp0\Modules\automation.ps1"
)
@echo Enter any key to Clear Console screen and check for new instrument.
Pause
goto 1