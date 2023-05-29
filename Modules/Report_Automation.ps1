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
Clear-Host
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
$TempFile = Get-Item ([System.IO.Path]::GetTempFilename())

$TestResultLOG_Leaf     = Test-Path -Path $Inst_rhid_Result\$TestResultLOG_File -PathType Leaf
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
$VerboseMode = "False"
$HistoryMode = "False"

. $PSScriptRoot\RHID_Str.ps1
. $PSScriptRoot\VerboseMode.ps1
. $PSScriptRoot\XML_and_Config.ps1
. $PSScriptRoot\RHID_XmlWriter.ps1

  if ($SerialRegMatch -ne "True") {
    $RHID_FolderList = Get-ChildItem "$Drive\", "$US_Drive" | Where-Object { $_.PSIsContainer -and $_.Name -Match 'RHID-\d\d\d\d' }
    $RHID_FolderList | Format-wide -Property name -AutoSize
    Write-Host "$Info : List of available RHID run folders in Servers $Drive $US_Drive for checking ↑↑↑↑" -ForegroundColor Cyan
    "$Info : For latest update, get source code from Github:"
    "$Info : https://github.com/chenyong-ng/AutoFAT-run-data-generator/tree/stable"
    "$Info : Pacific Time is now : $PST_TimeZone"
    "$Info : Powershell version: $PSVersion on $HostName"
    "$Info : Created Temp file $TempFile for logging"
    If ($RealtimeProtection.DisableRealtimeMonitoring -match "false") {
        Write-Host "$Info : Realtime AntiMalware Protection is enabled, Script performance might be affected" -ForegroundColor Yellow
    }
    $SerialNumber = read-host "$Info : Enter Instrument Serial Number (4 digits) to proceed"
    $IndexedSerialNumber = $serialNumber[0] + $serialNumber[1] + $serialNumber[2] + $serialNumber[3]
    $LocalServerTestPath = Test-Path -Path $path-$IndexedSerialNumber
    $US_ServerTestPath = Test-Path -Path $US_path-$IndexedSerialNumber
    $serialNumber[4, 5, 6]
    
    If (($LocalServerTestPath -eq "True") -or ($US_ServerTestPath -eq "True")) {
      . $PSScriptRoot\RHID_Report.ps1
    } Else {
        Write-Host "[ RapidHIT ID]: selected Serial Number $IndexedSerialNumber does not have record in Server" -ForegroundColor Yellow 
    }
}

# "$Drive\RHID-\Internal\RapidHIT ID\Results\$TestResultLOG_File"
# created temp file and cpy to server?
# open log file and generate in background, if generated file larger than old one then copy to server and refresh
# *> "$Drive\RHID-$SerialNumber\Internal\RapidHIT ID\Results\$TestResultLOG_File"
# "$Drive\$HostName\Internal\$TestResultLOG_File"
# notepad $PSScriptRoot\..\CONFIG\REPORT.LOG