@Title RapidHIT ID Powershell Automation and Troubleshooting Tools
@echo off
:1
clear
If Exist "%~dp0\automation.ps1" (
<<<<<<< HEAD
	Powershell -Command "& {Set-ExecutionPolicy unrestricted -Scope CurrentUser}"
	Powershell -sta -ExecutionPolicy ByPass -File "%~dp0\automation.ps1"
=======
	powershell -Command "& {Set-ExecutionPolicy unrestricted -Scope CurrentUser}"
	powershell -sta -ExecutionPolicy ByPass -File "%~dp0\automation.ps1"
>>>>>>> 2af67d5f6cf02ba47431675839205a8e261148c9
)
@echo Enter any key to Clear Console screen and check for new instrument.
Pause
goto 1