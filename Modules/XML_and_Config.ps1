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

function TC_verification {
Write-Output "
Instrument SN   : $name
Time Created    : ${get-date}
Ambient + Probe : °C,  °C
Temp + Humidity : °C,  %
TC Probe ID   M :  
TC Stage 1  °C  :  [95.0 ± 0.25°C]
TC Stage 2  °C  :  [61.5 ± 0.25°C]
TC Stage 3  °C  :  [94.0 ± 0.25°C]
TC Stage 4  °C  :  [61.5 ± 0.25°C]
Airleak Test    : Passed/NA
Laser LD_488 S/N: 
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

function network {
    Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter IPEnabled=true -ComputerName . | ForEach-Object -Process { $_.InvokeMethod("EnableDHCP", $null) }
    Get-WmiObject -List | Where-Object -FilterScript { $_.Name -eq "Win32_NetworkAdapterConfiguration" } | ForEach-Object -Process { $_.InvokeMethod("ReleaseDHCPLeaseAll", $null) }
    Get-WmiObject -List | Where-Object -FilterScript { $_.Name -eq "Win32_NetworkAdapterConfiguration" } | ForEach-Object -Process { $_.InvokeMethod("RenewDHCPLeaseAll", $null) }
}

function debug {
. $PSScriptRoot\Info_Screens.ps1
. $PSScriptRoot\AdapterTypes.ps1

    $DIMM       = [string](wmic memorychip get Manufacturer,DeviceLocator,PartNumber | Select-String "A1_DIMM0","A1_DIMM1")
    $Ram        = (Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property capacity -Sum).sum /1GB
    $Disk       = [math]::Round((Get-Disk | Where-Object -FilterScript { $_.Bustype -eq "SATA"} | Measure-Object -Property size -Sum).sum /1GB)
    $DiskType   = [string](wmic diskdrive get InterfaceType,Model,Name | select-string "SATA", "IDE")
    $tz         = [System.TimeZoneInfo]::Local.DisplayName
    $RealtimeProtection = [bool] ([System.Convert]::ToString( (Get-MpPreference | select-object DisableRealtimeMonitoring) ) | select-string false)
    $currentPrincipal   = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    $AdminMode  = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    $Local = "{0:N4} MB" -f ((gci –force "E:\RapidHIT ID" –Recurse -ErrorAction SilentlyContinue| measure Length -sum ).sum / 1Mb)
    $Remote = "{0:N4} MB" -f ((gci –force "U:\$MachineName\Internal\"  –Recurse -ErrorAction SilentlyContinue| measure Length -sum ).sum / 1Mb)
    # add function to check USB device status

    $D = "DEBUG"
    "[$D] Path           : $env:Path"
    "[$D] Sn             : $sn"
    "[$D] Timezone       : $tz"
    "[$D] Computer Name  : $env:COMPUTERNAME"
    "[$D] MalwareScanner : $RealtimeProtection"
    "[$D] name           : $name"
    "[$D] SerialRegMatch : $SerialRegMatch" 
    "[$D] get-date       : ${get-date}"
    "[$D] rhid           : $rhid"
    "[$D] result         : $result"
    "[$D] nl             : $nl"
    "[$D] wv             : $wv"
    "[$D] tcc            : $tcc"
    "[$D] MachineConfig  : $MachineConfig"
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
    "[$D] Display        : $screen_cnt"
    "[$D] DIMM           : $DIMM"
    "[$D] Administrator? : $AdminMode"
    "[$D] Local Size ?   : $Local"
    "[$D] Remote Size?   : $Remote"
    $col_screens, $strMonitors
}