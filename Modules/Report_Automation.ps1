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
"[ RapidHIT ID] : Loading PS script Report_Automation.ps1.."

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

. $PSScriptRoot\XML_and_Config.ps1
"Loading PS script XML_and_Config.ps1.."

if ($SerialRegMatch -eq "True") {
    "Loading PS script MainFunction.ps1 and RHID_Report.ps1.."
    . $PSScriptRoot\MainFunction.ps1
    . $PSScriptRoot\RHID_Report.ps1
} else { 
    MainOptions } 
<#
$ServerDir_Leaf = Test-Path -Path "$serverdir"
if ($ServerDir_Leaf -eq "True") {
    
} else {
    Write-Host "[Error!] Selected instrument Serial number does not exist, or moved to US server" -ForegroundColor Yellow
}
<# text string searching/filtering, > $serverdir\Internal\"RapidHIT ID"\Results\RHID_"$Sn"_MTSS.TXT
#>

<#
do {
debug
If ($SerialRegMatch -eq $True) { CONFIG }
Main
Help1
Selection
Help2
$input = read-host "select a function from list above"

 Get-PnpDevice -PresentOnly | Where-Object { $_.InstanceId -match '^USB' } | select-object "FriendlyName" | Select-String "Creative")

gwmi Win32_USBControllerDevice |%{[wmi]($_.Dependent)} | Sort Manufacturer,Description,DeviceID | Ft -GroupBy Manufacturer Description,Service,DeviceID

if ($input -eq "config") {config $exicode = "Null"}
if ($input -eq "i") {i -and $exicode = "Null"}
if ($input -eq "w") {w -and $exicode = "Null"}
} while ($exicode = "Null")
=======
Get-ChildItem -Path $folder -r  | 
? { $_.PsIsContainer -and $_.FullName -notmatch 'archive' }
[bool](Get-PnpDevice -PresentOnly | Where-Object { $_.InstanceId -match '^USB' } | Select-String "TouchChip Fingerprint Coprocessor" )


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