@Title RapidHIT ID Powershell Automation and Troubleshooting Tools
@echo off
chcp 437
:1
If Exist "%~dp0\automation.ps1" (
	PowerShell.exe clear-host
	PowerShell -Command "& {Set-ExecutionPolicy unrestricted -Scope CurrentUser}"
	PowerShell.exe -sta -ExecutionPolicy ByPass -File "%~dp0\automation.ps1"
)
@pause
goto 1