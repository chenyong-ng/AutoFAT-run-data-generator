# Server-side file checks
Function Server-side_Waves_Screenshot_Check {
if ($Nonlinearity_Leaf_Server -eq $True) { 
    $NonLinearity_FileSize_Server = (Get-Item $Nonlinearity_FullPath -ErrorAction SilentlyContinue | ForEach-Object { [math]::ceiling($_.length / 1KB) })
}
if ($Nonlinearity_Leaf_Server -eq $False) {
    Write-host "$info : $Nonlinearity_File Not Backed to Server" -ForegroundColor Yellow
}
elseif ($NonLinearity_FileSize_Server -eq '0') {
    Write-host "$Warning : Empty $Nonlinearity_File, $NonLinearity_FileSize_Server KB" -ForegroundColor Yellow
} else {
    Write-Host "$info : '$Nonlinearity_File' file size is: $NonLinearity_FileSize_Server KB" -ForegroundColor Green
}

if ($Waves_Leaf_Server -eq $True) {
    $Waves_Filesize_Server = (Get-Item $Waves_FullPath -ErrorAction SilentlyContinue| ForEach-Object { [math]::ceiling($_.length / 1KB) })
}
if ($Waves_Leaf_Server -eq $False) {
    Write-host "$info : $Waves_File Not Backed to Server" -ForegroundColor Yellow
}
elseif ($Waves_Filesize_Server -eq '0') {
    Write-host "$Warning : Empty $Waves_File, $Waves_Filesize_Server KB" -ForegroundColor Yellow
} else {
    Write-Host "$info : '$Waves_File' file size is:" $Waves_Filesize_Server KB -ForegroundColor Green
}
}