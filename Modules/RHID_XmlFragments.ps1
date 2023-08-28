[XML]$xmlMmat = (Get-Content -Encoding utf8 -Raw "$TempXMLFile")
$xmlFragment = $xmlMmat.CreateDocumentFragment()
$xmlFragment.InnerXml =
@"
<FAT_Test>
<LysisHeater>$Lysis_Heater_Test_Result</LysisHeater>
<DenatureHeater>$DN_Heater_Test_Result</DenatureHeater>
<PCR>$PCR_Heater_Test_Result</PCR>
<OpticsHeater>$Optics_Heater_Test_Result</OpticsHeater>
</FAT_Test>
"@+
@"
<Dummy><Dummy1>$GFE36cyclesC3ount</Dummy1><Dummy5>$GFE_B3VCount</Dummy5></Dummy>
"@+
@"
<Dummy2><Dummy4>$GFE36cyclesCount</Dummy4><Dummy3>$GFE_BVCount</Dummy3></Dummy2>
"@+
@"
<Fullrun><GFE36cyclesCount>$GFE36cyclesC2ount</GFE36cyclesCount><GFE_BVCount>$GFE_3BVCount</GFE_BVCount></Fullrun>
"@+
@"
<Full2run><GFE36cyclesCount>$GFE36cyclesC3ount</GFE36cyclesCount><GFE_BVCount>$GFE_B3VCount</GFE_BVCount></Full2run>
"@+
@"
<NewElement><GFE36cyclesCount>$GFE36cyclesCount</GFE36cyclesCount><GFE_BVCount>$GFE_BVCount</GFE_BVCount></NewElement>
"@

$null = $xmlMmat.TestReport.AppendChild($xmlFragment)
$xmlMmat.save("$TempXMLFile")
$xmlWriter.Flush()
$xmlWriter.Dispose()
