@Title [%computername%] RapidHIT ID Powershell Automation and Troubleshooting Tools
@echo off
REM Checking Pwsh.exe presence
where.exe /q pwsh.exe
if %Errorlevel%==0 (
    set PowerShell=pwsh.exe
	@echo [Batch Script] : Powershell version 7 detected
) Else (
	set PowerShell=Powershell
	@echo [Batch Script] : Powershell version 5.1.1 detected
)
:0
pushd "%~dp0%"
rem Pushd does not work with folder name containts dash symbol, as it will fail to work, necessary for Git 
If Exist "%~dp0\Modules\Report_Automation.ps1" (
	%PowerShell% -Mta -ExecutionPolicy ByPass -File "%~dp0\Modules\Report_Automation.ps1"
rem Inline Powershell Workaround for different Powershell version in Workstation environment and the Instruments
)
@echo [Batch Script] : Press any key to Clear Console screen and refresh test result.
@Pause>:nul
goto 0
rem Looping the script, for refreshing test result
