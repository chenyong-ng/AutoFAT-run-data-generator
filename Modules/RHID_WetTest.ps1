
"$Loading : WET test textual filtering commands "
$RHID_Water_Prime    = ($storyboard | Select-String "Bring Up: Water Prime" | Select-Object -Last 1)
$RHID_Lysis_Prime    = ($storyboard | Select-String "Bring Up: Lysis Prime" | Select-Object -Last 1)
$RHID_Buffer_Prime   = ($storyboard | Select-String "Bring Up: Buffer Prime" |  Select-Object -Last 1)

$RHID_Lysis_Dispense = ($storyboard | Select-String "Bring Up: Lysis Dispense Test" | Select-Object -Last 1)
$RHID_Lysate_Pull = ($storyboard | Select-String "Bring Up: Lysate Pull" | Select-Object -Last 1)
$RHID_Capillary_Gel_Prime = ($storyboard | Select-String "Bring Up: Capillary Gel Prime" | Select-Object -Last 1)
$RHID_Raman = ($storyboard | Select-String "Bring Up: Verify Raman"  | Select-Object -Last 1)

$RHID_Bolus_DN = ((Get-ChildItem "$Drive\$MachineName\*Bolus Delivery Test*" -I storyboard*.* -R | Select-String "% in DN =").line.split(",") | Select-String "% in DN")
$RHID_Bolus_DN_Alt = (Get-ChildItem "$Drive\$MachineName\*Bolus Delivery Test*" -I storyboard*.* -R | Select-String "Bolus detected").line.split(",") | Select-String "Bolus detected" | Select-String "into the denaturing window"
$RHID_Bolus_Volume = ((Get-ChildItem "$Drive\$MachineName\*Bolus Delivery Test*" -I storyboard*.* -R | Select-String "Volume  =").line.split(",") | Select-String "Volume  =")
$RHID_Bolus_Volume_Alt = (Get-ChildItem "$Drive\$MachineName\*Bolus Delivery Test*" -I storyboard*.* -R | Select-String "Bolus first detected at").line
$RHID_Bolus_Timing = ((Get-ChildItem "$Drive\$MachineName\*Bolus Delivery Test*" -I storyboard*.* -R | Select-String "Timing =").line.split(",") | Select-String "Timing =") 
$RHID_Bolus_Current = ((Get-ChildItem "$Drive\$MachineName\*Bolus Delivery Test*" -I storyboard*.* -R | Select-String "Bolus Current =").line.split(",") | Select-String "Bolus Current =")
"Last 10 runs DN% :"
$RHID_Bolus_DN.line.trimStart()
$RHID_Bolus_DN_Alt.line.trimStart() 
"Last 10 runs Bolus Vol :"
($RHID_Bolus_Volume.line.trimStart())
$RHID_Bolus_Volume_Alt
"Last 10 runs Bolus Timing :"
($RHID_Bolus_Timing.line.trimStart())
"Last 10 runs Bolus Current :"
($RHID_Bolus_Current.line.trimStart())

"$Loading : BEC Insertion textual filtering commands "
$RHID_BEC_Reinsert = ( $CoverOn_BEC_Reinsert | Select-String "BEC Reinsert completed" | Select-Object -Last 1) 
$RHID_BEC_Reinsert_ID = ( $CoverOn_BEC_Reinsert | Select-String "BEC ID" | Select-Object -Last 1)

"$Loading : Full run textual filtering commands "
$GM_ILS_Score_GFE_36cycles   = ( $SampleQuality | Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' } | select-string -NotMatch "Current" | Select-String "Trace__GFE-300uL-36cycles")
$GM_ILS_Score_GFE_BV         = ( $SampleQuality | Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' } | select-string -NotMatch "Current" | Select-String "Trace__GFE-BV")

function RHID_WetTest {
if ($RHID_Water_Prime.count -eq "0") {
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

if ($RHID_Lysis_Prime.count -eq 0) {
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

If ((Test-Path -Path "$Drive\$MachineName\*Bolus Delivery Test*") -eq "True") {
    $Bolus_leaf = "$Drive\$MachineName\*Bolus Delivery Test*"
    }
If ((Test-Path -Path "$US_Drive\$MachineName\*Bolus Delivery Test*") -eq "True") {
    $US_Bolus_leaf = "$US_Drive\$MachineName\*Bolus Delivery Test*"
    }
$Bolus_Delivery_Folder = $Bolus_leaf + $US_Bolus_leaf
$RHID_Bolus = Get-ChildItem $Bolus_Delivery_Folder -I storyboard*.* -R | Select-String "Bolus Devliery Test" | select-string "PASS"
if ($RHID_Bolus.count -gt 1) {
    Write-host "$Bolus : $Bolus_Test_count_Str" : $RHID_Bolus.count -ForegroundColor Green
}
else {
    Write-host "$Bolus : $Bolus_Test_count_Str : N/A" -ForegroundColor Yellow
}
}

function RHID_CoverOff_FullRun {
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
<#
Cover Off GFE 36 cycles 300ul Tests
#>
If ((Test-Path -Path "$Drive\$MachineName\*GFE-300uL-36cycles*") -eq "True") {
    $serverdir36cycles_leaf = "$Drive\$MachineName\*GFE-300uL-36cycles*"
    }
If ((Test-Path -Path "$US_Drive\$MachineName\*GFE-300uL-36cycles*") -eq "True") {
    $US_serverdir36cycles_leaf = "$US_Drive\$MachineName\*GFE-300uL-36cycles*"
    }
$serverdir36cycles = $serverdir36cycles_leaf + $US_serverdir36cycles_leaf

IF ($GM_ILS_Score_GFE_36cycles[-1].count -gt "0") {
    $GM_ILS_Score_GFE_36cycles_Score = $GM_ILS_Score_GFE_36cycles.Line.Split("	") | Select-Object -Last 1
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
<#
Cover Off Blank Tests
#>
If ((Test-Path -Path "$Drive\$MachineName\*GFE-BV_*") -eq "True") {
    $serverdir_GFE_BV_leaf = "$Drive\$MachineName\*GFE-BV_*"
    }
If ((Test-Path -Path "$US_Drive\$MachineName\*GFE-BV_*") -eq "True") {
    $US_serverdir_GFE_BV_leaf = "$US_Drive\$MachineName\*GFE-BV_*"
    }
$serverdir_GFE_BV = $serverdir_GFE_BV_leaf + $US_serverdir_GFE_BV_leaf

IF ($GM_ILS_Score_GFE_BV[-1].count -gt "0") {
    $GM_ILS_Score_GFE_BV_Score = $GM_ILS_Score_GFE_BV.Line.Split("	") | Select-Object -Last 1
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
}
