$PSDefaultParameterValues['*:Encoding'] = 'utf8'
$ErrorActionPreference      = 'silentlycontinue' # Script-wide error message supression
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
$CheckLan                   = (Get-NetIPAddress -InterfaceAlias "Ethernet*" -addressfamily "IPv4").interfacealias
                            # [Bool]((Get-NetConnectionProfile).interfacealias[0..2] -match "Ethernet")
$CheckWifi                  = (Get-NetIPAddress -InterfaceAlias "Wi-Fi*" -addressfamily "IPv4").interfacealias
                            # [Bool]((Get-NetConnectionProfile).interfacealias[0..2] -match "Wi-Fi")
$CheckInternet              = [bool]((Get-NetConnectionProfile).IPv4Connectivity[0..2] -match "Internet")
$WiFiIPaddress              = (Get-NetIPAddress -InterfaceAlias "Wi-Fi*" -addressfamily "IPv4","IPv6").ipaddress
$LANIPaddress               = (Get-NetIPAddress -InterfaceAlias "Ethernet*" -addressfamily "IPv4","IPv6").ipaddress
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
$TestResultXML_File         = "TestResult $MachineName[$HostName].XML"
$TestResultLOG_File         = "TestResult $MachineName[$HostName].LOG"
$ScriptMetadataTXT          = "$Env:Temp\$HostName\Script_Metadata.txt"
$ScriptMetadataXML          = "$Env:Temp\$HostName\Script_Metadata.XML"

$LogTimerStart              = "Logging Started at $(Get-Date -format "dddd dd MMMM yyyy HH:mm:ss:ms")"
$LogTimerEnd                = "Logging Ended at $(Get-Date -format "dddd dd MMMM yyyy HH:mm:ss:ms")" 
$TestResultLOG_FullPath     = "$Drive\$MachineName\Internal\RapidHIT ID\Results\$TestResultLOG_File"
$TestResultXML_FullPath     = "$Drive\$MachineName\Internal\RapidHIT ID\Results\$TestResultXML_File"
#todo clean up duplicates and move testresultlog generator to other place
$TestResultLOG_Leaf         = Test-Path -PathType Leaf -Path $TestResultLOG_FullPath
$TestResultXML_Leaf         = Test-Path -PathType Leaf -Path $TestResultXML_FullPath
$Nonlinearity_Leaf          = Test-Path -PathType Leaf -Path $Inst_rhid_Result\$Nonlinearity_File
$Waves_Leaf                 = Test-Path -PathType Leaf -Path $Inst_rhid_Result\$Waves_File
$Nonlinearity_Leaf_Server   = Test-Path -PathType Leaf -Path "$Drive\$MachineName\Internal\RapidHIT ID\Results\$Nonlinearity_File"
$Waves_Leaf_Server          = Test-Path -PathType Leaf -Path "$Drive\$MachineName\Internal\RapidHIT ID\Results\$Waves_File"
$TC_verification_Leaf       = Test-Path -PathType Leaf -Path $Inst_rhid_Result\$TC_verification_File
$MachineConfig_Leaf         = Test-Path -PathType Leaf -Path $Inst_rhid_Folder\$MachineConfig_File
$TC_CalibrationXML_Leaf     = Test-Path -PathType Leaf -Path $Inst_rhid_Folder\$TC_CalibrationXML_File
$DannoAppConfigCheck        = Test-Path -PathType Leaf -Path $Inst_rhid_Result\"Data $HostName"\$DannoAppConfigXML_File
$DannoAppRhidCheck          = Test-Path -PathType Leaf -Path "D:\DannoGUI\$DannoAppConfigXML_File"
$OverrideSettingsXML_Leaf   = Test-Path -PathType Leaf -Path $Inst_rhid_Folder\$OverrideSettingsXML_File
    
$Server_Internal            = Test-Path -Path "$Drive\$HostName\Internal\"
$USServer_Internal          = Test-Path -Path "$US_Drive\$HostName\Internal\"
$Danno_leaf                 = Test-Path -Path "$Drive\Dano Planning\Test Data\$HostName"
$US_Danno_leaf              = Test-Path -Path "$US_Drive\Dano Planning\Test Data\$HostName"

$NotepadAPP                 = [String]$ScriptConfig.Apps.Notepad

$RealtimeProtection         = (Get-MpPreference | select-object DisableRealtimeMonitoring).DisableRealtimeMonitoring

$ConsoleWidth               = (Get-Host).UI.RawUI.buffersize.width
$Section_Separator          = ("=" * $ConsoleWidth) # Adaptive Consoles Seperator

$Debug = "off"
$exicode = $Null
$HistoryMode = "False"