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
clear-host

#. $PSScriptRoot\..\config\XmlWriter.ps1


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
$InteralDisplay = "CHR $env:COMPUTERNAME (Internal)"
$DELL_Display   = "DEL $env:COMPUTERNAME (VGA)"
$SerialRegMatch = "$HostName" -match "RHID-\d\d\d\d"
$NewDate = ([String]$Date = Get-Date)
$psv = [string]($psversiontable.psversion)
$Inst_rhid_Folder   = "E:\RapidHIT ID"
$Inst_rhid_Result   = "E:\RapidHIT ID\Results"
$Nonlinearity_File  = "Non-linearity Calibration $HostName.PNG"
$Waves_File         = "Waves $HostName.PNG"
$TC_verification_File    = "TC_verification $HostName.TXT"
$MachineConfig_File  = "MachineConfig.xml"
$StatusData_File     = "StatusData_Graphs.pdf"
$GM_Analysis_File    = "GM_Analysis.sgf"
$TC_CalibrationXML_File = "TC_Calibration.xml"
$DannoAppConfigXML_File = "DannoAppConfig.xml"
$OverrideSettingsXML_File = "OverrideSettings.xml"
$TestResultXML_File     = "TestResult $HostName.xml"

$TestResultXML_Leaft    = Test-Path -Path $Inst_rhid_Result\$TestResultXML_File -PathType Leaf
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
$VerboseMode = "True"
$HistoryMode = "False"

. $PSScriptRoot\RHID_Str.ps1
. $PSScriptRoot\VerboseMode.ps1
. $PSScriptRoot\XML_and_Config.ps1

if ($SerialRegMatch -eq "True") {
    . $PSScriptRoot\MainFunction.ps1
    . $PSScriptRoot\RHID_Report.ps1
} else { 
    MainOptions } 