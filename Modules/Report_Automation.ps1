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
#>
$ScreenWidth 	= [System.Windows.Forms.SystemInformation]::PrimaryMonitorSize.Width
$ScreenHeight 	= [System.Windows.Forms.SystemInformation]::PrimaryMonitorSize.Height

$ScriptConfigXML = "$PSScriptRoot\..\config\ScriptConfig.xml"
$ScriptConfig 	= ([XML](Get-Content $ScriptConfigXML -Encoding UTF8)).ScriptConfig

	$Danno 		= [String]$ScriptConfig.Global.Danno
if ($env:COMPUTERNAME -eq "SGSI11-59FKK13") {
	$Drive 		= [String]$ScriptConfig.Workstation.Drive
	$Path 		= [String]$ScriptConfig.Workstation.Path
	#$Danno 		= [String]$ScriptConfig.Workstation.Danno
	$US_Drive 	= [String]$ScriptConfig.Workstation.US_Drive
	$US_Path 	= [String]$ScriptConfig.Workstation.US_Path
	#$US_danno	= [String]$ScriptConfig.Workstation.US_danno
} else {
	$Drive 		= [String]$ScriptConfig.Default.Drive
	$Path 		= [String]$ScriptConfig.Default.Path
} #RHID Workststion laptop has differnt network drive path

$ScriptConfigINI = Get-Content $PSScriptRoot\..\config\ScriptConfig.ini | Select-Object -skip 0 | ConvertFrom-StringData

. $PSScriptRoot\GlobalVariables.ps1
. $PSScriptRoot\RHID_Str.ps1
. $PSScriptRoot\VerboseMode.ps1
# move verbose mode to above and add option to enable/disable
. $PSScriptRoot\XML_and_Config.ps1
. $PSScriptRoot\CheckSum.ps1
# add option to enable/disable script pre-run check
. $PSScriptRoot\RHID_Diagnostic.ps1
. $PSScriptRoot\CountDown.ps1

if ($EnableDescriptions -eq "True") {
. $PSScriptRoot\RHID_Descriptions.ps1
}
# add switch to perform full backup
# generate temp files after input to prevent create junk files
$TempLogFile = Get-Item ([System.IO.Path]::GetTempFilename())
$TempXMLFile = Get-Item ([System.IO.Path]::GetTempFilename())
. $PSScriptRoot\RHID_XmlWriter.ps1
. $PSScriptRoot\RHID_Report.ps1

