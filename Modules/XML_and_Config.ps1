
function MachineConfigXML_Gen {
  Write-Output "<?xml version=""1.0"" encoding=""utf-8""?>
<InstrumentSettings xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"" xmlns:xsd=""http://www.w3.org/2001/XMLSchema"">
  <MachineName>$HostName</MachineName>
  <HWVersion>ID18-3</HWVersion>
  <MachineConfiguration>NoFLSpring V2SCI</MachineConfiguration>
  <DataServerUploadPath>U:\</DataServerUploadPath>
  <HP_HardstopZeroForce_mm>-1</HP_HardstopZeroForce_mm>
  <HP_Hardstop100Percent_mm>-1</HP_Hardstop100Percent_mm>
  <SCIState>
    <moduleID>Cartridge Interface</moduleID>
    <Clamp>IsDisengaged</Clamp>
    <Contamination>Clean</Contamination>
    <LastKnownValveState>Unknown</LastKnownValveState>
  </SCIState>
</InstrumentSettings>"
} #MachineConfig XML Creation


function TC_CalibrationXML_Gen {
  Write-Output "<?xml version=""1.0"" encoding=""utf-8""?>
<InstrumentSettings xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"" xmlns:xsd=""http://www.w3.org/2001/XMLSchema"">
  <MachineName>$HostName</MachineName>
  <TC_Calibration>
    <Offsets>GFE, NaN</Offsets>
    <!-- GFE protocols should have 9 comma separated numbers after the GFE identifier-->
    <Offsets>NGM, NaN, NaN</Offsets>
    <!-- NGM protocols should have 10 comma separated numbers after the NGM identifier -->
  </TC_Calibration>
</InstrumentSettings>"
} #TC_Calibration XML Creation

function OverrideSettingsXML_Gen {
@'
"<?xml version="1.0" encoding="utf-8"?>
<InstrumentSettings xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <Protocols_GFE>
    <GFEProtocol>
      <Name>GFE-300uL-36cycles</Name>
      <TC_CycleRepeats>35</TC_CycleRepeats>
      <LysisVolume_uL>300</LysisVolume_uL>
    </GFEProtocol>
    <GFEProtocol>
      <Name>GFE-BV-3cycles</Name>
      <TC_CycleRepeats>2</TC_CycleRepeats>
    </GFEProtocol>
  </Protocols_GFE>
  <Protocols_NGM>
    <NGMProtocol>
      <Name>NGM-300uL-36cycles</Name>
      <TC_CycleRepeats>35</TC_CycleRepeats>
      <LysisVolume_uL>300</LysisVolume_uL>
    </NGMProtocol>
    <NGMProtocol>
      <Name>NGM-BV-3cycles</Name>
      <TC_CycleRepeats>2</TC_CycleRepeats>
    </NGMProtocol>
  </Protocols_NGM>
</InstrumentSettings>"
'@
} # OverrideSettings XML Creation, only used for 36cycles test, valid for SG Production use as of 2020 until further notice.

function TestResultXML_Gen {
  Write-Output "<?xml version=""1.0"" encoding=""utf-8""?>
<TestResult xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"" xmlns:xsd=""http://www.w3.org/2001/XMLSchema"">
	<StartDate>$StartDate</StartDate>
	<MachineName>$HostName</MachineName>
    <Hardware>
      <QminiSN></QminiSN>
      <Coefficient></Coefficient>
      <InflectionPoints></InflectionPoints>
      <TC_Calibration></TC_Calibration>
    </Hardware>
	<EndDate>$EndDate</EndDate>
</TestResult>"
} #MachineConfig XML Creation

function TC_verification {
Write-Output "
Instrument SN   : $env:COMPUTERNAME
Time Created    : $NewDate
Ambient + Probe :   °C,   °C
Temp + Humidity :   °C,   %
TC Probe ID     : M
TC Step 1       :   °C [95.0 ± 0.25°C]
TC Step 2       :   °C [61.5 ± 0.25°C]
TC Step 3       :   °C [94.0 ± 0.25°C]
TC Step 4       :   °C [61.5 ± 0.25°C]
Airleak Test    :  Passed/NA
"
} #for recording TC verification data

function BackupBeforeShipprep {
  Copy-Item -Force -Recurse -Exclude "System Volume Information", "*RECYCLE.BIN", "bootsqm.dat" "E:\*" -Destination "U:\$MachineName\Internal\"
}

function BackupConfig {
Set-Location $Inst_rhid_Folder
Copy-Item $TC_CalibrationXML_File -Destination "U:\$HostName\Internal\RapidHIT ID\"
Set-Location $Inst_rhid_Result
Copy-Item $TC_verification_File , $Waves_File , $Nonlinearity_File -Destination "U:\$HostName\Internal\RapidHIT ID\Results\"
}

function network {
    Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter IPEnabled=true -ComputerName . | ForEach-Object -Process { $_.InvokeMethod("EnableDHCP", $null) }
    Get-WmiObject -List | Where-Object -FilterScript { $_.Name -eq "Win32_NetworkAdapterConfiguration" } | ForEach-Object -Process { $_.InvokeMethod("ReleaseDHCPLeaseAll", $null) }
    Get-WmiObject -List | Where-Object -FilterScript { $_.Name -eq "Win32_NetworkAdapterConfiguration" } | ForEach-Object -Process { $_.InvokeMethod("RenewDHCPLeaseAll", $null) }
}

<#
├───Internal
│   ├───im
│   ├───logs
│   └───RapidHIT ID
│       └───Results
│           └───Data RHID-0486
#>
function DannoAppConfig.xml {
@'
<?xml version="1.0" encoding="utf-8"?>
<InstrumentSettings xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
<BECRunCount>150</BECRunCount>
<CODISLoci_NGM>D10S1248, VWA, D16S539, D2S1338, AMEL, D8S1179, D21S11, D18S51, D22S1045, D19S433, TH01, FGA, D2S441, D3S1358, D1S1656, D12S391, SE33</CODISLoci_NGM>
<CODISLoci_GFE>AMEL, CSF1PO, D10S1248, D12S391, D13S317, D16S539, D18S51, D19S433, D1S1656, D21S11, D22S1045, D2S1338, D2S441, D3S1358, D5S818, D7S820, D8S1179, FGA, SE33, TH01, TPOX, VWA</CODISLoci_GFE>
<UserDataVolume>E:\</UserDataVolume>
<CommandCentral>true</CommandCentral>
<IPAddress>0.0.0.0</IPAddress>
<Port>8080</Port>
<RapidHitSerialNo />
<RunFolderUploadRetryTimes>3</RunFolderUploadRetryTimes>
<RunFolderUploadRetryPeriodInSec>30</RunFolderUploadRetryPeriodInSec>
<IsAuthenticationRequiredtoUpload>false</IsAuthenticationRequiredtoUpload>
<NetworkUsername />
<NetworkPassword />
<InsufficientRunStorageMessage>Insufficient run storage space available.</InsufficientRunStorageMessage>
<BECExhaustedMessage>The primary cartridge must be replaced before a run can be started.</BECExhaustedMessage>
<GelCompromisedMessage>The gel must be replaced before a run can be started.</GelCompromisedMessage>
<BECNotEngagedMessage>The primary cartridge is not engaged.</BECNotEngagedMessage>
<ChangePinMessage>Account PIN must be changed</ChangePinMessage>
<BECReplaceConfirmMessage>Do you want to eject the primary cartridge?</BECReplaceConfirmMessage>
<BECReplaceFailedMessage>Primary cartridge replacement failed.</BECReplaceFailedMessage>
<PhoneContactInfo />
<BECIdentifier />
<LastShutDownMode>Real</LastShutDownMode>
<DoubleSampleEntry>false</DoubleSampleEntry>
<PoFAActive>false</PoFAActive>
<PoFAWorkflowActive>false</PoFAWorkflowActive>
<CODISRunMode>Normal</CODISRunMode>
<PendingArresteeBarcodes />
<ArresteeBarcodeUnrecognizedMessage>The arrestee barcode is currently unrecognized.</ArresteeBarcodeUnrecognizedMessage>
<BScrapeAwaitingDestructionIDs />
<TwoFactorsRequiredMessage>Please register for at least two authentication methods.</TwoFactorsRequiredMessage>
<PendingUserChangesWarningMessage>There are unsaved changes to this user pending.</PendingUserChangesWarningMessage>
<CurrentActiveRunName />
<CurrentActiveRunASN />
</IXDannoAppConfigData>
'@ | Out-File "E:\RapidHIT ID\Results\Data $HostName\DannoAppConfig.xml"
}

function DannoUserConfig.xml {
'@
<?xml version="1.0" encoding="utf-8"?>
<DannoUsers xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" version="4.0">
  <Users>
    <IXUserDataStruct>
      <IsActiveUser>true</IsActiveUser>
      <UserImagePath />
      <UserName>Rhid-0485</UserName>
      <PermissionLevel>Administrator</PermissionLevel>
      <MobileNumber />
      <Email />
      <UserPIN>YKV7CMx1IjuP3+fLW+HR8+sKsdMgBZKc3O9cA1tKujfHEoNUOs/tUAZUqPC/8Zdk</UserPIN>
      <IsPinChangeRequired>false</IsPinChangeRequired>
      <IsFingerprintEnrolled>false</IsFingerprintEnrolled>
      <FingerprintDataSlot>-1</FingerprintDataSlot>
      <IsFacialRecognitionEnrolled>false</IsFacialRecognitionEnrolled>
      <GlobalUserId>0</GlobalUserId>
      <UserGUID>ad0d7f10-deca-4780-93b0-ffc03a5aefd4</UserGUID>
      <FingerPrintTemplate />
      <FaceIdentifier>0</FaceIdentifier>
      <FaceRecognitionImage />
      <AuthorizedInstruments>
        <string />
      </AuthorizedInstruments>
      <LastUpdated>2023-05-29T04:24:26.7677698Z</LastUpdated>
    </IXUserDataStruct>
  </Users>
</DannoUsers>
@'
}