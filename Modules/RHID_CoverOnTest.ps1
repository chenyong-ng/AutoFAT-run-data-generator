

$GM_ILS_Score_Allelic_Ladder = ( $SampleQuality | Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' } | select-string -NotMatch "Current" | Select-String "Trace__Ladder.fsa")
$GM_ILS_Score_GFE_007 = ( $SampleQuality | Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' } | select-string -NotMatch "Current" | Select-String "Trace__GFE_007")
$GM_ILS_Score_NGM_007 = ( $SampleQuality | Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' } | select-string -NotMatch "Current" | Select-String "Trace__NGM")
$GM_ILS_Score_BLANK = ( $SampleQuality | Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' } | select-string -NotMatch "Current" | Select-String "Trace__BLANK")
# Sample Quality if -1 means failed

If ([Bool]$MachineName -eq "True") {
    "$Loading : $StatusData_File and $GM_Analysis_File textual filtering commands "
    $StatusData_leaf = Get-ChildItem $FullRun_Folder -I $StatusData_File -R -ErrorAction SilentlyContinue |  Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' } | Test-path -PathType Leaf
    "$Found : " + $StatusData_leaf.count + " , " + $(if ($StatusData_leaf.count -gt 0) { $StatusData_leaf[0] })
    $GM_Analysis_leaf = Get-ChildItem $FullRun_Folder -I $GM_Analysis_File -R -ErrorAction SilentlyContinue |  Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' } | Test-path -PathType Leaf
    "$Found : " + $GM_Analysis_leaf.count + " , " + $(if ($GM_Analysis_leaf.count -gt 0) { $GM_Analysis_leaf[0] })
}
# Use | Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' } |
# Commands to filter out the "Internal" Folder which is duplicate copies of Main folders to speed up the data extraction

"$Loading : DannoGUIState.XML for Ambient and Humidity reading"
$RHID_USB_Temp_Rdr = $DannoGUIStateXML | Select-Xml -XPath "//RunEndAmbientTemperatureC" | ForEach-Object { $_.node.InnerXML } | Select-Object -Last 3
$RHID_USB_Humi_Rdr = $DannoGUIStateXML | Select-Xml -XPath "//RunEndRelativeHumidityPercent" | ForEach-Object { $_.node.InnerXML } | Select-Object -Last 3

function RHID_CoverOn_FullRun {
<#
Cover On Allelic Ladder Tests
#>
IF ($GM_ILS_Score_Allelic_Ladder.count -gt "0") {
    $GM_ILS_Score_Allelic_Ladder_Score = $GM_ILS_Score_Allelic_Ladder.Line.Split("	") | Select-Object -Last 1
    $DxCode = Get-ChildItem $serverdir_Ladder -I DxCode.xml -R -ErrorAction SilentlyContinue | Select-Xml -XPath "//DxCode" | ForEach-Object { $_.node.InnerXML }
    $RHID_GelSyringe_record = (Get-ChildItem $serverdir_Ladder -I Storyboard*.txt -R -ErrorAction SilentlyContinue | Select-String "Gel syringe record").line.split(",")[-1].replace("Gel syringe record:", "").replace("mL", "").Trim()
    $RunSummaryCSV = Get-ChildItem $serverdir_Ladder -I RunSummary.csv -R -ErrorAction SilentlyContinue 
    . $PSScriptRoot\RunSummaryCSV.ps1
    Write-Host "$GM_ILS : $Allelic_Ladder_Trace_Str : $GM_ILS_Score_Allelic_Ladder_Score $DxCode" -ForegroundColor Green
    "$Date_Time : [2/3] $RHID_Date_Time ; $Bolus_Timing : $RHID_Bolus_Timing"
    Write-Host "$Cartridge_Type : [3/3] $RHID_Cartridge_Type ; [Type] : $RHID_RunType" -ForegroundColor Cyan
    "$Protocol_Setting : [4/3] $RHID_Protocol_Setting [LN]$RHID_Cartridge_ID [BEC]$RHID_BEC_ID"
    "$Gel_Syringe : [5/3] $RHID_GelSyringe_record [mL]"
}
Else { Write-Host "$GM_ILS : $Allelic_Ladder_Trace_Str : N/A" -ForegroundColor Yellow }
$Section_Separator
<#
Cover On GFE Tests
#>
IF ($GM_ILS_Score_GFE_007.count -gt "0") {
    $GM_ILS_Score_GFE_007_Score = $GM_ILS_Score_GFE_007.Line.Split("	") | Select-Object -Last 1
    $DxCode = Get-ChildItem $serverdir_GFE_007 -I DxCode.xml -R -ErrorAction SilentlyContinue | Select-Xml -XPath "//DxCode" | ForEach-Object { $_.node.InnerXML }
    $RHID_GelSyringe_record = (Get-ChildItem $serverdir_GFE_007 -I Storyboard*.txt -R -ErrorAction SilentlyContinue | Select-String "Gel syringe record").line.split(",")[-1].replace("Gel syringe record:", "").replace("mL", "").Trim()
    $RunSummaryCSV = Get-ChildItem $serverdir_GFE_007 -I RunSummary.csv -R -ErrorAction SilentlyContinue
    . $PSScriptRoot\RunSummaryCSV.ps1
    Write-Host "$GM_ILS : $GFE_007_Trace_Str : $GM_ILS_Score_GFE_007_Score $DxCode" -ForegroundColor Green
    "$Date_Time : [2/4] $RHID_Date_Time ; $Bolus_Timing : $RHID_Bolus_Timing"
    "$SampleName : [3/4] $RHID_SampleName"
    Write-Host "$Cartridge_Type : [4/4] $RHID_Cartridge_Type ; [Type] : $RHID_RunType" -ForegroundColor magenta
    "$Protocol_Setting : [5/4] $RHID_Protocol_Setting [LN]$RHID_Cartridge_ID [BEC]$RHID_BEC_ID"
    "$Gel_Syringe : [6/4] $RHID_GelSyringe_record [mL]"
}
Else { Write-Host "$GM_ILS : $GFE_007_Trace_Str : N/A" -ForegroundColor Yellow }
$Section_SeparatoR
<#
Cover On NGM Tests, to be retired after NGM Catridges runs out of supply after May of 2023
Keeping codes for checking test results for older instruments
#>
IF ($GM_ILS_Score_NGM_007.count -gt "0") {
    $GM_ILS_Score_NGM_007_Score = $GM_ILS_Score_NGM_007.Line.Split("	") | Select-Object -Last 1
    $DxCode = Get-ChildItem $serverdir_NGM_007 -I DxCode.xml -R -ErrorAction SilentlyContinue | Select-Xml -XPath "//DxCode" | ForEach-Object { $_.node.InnerXML }
    $RHID_GelSyringe_record = (Get-ChildItem $serverdir_NGM_007 -I Storyboard*.txt -R -ErrorAction SilentlyContinue | Select-String "Gel syringe record").line.split(",")[-1].replace("Gel syringe record:", "").replace("mL", "").Trim()
    $RunSummaryCSV = Get-ChildItem $serverdir_NGM_007 -I RunSummary.csv -R -ErrorAction SilentlyContinue
    . $PSScriptRoot\RunSummaryCSV.ps1
    Write-Host "$GM_ILS : $NGM_007_Trace_Str : $GM_ILS_Score_NGM_007_Score $DxCode" -ForegroundColor Green
    "$Date_Time : [2/5] $RHID_Date_Time ; $Bolus_Timing : $RHID_Bolus_Timing"
    "$SampleName : [3/5] $RHID_SampleName"
    Write-Host "$Cartridge_Type : [4/5] $RHID_Cartridge_Type ; [Type] : $RHID_RunType"-ForegroundColor Green
    "$Protocol_Setting : [5/5] $RHID_Protocol_Setting [LN]$RHID_Cartridge_ID [BEC]$RHID_BEC_ID"
    "$Gel_Syringe : [6/5] $RHID_GelSyringe_record [mL]"
}
Else { Write-Host "$GM_ILS : NGM Tests to be depreciated after May 2023" }
$Section_Separator
<#
Cover On Blank Tests
#>
IF ($GM_ILS_Score_BLANK.count -gt "0") {
    $GM_ILS_Score_BLANK_Score = $GM_ILS_Score_BLANK.Line.Split("	") | Select-Object -Last 1
    $DxCode = Get-ChildItem $serverdir_BLANK -I DxCode.xml -R -ErrorAction SilentlyContinue | Select-Xml -XPath "//DxCode" | ForEach-Object { $_.node.InnerXML }
    $RHID_GelSyringe_record = (Get-ChildItem $serverdir_BLANK -I Storyboard*.txt -R -ErrorAction SilentlyContinue | Select-String "Gel syringe record").line.split(",")[-1].replace("Gel syringe record:", "").replace("mL", "").Trim()
    $RunSummaryCSV = Get-ChildItem $serverdir_BLANK -I RunSummary.csv -R -ErrorAction SilentlyContinue
    $BlankRunCounter = Get-ChildItem $serverdir_BLANK -I $GM_Analysis_File -R -ErrorAction SilentlyContinue
    If ($BlankRunCounter.count -gt 3) { $Color = "Cyan"
        } else {
            $Color = "Red"
            $BlankSOP = "$RunCounter : [7/6] Minimum 4 Blank Tests are required after February 2023 as per SOP"
        }
    . $PSScriptRoot\RunSummaryCSV.ps1
    Write-Host "$GM_ILS : $BLANK_Trace_Str : $GM_ILS_Score_BLANK_Score $DxCode" -ForegroundColor Green
    "$Date_Time : [2/6] $RHID_Date_Time ; $Bolus_Timing : $RHID_Bolus_Timing"
    "$SampleName : [3/6] $RHID_SampleName"
    Write-Host "$Cartridge_Type : [4/6] $RHID_Cartridge_Type ; [Type] : $RHID_RunType" -ForegroundColor magenta
    "$Protocol_Setting : [5/6] $RHID_Protocol_Setting [LN]$RHID_Cartridge_ID [BEC]$RHID_BEC_ID"
    "$Gel_Syringe : [6/6] $RHID_GelSyringe_record [mL]"
    Write-Host "$RunCounter : [7/6] Blank Run Counter :" $BlankRunCounter.count -ForegroundColor $Color
    Write-Host $BlankSOP -ForegroundColor $Color
}
Else { Write-Host "$GM_ILS : $BLANK_Trace_Str : N/A" -ForegroundColor Yellow }
}
function RHID_PDF_Check {
if ($StatusData_leaf[0] -eq "True" ) {
        $RHID_StatusData_PDF = Get-ChildItem -path $FullRun_Folder -I $StatusData_File -R -ErrorAction SilentlyContinue |  Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' } | Format-table Directory -Autosize -wrap -HideTableHeaders
    Write-Host "$Full_Run : $StatusData_File $File_found" -ForegroundColor Green
        $RHID_StatusData_PDF
}
else { Write-host "$Full_Run : $StatusData_File $File_not_Found" -ForegroundColor yellow 
}
}

function RHID_GM_Analysis_Check {
if ($GM_Analysis_leaf[0] -eq "True" ) {
        $RHID_GM_Analysis = Get-ChildItem -path $FullRun_Folder -I $GM_Analysis_File -R -ErrorAction SilentlyContinue |  Where-Object { $_.PsIsContainer -or $_.FullName -notmatch 'Internal' } | Format-table Directory -Autosize -wrap -HideTableHeaders
    Write-Host "$Full_Run : $GM_Analysis_File $File_found" -ForegroundColor Green
        $RHID_GM_Analysis
        # Disabled: Size Call Failed (anatlysis failed)
}
else { Write-host "$Full_Run : $GM_Analysis_File $File_not_Found" -ForegroundColor yellow }
}

function RHID_TempHumi_Check {
Write-Host "$USB_Temp : $USB_Temp_RD : $RHID_USB_Temp_Rdr" -ForegroundColor Cyan
Write-Host "$USB_Humi : $USB_Humi_RD : $RHID_USB_Humi_Rdr" -ForegroundColor Cyan
}
