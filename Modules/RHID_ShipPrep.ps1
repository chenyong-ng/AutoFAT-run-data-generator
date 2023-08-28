
function RHID_ShipPrep_Check {
# ignore folder with 0 size
$Remote                     = Get-ChildItem -force "$Drive\$MachineName\Internal\"  -Recurse -ErrorAction SilentlyContinue
$Local                      = Get-ChildItem -force "E:\RapidHIT ID"             -Recurse -ErrorAction SilentlyContinue
$RemoteSize                 = "{0:N4} GB" -f (($Remote | Measure-Object Length -sum -ErrorAction SilentlyContinue ).sum / 1Gb)
$LocalSize                  = "{0:N4} GB" -f (( $Local | Measure-Object Length -sum ).sum / 1Gb)
$RemoteFileCount            = (Get-ChildItem "$Drive\$MachineName\Internal\"  -Recurse -ErrorAction SilentlyContinue | Measure-Object).Count 
$localFileCount             = (Get-ChildItem "E:\RapidHIT ID"  -Recurse -ErrorAction SilentlyContinue | Measure-Object).Count 

$RHID_Shipping_BEC          = $storyboard | Select-String "Shipping BEC engaged"
if ([bool]$RHID_Shipping_BEC -eq "True") {
    Write-Host "$SHP_BEC :   BEC Insertion completed, Shipping BEC : Engaged" -ForegroundColor Green
}
else {
    Write-Host "$SHP_BEC :           Shipping BEC not yet inserted" -ForegroundColor Yellow 
}

$Remote_Str                 = "     Remote $Drive\$MachineName\Internal\ Size" 
$Local_Str                  = "       Local Folder E:\RapidHIT ID Size" 
# block empty machine name
$Local_Folder_Msg           = Write-Host "$boxPrep : $Local_Str : $LocalSize ; Files : $LocalFileCount"
$Remote_Folder_Msg          = Write-Host "$boxPrep : $Remote_Str : $RemoteSize ; Files : $RemoteFileCount"
IF ([Bool]$MachineName -eq "False") {
    $Local_Folder_Msg
    $Remote_Folder_Msg
    #Write-Host "$BoxPrep : Backup Instrument folder before Boxprep !!!" -ForegroundColor Red
}

$RHID_Danno_Path            = $Drive + $Danno + $MachineName
$RHID_US_Danno_Path         = $US_Drive + $Danno + $MachineName
If ((Test-Path -Path "$RHID_Danno_Path") -eq "True") {
    $RHID_HIDAutolite       = [string](Get-ChildItem $RHID_Danno_Path -I *BoxPrepLog_RHID* -R -ErrorAction SilentlyContinue -Exclude "*.log" | Select-String $RHID_HIDAutolite_Str)[-1].Line.Split("License number provided is")[-1].replace(".","").Trim()
    $RHID_BoxPrep_Scrshot   = Get-ChildItem -Path $RHID_Danno_Path\Screenshots *.PNG -ErrorAction SilentlyContinue
    Write-Host $BoxPrep : $Danno_SS_Count : $RHID_BoxPrep_Scrshot.Name.Count -ForegroundColor Green
    Write-Host "$HIDAutolite : $RHID_HIDAutolite_Str : $RHID_HIDAutolite" -ForegroundColor Green
    } elseif ($RHID_BoxPrep_Scrshot.Name.Count -eq "0") {
    Write-Host "$BoxPrep : Not Initialized" -ForegroundColor Yellow
    Write-Host "$HIDAutolite : $RHID_HIDAutolite_Str : N/A" -ForegroundColor Green 
}

$GFE36cyclesCount           = ($GM_ILS_Score_GFE_36cycles.count -gt 0)
$GFE_BVCount                = ($GM_ILS_Score_GFE_BV.count -gt 0)
$LadderCount                = ($GM_ILS_Score_Allelic_Ladder.count -gt 0)
$GFE_007Count               = ($GM_ILS_Score_GFE_007.count -gt 0)
$NGM_007Count               = ($GM_ILS_Score_NGM_007.count -gt 0)
$BLANKCount                 = ($GM_ILS_Score_BLANK.count -gt 3)
$FullRunCounter             = $GFE36cyclesCount, $GFE_BVCount, $LadderCount, $GFE_007Count, $NGM_007Count, $BLANKCount

if ((($FullRunCounter -match "True").count -gt 5) -and ($SerialRegMatch -eq "True")) {
    Write-Host "$BoxPrep :   Backing Up Instrument Run data to Remote Folder" -ForegroundColor Green

        "Performing backup operation"
        # BackupBeforeShipprep
    }
}