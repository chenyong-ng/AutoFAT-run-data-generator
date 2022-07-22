@echo off
If Exist "%~dp0\automation.ps1" (
	PowerShell -Command "& {Set-ExecutionPolicy unrestricted -Scope CurrentUser}"
	PowerShell.exe -sta -ExecutionPolicy ByPass -File "%~dp0\automation.ps1"
)
