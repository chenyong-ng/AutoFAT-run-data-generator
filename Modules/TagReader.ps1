
# Common Cartridge Information
$storyboard             = Get-ChildItem "U:\RHID-0897\*Bolus Delivery*" -I storyboard*.txt -R | Sort-Object LastWriteTime -ErrorAction SilentlyContinue
$Cart_Cartridge_Type    = (($Storyboard | Select-String "Cartridge Type:").line.Split(",")  | select-string "Cartridge Type:").line.replace("Cartridge Type:","").trim()
$Cart_ID_Number         = (($Storyboard | Select-String "ID Number:").line.Split(",")       | select-string "ID Number:").line.replace("ID Number:","").trim()
$Cart_Manufacture_Date  = (($Storyboard | Select-String "Manufacture Date:").line.Split(",")| select-string "Manufacture Date:").line.replace("Manufacture Date:", "").trim()
$Cart_Expiration_Date   = (($Storyboard | Select-String "Expiration Date:").line.Split(",") | select-string "Expiration Date:").line.replace("Expiration Date:", "").trim()
$Cart_Use_Counter       = (($Storyboard | Select-String "Use Counter:").line.Split(",")     | select-string "Use Counter:").line.replace("Use Counter:","").trim()
$Cart_Last_Use_Date     = (($Storyboard | Select-String "Last Use Date:").line.Split(",")   | select-string "Last Use Date:").line.replace("Last Use Date:","").trim()
# BEC exclusive
$Cart_Instrument        = (($Storyboard | Select-String "Instrument:").line.Split(",")      | select-string "Instrument:").line.replace("Instrument:","").trim()
$Cart_Is_Primed         = (($Storyboard | Select-String "Is Primed:").line.Split(",")       | select-string "Is Primed:").line.replace("Is Primed:","").trim()
# Gel Syringe exclusive
# Fresh Gel Syringe does not have BEC info
If (($Storyboard | Select-String "Primary Cartridge:").count -gt 0) {
$Cart_Primary_Cartridge = (($Storyboard | Select-String "Primary Cartridge:").line.Split(",") | select-string "Primary Cartridge:").line.replace("Primary Cartridge:", "").trim()
}

$SampleCartridgeType = @{}
$SampleCartridgeType = @{
   GFE            = "RHID_GFESampleCartridgePLUS"
   GFE_Neg_Ctrl   = "RHID_GFE_ACE_NEGCTRL"
   GFE_Pos_Ctrl   = "RHID_GFE_ACE_POSCTRL"
   NGM_Sample     = "RHID_NGMSampleCartridgePLUS"
   GFE_Ladder     = "RHID_GFEControlCartridgePLUS"
   BEC            = "RHID_PrimaryCartridge_V4"
   Gel            = "RHID_GelSyringe"
}

$Folder_LastWriteTime   = $Storyboard.directory.lastwritetime
$Folder_Name            = $Storyboard.directory.name
$Storyboard_Fullpath    = $Storyboard.FullName
$Cartridge_Type_Sample  = [string]$Cart_Cartridge_Type[0]
$Cartridge_Type_BEC     = [string]$Cart_Cartridge_Type[1]
$Cartridge_Type_Gel     = [string]$Cart_Cartridge_Type[2]
$Cart_ID_Number_Sample  = [int]$Cart_ID_Number[0]
$Cart_ID_Number_BEC     = [int]$Cart_ID_Number[1]
$Cart_ID_Number_Gel     = [int]$Cart_ID_Number[2]
$Cart_Manufacture_Date_Sample = $Cart_Manufacture_Date[0]
$Cart_Manufacture_Date_BEC  = $Cart_Manufacture_Date[1]
$Cart_Manufacture_Date_Gel  = $Cart_Manufacture_Date[2]
$Cart_Expiration_Date_Sample = $Cart_Expiration_Date[0]
$Cart_Expiration_Date_BEC   = $Cart_Expiration_Date[1]
$Cart_Expiration_Date_Gel   = $Cart_Expiration_Date[2]
$Cart_Use_Counter_Sample    = [int]$Cart_Use_Counter[0]
$Cart_Use_Counter_BEC       = [int]$Cart_Use_Counter[1]
$Cart_Use_Counter_Gel       = [int]$Cart_Use_Counter[2]
$Cart_Last_Use_Date_Sample  = $Cart_Last_Use_Date[0]
$Cart_Last_Use_Date_BEC     = $Cart_Last_Use_Date[1]
$Cart_Last_Use_Date_Gel     = $Cart_Last_Use_Date[2]

#Typical usage in production
# add folder name
$TagReaderInfo = @()
   $TagObject = New-Object PSObject
   Add-Member -inputObject $TagObject -memberType NoteProperty -name "Folder_LastWriteTime"     -value $Folder_LastWriteTime  
   Add-Member -inputObject $TagObject -memberType NoteProperty -name "Folder_Name"              -value $Folder_Name           
   Add-Member -inputObject $TagObject -memberType NoteProperty -name "Storyboard_Fullpath"      -value $Storyboard_Fullpath   
   Add-Member -inputObject $TagObject -memberType NoteProperty -name "Cartridge_Type"           -value $Cart_Cartridge_Type
   Add-Member -inputObject $TagObject -memberType NoteProperty -name "Cart_ID_Number"           -value $Cart_ID_Number
   Add-Member -inputObject $TagObject -memberType NoteProperty -name "Cart_Manufacture_Date"    -value $Cart_Manufacture_Date
   Add-Member -inputObject $TagObject -memberType NoteProperty -name "Cart_Expiration_Date"     -value $Cart_Expiration_Date
   Add-Member -inputObject $TagObject -memberType NoteProperty -name "Cart_Use_Counter"         -value $Cart_Use_Counter
   Add-Member -inputObject $TagObject -memberType NoteProperty -name "Cart_Last_Use_Date"       -value $Cart_Last_Use_Date
   Add-Member -inputObject $TagObject -memberType NoteProperty -name "Cart_Instrument"          -value $Cart_Instrument
   Add-Member -inputObject $TagObject -memberType NoteProperty -name "Cart_Is_Primed"           -value $Cart_Is_Primed
   Add-Member -inputObject $TagObject -memberType NoteProperty -name "Cart_Primary_Cartridge"   -value $Cart_Primary_Cartridge
   $TagReaderInfo += $TagObject

$Cartridge_Information = "Sample Cartridge Data :
   Cartridge Type:     $Cartridge_Type_Sample
   ID Number:          $Cart_ID_Number_Sample
   Manufacture Date:   $Cart_Manufacture_Date_Sample
   Expiration Date:    $Cart_Expiration_Date_Sample
   Use Counter:        $Cart_Use_Counter_Sample
   Last Use Date:      $Cart_Last_Use_Date_Sample
   Instrument:         $Cart_Instrument
BEC Data :
   Cartridge Type:     $Cartridge_Type_BEC
   ID Number:          $Cart_ID_Number_BEC
   Manufacture Date:   $Cart_Manufacture_Date_BEC
   Expiration Date:    $Cart_Expiration_Date_BEC
   Use Counter:        $Cart_Use_Counter_BEC
   Last Use Date:      $Cart_Last_Use_Date_BEC
   Instrument:         $Cart_Instrument
   Is Primed:          $Cart_Is_Primed
Gel Syringe Data :
   Cartridge Type:     $Cartridge_Type_Gel
   ID Number:          $Cart_ID_Number_Gel
   Manufacture Date:   $Cart_Manufacture_Date_Gel
   Expiration Date:    $Cart_Expiration_Date_Gel
   Use Counter:        $Cart_Use_Counter_Gel
   Last Use Date:      $Cart_Last_Use_Date_Gel
   Primary Cartridge:  $Cart_Primary_Cartridge
Bolus Test Time: $Folder_LastWriteTime
Test Folder: $Folder_Name 
"
