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
$name = "$env:COMPUTERNAME"
$SystemTimeZone = [System.TimeZoneInfo]::Local.DisplayName
$InteralDisplay = "CHR $env:COMPUTERNAME (Internal)"
$DELL_Display = "DEL $env:COMPUTERNAME (VGA)"
$SerialRegMatch = "$name" -match "RHID-\d\d\d\d"
${get-date} = Get-date
$rhid   = "E:\RapidHIT ID"
$result = "E:\RapidHIT ID\Results"
$nl     = "Non-linearity Calibration $name.PNG"
$wv     = "Waves $name.PNG"
$tcc    = "TC_verification $name.TXT"
$MachineConfig  = "MachineConfig.xml"
$StatusData     = "StatusData_Graphs.pdf"
$GM_Analysis    = "GM_Analysis.sgf"
$nlc    = Test-Path -Path $result\$nl -PathType Leaf
$waves  = Test-Path -Path $result\$wv -PathType Leaf
$tc     = Test-Path -Path $result\$tcc -PathType Leaf
$mcleaf = Test-Path -Path $rhid\$MachineConfig -PathType Leaf
$internal      = Test-Path -Path "U:\$name\Internal\"
$US_internal   = Test-Path -Path "Y:\$name\Internal\"
$Danno_leaf    = Test-Path -Path "U:\Dano Planning\Test Data\$name"
$US_Danno_leaf = Test-Path -Path "Y:\Dano Planning\Test Data\$name"

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