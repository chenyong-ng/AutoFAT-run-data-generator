<#
.Title        : Powershell Utility for RHID Instrument
.Source       : https://github.com/chenyong-ng/AutoFAT-run-data-generator
.Version      :	v0.4
.License      : Public Domain
.Revision Date: 10 JUL 2022
.Todo         : Set display resolution, change to display 2, check exported PDF  leaf from full run
#>

<#
Initialize global variables, do not change the order.
#>

#$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
#$currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

$PSDefaultParameterValues['*:Encoding'] = 'utf8'
$name = "$env:COMPUTERNAME"
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

if ($name -eq "SGSI11-59FKK13") {
    $path = "S:\"
    $danno = "S:\Dano Planning\Test Data"
    $US_Path = "Y:\"
    $US_danno = "Y:\Dano Planning\Test Data"
}
else {
    $path = "U:\RHID"
    $danno = "U:\Dano Planning\Test Data"
} #RHID Workststion laptop has differnt network drive path

#File detection and file size calculation
if ($waves -eq $True) { $wvfs = (Get-Item $result\$wv | ForEach-Object { [math]::ceiling($_.length / 1KB) }) }
if ($nlc -eq $True) { $nlfs = (Get-Item $result\$nl | ForEach-Object { [math]::ceiling($_.length / 1KB) }) }

<#Set-WindowStyle.ps1 and XML_and_Config.ps1 must be saved in UTF-8 BOM encoding,
otherwise output will be result in gibberish #>
. $PSScriptRoot\Modules\Set-WindowStyle.ps1
. $PSScriptRoot\Modules\XML_and_Config.ps1
. $PSScriptRoot\Modules\MainFunction.ps1

function j { 
    #     $sn2 = read-host "Checking archived U.S. server Boxprep SoftGenetics License key, Enter Instrument Serial number"
    #     set-variable -name "serverdir" -value "Y:\Dano Planning\Test Data\RHID-$sn2"
    # add more function to check single, or multiple license key
    $sn2 = read-host "Enter Instrument Serial number to check HID Autolite License key"
    Get-ChildItem "$danno\RHID-$sn2" -I *BoxPrepLog_RHID* -R  -Exclude "*.log" | Select-String "SoftGenetics License number provided is"
}

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

Get-ItemPropertyValue 'HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{96236EEA-504A-4395-8C4D-299A6CA26A3F}_is1' 'DisplayName'

"C:\Program Files (x86)\SoftGenetics\HIDAutoLite\V2.95 for IntegenX\DataCheck.exe" 7C0469C3-1269-42C8-B779-4FB6E8D0F527 35

RHID_GFESampleCartridgePLUS = PURPLE CARTRIDGE
RHID_GFEControlCartridgePLUS = BLUE CARTRIDGE / ALLELIC LADDER
RHID_NGMSampleCartridgePLUS = GREEN CARTRIDGE
RHID_PrimaryCartridge_V4 = BEC
RHID_GelSyringe = GEL

$env:Path                             # shows the actual content
$env:Path = 'C:\foo;' + $env:Path     # attach to the beginning
$env:Path += ';C:\foo'                # attach to the end
#>
#>