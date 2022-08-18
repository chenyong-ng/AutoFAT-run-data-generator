$storyboard       = Get-ChildItem "$serverdir" -I storyboard*.* -R 
$MachineConfigXML = Get-ChildItem "$serverdir" -I MachineConfig.xml -R
$TC_CalibrationXML= Get-Childitem "$serverdir" -I TC_Calibration.xml -R 
$MachineName = ($storyboard | Select-String "MachineName" | Select-Object -Last 1).Line.Split(":").TrimStart() | Select-Object -Last 1
Write-Host "[ RapidHIT ID] : Running query on Instrument $MachineName run data for result..." -ForegroundColor Magenta
# add check machine name first, last from log and compare with $env:computername
# convert everything to functios, execute only if condition is true

$Optics       = "[ Optics     ]" ; $PCBA         = "[ PCBA       ]" ; $Raman_Bkg    = "[ Raman Bkg  ]" 
$Heater       = "[ Heater     ]" ; $SCI          = "[ SCI        ]" ; $MachineConf  = "[MachineConf.]"
$Ambient      = "[ Ambient_Sr ]" ; $Gel_Cooler   = "[ Gel Cooler ]" ; $TC_Cal       = "[ TC_Cal Val.]"
$Full_Run     = "[ Full-Run   ]" ; $Mezz_Plate   = "[ Mezz_Plate ]" ; $SCI_Cal      = "[SCI_Cal Val.]"
$Bolus        = "[ Bolus      ]" ; $WetTest      = "[ Wet Test   ]" ; $BEC_Status   = "[ BEC_Status ]"
$BoxPrep      = "[ BoxPrep    ]" ; $HIDAutolite  = "[ HIDAutolite]" ; $Prime        = "[ Prime      ]"
$USB_Temp     = "[ Temp Sensor]" ; $USB_Humi     = "[ Humi Sensor]" ; $Laser        = "[ Laser      ]" 
$SHP_BEC      = "[Shipping BEC]" ; $Error_msg    = "[ Error! ]"     ; $SyringePump  = "[ SyringePump]"

$Test_Failed  = "Test : FAILED"  ; $Test_Passed  = "Test : PASSED"  ; $Test_NA      = "Test : N/A"
$USB_Temp_RD  = "Run end Ambient reading in °C"
$USB_Humi_RD  = "Run end Humidity reading in %"
$File_not_Found = "Not found or no full run has been performed"
$File_found     = "Files found in these folders"

$RHID_QMini_str = "Q-mini serial number"
$RHID_Coeff_Str = "Coefficients"
$RHID_Infl_Str  = "Inflection Point"
$RHID_Mainboard_str = "Main board firmware version"
$RHID_Mezzbaord_str = "Mezz board firmware version"
$RHID_Firmware79    = "1001.4.79"
$RHID_Anode_Motor_Str  = "Anode Motor FAT"
$RHID_Lysis_Heater_str = "Lysis Heater FAT"
$RHID_DN_Heater_str    = "DN FAT"
$RHID_PCR_Heater_str   = "PCR FAT"
$RHID_Optics_Heater_str = "Optics Heater FAT"
$RHID_Gel_Cooler_str    = "Gel Cooling FAT"
$RHID_Ambient_str       = "Ambient FAT"
$RHID_CAM_FAT_str       = "CAM FAT"
$RHID_HIDAutolite_Str   = "SoftGenetics License number provided is"

$RHID_QMini_SN          = ($storyboard | Select-String $RHID_QMini_str | Select-object -last 1).line.split(":").TrimStart() | Select-object -last 1
$RHID_QMini_Coeff       = ($storyboard | Select-String $RHID_Coeff_Str | Select-object -last 1).line.split(":").TrimStart() | Select-object -last 1
$RHID_QMini_Infl        = ($storyboard | Select-String $RHID_Infl_Str  | Select-object -last 1).line.split(":").TrimStart() | Select-object -last 1
$RHID_Mainboard_FW_Ver  = ($storyboard | Select-String $RHID_Mainboard_str | Select-object -last 1).line.split(":").TrimStart() | Select-object -last 1
$RHID_Mezzbaord_FW_Ver  = ($storyboard | Select-String $RHID_Mezzbaord_str | Select-object -last 1).line.split(":").TrimStart() | Select-object -last 1
$RHID_TC_Calibration    = $TC_CalibrationXML | Select-Xml -XPath "//Offsets" | ForEach-Object { $_.node.InnerXML }
$RHID_MachineConfig_HW     = $MachineConfigXML  | Select-Xml -XPath "//MachineName | //HWVersion | //MachineConfiguration | //DataServerUploadPath" | ForEach-Object { $_.node.InnerXML }
$RHID_MachineConfig_Syring = $MachineConfigXML  | Select-Xml -XPath "//SyringePumpResetCalibration_ms | //SyringePumpStallCurrent" | ForEach-Object { $_.node.InnerXML }
$RHID_MachineConfig_Blue   = $MachineConfigXML  | Select-Xml -XPath "//Signature" | ForEach-Object { $_.node.InnerXML }
$RHID_MachineConfig_SCI    = $MachineConfigXML  | Select-Xml -XPath "//FluidicHomeOffset_mm | //PreMixHomeOffset_mm | //DiluentHomeOffset_mm"| ForEach-Object { $_.node.InnerXML }
$RHID_MachineConfig_BEC    = $MachineConfigXML  | Select-Xml -XPath "//IsBECInsertion | //LastGelPurgeOK | //RunsSinceLastGelFill" | ForEach-Object { $_.node.InnerXML }
$RHID_MachineConfig_Prime  = $MachineConfigXML  | Select-Xml -XPath "//Water | //LysisBuffer"| ForEach-Object { $_.node.InnerXML }
$RHID_MachineConfig_Laser  = $MachineConfigXML  | Select-Xml -XPath "//LaserHours " | ForEach-Object { $_.node.InnerXML }

Write-Host "$Optics : $RHID_QMini_str : $RHID_QMini_SN"   -ForegroundColor Green
Write-Host "$Optics : $RHID_Coeff_Str : $RHID_QMini_Coeff"-ForegroundColor Green
Write-Host "$Optics : $RHID_Infl_Str  : $RHID_QMini_Infl" -ForegroundColor Green
Write-Host "$TC_Cal : Calibrated Value : $RHID_TC_Calibration" -ForegroundColor Green
Write-Host "$MachineConf : Machine Configuration : $RHID_MachineConfig_HW" -ForegroundColor Green
Write-Host "$SyringePump : Syringe Pump Calibration $RHID_MachineConfig_Syring" -ForegroundColor Green
If ([Bool]$RHID_MachineConfig_Blue -eq "True") {
    Write-Host "$Raman_Bkg : Blue Background Stashed" -ForegroundColor Green
} else {
    Write-Host "$Raman_Bkg : Blue Background N/A" -ForegroundColor Yellow }
If ([Bool]$RHID_MachineConfig_SCI -eq "True") {
Write-Host "$SCI_Cal : SCI Calibration $RHID_MachineConfig_SCI mm" -ForegroundColor Green }
If ([Bool]$RHID_MachineConfig_BEC -eq "True") {
Write-Host "$BEC_Status : BEC Insertion, Gel Purge : $RHID_MachineConfig_BEC" -ForegroundColor Green }
If ([Bool]$RHID_MachineConfig_Prime -eq "True") {
Write-Host "$Prime : Is Lysis/Water Primed? $RHID_MachineConfig_Prime" -ForegroundColor Green }
Write-Host "$Laser : Laser Hour $RHID_MachineConfig_Laser" -ForegroundColor Green
if ("$RHID_Mainboard_FW_Ver" -eq $RHID_Firmware79) {
    Write-Host "$PCBA : $RHID_Mainboard_str : $RHID_Mainboard_FW_Ver" -ForegroundColor Green }
else {
    Write-Host "$PCBA : $Error_msg $RHID_Mainboard_str not updated, $RHID_Mezzbaord_FW_Ver detected" -ForegroundColor Red }
if ("$RHID_Mezzbaord_FW_Ver" -eq $RHID_Firmware79) {
    Write-Host "$PCBA : $RHID_Mezzbaord_str : $RHID_Mezzbaord_FW_Ver" -ForegroundColor Green }
else {
    Write-Host "$PCBA : $Error_msg $RHID_Mezzbaord_str not updated, $RHID_Mezzbaord_FW_Ver detected" -ForegroundColor Red } 

$RHID_Lysis_Heater_FAT  = $storyboard | Select-String $RHID_Lysis_Heater_str  | Select-Object -Last 1
$RHID_DN_Heater_FAT     = $storyboard | Select-String $RHID_DN_Heater_str     | Select-Object -Last 1
$RHID_PCR_Heater_FAT    = $storyboard | Select-String $RHID_PCR_Heater_str    | Select-Object -Last 1
$RHID_Optics_Heater_FAT = $storyboard | Select-String $RHID_Optics_Heater_str | Select-Object -Last 1

if (($RHID_Lysis_Heater_FAT).count -eq "") {
    Write-Host "$Heater : $RHID_Lysis_Heater_str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_Lysis_Heater_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$Heater : $RHID_Lysis_Heater_str $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$Heater : $RHID_Lysis_Heater_str $Test_Failed" -ForegroundColor Red    }

if (($RHID_DN_Heater_FAT).count -eq "") {
    Write-Host "$Heater : $RHID_DN_Heater_str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_DN_Heater_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$Heater : $RHID_DN_Heater_str $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$Heater : $RHID_DN_Heater_str $Test_Failed"  -ForegroundColor Red    }

if (($RHID_PCR_Heater_FAT).count -eq "") {
    Write-Host "$Heater : $RHID_PCR_Heater_str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_PCR_Heater_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$Heater : $RHID_PCR_Heater_str $Test_Passed" -ForegroundColor Green  }
else {
    Write-Host "$Heater : $RHID_PCR_Heater_str $Test_Failed" -ForegroundColor Red    }

if (($RHID_Optics_Heater_FAT).count -eq "") {
    Write-Host "$Heater : $RHID_Optics_Heater_str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_Optics_Heater_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$Heater : $RHID_Optics_Heater_str $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$Heater : $RHID_Optics_Heater_str $Test_Failed" -ForegroundColor Red    }

# Mainboard tests
$RHID_Gel_Cooler_FAT = $storyboard | Select-String $RHID_Gel_Cooler_str | Select-Object -Last 1
$RHID_Ambient_FAT    = $storyboard | Select-String $RHID_Ambient_str    | Select-Object -Last 1
if (($RHID_Gel_Cooler_FAT).count -eq "") {
    Write-Host "$Gel_Cooler : $RHID_Gel_Cooler_str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_Gel_Cooler_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$Gel_Cooler : $RHID_Gel_Cooler_str $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$Gel_Cooler : $RHID_Gel_Cooler_str $Test_Failed" -ForegroundColor Red    }
if (($RHID_Ambient_FAT).count -eq "") {
    Write-Host "$Ambient : $RHID_Ambient_str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_Ambient_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$Ambient : $RHID_Ambient_str $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$Ambient : $RHID_Ambient_str $Test_Failed" -ForegroundColor Red    }

# SCI tests
$RHID_CAM_FAT     = ($storyboard | Select-String $RHID_CAM_FAT_str | select-string "PASS" | Select-Object -Last 1)

if (($RHID_CAM_FAT).count -eq "") {
    Write-Host "$SCI : $RHID_CAM_FAT_str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool] ($RHID_CAM_FAT | Select-String "Pass") -eq "True") {
    Write-Host "$SCI : $RHID_CAM_FAT_str $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$SCI : $RHID_CAM_FAT_str $Test_Failed" -ForegroundColor Red    }

    # .line.split(",") | Select-Object -Last 1
#$Pass_Filter = select-string "PASS" | Select-Object -Last 1
$RHID_SCI_Insertion_FAT     = ($storyboard | Select-String "SCI Insertion FAT" | select-string "PASS" | Select-Object -Last 1)
$RHID_FRONT_END_FAT         = ($storyboard | Select-String "FRONT END FAT"                  | select-string "PASS" | Select-Object -Last 1)
$RHID_FE_Motor_Calibration  = ($storyboard | Select-String "Bring Up: FE Motor Calibration" | select-string "PASS" | Select-Object -Last 1)
$RHID_FE_Motor_Test             = ($storyboard | Select-String "Bring Up: FE Motor Test"        | select-string "PASS" | Select-Object -Last 1)
$RHID_Homing_Error_Test         = ($storyboard | Select-String "Bring Up: Homing Error Test"    | select-string "PASS" | Select-Object -Last 1)
$RHID_FL_Homing_Error_wCAM_Test = ($storyboard | Select-String "Bring Up: FL Homing Error w/CAM Test" | select-string "PASS" | Select-Object -Last 1)
$RHID_SCI_Antenna_Test          = ($storyboard | Select-String "Bring Up: SCI Antenna Test"           | select-string "PASS" | Select-Object -Last 1)

$RHID_SCI_Insertion_FAT
$RHID_FRONT_END_FAT
$RHID_FE_Motor_Calibration
$RHID_FE_Motor_Test
$RHID_Homing_Error_Test
$RHID_FL_Homing_Error_wCAM_Test
$RHID_SCI_Antenna_Test 

# Mezzboard PCB .line.split(",")| Select-Object -Last 1
$RHID_Mezz_test = ($storyboard | Select-String "MEZZ test" | select-string "PASS" | Select-Object -Last 1)
$RHID_HP_FAT    = ($storyboard | Select-String "HP FAT"    | select-string "PASS" | Select-Object -Last 1)
$RHID_LP_FAT    = ($storyboard | Select-String "LP FAT"    | select-string "PASS" | Select-Object -Last 1)
IF (($storyboard | Select-String "$RHID_Anode_Motor_Str").count -eq ("0")) {
    Write-Host "$Mezz_Plate $RHID_Anode_Motor_Str $Test_NA"    -ForegroundColor Yellow }
elseif ([bool]($storyboard | Select-String "$RHID_Anode_Motor_Str") -eq ("True")) {
$RHID_Anode_Motor_FAT = ($storyboard | Select-String "$RHID_Anode_Motor_Str" | Select-Object -Last 1).line.split(",") | Select-Object -Last 1
Write-Host "$RHID_Anode_Motor_FAT"
    Write-Host "$Mezz_Plate $RHID_Anode_Motor_Str $Test_Passed" -ForegroundColor Green }
else {
    Write-Host "$Mezz_Plate $RHID_Anode_Motor_Str $Test_Failed" -ForegroundColor Red   }

    #.line.split(",")| Select-Object -Last 1
$RHID_BEC_Interlock_FAT = ($storyboard | Select-String "BEC Interlock FAT"     | select-string "PASS"| Select-Object -Last 1)
$RHID_Gel_Antenna_LOW   = ($storyboard | Select-String "Bring Up: Gel Antenna" | select-string "PASS"| Select-String "high" | Select-Object -Last 1)
$RHID_Gel_Antenna_HIGH  = ($storyboard | Select-String "Bring Up: Gel Antenna" | select-string "PASS"| Select-String "low"  | Select-Object -Last 1)
$RHID_Syringe_Stallout_FAT  = ($storyboard | Select-String "Syringe Stallout FAT"  | select-string "PASS" | Select-Object -Last 1)
$RHID_Syringe_MIN_CURRENT   = ($storyboard | Select-String "Min Current"       | Select-Object -Last 1).line.split(",").TrimStart()| Select-Object -Last 1
$RHID_Mezzboard_FAT         = ($storyboard | Select-String "Mezzboard FAT"     | select-string "PASS"| Select-Object -Last 1)
$RHID_BEC_Reinsert_First    = ($storyboard | Select-String "BEC Reinsert completed" | Select-Object -First 1).line.split(",")| Select-Object -Last 1 #First BEC Insertion
$RHID_Gel_Void_First = ($storyboard | Select-String "Estimated gel void volume" | Select-Object -First 1).line.split(",").TrimStart()| Select-Object -Last 1
$RHID_BEC_Reinsert   = ($storyboard | Select-String "BEC Reinsert completed"    | Select-Object -Last 1).line.split(",")| Select-Object -Last 1 #Cover-on BEC Insertion
$RHID_Gel_Void       = ($storyboard | Select-String "Estimated gel void volume" | Select-object -last 1).line.split(",").TrimStart()| Select-Object -Last 1

# .line.split(",")| Select-Object -Last 1
$RHID_Piezo_FAT = ($storyboard | Select-String "Piezo FAT" | select-string "PASS" | Select-Object -Last 1)
$RHID_HV_FAT    = ($storyboard | Select-String "HV FAT"    | select-string "PASS" | Select-Object -Last 1)
$RHID_Laser_FAT = ($storyboard | Select-String "Laser FAT" | select-string "PASS" | Select-Object -Last 1)

$RHID_Water_Prime      = ($storyboard | Select-String "Bring Up: Water Prime" | select-string "PASS"| Select-Object -Last 1)
$RHID_Water_Prime_Plug = ($storyboard | Select-String "Plug detected"         | Select-Object -Last 1).line.split(",").TrimStart()| Select-Object -Last 2 | Select-Object -SkipLast 1
$RHID_Water_Prime
Write-Host "$WetTest : $RHID_Water_Prime_Plug" -ForegroundColor Cyan
# .line.split(",")| Select-Object -Last 1
$RHID_Lysis_Prime    = ($storyboard | Select-String "Bring Up: Lysis Prime"         | select-string "PASS"| Select-Object -Last 1)
$RHID_Buffer_Prime   = ($storyboard | Select-String "Bring Up: Buffer Prime"        | select-string "PASS"| Select-Object -Last 1)
$RHID_Lysis_Dispense = ($storyboard | Select-String "Bring Up: Lysis Dispense Test" | select-string "PASS"| Select-Object -Last 1)

$RHID_Lysate_Pull = ($storyboard | Select-String "Bring Up: Lysate Pull" | select-string "PASS"| Select-Object -Last 1)

$RHID_Capillary_Gel_Prime = ($storyboard | Select-String "Bring Up: Capillary Gel Prime" | select-string "Completed" | Select-Object -Last 1)
$RHID_Raman               = ($storyboard | Select-String "Bring Up: Verify Raman" | select-string "PASS" | Select-Object -Last 1)

$RHID_Bolus = Get-ChildItem "$serverdir\*Bolus Delivery Test*"  -I  storyboard*.* -R | Select-String "Bolus Devliery Test" 
Write-host "$Bolus : Passed Bolus test count:" ($RHID_Bolus | select-string "PASS").count -ForegroundColor Green
 
$RHID_USB_Temp_Rdr = Get-ChildItem "$serverdir" -I DannoGUIState.xml -R | Select-Xml -XPath "//RunEndAmbientTemperatureC" | ForEach-Object { $_.node.InnerXML } | Select-Object -Last 3
$RHID_USB_Humi_Rdr  = Get-ChildItem "$serverdir" -I DannoGUIState.xml -R | Select-Xml -XPath "//RunEndRelativeHumidityPercent" | ForEach-Object { $_.node.InnerXML } | Select-Object -Last 3
Write-Host "$USB_Temp : $USB_Temp_RD : $RHID_USB_Temp_Rdr" -ForegroundColor Green
Write-Host "$USB_Humi : $USB_Humi_RD : $RHID_USB_Humi_Rdr" -ForegroundColor Green

# GM_ILS_Score_1,98
# GM_ILS_Score_1_Name, Trace__Ladder.fsa
#$GM_ILS_Score = (Get-ChildItem -Exclude "Internal" -path "$serverdir" | Get-ChildItem -I SampleQuality.txt -R | select-string "Trace__Current", "Trace__Ladder").Line.TrimStart()
$GM_ILS_Score_Name = (Get-ChildItem -Exclude "Internal" -path "$serverdir" | Get-ChildItem  -I SampleQuality.txt -R | select-string "Trace").Line.TrimStart().split(" ")
#Write-Host "$Full_Run : $GM_ILS_Score_Name GeneMarker ISL Score:" $GM_ILS_Score -ForegroundColor Green
$GM_ILS_Score 
$GM_ILS_Score_Name 

$StatusData_leaf  = Get-ChildItem "$serverdir" -I $StatusData  -R | Test-path -PathType Leaf
$GM_Analysis_leaf = Get-ChildItem "$serverdir" -I $GM_Analysis -R | Test-path -PathType Leaf

if ([Bool] ($StatusData_leaf | Select-Object -First 1) -eq "True" ) {
    $RHID_StatusData_PDF = Get-ChildItem -path "$serverdir" -Exclude "Internal" | Get-ChildItem -I $StatusData -R | Format-table Directory -Autosize -HideTableHeaders -wrap
    Write-Host "$Full_Run : $StatusData $File_found" -ForegroundColor Green
    $RHID_StatusData_PDF
} else {
    Write-host "$Full_Run : $StatusData $File_not_Found" -ForegroundColor yellow }

if ([Bool] ($GM_Analysis_leaf | Select-Object -First 1) -eq "True" ) {
    $RHID_GM_Analysis = Get-ChildItem -path "$serverdir" -Exclude "Internal" | Get-ChildItem -I $GM_Analysis -R | Format-table Directory -Autosize -HideTableHeaders -wrap
    Write-Host "$Full_Run : $GM_Analysis $File_found" -ForegroundColor Green
    $RHID_GM_Analysis
}
else {Write-host "$Full_Run : $GM_Analysis $File_not_Found" -ForegroundColor yellow }

$RHID_Shipping_BEC = $storyboard | Select-String "Shipping BEC engaged"
if ([bool]$RHID_Shipping_BEC -eq "True") {
    Write-Host "$SHP_BEC : BEC Insertion completed, Shipping BEC engaged" -ForegroundColor Green }
else {
    Write-Host "$SHP_BEC : Shipping BEC not yet inserted" -ForegroundColor Yellow }

$Danno_Local_leaf = Test-Path -Path "$danno\$MachineName"
IF ($Danno_Local_leaf -eq "True") {
    $RHID_Danno_Path = "$danno\$MachineName"
    $RHID_HIDAutolite = (Get-ChildItem $RHID_Danno_Path -I *BoxPrepLog_RHID* -R  -Exclude "*.log" | Select-String $RHID_HIDAutolite_Str | Select-Object -Last 1).Line.Split(" ").TrimStart() | Select-Object -Last 1
    $RHID_BoxPrep_Scrshot = Get-ChildItem -Path $RHID_Danno_Path\Screenshots *.PNG
    Write-Host $BoxPrep : Screenshots count : $RHID_BoxPrep_Scrshot.Name.Count -ForegroundColor Green
    Write-Host "$HIDAutolite : $RHID_HIDAutolite_Str : $RHID_HIDAutolite" -ForegroundColor Green
} Else {
    Write-Host "$BoxPrep : Boxprep not yet Initialized" -ForegroundColor Yellow
}
# $RHID_Bolus[2,3,4,5,6,7,8,9,0,1] (Get-ChildItem "$serverdir\*Bolus Delivery Test*"  -I  storyboard*.* -R |  select-string "Timing" | Select-Object -Last 1) ForEach-Object -MemberName Split -ArgumentList "." -ExpandProperty Line
#  $Bolus = Get-ChildItem "$serverdir\*Bolus Delivery Test*"  -I  storyboard*.* -R | Select-String "Timing" |  Select-Object -ExpandProperty Line  | ForEach-Object -MemberName Split -ArgumentList "="