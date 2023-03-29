
function MachineConfigXML {
    Write-Output "<?xml version=""1.0"" encoding=""utf-8""?>
<InstrumentSettings xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"" xmlns:xsd=""http://www.w3.org/2001/XMLSchema"">
  <MachineName>$name</MachineName>
  <HWVersion>ID18-3</HWVersion>
  <MachineConfiguration>NoFLSpring V2SCI</MachineConfiguration>
  <DataServerUploadPath>U:\</DataServerUploadPath>
  <HP_HardstopZeroForce_mm>-1</HP_HardstopZeroForce_mm>
  <HP_Hardstop100Percent_mm>-1</HP_Hardstop100Percent_mm>
  <SCIState>
    <moduleID>Cartridge Interface</moduleID>
    <Clamp>IsDisengaged</Clamp>
    <Contamination>Clean</Contamination>
    <LastKnownValveState>Unknown</LastKnownValveState>
  </SCIState>
</InstrumentSettings>"
} #MachineConfig XML Creation


function TC_CalibrationXML {
  Write-Output "<?xml version=""1.0"" encoding=""utf-8""?>
<InstrumentSettings xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"" xmlns:xsd=""http://www.w3.org/2001/XMLSchema"">
  <MachineName>$name</MachineName>
  <TC_Calibration>
    <Offsets>GFE, NaN</Offsets>
    <!-- GFE protocols should have 9 comma separated numbers after the GFE identifier-->
    <Offsets>NGM, NaN, NaN</Offsets>
    <!-- NGM protocols should have 10 comma separated numbers after the NGM identifier -->
  </TC_Calibration>
</InstrumentSettings>"
}

function OverrideSettingsXML {
  Write-Output "<?xml version=""1.0"" encoding=""utf-8""?>
<InstrumentSettings xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"" xmlns:xsd=""http://www.w3.org/2001/XMLSchema"">
  <Protocols_GFE>
    <GFEProtocol>
      <Name>GFE-300uL-36cycles</Name>
      <TC_CycleRepeats>35</TC_CycleRepeats>
      <LysisVolume_uL>300</LysisVolume_uL>
    </GFEProtocol>
    <GFEProtocol>
      <Name>GFE-BV-3cycles</Name>
      <TC_CycleRepeats>2</TC_CycleRepeats>
    </GFEProtocol>
  </Protocols_GFE>
  <Protocols_NGM>
    <NGMProtocol>
      <Name>NGM-300uL-36cycles</Name>
      <TC_CycleRepeats>35</TC_CycleRepeats>
      <LysisVolume_uL>300</LysisVolume_uL>
    </NGMProtocol>
    <NGMProtocol>
      <Name>NGM-BV-3cycles</Name>
      <TC_CycleRepeats>2</TC_CycleRepeats>
    </NGMProtocol>
  </Protocols_NGM>
</InstrumentSettings>"
}


function TC_verification {
Write-Output "
Instrument SN   : $env:COMPUTERNAME
Time Created    : ${get-date}
Ambient + Probe :   °C,   °C
Temp + Humidity :   °C,   %
TC Probe ID     : M
TC Step 1       :   °C [95.0 ± 0.25°C]
TC Step 2       :   °C [61.5 ± 0.25°C]
TC Step 3       :   °C [94.0 ± 0.25°C]
TC Step 4       :   °C [61.5 ± 0.25°C]
Airleak Test    :  Passed/NA
"
} #for recording TC verification data
function Help2 {
    Write-Host "
Enter 'e'  to search specific text,
Enter 'd'  to show Critical Diagnostic Code,
Enter 'v'  to show Verbose infomation of Gel Void Volume,
Enter 'v2' to show Gel Void Volume with BEC ID,
Enter 'p'  to show Test Progress,
Enter 'b'  to show only Bolus test result in server,
Enter 'b2' to show all Bolus test result,
Enter 't'  to show temp and humidity data fron DannoGUI,
Enter 'i'  to show HIDAuto Lite 2.9.5 for IntegenX trail license status,
Enter 'j'  to show Boxprep SoftGenetics License activation status,
Enter 'w'  to show Istrument hardware info, Timezone setting"
} # to listing secondary option

function MainOptions {
Write-Host "List of available RHID run folders for checking" -ForegroundColor Cyan
$RHID_FolderList = Get-ChildItem "$Drive\","$US_Drive" | Where-Object { $_.PSIsContainer -and $_.Name -Match 'RHID-\d\d\d\d' }
$RHID_FolderList | Format-table -autosize -hidetableheaders -wrap -property name
$SerialNumber = read-host "Enter Instrument Serial Number (4 digits) to proceed"

If ((Test-Path -Path "$path-$SerialNumber") -eq "True") {
  $serverdir = "$path-$SerialNumber"
  . $PSScriptRoot\RHID_Report.ps1
} elseif ((Test-Path -Path "$US_path-$SerialNumber") -eq "True") {
    $serverdir = "$US_path-$SerialNumber"
    $Drive = $US_Drive
    . $PSScriptRoot\RHID_Report.ps1
} Else {
    Write-Host "[ RapidHIT ID]: selected Serial Number $SerialNumber does not have record in Server" -ForegroundColor Yellow}
}
<#
Enter 1 to Paste folder path, can be folder in server or instrument local folder,
Enter 2 to Backup Instrument runs data to server, for Pre-Boxprep or Backup before re-imaging the instrument,
if ($SerialNumber -eq '1') {
  $SerialNumber = read-host "Enter Folder Path"
  set-variable -name "serverdir" -value "$SerialNumber"
} elseif ($SerialNumber -eq '2') {
  mkdir U:\"$name"\Internal\
    BackupBeforeShipprep
} elseif 
#>
function BackupBeforeShipprep {
  Copy-Item -Force -Recurse -Exclude "System Volume Information", "*RECYCLE.BIN", "bootsqm.dat" "E:\*" -Destination "U:\$MachineName\Internal\"
}

function BackupConfig {
New-Item -ItemType Directory -Force -Path "U:\$name\Internal\RapidHIT ID\Results\" -ErrorAction SilentlyContinue
Copy-Item "E:\RapidHIT ID\*" U:\"$name\Internal\RapidHIT ID"\Results\ -Exclude @("Data $MachineName") -Recurse
}

function network {
    Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter IPEnabled=true -ComputerName . | ForEach-Object -Process { $_.InvokeMethod("EnableDHCP", $null) }
    Get-WmiObject -List | Where-Object -FilterScript { $_.Name -eq "Win32_NetworkAdapterConfiguration" } | ForEach-Object -Process { $_.InvokeMethod("ReleaseDHCPLeaseAll", $null) }
    Get-WmiObject -List | Where-Object -FilterScript { $_.Name -eq "Win32_NetworkAdapterConfiguration" } | ForEach-Object -Process { $_.InvokeMethod("RenewDHCPLeaseAll", $null) }
    Get-ComputerInfo
    systeminfo
}

function debug {
. $PSScriptRoot\Info_Screens.ps1
. $PSScriptRoot\AdapterTypes.ps1

    $PSversion  = ($PSversionTable | select-object psversion | Format-table -Autosize -HideTableHeaders -wrap)
    $DIMM       = [string](wmic memorychip get Manufacturer,DeviceLocator,PartNumber | Select-String "A1_DIMM0","A1_DIMM1")
    $Ram        = (Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property capacity -Sum).sum /1GB
    $Disk       = [math]::Round((Get-Disk | Where-Object -FilterScript { $_.Bustype -eq "SATA"} | Measure-Object -Property size -Sum).sum /1GB)
    $DiskType   = [string](wmic diskdrive get InterfaceType,Model,Name | select-string "SATA", "IDE")
    $RealtimeProtection = [bool] ([System.Convert]::ToString( (Get-MpPreference | select-object DisableRealtimeMonitoring) ) | select-string false)
    $currentPrincipal   = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    $AdminMode  = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    # add function to check USB device status

    $D = "DEBUG"
    "[$D] Path           : $env:Path"
    "[$D] Computer Name  : $env:COMPUTERNAME"
    "[$D] name           : $name" ; "[$D] Sn             : $sn"
    "[$D] SerialRegMatch : $SerialRegMatch" 
    "[$D] get-date       : ${get-date}"
    "[$D] rhid           : $rhid"
    "[$D] result         : $result"
    "[$D] nl             : $nl"
    "[$D] wv             : $wv"
    "[$D] tcc            : $tcc"
    "[$D] nlc            : $nlc"
    "[$D] waves          : $waves"
    "[$D] tc             : $tc"
    "[$D] mcleaf         : $mcleaf"
    "[$D] internal       : $internal"
    "[$D] serverdir      : $serverdir"
    "[$D] danno          : $danno"
    "[$D] Ram            : $Ram GB"
    "[$D] SystemDiskSize : $Disk GB"
    "[$D] SystemDiskinfo : $Disktype"
    "[$D] exicode        : $exicode"
    "[$D] Display        : $screen_cnt"; "[$D] DIMM           : $DIMM"
    "[$D] Administrator ?: $AdminMode" ; "[$D] MalwareScanner : $RealtimeProtection"
    "[$D] Local Folder  ?: $Local"     ; "[$D] Remote Folder ?: $Remote"
    "[$D] PSVersion     ?:";" $PSversion"
    $col_screens, $strMonitors
    Add-Type -Assembly System.Windows.Forms; [Windows.Forms.SystemInformation]::ScreenOrientation
}


<#
Folder PATH listing for volume SQL Data Files
Volume serial number is 68AE-8CE0
U:.
├───Internal
│   ├───im
│   ├───logs
│   └───RapidHIT ID
│       └───Results
│           └───Data RHID-0486

#>