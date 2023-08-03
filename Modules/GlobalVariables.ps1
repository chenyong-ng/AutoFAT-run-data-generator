$PSDefaultParameterValues['*:Encoding'] = 'utf8'
$HostName       = "$env:COMPUTERNAME"
$SystemTimeZone = [System.TimeZoneInfo]::Local.DisplayName
$PST_TimeZone   = [System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId([DateTime]::Now, "Pacific Standard Time")
$NewGuid        = [guid]::NewGuid().guid.toUpper()
$InteralDisplay = "CHR $env:COMPUTERNAME (Internal)"
$DELL_Display   = "DEL $env:COMPUTERNAME (VGA)"
$SerialRegMatch = "$HostName" -match "RHID-\d\d\d\d"
$NewDate        = ([String](Get-Date -format "dddd dd MMMM yyyy HH:mm:ss:ms"))
$PSVersion      = [string]($psversiontable.psversion)
# $SystemUptime = (Get-Uptime).totalhours
$SystemUptime   = ((get-date) - ((Get-CimInstance -ClassName Win32_OperatingSystem).LastBootUpTime)).totalhours
if (((get-command git -ErrorAction SilentlyContinue).Path -match "git.exe") -eq "True") {
    $GitCommitDate = (git log -1 --date=local --format=%cd)
    $GitCommitHash = (git rev-parse --short HEAD)
    $GitCommitBranch = (git branch --show current)
}
$Inst_rhid_Folder   = "E:\RapidHIT ID"
$Inst_rhid_Result   = "E:\RapidHIT ID\Results"
$Nonlinearity_File  = "Non-linearity Calibration $HostName.PNG"
$Waves_File         = "Waves $HostName.PNG"
$TC_verification_File = "TC_verification $HostName.TXT"
$MachineConfig_File = "MachineConfig.xml"
$StatusData_File    = "StatusData_Graphs.pdf"
$GM_Analysis_File   = "GM_Analysis.sgf"
$TC_CalibrationXML_File = "TC_Calibration.xml"
$DannoAppConfigXML_File = "DannoAppConfig.xml"
$OverrideSettingsXML_File = "OverrideSettings.xml"
$TestResultXML_File = "TestResult $MachineName.xml"
$TestResultLOG_File = "TestResult $MachineName.LOG"
$ScriptMetadataTXT  = "$Env:Temp\$HostName\Script_Metadata.txt"
$ScriptMetadataXML  = "$Env:Temp\$HostName\Script_Metadata.XML"

$TestResultLOG_Leaf = Test-Path -Path "$Drive\$HostName\Internal\$TestResultLOG_File" -PathType Leaf
$TestResultXML_Leaf = Test-Path -Path "$Drive\$HostName\Internal\$TestResultXML_File" -PathType Leaf
$Nonlinearity_Leaf  = Test-Path -Path $Inst_rhid_Result\$Nonlinearity_File -PathType Leaf
$Waves_Leaf         = Test-Path -Path $Inst_rhid_Result\$Waves_File -PathType Leaf
$TC_verification_Leaf = Test-Path -Path $Inst_rhid_Result\$TC_verification_File -PathType Leaf
$MachineConfig_Leaf = Test-Path -Path $Inst_rhid_Folder\$MachineConfig_File -PathType Leaf
$TC_CalibrationXML_Leaf = Test-Path -Path $Inst_rhid_Folder\$TC_CalibrationXML_File -PathType Leaf
$DannoAppConfigCheck = Test-Path -Path $Inst_rhid_Result\"Data $HostName"\$DannoAppConfigXML_File -PathType Leaf
$DannoAppRhidCheck  = Test-Path -Path "D:\DannoGUI\DannoAppConfig.xml" -PathType Leaf
$OverrideSettingsXML_Leaf = Test-Path -Path $Inst_rhid_Folder\$OverrideSettingsXML_File -PathType Leaf

$Server_Internal    = Test-Path -Path "U:\$HostName\Internal\"
$USServer_Internal  = Test-Path -Path "Y:\$HostName\Internal\"
$Danno_leaf         = Test-Path -Path "U:\Dano Planning\Test Data\$HostName"
$US_Danno_leaf      = Test-Path -Path "Y:\Dano Planning\Test Data\$HostName"

$RealtimeProtection = Get-MpPreference | select-object DisableRealtimeMonitoring
$HIDAutoLitev295    = "C:\Program Files (x86)\SoftGenetics\HIDAutoLite\V2.95 for IntegenX\Register.EXE"

$Debug = "off"
$exicode = $Null
$HistoryMode = "False"