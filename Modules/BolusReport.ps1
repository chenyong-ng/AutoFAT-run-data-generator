
$Drive      = "U:"
$Inst_SN    = "RHID-0485"
#            "$Drive\$Inst_SN\*GFE-300uL*",
#            "$Drive\$Inst_SN\*GFE-BV*",
#            "$Drive\$Inst_SN\*BEC Insertion*",
#            "$Drive\$Inst_SN\*GFE-BV Allelic Ladder*",
#            "$Drive\$Inst_SN\*GFE_007*",
#            "$Drive\$Inst_SN\*NMG_007*",
#            "$Drive\$Inst_SN\*BLANK*",
$RunFolder = "$Drive\$Inst_SN\*2308095*"

$TargetFolder       = (Get-ChildItem $RunFolder | Sort-Object LastWriteTime -ErrorAction SilentlyContinue).FullName
# get list of full path,

# Common Cartridge Information
$storyboard         = Get-ChildItem $TargetFolder -I storyboard*.txt -R | Sort-Object LastWriteTime -ErrorAction SilentlyContinue
$Cart_Cartridge_Type = (($Storyboard | Select-String "Cartridge Type:").line.Split(",")  | select-string "Cartridge Type:").line.replace("Cartridge Type:", "").trim()
$Cart_ID_Number     = (($Storyboard | Select-String "ID Number:").line.Split(",")       | select-string "ID Number:").line.replace("ID Number:", "").trim()
$Cart_Manufacture_Date = (($Storyboard | Select-String "Manufacture Date:").line.Split(",") | select-string "Manufacture Date:").line.replace("Manufacture Date:", "").trim()
$Cart_Expiration_Date = (($Storyboard | Select-String "Expiration Date:").line.Split(",") | select-string "Expiration Date:").line.replace("Expiration Date:", "").trim()
$Cart_Use_Counter   = (($Storyboard | Select-String "Use Counter:").line.Split(",")     | select-string "Use Counter:").line.replace("Use Counter:", "").trim()
$Cart_Last_Use_Date = (($Storyboard | Select-String "Last Use Date:").line.Split(",")   | select-string "Last Use Date:").line.replace("Last Use Date:", "").trim()
# BEC exclusive
$Cart_Instrument    = (($Storyboard | Select-String "Instrument:").line.Split(",")      | select-string "Instrument:").line.replace("Instrument:", "").trim()
$Cart_Is_Primed     = (($Storyboard | Select-String "Is Primed:").line.Split(",")       | select-string "Is Primed:").line.replace("Is Primed:", "").trim()
# Gel Syringe exclusive
# Fresh Gel Syringe does not have BEC info
If (($Storyboard | Select-String "Primary Cartridge:").count -gt 0) {
    $Cart_Primary_Cartridge = (($Storyboard | Select-String "Primary Cartridge:").line.Split(",") | select-string "Primary Cartridge:").line.replace("Primary Cartridge:", "").trim()
}

$RHID_Bolus_Test_Result_Image = (Get-ChildItem $TargetFolder -I BolusInject_*.png -R -ErrorAction SilentlyContinue | Sort-Object LastWriteTime).Fullname
$RHID_Bolus_DN          = (($storyboard | Select-String "% in DN ="      ).line.split(",") | Select-String "% in DN ="      ).line.replace("% in DN =", ""      ).replace("%", "").Trim()
$RHID_Bolus_Volume      = (($storyboard | Select-String "Volume  ="      ).line.split(",") | Select-String "Volume  ="      ).line.replace("Volume  =", ""      ).replace("uL", "").Trim()
$RHID_Bolus_Timing      = (($storyboard | Select-String "Timing ="       ).line.split(",") | Select-String "Timing ="       ).line.replace("Timing =", ""       ).replace("s", "").Trim()
$RHID_Bolus_Current     = (($storyboard | Select-String "Bolus Current =").line.split(",") | Select-String "Bolus Current =" | Select-String "uA").line.replace("Bolus Current =", "").replace("uA", "").Trim()
$RHID_Bolust_Image_HTML = $RHID_Bolus_Test_Result_Image.replace("\", "/").replace(" ", "%20").replace("#", "%23")

# $Cartridge = @{}
# $Cartridge = @{
#    Utility = "RHID_UtilityCartridge"
#    GFE_Sample     = "RHID_GFESampleCartridgePLUS"
#    GFE_Neg_Ctrl   = "RHID_GFE_ACE_NEGCTRL"
#    GFE_Pos_Ctrl   = "RHID_GFE_ACE_POSCTRL"
#    NGM_Sample     = "RHID_NGMSampleCartridgePLUS"
#    GFE_Ladder     = "RHID_GFEControlCartridgePLUS"
#    BEC            = "RHID_PrimaryCartridge_V4"
#    Gel            = "RHID_GelSyringe"
# }

$Cartridge      = "RHID_GFESampleCartridgePLUS", "RHID_GFE_ACE_NEGCTRL", "RHID_GFE_ACE_POSCTRL",
                "RHID_NGMSampleCartridgePLUS", "RHID_GFEControlCartridgePLUS",
                "RHID_PrimaryCartridge_V4", "RHID_GelSyringe"

$Folder_LastWriteTime           = $Storyboard.directory.lastwritetime
$Folder_Name                    = $Storyboard.directory.name
$Storyboard_Fullpath            = $Storyboard.FullName
$Cartridge_Type_Utility         = $Cart_Cartridge_Type -match "RHID_UtilityCartridge"
$Cartridge_Type_GFE_Sample      = $Cart_Cartridge_Type -match "RHID_GFESampleCartridgePLUS"
$Cartridge_Type_GFE_NegCtrl     = $Cart_Cartridge_Type -match "RHID_GFE_ACE_NEGCTRL"
$Cartridge_Type_GFE_PosCtrl     = $Cart_Cartridge_Type -match "RHID_GFE_ACE_POSCTRL"
$Cartridge_Type_GFE_Ladder      = $Cart_Cartridge_Type -match "RHID_GFEControlCartridgePLUS"
$Cartridge_Type_NGM_Sample      = $Cart_Cartridge_Type -match "RHID_NGMSampleCartridgePLUS"
$Cartridge_Type_BEC             = $Cart_Cartridge_Type -match "RHID_PrimaryCartridge_V4"
$Cartridge_Type_Gel             = $Cart_Cartridge_Type -match "RHID_GelSyringe"
$Cart_ID_Number_Sample          = [int]$Cart_ID_Number[0]
$Cart_ID_Number_BEC             = [int]$Cart_ID_Number[1]
$Cart_ID_Number_Gel             = [int]$Cart_ID_Number[2]
$Cart_Manufacture_Date_Sample   = $Cart_Manufacture_Date[0]
$Cart_Manufacture_Date_BEC      = $Cart_Manufacture_Date[1]
$Cart_Manufacture_Date_Gel      = $Cart_Manufacture_Date[2]
$Cart_Expiration_Date_Sample    = $Cart_Expiration_Date[0]
$Cart_Expiration_Date_BEC       = $Cart_Expiration_Date[1]
$Cart_Expiration_Date_Gel       = $Cart_Expiration_Date[2]
$Cart_Use_Counter_Sample        = [int]$Cart_Use_Counter[0]
$Cart_Use_Counter_BEC           = [int]$Cart_Use_Counter[1]
$Cart_Use_Counter_Gel           = [int]$Cart_Use_Counter[2]
$Cart_Last_Use_Date_Sample      = $Cart_Last_Use_Date[0]
$Cart_Last_Use_Date_BEC         = $Cart_Last_Use_Date[1]
$Cart_Last_Use_Date_Gel         = $Cart_Last_Use_Date[2]

#Typical usage in production
# add folder name
$TagReaderInfo = @()
$TagObject = New-Object PSObject
Add-Member -inputObject $TagObject -memberType NoteProperty -name "Folder_LastWriteTime"     -value $Folder_LastWriteTime  
Add-Member -inputObject $TagObject -memberType NoteProperty -name "Folder_Name"              -value $Folder_Name           
Add-Member -inputObject $TagObject -memberType NoteProperty -name "Storyboard_Fullpath"      -value $Storyboard_Fullpath
Add-Member -inputObject $TagObject -memberType NoteProperty -name "Cartridge_Type_Utility"   -value $Cartridge_Type_Utility
Add-Member -inputObject $TagObject -memberType NoteProperty -name "Cartridge_Type_GFE_Sample" -value $Cartridge_Type_GFE_Sample
Add-Member -inputObject $TagObject -memberType NoteProperty -name "Cartridge_Type_GFE_NegCtrl" -value $Cartridge_Type_GFE_NegCtrl
Add-Member -inputObject $TagObject -memberType NoteProperty -name "Cartridge_Type_GFE_PosCtrl" -value $Cartridge_Type_GFE_PosCtrl
Add-Member -inputObject $TagObject -memberType NoteProperty -name "Cartridge_Type_GFE_Ladder" -value $Cartridge_Type_GFE_Ladder
Add-Member -inputObject $TagObject -memberType NoteProperty -name "Cartridge_Type_NGM_Sample" -value $Cartridge_Type_NGM_Sample
Add-Member -inputObject $TagObject -memberType NoteProperty -name "Cartridge_Type_BEC"       -value $Cartridge_Type_BEC
Add-Member -inputObject $TagObject -memberType NoteProperty -name "Cartridge_Type_Gel"       -value $Cartridge_Type_Gel
Add-Member -inputObject $TagObject -memberType NoteProperty -name "Cart_ID_Number"           -value $Cart_ID_Number
Add-Member -inputObject $TagObject -memberType NoteProperty -name "Cart_Manufacture_Date"    -value $Cart_Manufacture_Date
Add-Member -inputObject $TagObject -memberType NoteProperty -name "Cart_Expiration_Date"     -value $Cart_Expiration_Date
Add-Member -inputObject $TagObject -memberType NoteProperty -name "Cart_Use_Counter"         -value $Cart_Use_Counter
Add-Member -inputObject $TagObject -memberType NoteProperty -name "Cart_Last_Use_Date"       -value $Cart_Last_Use_Date
Add-Member -inputObject $TagObject -memberType NoteProperty -name "Cart_Instrument"          -value $Cart_Instrument
Add-Member -inputObject $TagObject -memberType NoteProperty -name "Cart_Is_Primed"           -value $Cart_Is_Primed
Add-Member -inputObject $TagObject -memberType NoteProperty -name "Cart_Primary_Cartridge"   -value $Cart_Primary_Cartridge
$TagReaderInfo += $TagObject



# $Result_Separator             = "################################"
#$Bolus_Folder           =   "U:\RHID-0890\*Bolus Delivery Test*"

# add foreach
# $RHID_Bolus_Counter             = $RHID_Bolus_Test_Result_Folder.count
$BolusTestInfo = @()
$BolusObject = New-Object PSObject
Add-Member -inputObject $BolusObject -memberType NoteProperty -name "Bolus_DN"         -value $RHID_Bolus_DN
Add-Member -inputObject $BolusObject -memberType NoteProperty -name "Bolus_Volume"     -value $RHID_Bolus_Volume
Add-Member -inputObject $BolusObject -memberType NoteProperty -name "Bolus_Timing"     -value $RHID_Bolus_Timing
Add-Member -inputObject $BolusObject -memberType NoteProperty -name "Bolus_Current"    -value $RHID_Bolus_Current
Add-Member -inputObject $BolusObject -memberType NoteProperty -name "Bolus_Test_Result_Image"       -value $RHID_Bolus_Test_Result_Image
Add-Member -inputObject $BolusObject -memberType NoteProperty -name "Bolus_Test_Result_ImageHTML"   -value $RHID_Bolust_Image_HTML
$BolusTestInfo += $BolusObject

$i = $RHID_Bolus_Test_Result_Folder.count
$i = 0
$BolusData = foreach ($RHID_Bolus_Test_Result_Folder in $RHID_Bolus_DN) {
    if ( $RHID_Bolus_Test_Result_Folder.count -gt 0) {
        #$Result_Separator
        #$Bolust_Image           = ($Drive + "\" + $MachineName + "\" + $RHID_Bolus_Test_Result_Image.directory.name[$i] + "\" + $RHID_Bolus_Test_Result_Image.name[$i])
        #$Bolust_Image_HTML      = ($Drive + "/" + $MachineName + "/" + $RHID_Bolus_Test_Result_Image.directory.name[$i] + "/" + $RHID_Bolus_Test_Result_Image.name[$i]).replace("\","/").replace("#","%23")
        $Bolus_Test_Counter = [Double]($i + 1)
        $RHID_Bolus_DN_Var = [Double]$RHID_Bolus_DN[$i]
        $RHID_Bolus_Volume_Var = [Double]$RHID_Bolus_Volume[$i]
        $RHID_Bolus_Timing_Var = [Double]$RHID_Bolus_Timing[$i]
        $RHID_Bolus_Current_Var = [Double]$RHID_Bolus_Current[$i]
        # "Test_Counter,$Bolus_Test_Counter"
        # "DN_Percentage,$RHID_Bolus_DN_Var,%"
        # "Volume,$RHID_Bolus_Volume_Var,uL"
        # "Timing,$RHID_Bolus_Timing_Var,S"
        # "BolusCurrent,$RHID_Bolus_Current_Var,uA"
        # "Image,$Bolust_Image"
        $Bolus_Test_Counter
        $RHID_Bolus_DN_Var
        $RHID_Bolus_Volume_Var
        $RHID_Bolus_Timing_Var
        $RHID_Bolus_Current_Var
        $Bolust_Image
        $BolusHash = [ordered]@{}
        [hashtable]$BolusHash = [ordered]@{
            "Bolus_Test_Counter"     = $Bolus_Test_Counter
            "RHID_Bolus_DN_Var"      = $RHID_Bolus_DN
            "RHID_Bolus_Volume_Var"  = $RHID_Bolus_Volume
            "RHID_Bolus_Timing_Var"  = $RHID_Bolus_Timing
            "RHID_Bolus_Current_Var" = $RHID_Bolus_Current
        }
        $i = $i + 1
        # Generate HTML Report with Bolus testimages
    }
}

# $BolusDataObj = (GetBolusData | ConvertFrom-String -Delimiter ',' -PropertyNames Type, Value, Unit | select-object -skip 0)
# $BolusDataObj | Out-File "$Drive\$MachineName\Internal\RapidHIT ID\Results\BolusDataObj.txt"
# Dont write anyting yet.

foreach ($RHID_Bolus_Test_Result_Folder in $RHID_Bolus_DN) {
    if ( $RHID_Bolus_Test_Result_Folder.count -gt 0) {
        $Bolust_Image           = $RHID_Bolust_Image_HTML[$i]
        $Bolus_Test_Counter     = [Double]($i + 1)
        $RHID_Bolus_DN_Var      = [Double]$RHID_Bolus_DN[$i]
        $RHID_Bolus_Volume_Var  = [Double]$RHID_Bolus_Volume[$i]
        $RHID_Bolus_Timing_Var  = [Double]$RHID_Bolus_Timing[$i]
        $RHID_Bolus_Current_Var = [Double]$RHID_Bolus_Current[$i]     
        @"
<Bolus_Test_$Bolus_Test_Counter>
    <Counter>$Bolus_Test_Counter</Counter>
    <Percentage>$RHID_Bolus_DN_Var</Percentage>
    <Volume>$RHID_Bolus_Volume_Var</Volume>
    <Timing>$RHID_Bolus_Timing_Var</Timing>
    <Current>$RHID_Bolus_Current_Var</Current>
    <Image>$Bolust_Image</Image>
</Bolus_Test_$Bolus_Test_Counter>
"@
        $i = $i + 1
        # Generate HTML Report with Bolus testimages
    }
}


$TagReader =
"Sample Cartridge Data :
   Cartridge Type:     $Cartridge_Type_SCI
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
Bolus Test Time:       $Folder_LastWriteTime
Test Folder:           $Storyboard_Fullpath"
