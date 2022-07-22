<#
.Title        : Powershell Utility for RHID Instrument
.Source       : https://github.com/chenyong-ng/AutoFAT-run-data-generator
.Version      :	v0.4
.License      : Public Domain
.Revision Date: 10 JUL 2022
.Todo         : Set display resolution, change to display 2, check exported PDF  leaf from full run, add win10 patch autorun
#>

<#
Initialize global variables, do not change the order.
#>

#$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
#$currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)


if ($name -eq "SGSI11-59FKK13") {
    $path = "S:\"
    $danno = "S:\Dano Planning\Test Data"
    $US_Path = "Y:\"
    $US_danno = "Y:\Dano Planning\Test Data"
}
else {
    $path = "U:\"
    $danno = "U:\Dano Planning\Test Data"
} #RHID Workststion laptop has differnt network drive path

$PSDefaultParameterValues['*:Encoding'] = 'utf8'
$name = $env:COMPUTERNAME
$SerialRegMatch = "$name" -match "RHID-\d\d\d\d"
${get-date} = Get-date
$rhid = "E:\RapidHIT ID"
$result = "E:\RapidHIT ID\Results"
$nl = "Non-linearity Calibration $name.PNG"
$wv = "Waves $name.PNG"
$tcc = "TC_verification $name.TXT"
$MachineConfig = "MachineConfig.xml"
$StatusData = "StatusData_Graphs.pdf"
$GM_Analysis = "GM_Analysis.sgf"
$nlc = Test-Path -Path $result\$nl -PathType Leaf
$waves = Test-Path -Path $result\$wv -PathType Leaf
$tc = Test-Path -Path $result\$tcc -PathType Leaf
$mcleaf = Test-Path -Path $rhid\$MachineConfig -PathType Leaf
$internal = Test-Path -Path "U:\$name\Internal\"
$exicode = "Null"

#File detection and file size calculation
if ($waves -eq $True) { $wvfs = (Get-Item $result\$wv | ForEach-Object { [math]::ceiling($_.length / 1KB) }) }
if ($nlc -eq $True) { $nlfs = (Get-Item $result\$nl | ForEach-Object { [math]::ceiling($_.length / 1KB) }) }

function Set-WindowStyle {
    param(
        [Parameter()]
        [ValidateSet('FORCEMINIMIZE', 'HIDE', 'MAXIMIZE', 'MINIMIZE', 'RESTORE', 
            'SHOW', 'SHOWDEFAULT', 'SHOWMAXIMIZED', 'SHOWMINIMIZED', 
            'SHOWMINNOACTIVE', 'SHOWNA', 'SHOWNOACTIVATE', 'SHOWNORMAL')]
        $Style = 'SHOW',
        [Parameter()]
        $MainWindowHandle = (Get-Process -Id $pid).MainWindowHandle
    )
    $WindowStates = @{
        FORCEMINIMIZE = 11; HIDE = 0
        MAXIMIZE = 3; MINIMIZE = 6
        RESTORE = 9; SHOW = 5
        SHOWDEFAULT = 10; SHOWMAXIMIZED = 3
        SHOWMINIMIZED = 2; SHOWMINNOACTIVE = 7
        SHOWNA = 8; SHOWNOACTIVATE = 4
        SHOWNORMAL = 1
    }
    Write-Verbose ("Set Window Style {1} on handle {0}" -f $MainWindowHandle, $($WindowStates[$style]))

    $Win32ShowWindowAsync = Add-Type –memberDefinition @” 
    [DllImport("user32.dll")] 
    public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);
“@ -name “Win32ShowWindowAsync” -namespace Win32Functions –passThru

    $Win32ShowWindowAsync::ShowWindowAsync($MainWindowHandle, $WindowStates[$Style]) | Out-Null
}

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
    Write-Output "Instrument SN  : $name
Time Created    : ${get-date}
Ambient + Probe : °C,  °C
Temp + Humidity : °C,  %
TC Probe ID   M :  [-----SPEC----]
Stage 1     °C  :  [95.0 ± 0.25°C]
Stage 2     °C  :  [61.5 ± 0.25°C]
Stage 3     °C  :  [94.0 ± 0.25°C]
Stage 4     °C  :  [61.5 ± 0.25°C]
Airleak Test    : Passed/NA
Laser LD_488 S/N: "
} #for recording TC verification data

function Help2 {
    Write-Host "
Enter 'e'  to search specific text,
Enter 'd'  to show Critical Diagnostic Code,
Enter 'v'  to show Gel Void Volume,
Enter 'v2' to show Gel Void Volume with BEC ID,
Enter 'p'  to show Test Progress,
Enter 'b'  to show only Bolus test result in server,
Enter 'b2' to show all Bolus test result,
Enter 't'  to show temp and humidity data fron DannoGUI,
Enter 'i'  to show HIDAuto Lite 2.9.5 for IntegenX trail license status,
Enter 'j'  to show Boxprep SoftGenetics License activation status,
Enter 'w'  to show Istrument hardware info, Timezone setting"
} # to listing secondary option

function Main {
    If ($SerialRegMatch -eq $True) {
        (Get-Process -Name PowerShell).MainWindowHandle | ForEach-Object { Set-WindowStyle MAXIMIZE $_ }
        $StatusData_leaf = Get-ChildItem -Path "$path$name\" -I $StatusData  -R | Test-path -PathType Leaf
        $GM_Analysis_leaf = Get-ChildItem -Path "$path$name\" -I $GM_Analysis -R | Test-path -PathType Leaf
        Write-host "[Info   ]: RapidHIT Instrument $name detected, creating Server folder, Non-linearity Calibration and Waves place-holder file."
        "[Info   ]: Force audio volume to 50%"
        . U:\"RHID Troubleshooting"\set-volume.ps1
        [audio]::Volume = 0.5
        Set-MpPreference -DisableRealtimeMonitoring $true
        if ([Bool] ($StatusData_leaf) -eq "True" ) {
            "[Info   ]: Found $StatusData in these folders"
            Get-ChildItem -Path "$path$name\*" -I $StatusData  -R | Format-table Directory -Autosize -HideTableHeaders -wrap
        }
        else { Write-host "[Info   ]: $StatusData not found, PDF not exported or no full run has been performed" -ForegroundColor yellow }
        if ([Bool] ($GM_Analysis_leaf) -eq "True" ) {
            "[Info   ]: Found $GM_Analysis in these folders"
            Get-ChildItem -Path "$path$name\*" -I $GM_Analysis -R | Format-table Directory -Autosize -HideTableHeaders -wrap
        }
        else { Write-host "[Info   ]: $GM_Analysis not found or no full run has been performed" -ForegroundColor yellow }
        Get-ItemPropertyValue 'HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{96236EEA-504A-4395-8C4D-299A6CA26A3F}_is1' 'DisplayName'
        if ($internal -eq $True) {
            Write-host "[Info   ]: U:\$name\Internal\ already exists in server, skipping"
        }
        elseif ($internal -eq $False) {
            mkdir U:\"$name"\Internal\
            Write-host "[Info   ]: Server path $internal sucessfully created."
        }
        Set-Location $result
        if ($nlc -eq $False) {
            New-Item -Path "Non-linearity Calibration $name.PNG" -ItemType File
            Write-host "[Info   ]: Created placeholder file: Non-linearity Calibration $name.PNG"
        }
        elseif ($nlfs -eq '0') {
            Write-host "[Warning]: Empty file $nl detected, reported as $nlfs KB" -ForegroundColor red
        }
        else {
            Write-Host "[Info   ]: 'Non-linearity Calibration $name.PNG' already exists, skipping, File size is:" $nlfs KB
        }
        if ($waves -eq $False) {
            New-Item -Path "Waves $name.PNG" -ItemType File
            Write-host "[Info   ]: Created placeholder file: Waves $name.PNG"
        }
        elseif ($wvfs -eq '0') {
            Write-host "[Warning]: Empty file $wv detected, reported as $wvfs KB" -ForegroundColor red
        }
        else {
            Write-Host "[Info   ]: 'Waves $name.PNG' already exists, skipping, File size is:" $wvfs KB
        }

        if ($mcleaf -eq $False) {
            MachineConfigXML > $rhid\$MachineConfig
            Write-host "[Info   ]: '$MachineConfig' created"
        }
        else {
            Write-Host "[Info   ]: '$MachineConfig' already exists, skipping"
        }
        if ($tc -eq $False) {
            TC_verification > "TC_verification $name.TXT"
            Write-host "[Info   ] : Created placeholder file: TC_verification $name.TXT"
        }
        else {
            Write-Host "[Info   ]: 'TC_verification $name.TXT' already exists, skipping"
            Get-Content "TC_verification $name.TXT"
        }

        $keypress = read-host "[Info   ]: Enter y to open Snipping tool and Waves for taking screenshot, Enter to skip"
        "[Info   ]: Make sure AutoFAT is not running, as Waves will cause resource conflict"
        if ($keypress -eq 'y') {
            Start-Process -WindowStyle Minimized -FilePath notepad.exe "TC_verification $name.TXT"
            Start-Process -WindowStyle Minimized -FilePath SnippingTool.exe
            Start-Process -WindowStyle Minimized -FilePath C:\"Program Files (x86)\RGB Lasersystems"\Waves\Waves.exe
            Start-Process -WindowStyle Minimized -FilePath D:\gui-sec\gui_sec_V1001_4_79.exe
        }
    } # Main function to check whether if it's RHID instrument or Workstation
}

function network {
    Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter IPEnabled=true -ComputerName . | ForEach-Object -Process { $_.InvokeMethod("EnableDHCP", $null) }
    Get-WmiObject -List | Where-Object -FilterScript { $_.Name -eq "Win32_NetworkAdapterConfiguration" } | ForEach-Object -Process { $_.InvokeMethod("ReleaseDHCPLeaseAll", $null) }
    Get-WmiObject -List | Where-Object -FilterScript { $_.Name -eq "Win32_NetworkAdapterConfiguration" } | ForEach-Object -Process { $_.InvokeMethod("RenewDHCPLeaseAll", $null) }
}

function w {
    Get-WmiObject Win32_BaseBoard
    Get-WmiObject win32_physicalmemory | Format-Table Manufacturer, Banklabel, Configuredclockspeed, Devicelocator, Capacity, Serialnumber -autosize
    Get-Disk | Where-Object -FilterScript { $_.Bustype -or "SATA" -or "NVME" -or "RAID" -or "USB" }
    Get-Timezone
}

function j { 
    #     $sn2 = read-host "Checking archived U.S. server Boxprep SoftGenetics License key, Enter Instrument Serial number"
    #     set-variable -name "serverdir" -value "Y:\Dano Planning\Test Data\RHID-$sn2"
    # add more function to check single, or multiple license key
    $sn2 = read-host "Enter Instrument Serial number to check HID Autolite License key"
    Get-ChildItem "$danno\RHID-$sn2" -I *BoxPrepLog_RHID* -R  -Exclude "*.log" | Select-String "SoftGenetics License number provided is"
    
}

function debug {
    $D = "DEBUG"
    "[$D] Path           : $env:Path"
    "[$D] Sn             : $sn"
    "[$D] Computer Name  : $env:COMPUTERNAME"
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
    "[$D] exicode        : $exicode"
}


debug
Main

$sn = read-host "
Enter Insutrment Serial Number, format should be 0###, eg, 0485,
Enter again to search local folder E:\RapidHIT ID test result, should use within Instrument only,
Enter 1 to Paste folder path, can be folder in server or instrument local folder,
Enter 5 to Backup Instrument config and calibrated TC data to Local server,
Enter 6 to Backup Instrument runs data to server, for Pre-Boxprep or Backup before re-imaging the instrument,
Enter number to proceed"

if ($sn -eq '1') {
    $sn = read-host "Enter Folder Path"
    set-variable -name "serverdir" -value "$sn"
}
elseif ($sn -eq '5') {
    mkdir U:\"$name\Internal\RapidHIT ID"\Results\
    Copy-Item E:\"RapidHIT ID"\*.xml U:\"$name\Internal\RapidHIT ID"\
    Copy-Item E:\"RapidHIT ID"\Results\*.PNG , E:\"RapidHIT ID"\Results\*.TXT U:\"$name\Internal\RapidHIT ID"\Results\
}
elseif ($sn -eq '6') {
    mkdir U:\"$name"\Internal\
    Copy-Item -Force -Recurse -Exclude "System Volume Information", "*RECYCLE.BIN", "bootsqm.dat" "E:\*" -Destination U:\"$name"\Internal\
}
elseif ($sn -eq '') {
    set-variable -name "serverdir" -value "E:\RapidHIT ID"
}
else 
{ set-variable -name "serverdir" -value "$path-$sn" }

<# text string searching/filtering #>
function d {
    Get-ChildItem "$serverdir" -I storyboard*.* -R | Select-String "Critical diagnostics code"
}

function v {
    Get-ChildItem "$serverdir" -I storyboard*.* -R | Select-String "Estimated gel void volume"
}

function v2 {
    Get-ChildItem "$serverdir" -I storyboard*.* -R | Select-String "Gel syringe record" , "Cartridge Type" , "ID Number" , "Estimated gel void volume"
}

function b {
    Get-ChildItem "$serverdir"  -I  storyboard*.* -R | Select-String "Bolus Devliery Test", "% in DN", "Volume  =", "Timing =", "Bolus Current"
}

<#"Cartridge Type" , "ID Number"#>
function p {
    Get-ChildItem "$serverdir" -I storyboard*.* -R | Select-String "Lysis Heater FAT", "DN FAT", "PCR FAT", "Optics Heater FAT", "Gel Cooling FAT", "Ambient FAT", 
    "SCI Sensor/CAM FAT", "FRONT END FAT", "Bring Up: FE Motor Calibration", "Bring Up: FE Motor Test", "Bring Up: Homing Error Test", "Bring Up: FL Homing Error w/CAM Test", "SCI Antenna Test",
    "MEZZ test", "LP FAT", "HP FAT", "Anode Motor FAT", "BEC Interlock FAT", "Bring Up: Gel Antenna", "Syringe Stallout FAT", "Mezzboard FAT",
    "Piezo FAT", "HV FAT", "Laser FAT", "Bring Up: Verify Raman" , "Bring Up: Lysate Pull Test", "Lysis Volume", "Bring Up: Water Prime", " Bring Up: Lysis Prime", "Bring Up: Buffer Prime", "Bring Up: Capillary Gel Prime"
}

function pd {
    Get-ChildItem "$serverdir" -I storyboard*.* -R | Select-String "Lysis Heater FAT: PASS", "DN FAT: PASS", "PCR FAT: PASS", "Optics Heater FAT: PASS", "Gel Cooling FAT", "Ambient FAT", 
    "SCI Sensor/CAM FAT", "FRONT END FAT", "MEZZ test", "LP FAT", "HP FAT", "Anode Motor FAT", "BEC Interlock FAT", "Bring Up: Gel Antenna", "Syringe Stallout FAT", "Mezzboard FAT",
    "Piezo FAT", "HV FAT", "Laser FAT", "Bring Up: Verify Raman" , "Bring Up: Lysate Pull Test" , "Lysis Volume", "Bring Up: Water Prime", " Bring Up: Lysis Prime", "Bring Up: Buffer Prime", "Bring Up: Capillary Gel Prime"
}

#"$serverdir\Internal\RapidHIT ID"
function config {
    If ($SerialRegMatch -eq $True) {
        Write-host "Instrument S/N: $name"
        set-variable -name "serverdir" -value "E:\RapidHIT ID"
    }
    Get-ChildItem "$serverdir" -I  MachineConfig.xml, TC_Calibration.xml -R | Select-String "MachineName", "HWVersion", "MachineConfiguration", "DataServerUploadPath", "<HP_HardstopZeroForce_mm>", "<HP_Hardstop100Percent_mm>",
    "FluidicHomeOffset", "PreMixHomeOffset", "DiluentHomeOffset", "SyringePumpStallCurrent", "SyringePumpResetCalibration", "LastBEC_TagID", "double", "RunsSinceLastGelFill", "DeliveredSamples", "LaserHours", "<Offsets>"
    Get-Childitem "$serverdir" -I TC_verification*.* -R | Get-Content
    #Get-Content -Path "TC_verification $name.TXT"
}

function e {
      ($custom = read-host "Enter specific text to search, for example 'Q-mini serial number: 2531',
Optics Monitor, Raman line Gaussian fit, etc, seach range limited to Storyboard, MachineConfig, TC Calibation and Boxpreplog") -and (set-variable -name "custom" -value "$custom")
    Get-ChildItem "$serverdir"  -I  storyboard*.* , MachineConfig.xml, TC_Calibration.xml, *BoxPrepLog_RHID* -R | Select-String "$custom"
}

function b2 {
    Get-ChildItem "$serverdir\*Bolus Delivery Test*"  -I  storyboard*.* -R | Select-String "Bolus Devliery Test", "% in DN", "Volume  =", "Timing =", "Bolus Current"
}

function t {
    Get-ChildItem "$serverdir"  -I DannoGUIState.xml -R | Select-String "<UserName>", "<RunStartAmbientTemperatureC>", "<RunEndAmbientTemperatureC>", "<RunStartRelativeHumidityPercent>", "<RunEndRelativeHumidityPercent>"
}

function i {
    Get-ChildItem "$serverdir"  -I execution_withLadders.log -R | Select-String "Error", "Your trial has"
}

Help2



<#
do {
debug
If ($SerialRegMatch -eq $True) { CONFIG }
Main
Help1
Selection
Help2
$input = read-host "select a function from list above"


Get-ChildItem -Path $folder -r  | 
? { $_.PsIsContainer -and $_.FullName -notmatch 'archive' }

if ($input -eq "config") {config $exicode = "Null"}
if ($input -eq "i") {i -and $exicode = "Null"}
if ($input -eq "w") {w -and $exicode = "Null"}
} while ($exicode = "Null")


 $InstalledSoftware = Get-ChildItem "HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
foreach($obj in $InstalledSoftware){write-host $obj.GetValue('DisplayName') -NoNewline; write-host " - " -NoNewline; write-host $obj.GetValue('DisplayVersion')}

RHID_GFESampleCartridgePLUS = PURPLE CARTRIDGE
RHID_GFEControlCartridgePLUS = BLUE CARTRIDGE / ALLELIC LADDER
RHID_NGMSampleCartridgePLUS = GREEN CARTRIDGE
RHID_PrimaryCartridge_V4 = BEC
RHID_GelSyringe = GEL

$env:Path                             # shows the actual content
$env:Path = 'C:\foo;' + $env:Path     # attach to the beginning
$env:Path += ';C:\foo'                # attach to the end

#>