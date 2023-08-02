<#
.Title          : Powershell Utility for RHID Instrument
.Source         : https://github.com/chenyong-ng/AutoFAT-run-data-generator
.Version        : v0.5
.License        : Public Domain, CC0 1.0 Universal
.Revision Date  : 22 MAY 2023
.Todo           : Add more meaningful error message, add error code and instrument troubleshooting information
.Notes          : Generate Test result progress into XML
.Usage          : .\Report_Automation.ps1: Generate Test result progress into console.

$content = [System.IO.File]::ReadAllText("c:\bla.txt").Replace("[MYID]","MyValue")
[System.IO.File]::WriteAllText("c:\bla.txt", $content)

$ini = Get-Content $PSScriptRoot\..\config\ScriptConfig.ini | Select-Object -skip 0 | ConvertFrom-StringData

$ini.SystemTimeZone
$ini.path
"profile 0 : "+$ini.Profile[0]
"profile 1 : "+$ini.Profile[1]
 #$XMLFile = "$PSScriptRoot\..\config\ScriptConfig.xml"
#$XMLFile = "C:\Users\chenyong.ng\OneDrive - Thermo Fisher Scientific\Desktop\Source\Stable\Config\ScriptConfig.xml"
#$ScriptConfig = ([XML](Get-Content $XMLFile -Encoding utf8 -Raw)).ScriptConfig.Workstation
	$ScriptConfig.Profiles
	$ScriptConfig.Drive
	$ScriptConfig.path
	$ScriptConfig.danno
	$ScriptConfig.US_Drive
	$ScriptConfig.US_Path
	$ScriptConfig.US_danno
#>
if ($env:COMPUTERNAME -eq "SGSI11-59FKK13") {
		$Drive = "S:"
		$path = "S:\RHID"
		$danno = "S:\Dano Planning\Test Data\"
		$US_Drive = "Y:"
		$US_Path = "Y:\RHID"
		$US_danno = "Y:\Dano Planning\Test Data\"
} else {
		$Drive = "U:"
		$path = "U:\RHID"
		$danno = "U:\Dano Planning\Test Data\"
} #RHID Workststion laptop has differnt network drive path

$PSDefaultParameterValues['*:Encoding'] = 'utf8'
$HostName = "$env:COMPUTERNAME"
$SystemTimeZone = [System.TimeZoneInfo]::Local.DisplayName
$PST_TimeZone   = [System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId([DateTime]::Now, "Pacific Standard Time")
$NewGuid        = [guid]::NewGuid().guid.toUpper()
$InteralDisplay = "CHR $env:COMPUTERNAME (Internal)"
$DELL_Display   = "DEL $env:COMPUTERNAME (VGA)"
$SerialRegMatch = "$HostName" -match "RHID-\d\d\d\d"
$NewDate = ([String](Get-Date -format "dddd dd MMMM yyyy HH:mm:ss:ms"))
$PSVersion = [string]($psversiontable.psversion)
# $SystemUptime = (Get-Uptime).totalhours
$SystemUptime = ((get-date) - ((Get-CimInstance -ClassName Win32_OperatingSystem).LastBootUpTime)).totalhours
if (((get-command git -ErrorAction SilentlyContinue).Path -match "git.exe") -eq "True") {
$GitCommitDate = (git log -1 --date=local --format=%cd)
$GitCommitHash = (git rev-parse --short HEAD)
$GitCommitBranch = (git branch --show current)
}
$Inst_rhid_Folder   = "E:\RapidHIT ID"
$Inst_rhid_Result   = "E:\RapidHIT ID\Results"
$Nonlinearity_File  = "Non-linearity Calibration $HostName.PNG"
$Waves_File         = "Waves $HostName.PNG"
$TC_verification_File   = "TC_verification $HostName.TXT"
$MachineConfig_File  = "MachineConfig.xml"
$StatusData_File     = "StatusData_Graphs.pdf"
$GM_Analysis_File    = "GM_Analysis.sgf"
$TC_CalibrationXML_File = "TC_Calibration.xml"
$DannoAppConfigXML_File = "DannoAppConfig.xml"
$OverrideSettingsXML_File = "OverrideSettings.xml"
$TestResultXML_File     = "TestResult $MachineName.xml"
$TestResultLOG_File     = "TestResult $MachineName.LOG"
$ScriptMetadataTXT     = "$Env:Temp\$HostName\Script_Metadata.txt"
$ScriptMetadataXML     = "$Env:Temp\$HostName\Script_Metadata.XML"

$TestResultLOG_Leaf     = Test-Path -Path "$Drive\$HostName\Internal\$TestResultLOG_File" -PathType Leaf
$TestResultXML_Leaf     = Test-Path -Path "$Drive\$HostName\Internal\$TestResultXML_File" -PathType Leaf
$Nonlinearity_Leaf      = Test-Path -Path $Inst_rhid_Result\$Nonlinearity_File -PathType Leaf
$Waves_Leaf             = Test-Path -Path $Inst_rhid_Result\$Waves_File -PathType Leaf
$TC_verification_Leaf   = Test-Path -Path $Inst_rhid_Result\$TC_verification_File -PathType Leaf
$MachineConfig_Leaf     = Test-Path -Path $Inst_rhid_Folder\$MachineConfig_File -PathType Leaf
$TC_CalibrationXML_Leaf = Test-Path -Path $Inst_rhid_Folder\$TC_CalibrationXML_File -PathType Leaf
$DannoAppConfigCheck    = Test-Path -Path $Inst_rhid_Result\"Data $HostName"\$DannoAppConfigXML_File -PathType Leaf
$DannoAppRhidCheck      = Test-Path -Path "D:\DannoGUI\DannoAppConfig.xml" -PathType Leaf
$OverrideSettingsXML_Leaf = Test-Path -Path $Inst_rhid_Folder\$OverrideSettingsXML_File -PathType Leaf

$Server_Internal    = Test-Path -Path "U:\$HostName\Internal\"
$USServer_Internal  = Test-Path -Path "Y:\$HostName\Internal\"
$Danno_leaf     = Test-Path -Path "U:\Dano Planning\Test Data\$HostName"
$US_Danno_leaf  = Test-Path -Path "Y:\Dano Planning\Test Data\$HostName"

$RealtimeProtection = Get-MpPreference | select-object DisableRealtimeMonitoring

$Debug = "off"
$exicode = $Null
$HistoryMode = "False"


. $PSScriptRoot\RHID_Str.ps1
. $PSScriptRoot\VerboseMode.ps1
# move verbose mode to above and add option to enable/disable
. $PSScriptRoot\XML_and_Config.ps1
. $PSScriptRoot\CheckSum.ps1
# add option to enable/disable script pre-run check
$t = New-TimeSpan -Seconds 8
$origpos = $host.UI.RawUI.CursorPosition
$spinner = @('☼', '♀', '♂', '♠', '♣', '♥', '♦', '#')
$spinnerPos = 0
$remain = $t
$d =( get-date) + $t
$remain = ($d - (get-date))

#coundown timer for script execution.
while ($remain.TotalSeconds -gt 0) {
	if ([Console]::KeyAvailable) {
		$key = [Console]::ReadKey($true).Key
		if ($key -in 'X', 'P', 'Spacebar', 'Enter') {
			break # keypress to break out from whileloop
		}
	}
			Write-Host (" {0} " -f $spinner[$spinnerPos%8]) -NoNewline
			write-host (" {0:d3}s {1:d3}ms : Press spacebar/enter to stop script execution" -f $remain.Seconds, $remain.MilliSeconds) -NoNewline
			$host.UI.RawUI.CursorPosition = $origpos
			$spinnerPos += 1
			Start-Sleep -seconds 0.5
			$remain = ($d - (get-date))
}
		$host.UI.RawUI.CursorPosition = $origpos
		Write-Host " * " -NoNewline

switch ($key) {
	('Spacebar' -or 'Enter') {
		break
	}
	P {
		debug
	}
	Q {
		# open HIDAutolite dialog		
	}
	C {
		Clear-Host
	}
	V {
		Start-Process "https://github.com/chenyong-ng/AutoFAT-run-data-generator/tree/stable"
	}
	default {
		. $PSScriptRoot\Branch.ps1
	}
}

if ($EnableDescriptions -eq "True") {
. $PSScriptRoot\RHID_Descriptions.ps1
}
# add switch to perform full backup
# generate temp files after input to prevent create junk files
$TempLogFile = Get-Item ([System.IO.Path]::GetTempFilename())
$TempXMLFile = Get-Item ([System.IO.Path]::GetTempFilename())
. $PSScriptRoot\RHID_XmlWriter.ps1
. $PSScriptRoot\RHID_Report.ps1
