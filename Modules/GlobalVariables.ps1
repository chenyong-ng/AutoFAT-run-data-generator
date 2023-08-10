$PSDefaultParameterValues['*:Encoding'] = 'utf8'
$HostName                   = "$env:COMPUTERNAME"
$SystemTimeZone             = [System.TimeZoneInfo]::Local.DisplayName
$PST_TimeZone               = [System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId([DateTime]::Now, "Pacific Standard Time")
$NewGuid                    = [guid]::NewGuid().guid.toUpper()
$InteralDisplay             = "CHR $env:COMPUTERNAME (Internal)"
$DELL_Display               = "DEL $env:COMPUTERNAME (VGA)"
$SerialRegMatch             = "$HostName" -match "RHID-\d\d\d\d"
$NewDate                    = ([String](Get-Date -format "dddd dd MMMM yyyy HH:mm:ss:ms"))
$PSVersion                  = [string]($psversiontable.psversion)
# $SystemUptime             = (Get-Uptime).totalhours
$SystemUptime               = ((get-date) - ((Get-CimInstance -ClassName Win32_OperatingSystem).LastBootUpTime)).totalhours
$WhereGitExe                = (get-command git -ErrorAction SilentlyContinue).Path -match "git.exe"
$WhereGitFolder             = Test-Path -Path ".git"
if (($WhereGitExe -and $WhereGitFolder) -eq "True") {
    $GitCommitDate          = (git.exe log -1 --date=local --format=%cd)
    $GitCommitHash          = (git.exe rev-parse --short HEAD)
    $GitCommitBranch        = (git.exe branch --show current)
    $GitCommitInfo          = "GIT : Git Commit branch : $GitCommitBranch, ID: $GitCommitHash , Date : $GitCommitDate"
    # Get info from ScripConfig instead of probing the folder if git folder not available
}
$Inst_rhid_Folder           = "E:\RapidHIT ID"
$Inst_rhid_Result           = "E:\RapidHIT ID\Results"
$Nonlinearity_File          = "Non-linearity Calibration $MachineName.PNG"
$Waves_File                 = "Waves $MachineName.PNG"
$TC_verification_File       = "TC_verification $MachineName.TXT"
$MachineConfig_File         = "MachineConfig.xml"
$StatusData_File            = "StatusData_Graphs.pdf"
$GM_Analysis_File           = "GM_Analysis.sgf"
$TC_CalibrationXML_File     = "TC_Calibration.xml"
$DannoAppConfigXML_File     = "DannoAppConfig.xml"
$OverrideSettingsXML_File   = "OverrideSettings.xml"
$TestResultXML_File         = "TestResult $MachineName.xml"
$TestResultLOG_File         = "TestResult $MachineName.LOG"
$ScriptMetadataTXT          = "$Env:Temp\$HostName\Script_Metadata.txt"
$ScriptMetadataXML          = "$Env:Temp\$HostName\Script_Metadata.XML"

$LogTimerStart              = "$LogTimer : Logging Started at $(Get-Date -format "dddd dd MMMM yyyy HH:mm:ss:ms")"
$LogTimerEnd                = "$LogTimer : Logging Ended at $(Get-Date -format "dddd dd MMMM yyyy HH:mm:ss:ms")" 
$TestResultLOG_File         = "$Drive\$MachineName\Internal\RapidHIT ID\Results\TestResult $MachineName[$HostName].LOG"
$TestResultXML_File         = "$Drive\$MachineName\Internal\RapidHIT ID\Results\TestResult $MachineName[$HostName].XML"

$TestResultLOG_Leaf         = Test-Path -PathType Leaf -Path "$Drive\$MachineName\Internal\$TestResultLOG_File"
$TestResultXML_Leaf         = Test-Path -PathType Leaf -Path "$Drive\$MachineName\Internal\$TestResultXML_File"
$Nonlinearity_Leaf          = Test-Path -PathType Leaf -Path $Inst_rhid_Result\$Nonlinearity_File
$Waves_Leaf                 = Test-Path -PathType Leaf -Path $Inst_rhid_Result\$Waves_File
$Nonlinearity_Leaf_Server   = Test-Path -PathType Leaf -Path "$Drive\$MachineName\Internal\RapidHIT ID\Results\$Nonlinearity_File"
$Waves_Leaf_Server          = Test-Path -PathType Leaf -Path "$Drive\$MachineName\Internal\RapidHIT ID\Results\$Waves_File"
$TC_verification_Leaf       = Test-Path -PathType Leaf -Path $Inst_rhid_Result\$TC_verification_File
$MachineConfig_Leaf         = Test-Path -PathType Leaf -Path $Inst_rhid_Folder\$MachineConfig_File
$TC_CalibrationXML_Leaf     = Test-Path -PathType Leaf -Path $Inst_rhid_Folder\$TC_CalibrationXML_File
$DannoAppConfigCheck        = Test-Path -PathType Leaf -Path $Inst_rhid_Result\"Data $HostName"\$DannoAppConfigXML_File
$DannoAppRhidCheck          = Test-Path -PathType Leaf -Path "D:\DannoGUI\DannoAppConfig.xml"
$OverrideSettingsXML_Leaf   = Test-Path -PathType Leaf -Path $Inst_rhid_Folder\$OverrideSettingsXML_File
    
$Server_Internal            = Test-Path -Path "U:\$HostName\Internal\"
$USServer_Internal          = Test-Path -Path "Y:\$HostName\Internal\"
$Danno_leaf                 = Test-Path -Path "U:\Dano Planning\Test Data\$HostName"
$US_Danno_leaf              = Test-Path -Path "Y:\Dano Planning\Test Data\$HostName"

$RealtimeProtection         = Get-MpPreference | select-object DisableRealtimeMonitoring

$ConsoleWidth               = (Get-Host).UI.RawUI.buffersize.width
$Section_Separator          = ("=" * $ConsoleWidth) # Adaptive Consoles Seperator

$Debug = "off"
$exicode = $Null
$HistoryMode = "False"