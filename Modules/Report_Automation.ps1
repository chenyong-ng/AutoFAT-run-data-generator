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

. $PSScriptRoot\GlobalVariables.ps1

. $PSScriptRoot\RHID_Str.ps1
. $PSScriptRoot\VerboseMode.ps1
# move verbose mode to above and add option to enable/disable
. $PSScriptRoot\XML_and_Config.ps1
. $PSScriptRoot\CheckSum.ps1
# add option to enable/disable script pre-run check
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
