
$RHID_Report_Leaf     = Test-Path -Path $PSScriptRoot\Modules\RHID_Report.ps1 -PathType Leaf
if ($RHID_Report_Leaf -eq $True) {
    "good to go"
    } else {
    "nogo"}
start-sleep -Seconds 5
. $PSScriptRoot\Modules\Report_Automation.ps1