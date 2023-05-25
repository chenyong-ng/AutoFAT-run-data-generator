$XMLFile = "$PSScriptRoot\..\config\ScriptConfig_Experimental.xml"
$NewDate = Get-Date -format "dddd dd MMMM yyyy hh:mm"
$NewGuid = [guid]::NewGuid().guid.toUpper()

$xmlsettings = New-Object System.Xml.XmlWriterSettings
$xmlsettings.Indent = $true
$xmlsettings.IndentChars = "	"

$xmlWriter = [System.XML.XmlWriter]::Create($XMLFile, $xmlsettings)
$xmlWriter.WriteStartElement("TestReport") 
$xmlWriter.WriteAttributeString("Version", "1.0")
$XmlWriter.WriteAttributeString("xmlns", "xsi", 
    "http://www.w3.org/2000/xmlns/", 
    "http://www.w3.org/2001/XMLSchema-instance");
$XmlWriter.WriteAttributeString("xmlns","xsd",
	"http://www.w3.org/2000/xmlns/",
	"http://www.w3.org/2001/XMLSchema");
$xmlWriter.WriteElementString("StartDate", $NewDate)
$xmlWriter.WriteElementString("SerialNumber", $env:COMPUTERNAME)
#$xmlWriter.WriteElementString("GUID", $NewGuid)
$xmlWriter.WriteElementString("Optics",'na')
$xmlWriter.WriteElementString("QminiSerial", 'na')
$xmlWriter.WriteElementString("Coefficients",'na')
$xmlWriter.WriteElementString("InflectionPoints", 'na')
$xmlWriter.Write
$xmlWriter.WriteEndElement()

$xmlWriter.Flush()
$xmlWriter.Close()



[XML]$xmlMmat = (Get-Content -Encoding utf8 -Raw $XMLFile)
$xmlFragment = $xmlMmat.CreateDocumentFragment()
$xmlFragment.InnerXml =
@"
<Optics>
<TestDate>$NewDate</TestDate>
<HostName>$env:COMPUTERNAME</HostName>
</Optics>
"@

$null = $xmlMmat.TestReport.AppendChild($xmlFragment.Optics)
$xmlWriter = [System.Xml.XmlTextWriter] [System.IO.StreamWriter] $XMLFile
  $xmlWriter.Formatting = 'indented'; $xmlWriter.Indentation = 4
  $xmlMMat.WriteContentTo($xmlWriter)
$xmlWriter.Dispose()

