

$GM_ILS_Score_Allelic_Ladder = ( $SampleQuality | Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' } | select-string -NotMatch "Current" | Select-String "Trace__Ladder.fsa") | Select-Object -Last 1
$GM_ILS_Score_GFE_007 = ( $SampleQuality | Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' } | select-string -NotMatch "Current" | Select-String "Trace__GFE_007") | Select-Object -Last 1
$GM_ILS_Score_NGM_007 = ( $SampleQuality | Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' } | select-string -NotMatch "Current" | Select-String "Trace__NGM") | Select-Object -Last 1
$GM_ILS_Score_BLANK = ( $SampleQuality | Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' } | select-string -NotMatch "Current" | Select-String "Trace__BLANK") | Select-Object -Last 1

If ([Bool]$MachineName -eq "True") {
    "$Loading : $StatusData and $GM_Analysis textual filtering commands "
    $StatusData_leaf = Get-ChildItem $Drive\$MachineName -I $StatusData  -R | Test-path -PathType Leaf
    $GM_Analysis_leaf = Get-ChildItem $Drive\$MachineName -I $GM_Analysis -R | Test-path -PathType Leaf
}

"$Loading : DannoGUIState.XML for Ambient and Humidity reading"
$RHID_USB_Temp_Rdr = $DannoGUIStateXML | Select-Xml -XPath "//RunEndAmbientTemperatureC" | ForEach-Object { $_.node.InnerXML } | Select-Object -Last 3
$RHID_USB_Humi_Rdr = $DannoGUIStateXML | Select-Xml -XPath "//RunEndRelativeHumidityPercent" | ForEach-Object { $_.node.InnerXML } | Select-Object -Last 3

function RHID_CoverOn_FullRun {
<#
Cover On Allelic Ladder Tests
#>
IF ([BOOL]$GM_ILS_Score_Allelic_Ladder -eq "True") {
    $GM_ILS_Score_Allelic_Ladder_Score = $GM_ILS_Score_Allelic_Ladder.Line.Split("	") | Select-Object -Last 1
    $serverdir_Ladder = "$Drive\$MachineName\*GFE-BV Allelic Ladder*"
    $DxCode = Get-ChildItem $serverdir_Ladder -I DxCode.xml -R | Select-Xml -XPath "//DxCode" | ForEach-Object { $_.node.InnerXML }
    $RunSummaryCSV = Get-ChildItem $serverdir_Ladder -I RunSummary.csv -R
    . $PSScriptRoot\RunSummaryCSV.ps1
    Write-Host "$GM_ILS : $Allelic_Ladder_Trace_Str : $GM_ILS_Score_Allelic_Ladder_Score $DxCode" -ForegroundColor Green
    "$Date_Time : [2/3] $RHID_Date_Time ; $Bolus_Timing : $RHID_Bolus_Timing"
    Write-Host "$Cartridge_Type : [3/3] $RHID_Cartridge_Type ; [Type] : $RHID_RunType" -ForegroundColor Cyan
    "$Protocol_Setting : [4/3] $RHID_Protocol_Setting [LN]$RHID_Cartridge_ID [BEC]$RHID_BEC_ID"
}
Else { Write-Host "$GM_ILS : $Allelic_Ladder_Trace_Str : N/A" -ForegroundColor Yellow }
$Section_Separator
<#
Cover On GFE Tests
#>
IF ([BOOL]$GM_ILS_Score_GFE_007 -eq "True") {
    $GM_ILS_Score_GFE_007_Score = $GM_ILS_Score_GFE_007.Line.Split("	") | Select-Object -Last 1
    $serverdir_GFE_007 = "$Drive\$MachineName\*GFE_007*"
    $DxCode = Get-ChildItem $serverdir_GFE_007 -I DxCode.xml -R | Select-Xml -XPath "//DxCode" | ForEach-Object { $_.node.InnerXML }
    $RunSummaryCSV = Get-ChildItem $serverdir_GFE_007 -I RunSummary.csv -R
    . $PSScriptRoot\RunSummaryCSV.ps1
    Write-Host "$GM_ILS : $GFE_007_Trace_Str : $GM_ILS_Score_GFE_007_Score $DxCode" -ForegroundColor Green
    "$Date_Time : [2/4] $RHID_Date_Time ; $Bolus_Timing : $RHID_Bolus_Timing"
    "$SampleName : [3/4] $RHID_SampleName"
    Write-Host "$Cartridge_Type : [4/4] $RHID_Cartridge_Type ; [Type] : $RHID_RunType" -ForegroundColor magenta
    "$Protocol_Setting : [5/4] $RHID_Protocol_Setting [LN]$RHID_Cartridge_ID [BEC]$RHID_BEC_ID"
}
Else { Write-Host "$GM_ILS : $GFE_007_Trace_Str : N/A" -ForegroundColor Yellow }
$Section_SeparatoR
<#
Cover On NGM Tests, to be retired after NGM Catridges runs out of supply after May of 2023
Keeping codes for checking test results for older instruments
#>
IF ([BOOL]$GM_ILS_Score_NGM_007 -eq "True") {
    $GM_ILS_Score_NGM_007_Score = $GM_ILS_Score_NGM_007.Line.Split("	") | Select-Object -Last 1
    $serverdir_NGM_007 = "$Drive\$MachineName\*NGM_007*"
    $DxCode = Get-ChildItem $serverdir_NGM_007 -I DxCode.xml -R | Select-Xml -XPath "//DxCode" | ForEach-Object { $_.node.InnerXML }
    $RunSummaryCSV = Get-ChildItem $serverdir_NGM_007 -I RunSummary.csv -R
    $BlankRunCounter = Get-ChildItem $serverdir_BLANK -I $GM_Analysis -R
    . $PSScriptRoot\RunSummaryCSV.ps1
    Write-Host "$GM_ILS : $NGM_007_Trace_Str : $GM_ILS_Score_NGM_007_Score $DxCode" -ForegroundColor Green
    "$Date_Time : [2/5] $RHID_Date_Time ; $Bolus_Timing : $RHID_Bolus_Timing"
    "$SampleName : [3/5] $RHID_SampleName"
    Write-Host "$Cartridge_Type : [4/5] $RHID_Cartridge_Type ; [Type] : $RHID_RunType"-ForegroundColor Green
    "$Protocol_Setting : [5/5] $RHID_Protocol_Setting [LN]$RHID_Cartridge_ID [BEC]$RHID_BEC_ID"
}
Else { Write-Host "$GM_ILS : NGM Tests to be retired after May 2023" }
$Section_Separator
<#
Cover On Blank Tests
#>
IF ([BOOL]$GM_ILS_Score_BLANK -eq "True") {
    $GM_ILS_Score_BLANK_Score = $GM_ILS_Score_BLANK.Line.Split("	") | Select-Object -Last 1
    $serverdir_BLANK = "$Drive\$MachineName\*BLANK*"
    $DxCode = Get-ChildItem $serverdir_BLANK -I DxCode.xml -R | Select-Xml -XPath "//DxCode" | ForEach-Object { $_.node.InnerXML }
    $RunSummaryCSV = Get-ChildItem $serverdir_BLANK -I RunSummary.csv -R
    $BlankRunCounter = Get-ChildItem $serverdir_BLANK -I $GM_Analysis -R
    If ($BlankRunCounter.count -gt 3) { $Color = "Cyan"
        } else {
            $Color = "Red"
            $BlankSOP = "$RunCounter : [6/7] Minimum 4 Blank Tests are required after February 2023 as per SOP"
        }
    . $PSScriptRoot\RunSummaryCSV.ps1
    Write-Host "$GM_ILS : $BLANK_Trace_Str : $GM_ILS_Score_BLANK_Score $DxCode" -ForegroundColor Green
    "$Date_Time : [2/6] $RHID_Date_Time ; $Bolus_Timing : $RHID_Bolus_Timing"
    "$SampleName : [3/6] $RHID_SampleName"
    Write-Host "$Cartridge_Type : [4/6] $RHID_Cartridge_Type ; [Type] : $RHID_RunType" -ForegroundColor magenta
    "$Protocol_Setting : [5/6] $RHID_Protocol_Setting [LN]$RHID_Cartridge_ID [BEC]$RHID_BEC_ID"
    Write-Host "$RunCounter : [6/6] Blank Run Counter :" $BlankRunCounter.count -ForegroundColor $Color
    Write-Host $BlankSOP -ForegroundColor $Color
}
Else { Write-Host "$GM_ILS : $BLANK_Trace_Str : N/A" -ForegroundColor Yellow }
}
function RHID_PDF_Check {
if ([Bool] ($StatusData_leaf | Select-Object -First 1) -eq "True" ) {
    $RHID_StatusData_PDF = Get-ChildItem -path "$Drive\$MachineName" -I $StatusData -R |  Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' } | Format-table Directory -Autosize -HideTableHeaders -wrap
    Write-Host "$Full_Run : $StatusData $File_found" -ForegroundColor Green
    $RHID_StatusData_PDF
}
else { Write-host "$Full_Run : $StatusData $File_not_Found" -ForegroundColor yellow 
}
}

function RHID_GM_Analysis_Check {
if ([Bool] ($GM_Analysis_leaf | Select-Object -First 1) -eq "True" ) {
    $RHID_GM_Analysis = Get-ChildItem -path "$Drive\$MachineName" -I $GM_Analysis -R |  Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' } | Format-table Directory -Autosize -HideTableHeaders -wrap
    Write-Host "$Full_Run : $GM_Analysis $File_found" -ForegroundColor Green
    $RHID_GM_Analysis 
}
else { Write-host "$Full_Run : $GM_Analysis $File_not_Found" -ForegroundColor yellow }
}

function RHID_TempHumi_Check {
Write-Host "$USB_Temp : $USB_Temp_RD : $RHID_USB_Temp_Rdr" -ForegroundColor Cyan
Write-Host "$USB_Humi : $USB_Humi_RD : $RHID_USB_Humi_Rdr" -ForegroundColor Cyan
}
