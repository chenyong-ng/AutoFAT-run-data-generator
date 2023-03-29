
if (($RHID_Water_Prime).count -eq "") {
    Write-Host "$WetTest : $RHID_Water_Prime_Str $Test_NA" -ForegroundColor Yellow 
}
elseif ([bool] ($RHID_Water_Prime | Select-String "Pass") -eq "True") {
    $RHID_Water_Prime_Plug = ($storyboard | Select-String "Plug detected" | Select-Object -Last 1).line.split(",").TrimStart() | Select-Object -Last 2 | Select-Object -SkipLast 1
    Write-Host "$WetTest : $RHID_Water_Prime_Str $Test_Passed" -ForegroundColor Green
    Write-Host "$WetTest : [32/41]  $RHID_Water_Prime_Plug" -ForegroundColor Cyan 
}
else {
    Write-Host "$WetTest : $RHID_Water_Prime_Str $Test_Failed" -ForegroundColor Red    
}

if (($RHID_Lysis_Prime).count -eq "") {
    Write-Host "$WetTest : $RHID_Lysis_Prime_Str $Test_NA"    -ForegroundColor Yellow 
}
elseif ([bool] ($RHID_Lysis_Prime | Select-String "Pass") -eq "True") {
    Write-Host "$WetTest : $RHID_Lysis_Prime_Str $Test_Passed" -ForegroundColor Green 
}
else {
    Write-Host "$WetTest : $RHID_Lysis_Prime_Str $Test_Failed" -ForegroundColor Red    
}

if (($RHID_Buffer_Prime).count -eq "") {
    Write-Host "$WetTest : $RHID_Buffer_Prime_Str $Test_NA"    -ForegroundColor Yellow 
}
elseif ([bool] ($RHID_Buffer_Prime | Select-String "Pass") -eq "True") {
    Write-Host "$WetTest : $RHID_Buffer_Prime_Str $Test_Passed" -ForegroundColor Green 
}
else {
    Write-Host "$WetTest : $RHID_Buffer_Prime_Str $Test_Failed" -ForegroundColor Red    
}

if (($RHID_Lysis_Dispense).count -eq "") {
    Write-Host "$WetTest : $RHID_Lysis_Dispense_Str $Test_NA"    -ForegroundColor Yellow 
}
elseif ([bool] ($RHID_Lysis_Dispense | Select-String "Pass") -eq "True") {
    $RHID_Lysis_Dispense_Volume = ($storyboard | Select-String "Lysis Volume ="  | Select-Object -Last 1).line.split("=").TrimStart() | Select-object -last 1
    Write-Host "$WetTest : $RHID_Lysis_Dispense_Str $Test_Passed" -ForegroundColor Green
    Write-Host "$WetTest : $RHID_Lysis_Dispense_Str : $RHID_Lysis_Dispense_Volume" -ForegroundColor Cyan 
}
else {
    Write-Host "$WetTest : $RHID_Lysis_Dispense_Str $Test_Failed" -ForegroundColor Red    
}

if (($RHID_Lysate_Pull).count -eq "") {
    Write-Host "$WetTest : $RHID_Lystate_Pull_Str $Test_NA"    -ForegroundColor Yellow 
}
elseif ([bool] ($RHID_Lysate_Pull | Select-String "Pass") -eq "True") {
    Write-Host "$WetTest : $RHID_Lystate_Pull_Str $Test_Passed" -ForegroundColor Green 
}
else {
    Write-Host "$WetTest : $RHID_Lystate_Pull_Str $Test_Failed" -ForegroundColor Red    
}

if (($RHID_Capillary_Gel_Prime).count -eq "") {
    Write-Host "$WetTest : $RHID_Capillary_Gel_Prime_Str $Test_NA"    -ForegroundColor Yellow 
}
elseif ([bool] ($RHID_Capillary_Gel_Prime | Select-String "Completed") -eq "True") {
    Write-Host "$WetTest : $RHID_Capillary_Gel_Prime_Str : Completed" -ForegroundColor Green 
}
else {
    Write-Host "$WetTest : $RHID_Capillary_Gel_Prime_Str $Test_Failed" -ForegroundColor Red    
}

if (($RHID_Raman).count -eq "") {
    Write-Host "$Laser : $RHID_Verify_Raman_Str $Test_NA"    -ForegroundColor Yellow 
}
elseif ([bool] ($RHID_Raman | Select-String "Pass") -eq "True") {
    Write-Host "$Laser : $RHID_Verify_Raman_Str $Test_Passed" -ForegroundColor Green
}
else {
    Write-Host "$Laser : $RHID_Verify_Raman_Str $Test_Failed" -ForegroundColor Red    
}

$RHID_Bolus = Get-ChildItem "$Drive\$MachineName\*Bolus Delivery Test*" -I storyboard*.* -R | Select-String "Bolus Devliery Test" | select-string "PASS"
if ($RHID_Bolus.count -gt 1) {
    Write-host "$Bolus : $Bolus_Test_count_Str" : $RHID_Bolus.count -ForegroundColor Green
}
else {
    Write-host "$Bolus : $Bolus_Test_count_Str : N/A" -ForegroundColor Yellow
}

IF ([Bool]$RHID_BEC_Reinsert -eq "True") {
    $RHID_Gel_Void = ($storyboard | Select-String "Estimated gel void volume" | Select-object -last 1).line.split("=").TrimStart() | Select-Object -Last 1
    $RHID_BEC_ID = $RHID_BEC_Reinsert_ID.line.split(":").TrimStart() | Select-Object -Last 1
    Write-host "$BEC_Insertion : $RHID_CoverOn_BEC_Reinsert : Completed ; $RHID_BEC_ID"
    Write-host "$BEC_Insertion : $RHID_Last_Gel_Void : $RHID_Gel_Void" -ForegroundColor Cyan 
}
Else {
    Write-host "$BEC_Insertion : $RHID_CoverOn_BEC_Reinsert : N/A" -ForegroundColor Yellow
    Write-host "$BEC_Insertion : $RHID_Last_Gel_Void : N/A" -ForegroundColor Yellow 
}
$Section_Separator
IF ([BOOL]$GM_ILS_Score_GFE_36cycles -eq "True") {
    $GM_ILS_Score_GFE_36cycles_Score = $GM_ILS_Score_GFE_36cycles.Line.Split("	") | Select-Object -Last 1
    $serverdir36cycles = "$Drive\$MachineName\*GFE-300uL-36cycles*"
    $DxCode = Get-ChildItem $serverdir36cycles -I DxCode.xml -R | Select-Xml -XPath "//DxCode" | ForEach-Object { $_.node.InnerXML }
    $RunSummaryCSV = Get-ChildItem $serverdir36cycles -I RunSummary.csv -R
    . $PSScriptRoot\RunSummaryCSV.ps1
    Write-Host "$GM_ILS : $GFE_36cycles_Trace_Str : $GM_ILS_Score_GFE_36cycles_Score $DxCode" -ForegroundColor Green
    "$Date_Time : [2/1] $RHID_Date_Time ; $Bolus_Timing : $RHID_Bolus_Timing"
    "$SampleName : [3/1] $RHID_SampleName"
    "$Cartridge_Type : [4/1] $RHID_Cartridge_Type ; [Type] : $RHID_RunType"
    "$Protocol_Setting : [5/1] $RHID_Protocol_Setting [LN]$RHID_Cartridge_ID [BEC]$RHID_BEC_ID"
}
Else { Write-Host "$GM_ILS : $GFE_36cycles_Trace_Str : N/A" -ForegroundColor Yellow }
$Section_Separator
IF ([BOOL]$GM_ILS_Score_GFE_BV -eq "True") {
    $GM_ILS_Score_GFE_BV_Score = $GM_ILS_Score_GFE_BV.Line.Split("	") | Select-Object -Last 1
    $serverdir_GFE_BV = "$Drive\$MachineName\*GFE-BV_*"
    $DxCode = Get-ChildItem $serverdir_GFE_BV -I DxCode.xml -R | Select-Xml -XPath "//DxCode" | ForEach-Object { $_.node.InnerXML }
    $RunSummaryCSV = Get-ChildItem $serverdir_GFE_BV -I RunSummary.csv -R
    . $PSScriptRoot\RunSummaryCSV.ps1
    Write-Host "$GM_ILS : $GFE_BV_Trace_Str : $GM_ILS_Score_GFE_BV_Score $DxCode"-ForegroundColor Green
    "$Date_Time : [2/2] $RHID_Date_Time ; $Bolus_Timing : $RHID_Bolus_Timing"
    "$SampleName : [3/2] $RHID_SampleName"
    "$Cartridge_Type : [4/2] $RHID_Cartridge_Type ; [Type] : $RHID_RunType"
    "$Protocol_Setting : [5/2] $RHID_Protocol_Setting [LN]$RHID_Cartridge_ID [BEC]$RHID_BEC_ID"
}
Else { Write-Host "$GM_ILS : $GFE_BV_Trace_Str : N/A" -ForegroundColor Yellow }
