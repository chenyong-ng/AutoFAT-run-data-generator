@Title RapidHIT ID Powershell Automation and Troubleshooting Tools
@echo off
:1
If Exist "%~dp0\automation.ps1" (
	Pwsh -Command "& {Set-ExecutionPolicy unrestricted -Scope CurrentUser}"
	Pwsh.exe -sta -ExecutionPolicy ByPass -File "%~dp0\automation.ps1"
	clear-host
)
@echo Enter any key to Clear Console screen and check for new instrument.
@Pause >:null
goto 1