<#
.Title          : Powershell Utility for RHID Instrument
.Source         : https://github.com/chenyong-ng/AutoFAT-run-data-generator
.Version        :	v0.4
.License        : Public Domain
.Revision Date  : 10 JUL 2022
.Description    : This script are best viewed and edit in Visual Studio Code https://code.visualstudio.com/
.Todo           : 
#>

IF ([Bool]$RunSummaryCSV -eq "true") {
$RHID_Protocol_Setting = ($RunSummaryCSV | Select-String "Protocol_Setting" | Select-object -last 1).Line.Split(",") | Select-Object -Last 1
$RHID_RunType        = ($RunSummaryCSV | Select-String "Run_Type" | Select-object -last 1).Line.Split(",") | Select-Object -Last 1
$RHID_Cartridge_ID   = ($RunSummaryCSV | Select-String "Cartridge_ID" | Select-object -last 1).Line.Split(",") | Select-Object -Last 1
$RHID_Cartridge_Type = ($RunSummaryCSV | Select-String "Cartridge_Type" | Select-object -last 1).Line.Split(",") | Select-Object -Last 1
$RHID_SampleName     = ($RunSummaryCSV | Select-String "SampleName" | Select-object -last 1).Line.Split(",") | Select-Object -Last 1
$RHID_BEC_ID         = ($RunSummaryCSV | Select-String "BEC_ID" | Select-object -last 1).Line.Split(",") | Select-Object -Last 1
$RHID_Bolus_Timing   = ($RunSummaryCSV | Select-String "Bolus_Timing" | Select-object -last 1).Line.Split(",") | Select-Object -Last 1
$RHID_Date_Time      = ($RunSummaryCSV | Select-String "Date_Time" | Select-object -last 1).Line.Split(",") | Select-Object -Last 1
}
