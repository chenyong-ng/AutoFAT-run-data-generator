﻿
if ($SerialRegMatch -eq "True") {
<#
"[Probing] USB Devices"
$RHID_USBDvices = (Get-PnpDevice -PresentOnly | Where-Object { $_.InstanceId -match '^USB' } | Select-String "TouchChip Fingerprint Coprocessor", "HD USB Camera" )
$FPMatch = $RHID_USBDvices -match "TouchChip Fingerprint Coprocessor"
$CameraMAtch = $RHID_USBDvices -match "HD USB Camera"
#>

#Query for the mac address and ip address 

function RHID_USBDevices_Check {
"$Probing : USB Camera and Fingerprint Sensor"
$RHID_USBDevices                = (Get-PnpDevice -PresentOnly | Where-Object { $_.InstanceId -match '^USB' } | Select-String "TouchChip Fingerprint Coprocessor", "HD USB Camera" )
$FPMatch                        = $RHID_USBDevices -match "TouchChip Fingerprint Coprocessor"
$CameraMatch                    = $RHID_USBDevices -match "HD USB Camera"
if ([Bool]$FPMatch -eq "True" ) {
    $FP_Check                   = "Present"
    } else {
    $FP_Check                   = "N/A" }
    "$FP : $FP_Sensor_Str : $FP_Check"
if ([Bool]$CameraMatch -eq "True" ) {
    $HD_USB_CAM_Check           = "Present"
    } else {
    $HD_USB_CAM_Check           = "N/A" }
    "$HD_USB_CAM : $HD_USB_CAM_Str : $HD_USB_CAM_Check"
}
"$info : $FPMatch"
"$info : $CameraMatch"

function ABRHID_Patch {
    "$Probing : ABRHID_Win10_Patch20201208 Presence"
    $Win110Patch_RegKey         = "HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{96236EEA-504A-4395-8C4D-299A6CA26A3F}_is1"
    $Win10patch_leaf            = Test-Path -Path "$Win110Patch_RegKey" 
    if ($Win10patch_leaf -eq "True") {
        $Win10patch             = Get-ItemPropertyValue "$Win110Patch_RegKey" 'DisplayName'
        Write-host "$info : $Win10patch Installed" -ForegroundColor Magenta
    } else {
        Write-host "$Warning : Patch ABRHID_Win10_Patch20201208 not installed" -ForegroundColor red
    }
}
"$Found : Win110Patch $Win10patch_leaf"
$Ram                            = (Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property capacity -Sum).sum /1GB
$Disk                           = [math]::Round((Get-Disk | Where-Object -FilterScript { $_.Bustype -eq "SATA" } | Measure-Object -Property size -Sum).sum / 1GB)
$DiskType                       = [string](wmic diskdrive get InterfaceType,model | select-string "IDE")
$DisplayOrientation             = [Windows.Forms.SystemInformation]::ScreenOrientation
    if ($DisplayOrientation -eq "Angle0") {
    $DOI = "Landscape (0°)"
    } elseif ($DisplayOrientation -eq "Angle270" ) {
    $DOI = "Potrait (Flipped, 270°)" }
"[$D] Ram            : $Ram GB"
"[$D] SystemDiskSize : $Disk GB"
"[$D] SystemDiskinfo : $Disktype"
"[$D] Display Orientation : $DOI"

If ([Bool]$DannoAppConfigCheck -eq "True" ) {
    Write-Host "$info : E:\RapidHIT ID\Results\Data $HostName\$DannoAppConfigXML_File exist" -ForegroundColor Green
} Else {
    Write-Host "$info : E:\RapidHIT ID\Results\Data $HostName\$DannoAppConfigXML_File missing" -ForegroundColor Red}
If ([Bool]$DannoAppRhidCheck -eq "True" ) {
    Write-Host "$info : D:\DannoGUI\$DannoAppConfigXML_File exist" -ForegroundColor Green
} Else {
    Write-Host "$info : D:\DannoGUI\$DannoAppConfigXML_File missing" -ForegroundColor Red}
#add option to check and generate DannoAppConfig.xml
}
"$info : DannoAppConfigCheck $DannoAppConfigCheck"
"$info : DannoAppRhidCheck $DannoAppRhidCheck"
"$Loading : Q-mini textual filtering commands"
$RHID_QMini_SN                      = ($storyboard | Select-String "Q-mini serial number").line.split(":").TrimStart()[-1]
$RHID_QMini_Coeff                   = ($storyboard | Select-String "Coefficients").line.split(":").TrimStart()[-1]
$RHID_QMini_Infl                    = ($storyboard | Select-String "Inflection Point").line.split(":").TrimStart()[-1]
"$Found : " + $RHID_QMini_SN
"$Found : " + $RHID_QMini_Coeff
"$Found : " + $RHID_QMini_Infl
<#
IF ($VerboseMode -eq "True") { $RHID_QMini_SN , $RHID_QMini_Coeff, $RHID_QMini_Infl }
IF ($HistoryMode -eq "True") { $storyboard | Select-String "Q-mini serial number" , $RHID_QMini_Coeff, $RHID_QMini_Infl }
#>

"$Loading : Main board and Mezz PCB textual filtering commands"
$RHID_Mainboard_FW_Ver              = (($storyboard     | Select-String "Main board firmware version" | Select-object -last 1).line.split(":").TrimStart())[-1]
$RHID_Mezzbaord_FW_Ver              = (($storyboard     | Select-String "Mezz board firmware version" | Select-object -last 1).line.split(":").TrimStart())[-1]
$RHID_ExecutionLOG                  = ($ExecutionLOG    | Select-String 'Your trial has | License is Valid')[-1]
# $RHID_ExecutionLOG_Valid= $ExecutionLOG | Select-String "License is Valid" | Select-object -last 1
$RHID_GM_Analysis_PeakTable         = ($GM_Analysis_PeakTable | Select-String "Date/Time:")[-1]
"$Found : $RHID_Mainboard_FW_Ver"
"$Found : $RHID_Mezzbaord_FW_Ver"
"$Found : $RHID_ExecutionLOG"
"$Found : $RHID_GM_Analysis_PeakTable"
#If ($VerboseMode -eq "True") { $RHID_Mainboard_FW_Ver , $RHID_Mezzbaord_FW_Ver , $RHID_ExecutionLOG , $RHID_GM_Analysis_PeakTable }

"$Looping : TC_CalibrationXML"
$RHID_TC_Calibration                = $TC_CalibrationXML | Select-Xml -XPath "//MachineName | //Offsets" | ForEach-Object { $_.node.InnerXML }
"$Found : $RHID_TC_Calibration"

"$Looping : through MachineConfigXML "
$RHID_MachineConfig_SN              = $MachineConfigXML  | Select-Xml -XPath "//MachineName"    | ForEach-Object { $_.node.InnerXML }
$RHID_MachineConfig_HWVer           = $MachineConfigXML  | Select-Xml -XPath "//HWVersion"      | ForEach-Object { $_.node.InnerXML }
$RHID_MachineConfig_HWID            = $MachineConfigXML  | Select-Xml -XPath "//MachineConfiguration" | ForEach-Object { $_.node.InnerXML }
$RHID_MachineConfig_ServerPath      = $MachineConfigXML  | Select-Xml -XPath "//DataServerUploadPath" | ForEach-Object { $_.node.InnerXML }
$RHID_MachineConfig_Syringe         = $MachineConfigXML  | Select-Xml -XPath "//SyringePumpResetCalibration_ms | //SyringePumpStallCurrent" | ForEach-Object { $_.node.InnerXML }
$RHID_MachineConfig_Blue            = $MachineConfigXML  | Select-Xml -XPath "//Signature"      | ForEach-Object { $_.node.InnerXML }
$RHID_MachineConfig_SCI             = $MachineConfigXML  | Select-Xml -XPath "//FluidicHomeOffset_mm | //PreMixHomeOffset_mm | //DiluentHomeOffset_mm"| ForEach-Object { $_.node.InnerXML }
$RHID_MachineConfig_BEC             = $MachineConfigXML  | Select-Xml -XPath "//IsBECInsertion | //LastGelPurgeOK | //RunsSinceLastGelFill" | ForEach-Object { $_.node.InnerXML }
$RHID_MachineConfig_PrimeWater      = $MachineConfigXML  | Select-Xml -XPath "//Water"          | ForEach-Object { $_.node.InnerXML }
$RHID_MachineConfig_PrimeLysisBuffer = $MachineConfigXML | Select-Xml -XPath "//LysisBuffer"    | ForEach-Object { $_.node.InnerXML }
$RHID_MachineConfig_Laser           = $MachineConfigXML  | Select-Xml -XPath "//LaserHours"     | ForEach-Object { $_.node.InnerXML }

"$Found : MachineName               : $RHID_MachineConfig_SN"
"$Found : HWVersion                 : $RHID_MachineConfig_HWVer"
"$Found : Signature                 : $RHID_MachineConfig_Blue"
"$Found : BEC Status                : $RHID_MachineConfig_BEC"
"$Found : PrimeWater                : $RHID_MachineConfig_PrimeWater"
"$Found : LysisBuffer               : $RHID_MachineConfig_PrimeLysisBuffer"
"$Found : Laser Hours               : $RHID_MachineConfig_Laser"
"$Found : MachineConfiguration      : $RHID_MachineConfig_HWID"
"$Found : DataServerUploadPath      : $RHID_MachineConfig_ServerPath"
"$Found : SCI Calibration           : $RHID_MachineConfig_SCI"
"$Found : SyringePump Calibration   : $RHID_MachineConfig_Syringe"

function RHID_Optics {
IF ($RHID_QMini_SN[-1].count -gt "0") {
    Write-Host "$Optics : $RHID_QMini_str : $RHID_QMini_SN" -ForegroundColor Green
    } Else { 
    Write-Host "$Optics : $RHID_QMini_str : $Not_Available" -ForegroundColor Yellow
    } #  Write-Host "$Optics : $RHID_QMini_str : $RHID_QMini_SN_Result" -ForegroundColor $QMini_SN_Color

IF ($RHID_QMini_Coeff[-1].count -gt "0") {
    Write-Host "$Optics : $RHID_Coeff_Str : $RHID_QMini_Coeff" -ForegroundColor Green
    } Else {
    Write-Host "$Optics : $RHID_Coeff_Str : $Not_Available" -ForegroundColor Yellow
    } # $Optics : $RHID_Coeff_Str : $RHID_QMini_Coeff_Result" -ForegroundColor $QMini_Coeff_Color

IF ($RHID_QMini_Infl[-1].count -gt "0") {
    Write-Host "$Optics : $RHID_Infl_Str : $RHID_QMini_Infl" -ForegroundColor Green
    } Else {
    Write-Host "$Optics : $RHID_Infl_Str : $Not_Available" -ForegroundColor Yellow
    } # $Optics : $RHID_Infl_Str : $RHID_QMini_Infl_Result" -ForegroundColor $QMini_Infl_Color
}

function RHID_TC {
    # replace with -match "NaN" instead of SS, then print the result
If ([Bool]($RHID_TC_Calibration | Select-String "NaN") -eq "True") {
    Write-Host "$TC_Cal : $RHID_TC_Calibration_Str : Uncalibrated" -ForegroundColor Yellow
} elseif (
    $RHID_TC_Calibration.count -eq "0") {
    Write-Host "$TC_Cal :               $Warning : TC_Calibration.XML Not Found" -ForegroundColor RED
    #add option to generate TC_Calibration.XML
} else {
    Write-Host "$TC_Cal : $RHID_TC_Calibration_Str : Calibrated" -ForegroundColor Green
    Write-Host "$TC_Offsets :" $RHID_TC_Calibration[1]
    Write-Host "$TC_Offsets :" $RHID_TC_Calibration[2]
}
}

function RHID_MachineConfig_check {
if ($RHID_MachineConfig_SN.count -eq "0") {
    Write-Host "$MachineConf : $Warning : MachineConfig.XML Not Found" -ForegroundColor RED
}
Write-Host "$MachineConf : $Instrument_Serial : $RHID_MachineConfig_SN" -ForegroundColor Green
    #Add big red warning of Instrument_Serial equal to RHID-0XXX
Write-Host "$MachineConf : $Hardware_Version : $RHID_MachineConfig_HWVer" -ForegroundColor Green
    # ID18-3 is production version, ID19-2 is development version
Write-Host "$MachineConf : $SCI_Configuration : $RHID_MachineConfig_HWID" -ForegroundColor Green
    # Production version is NoFLSpring V2SCI
Write-Host "$MachineConf : $Data_Upload_Path : $RHID_MachineConfig_ServerPath" -ForegroundColor Green
    # Equal to U:\, doubleslash is after boxprep, \\usple-portal-p1.amer.thermo.com\rundata\RHID\ is unconfigured
Write-Host "$MachineConf : $Syringe_Pump_Calibration : $RHID_MachineConfig_Syringe" -ForegroundColor Green
Write-Host "$MachineConf : $PrimeWater_Status : $RHID_MachineConfig_PrimeWater" -ForegroundColor Green
Write-Host "$MachineConf : $PrimeLysisBuffer : $RHID_MachineConfig_PrimeLysisBuffer" -ForegroundColor Green

If ([Bool]$RHID_MachineConfig_Blue -eq "True") {
    Write-Host "$Raman_Bkg : $Blue_Background_Str : Stashed" -ForegroundColor Green
    } else {
    Write-Host "$Raman_Bkg : $Blue_Background_Str : N/A" -ForegroundColor Yellow
}

If ([Bool]$RHID_MachineConfig_SCI -eq "True") {
    Write-Host "$SCI_Cal : $SCI_Calibration : $RHID_MachineConfig_SCI mm" -ForegroundColor Green
    } Else {
    Write-Host "$SCI_Cal : $SCI_Calibration : Uncalibrated" -ForegroundColor Red
}

If ([Bool]$RHID_MachineConfig_BEC -eq "True") {
    Write-Host "$BEC_Status : $Bec_Status_Str : $RHID_MachineConfig_BEC" -ForegroundColor Green
}

If ([Bool]$RHID_MachineConfig_Prime -eq "True") {
    Write-Host "$Prime : $Prime_Status : $RHID_MachineConfig_Prime" -ForegroundColor Green
}
    Write-Host "$Laser : $Laser_Hour : $RHID_MachineConfig_Laser" -ForegroundColor Green
}

function RHID_Firmware_Check {
if (($RHID_Mainboard_FW_Ver -and $RHID_Mezzbaord_FW_Ver) -eq $RHID_Firmware79) {
    Write-Host "$PCBA : $RHID_Mainboard_str : $RHID_Mainboard_FW_Ver ,$RHID_Mezzbaord_FW_Ver" -ForegroundColor Green
} else {
    Write-Host "$PCBA : $Error_msg Firmware mismatch, $RHID_Mainboard_FW_Ver $RHID_Mezzbaord_FW_Ver detected" -ForegroundColor Red
}
}
<#
if ("$RHID_Mezzbaord_FW_Ver" -eq $RHID_Firmware79) {
    Write-Host "$PCBA : $RHID_Mezzbaord_str : $RHID_Mezzbaord_FW_Ver" -ForegroundColor Green }
else {   
    Write-Host "$PCBA : $Error_msg $RHID_Mezzbaord_str not updated, $RHID_Mezzbaord_FW_Ver detected" -ForegroundColor Red } 
}#>

function RHID_HIDAutolite_Check {
IF ([Bool]$RHID_ExecutionLOG -eq "True") {
    $RHID_GM_Analysis_PeakTable_Filter = $RHID_GM_Analysis_PeakTable.line
    $RHID_ExecutionLOG_Filter = ($RHID_ExecutionLOG.Line.Split("-").TrimStart())[-1]
    Write-Host "$HIDAutolite : $RHID_HIDAutolite_Trial : $RHID_ExecutionLOG_Filter"
    Write-Host "$HIDAutolite : $HIDAutolite_Execution_Str $RHID_GM_Analysis_PeakTable_Filter "
} Else {
    Write-Host "$HIDAutolite : $RHID_HIDAutolite_Trial : Undetected or Expired" -ForegroundColor Red
}
}
