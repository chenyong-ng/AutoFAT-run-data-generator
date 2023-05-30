
function RHID_ShipPrep_Check {
# ignore folder with 0 size
$Remote = Get-ChildItem -force "$Drive\$MachineName\Internal\"  -Recurse -ErrorAction SilentlyContinue
$Local = Get-ChildItem -force "E:\RapidHIT ID"             -Recurse -ErrorAction SilentlyContinue
$RemoteSize = "{0:N4} GB" -f (($Remote | Measure-Object Length -sum -ErrorAction SilentlyContinue ).sum / 1Gb)
$LocalSize = "{0:N4} GB" -f (( $Local | Measure-Object Length -sum ).sum / 1Gb)
$RemoteFileCount = (Get-ChildItem "$Drive\$MachineName\Internal\"  -Recurse -ErrorAction SilentlyContinue | Measure-Object).Count 
$localFileCount = (Get-ChildItem "E:\RapidHIT ID"  -Recurse -ErrorAction SilentlyContinue | Measure-Object).Count 

$RHID_Shipping_BEC = $storyboard | Select-String "Shipping BEC engaged"
if ([bool]$RHID_Shipping_BEC -eq "True") {
    Write-Host "$SHP_BEC :   BEC Insertion completed, Shipping BEC : Engaged" -ForegroundColor Green
}
else {
    Write-Host "$SHP_BEC :           Shipping BEC not yet inserted" -ForegroundColor Yellow 
}

# block empty machine name
$Local_Folder_Msg = Write-Host "$boxPrep : $Local_Str : $LocalSize ; Files : $LocalFileCount"
$Remote_Folder_Msg = Write-Host "$boxPrep : $Remote_Str : $RemoteSize ; Files : $RemoteFileCount"
IF ([Bool]$MachineName -eq "False") {
    $Local_Folder_Msg
    $Remote_Folder_Msg
    #Write-Host "$BoxPrep : Backup Instrument folder before Boxprep !!!" -ForegroundColor Red
}

$RHID_Danno_Path = $danno + $MachineName
$RHID_US_Danno_Path = $US_danno + $MachineName
If ((Test-Path -Path "$RHID_Danno_Path") -eq "True") {
    $RHID_HIDAutolite = (Get-ChildItem $RHID_Danno_Path -I *BoxPrepLog_RHID* -R -ErrorAction SilentlyContinue -Exclude "*.log" | Select-String $RHID_HIDAutolite_Str | Select-Object -Last 1).Line.Split(" ").TrimStart()[-1]
    $RHID_BoxPrep_Scrshot = Get-ChildItem -Path $RHID_Danno_Path\Screenshots *.PNG -ErrorAction SilentlyContinue
    Write-Host $BoxPrep : $Danno_SS_Count : $RHID_BoxPrep_Scrshot.Name.Count -ForegroundColor Green
    Write-Host "$HIDAutolite : $RHID_HIDAutolite_Str : $RHID_HIDAutolite" -ForegroundColor Green
    } elseif ($RHID_BoxPrep_Scrshot.Name.Count -eq "0") {
    Write-Host "$BoxPrep : Not Initialized" -ForegroundColor Yellow
    Write-Host "$HIDAutolite : $RHID_HIDAutolite_Str : N/A" -ForegroundColor Green 
}


if (($RemoteSize -lt $LocalSize) -and ($SerialRegMatch -eq "True")) {
    Write-Host "$BoxPrep :   Backing Up Instrument Run data to Remote Folder" -ForegroundColor Green
    $KeyPress_Backup = "Enter to skip backup operation"
    IF ($KeyPress_Backup -eq "") {
        "Skipped backup operation"
    }
    else {
        "Performing backup operation"
        # BackupBeforeShipprep
    }
}
}