
if ([Bool]$RunSummaryCSV -eq "True") {
$RHID_Protocol_Setting = ($RunSummaryCSV | Select-String "Protocol_Setting" | Select-object -last 1).Line.Split(",") | Select-Object -Last 1
$RHID_RunType        = ($RunSummaryCSV | Select-String "Run_Type" | Select-object -last 1).Line.Split(",") | Select-Object -Last 1
$RHID_Cartridge_ID   = ($RunSummaryCSV | Select-String "Cartridge_ID" | Select-object -last 1).Line.Split(",") | Select-Object -Last 1
$RHID_Cartridge_Type = ($RunSummaryCSV | Select-String "Cartridge_Type" | Select-object -last 1).Line.Split(",") | Select-Object -Last 1
$RHID_SampleName     = ($RunSummaryCSV | Select-String "SampleName" | Select-object -last 1).Line.Split(",") | Select-Object -Last 1
$RHID_BEC_ID         = ($RunSummaryCSV | Select-String "BEC_ID" | Select-object -last 1).Line.Split(",") | Select-Object -Last 1
$RHID_Bolus_Timing   = ($RunSummaryCSV | Select-String "Bolus_Timing" | Select-object -last 1).Line.Split(",") | Select-Object -Last 1
$RHID_Date_Time      = ($RunSummaryCSV | Select-String "Date_Time" | Select-object -last 1).Line.Split(",") | Select-Object -Last 1
$RHID_Num_ILS_Off_Standard      = ($RunSummaryCSV | Select-String "Num_ILS_Off_Standard" | Select-object -last 1).Line.Split(",") | Select-Object -Last 1
    #Num_ILS_Off_Standard CHECK if eq to 1, Genotype Miscall
}
