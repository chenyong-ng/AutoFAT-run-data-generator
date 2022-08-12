@Title RapidHIT ID Powershell Automation and Troubleshooting Tools
@echo off
@chcp 437
:1
If Exist "%~dp0\automation.ps1" (
	PowerShell.exe clear-host
	PowerShell -Command "& {Set-ExecutionPolicy unrestricted -Scope CurrentUser}"
	PowerShell.exe -sta -ExecutionPolicy ByPass -File "%~dp0\automation.ps1"
)
@echo Enter any key to Clear Console screen and check for new instrument.
@Pause >:null
goto 1