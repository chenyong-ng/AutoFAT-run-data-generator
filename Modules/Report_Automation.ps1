<#
.Title          : Powershell Utility for RHID Instrument
.Source         : https://github.com/chenyong-ng/AutoFAT-run-data-generator
.Version        :	v0.4
.License        : Public Domain
.Revision Date  : 10 JUL 2022
.Todo           : Set display resolution, change to display 2, check exported PDF  leaf from full  [DONE]
                : Print RFID of BEC, Sample Cartridge. separate mtss test with prefix such sd [HEATER], [SCI] etc., add history and test count, apply no filter.
                : add method to check folderand run function if found 
                : Add more meaningful error message, add USB devices detection
                : add auto backup, add folder check
                : Add more meaningful error message, add error code and instrument troubleshooting information
                get data from run summary, then grep on sample quality data
                REVERT set-location on full run, set auto backup

Initialize global variables, do not change the order.
#>
clear-host
<#
$ini = Get-Content $PSScriptRoot\..\ScriptConfig.ini
$ini[0, 1, 2]


  $ScriptConfig = ([xml](Get-Content $PSScriptRoot\..\ScriptConfig.xml)).ScriptConfig
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
$PST_TimeZone = [System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId([DateTime]::Now, "Pacific Standard Time")
$InteralDisplay = "CHR $env:COMPUTERNAME (Internal)"
$DELL_Display = "DEL $env:COMPUTERNAME (VGA)"
$SerialRegMatch = "$HostName" -match "RHID-\d\d\d\d"
${get-date} = Get-date
$psv = [string]($psversiontable.psversion)
$Inst_rhid_Folder = "E:\RapidHIT ID"
$Inst_rhid_Result = "E:\RapidHIT ID\Results"
$Nonlinearity_File = "Non-linearity Calibration $HostName.PNG"
$Waves_File     = "Waves $HostName.PNG"
$TC_verification_File    = "TC_verification $HostName.TXT"
$MachineConfig_File  = "MachineConfig.xml"
$StatusData_File     = "StatusData_Graphs.pdf"
$GM_Analysis_File    = "GM_Analysis.sgf"
$TC_CalibrationXML_File = "TC_Calibration.xml"
$DannoAppConfigXML_File = "DannoAppConfig.xml"

$Nonlinearity_Leaf    = Test-Path -Path $Inst_rhid_Result\$Nonlinearity_File -PathType Leaf
$Waves_Leaf  = Test-Path -Path $Inst_rhid_Result\$Waves_File -PathType Leaf
$TC_verification_Leaf     = Test-Path -Path $Inst_rhid_Result\$TC_verification_File -PathType Leaf
$MachineConfig_Leaf = Test-Path -Path $Inst_rhid_Folder\$MachineConfig_File -PathType Leaf
$TC_CalibrationXML_Leaf = Test-Path -Path $Inst_rhid_Folder\$TC_CalibrationXML_File -PathType Leaf
$DannoAppConfigCheck = Test-Path -Path "E:\RapidHIT ID\Results\Data $HostName\DannoAppConfig.xml" -PathType Leaf
$DannoAppRhidCheck = Test-Path -Path "D:\DannoGUI\DannoAppConfig.xml" -PathType Leaf

$internal      = Test-Path -Path "U:\$HostName\Internal\"
$US_internal   = Test-Path -Path "Y:\$HostName\Internal\"
$Danno_leaf    = Test-Path -Path "U:\Dano Planning\Test Data\$HostName"
$US_Danno_leaf = Test-Path -Path "Y:\Dano Planning\Test Data\$HostName"

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