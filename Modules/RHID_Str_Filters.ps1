"Loading Q-mini textual filtering commands"
$RHID_QMini_SN          = ($storyboard | Select-String "Q-mini serial number" | Select-object -last 1)
$RHID_QMini_Coeff       = ($storyboard | Select-String "Coefficients" | Select-object -last 1)
$RHID_QMini_Infl        = ($storyboard | Select-String "Inflection Point" | Select-object -last 1)
<#
IF ($VerboseMode -eq "True") { $RHID_QMini_SN , $RHID_QMini_Coeff, $RHID_QMini_Infl }
IF ($HistoryMode -eq "True") { $storyboard | Select-String "Q-mini serial number" , $RHID_QMini_Coeff, $RHID_QMini_Infl }
#>

"Loading Main board and Mezz PCB textual filtering commands"
$RHID_Mainboard_FW_Ver  = ($storyboard | Select-String "Main board firmware version" | Select-object -last 1).line.split(":").TrimStart() | Select-object -last 1
$RHID_Mezzbaord_FW_Ver  = ($storyboard | Select-String "Mezz board firmware version" | Select-object -last 1).line.split(":").TrimStart() | Select-object -last 1
$RHID_ExecutionLOG      = $ExecutionLOG | Select-String 'Your trial has | License is Valid' | Select-object -last 1
# $RHID_ExecutionLOG_Valid= $ExecutionLOG | Select-String "License is Valid" | Select-object -last 1
$RHID_GM_Analysis_PeakTable = $GM_Analysis_PeakTable | Select-String "Date/Time:" | Select-object -last 1
#If ($VerboseMode -eq "True") { $RHID_Mainboard_FW_Ver , $RHID_Mezzbaord_FW_Ver , $RHID_ExecutionLOG , $RHID_GM_Analysis_PeakTable }

"Looking for TC_CalibrationXML"
$RHID_TC_Calibration    = $TC_CalibrationXML | Select-Xml -XPath "//Offsets" | ForEach-Object { $_.node.InnerXML }
"Looping through MachineConfigXML "
$RHID_MachineConfig_SN     = $MachineConfigXML  | Select-Xml -XPath "//MachineName" | ForEach-Object { $_.node.InnerXML }
$RHID_MachineConfig_HWVer = $MachineConfigXML  | Select-Xml -XPath "//HWVersion" | ForEach-Object { $_.node.InnerXML }
$RHID_MachineConfig_HWID    = $MachineConfigXML  | Select-Xml -XPath "//MachineConfiguration" | ForEach-Object { $_.node.InnerXML }
$RHID_MachineConfig_ServerPath = $MachineConfigXML  | Select-Xml -XPath "//DataServerUploadPath" | ForEach-Object { $_.node.InnerXML }
$RHID_MachineConfig_Syringe = $MachineConfigXML  | Select-Xml -XPath "//SyringePumpResetCalibration_ms | //SyringePumpStallCurrent" | ForEach-Object { $_.node.InnerXML }
$RHID_MachineConfig_Blue   = $MachineConfigXML  | Select-Xml -XPath "//Signature" | ForEach-Object { $_.node.InnerXML }
$RHID_MachineConfig_SCI    = $MachineConfigXML  | Select-Xml -XPath "//FluidicHomeOffset_mm | //PreMixHomeOffset_mm | //DiluentHomeOffset_mm"| ForEach-Object { $_.node.InnerXML }
$RHID_MachineConfig_BEC    = $MachineConfigXML  | Select-Xml -XPath "//IsBECInsertion | //LastGelPurgeOK | //RunsSinceLastGelFill" | ForEach-Object { $_.node.InnerXML }
$RHID_MachineConfig_PrimeWater  = $MachineConfigXML  | Select-Xml -XPath "//Water"| ForEach-Object { $_.node.InnerXML }
$RHID_MachineConfig_PrimeLysisBuffer = $MachineConfigXML  | Select-Xml -XPath "//LysisBuffer" | ForEach-Object { $_.node.InnerXML }
$RHID_MachineConfig_Laser  = $MachineConfigXML  | Select-Xml -XPath "//LaserHours" | ForEach-Object { $_.node.InnerXML }
"Loading Heaters textual filtering commands "

function RHID_Lysis_Heater_TEST {

$RHID_Lysis_Heater_FAT = $storyboard | Select-String "Lysis Heater FAT"
$RHID_Lysis_Heater_FAT_PASS = ($RHID_Lysis_Heater_FAT | select-string "pass" )
$RHID_Lysis_Heater_FAT_FAIL = ($RHID_Lysis_Heater_FAT | select-string "fail" )
if ($RHID_Lysis_Heater_FAT.count -eq "0") {
    Write-Host "$Heater : $RHID_Lysis_Heater_str $Test_NA" -ForegroundColor Yellow 
}
elseif ([bool]($RHID_Lysis_Heater_FAT_PASS.Line.split(":").TrimStart()[-1] -eq "PASS")) {
    Write-Host "$Heater : $RHID_Lysis_Heater_str $Test_Passed" -ForegroundColor Green
    If ($DebugMode -eq "True") {
        Write-Host "Lysis Heater Pass Count" $RHID_Lysis_Heater_FAT_PASS.count
            ($RHID_Lysis_Heater_FAT | select-string "pass" )
    }
}
elseif ([bool]($RHID_Lysis_Heater_FAT_FAIL.Line.split(":").TrimStart()[-1] -eq "fail")) {
    Write-Host "$Heater : $RHID_Lysis_Heater_str $Test_Failed" -ForegroundColor Red
    If (DebugMode = "True") { $RHID_Lysis_Heater_FAT | select-string "fail" }
}
}

$RHID_DN_Heater_FAT     = $storyboard | Select-String "DN FAT"            | Select-Object -Last 1
$RHID_PCR_Heater_FAT    = $storyboard | Select-String "PCR FAT"           | Select-Object -Last 1
$RHID_Optics_Heater_FAT = $storyboard | Select-String "Optics Heater FAT" | Select-Object -Last 1

$RHID_Gel_Cooler_FAT = $storyboard | Select-String "Gel Cooling FAT" | Select-Object -Last 1
$RHID_Ambient_FAT    = $storyboard | Select-String "Ambient FAT"     | Select-Object -Last 1

"Loading SCI textual filtering commands "

$RHID_CAM_FAT = ($storyboard | Select-String "CAM FAT" | Select-Object -Last 1)
$RHID_SCI_Insertion_FAT = ($storyboard | Select-String "SCI Insertion FAT" | Select-Object -Last 1)
$RHID_FRONT_END_FAT = ($storyboard | Select-String "FRONT END FAT" | Select-Object -Last 1)
$RHID_FE_Motor_Calibration = ($storyboard | Select-String "Bring Up: FE Motor Calibration" | Select-Object -Last 1)
$RHID_FE_Motor_Test = ($storyboard | Select-String "Bring Up: FE Motor Test" | Select-Object -Last 1)
$RHID_Homing_Error_Test = ($storyboard | Select-String "Bring Up: Homing Error Test" | Select-Object -Last 1)
$RHID_FL_Homing_Error_wCAM_Test = ($storyboard | Select-String "Bring Up: FL Homing Error w/CAM Test" | Select-Object -Last 1)

$RHID_SCI_Antenna_Test = ($storyboard | Select-String "Bring Up: SCI Antenna Test" | Select-Object -Last 1)
$RHID_Mezz_test = $storyboard | Select-String "MEZZ test" | Select-Object -Last 1

"Loading MEZZ textual filtering commands "

$RHID_HP_FAT    = $storyboard | Select-String "HP FAT"    | Select-Object -Last 1
$RHID_LP_FAT    = $storyboard | Select-String "LP FAT"    | Select-Object -Last 1
$RHID_Anode_Motor_FAT = $storyboard | Select-String "Anode Motor FAT" | Select-Object -Last 1
"Loading BEC textual filtering commands "
$RHID_BEC_Interlock_FAT = ($storyboard | Select-String "BEC Interlock FAT" | Select-Object -Last 1)
$RHID_Gel_Antenna_LOW = ($storyboard | Select-String "Bring Up: Gel Antenna" | Select-String "Low" | Select-Object -Last 1)
$RHID_Gel_Antenna_HIGH = ($storyboard | Select-String "Bring Up: Gel Antenna" | Select-String "High"  | Select-Object -Last 1)
$RHID_Syringe_Stallout_FAT = ($storyboard | Select-String "Syringe Stallout FAT" | Select-Object -Last 1)
$RHID_Mezzboard_FAT = ($storyboard | Select-String "Mezzboard FAT" |  Select-Object -Last 1)

"Loading BEC Insertion textual filtering commands "
$RHID_BEC_Reinsert_First = ($storyboard | Select-String "BEC Reinsert completed" | Select-Object -First 1) 
$RHID_BEC_insert_ID = ($storyboard | Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' } | Select-String "BEC Insertion BEC_") | Select-Object -First 1
$RHID_Piezo_FAT = ($storyboard | Select-String "Piezo FAT" | Select-Object -Last 1)
$RHID_HV_FAT = ($storyboard | Select-String "HV FAT" | Select-Object -Last 1)
$RHID_Laser_FAT = ($storyboard | Select-String "Laser FAT" | Select-Object -Last 1)

"Loading WET test textual filtering commands "
$RHID_Water_Prime    = ($storyboard | Select-String "Bring Up: Water Prime" | Select-Object -Last 1)
$RHID_Lysis_Prime    = ($storyboard | Select-String "Bring Up: Lysis Prime" | Select-Object -Last 1)
$RHID_Buffer_Prime   = ($storyboard | Select-String "Bring Up: Buffer Prime" |  Select-Object -Last 1)
$RHID_Lysis_Dispense = ($storyboard | Select-String "Bring Up: Lysis Dispense Test" | Select-Object -Last 1)
$RHID_Lysate_Pull = ($storyboard | Select-String "Bring Up: Lysate Pull" | Select-Object -Last 1)
$RHID_Capillary_Gel_Prime = ($storyboard | Select-String "Bring Up: Capillary Gel Prime" | Select-Object -Last 1)
$RHID_Raman = ($storyboard | Select-String "Bring Up: Verify Raman"  | Select-Object -Last 1)
"Loading BEC Insertion textual filtering commands "
$RHID_BEC_Reinsert = ( $CoverOn_BEC_Reinsert | Select-String "BEC Reinsert completed" | Select-Object -Last 1) 
$RHID_BEC_Reinsert_ID = ( $CoverOn_BEC_Reinsert | Select-String "BEC ID" | Select-Object -Last 1)

"Loading Full run textual filtering commands "
$GM_ILS_Score_GFE_36cycles   = ( $SampleQuality | Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' } | select-string -NotMatch "Current" | Select-String "Trace__GFE-300uL-36cycles") | Select-Object -Last 1
$GM_ILS_Score_GFE_BV         = ( $SampleQuality | Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' } | select-string -NotMatch "Current" | Select-String "Trace__GFE-BV") | Select-Object -Last 1
$GM_ILS_Score_Allelic_Ladder = ( $SampleQuality | Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' } | select-string -NotMatch "Current" | Select-String "Trace__Ladder.fsa") | Select-Object -Last 1
$GM_ILS_Score_GFE_007        = ( $SampleQuality | Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' } | select-string -NotMatch "Current" | Select-String "Trace__GFE_007") | Select-Object -Last 1
$GM_ILS_Score_NGM_007        = ( $SampleQuality | Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' } | select-string -NotMatch "Current" | Select-String "Trace__NGM") | Select-Object -Last 1
$GM_ILS_Score_BLANK          = ( $SampleQuality | Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' } | select-string -NotMatch "Current" | Select-String "Trace__BLANK")| Select-Object -Last 1

If ([Bool]$MachineName -eq "True") {
"Loading $StatusData and $GM_Analysis textual filtering commands "
$StatusData_leaf = Get-ChildItem $Drive\$MachineName -I $StatusData  -R | Test-path -PathType Leaf
$GM_Analysis_leaf = Get-ChildItem $Drive\$MachineName -I $GM_Analysis -R | Test-path -PathType Leaf
}

"Loading DannoGUIState.XML for Ambient and Humidity reading"
$RHID_USB_Temp_Rdr = $DannoGUIStateXML | Select-Xml -XPath "//RunEndAmbientTemperatureC" | ForEach-Object { $_.node.InnerXML } | Select-Object -Last 3
$RHID_USB_Humi_Rdr = $DannoGUIStateXML | Select-Xml -XPath "//RunEndRelativeHumidityPercent" | ForEach-Object { $_.node.InnerXML } | Select-Object -Last 3