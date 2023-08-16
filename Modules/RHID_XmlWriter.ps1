<#
.Title          : Powershell XML test result Writer for RHID Instrument
.Source         : https://github.com/chenyong-ng/AutoFAT-run-data-generator
.Version        : v0.1
.License        : Public Domain, CC0 1.0 Universal
.Revision Date  : 22 MAY 2023
.Todo           : 
.Notes          : Generate Test result progress into XML
.Usage          : 
#>

$xmlsettings = New-Object System.Xml.XmlWriterSettings
$xmlsettings.Indent = $true
$xmlsettings.IndentChars = "	"

$xmlWriter = [System.XML.XmlWriter]::Create($TempXMLFile, $xmlsettings)
$xmlWriter.WriteStartElement("TestReport") 
$xmlWriter.WriteAttributeString("Version", "1.0")
$XmlWriter.WriteAttributeString("xmlns", "xsi", 
	"http://www.w3.org/2000/xmlns/", 
	"http://www.w3.org/2001/XMLSchema-instance");
$XmlWriter.WriteAttributeString("xmlns","xsd",
	"http://www.w3.org/2000/xmlns/",
	"http://www.w3.org/2001/XMLSchema");
$xmlWriter.WriteElementString("StartDate", $NewDate)
$xmlWriter.WriteElementString("SystemTimezone", $SystemTimeZone)
$xmlWriter.WriteElementString("SerialNumber", $env:COMPUTERNAME)
#$xmlWriter.WriteElementString("GUID", $NewGuid)
$xmlWriter.WriteStartElement("Hardware")
$xmlWriter.WriteStartElement("Optics")
$xmlWriter.WriteElementString("QminiSerial", $RHID_QMini_SN)
$xmlWriter.WriteElementString("Coefficients", $RHID_QMini_Coeff)
$xmlWriter.WriteElementString("InflectionPoints", $RHID_QMini_Infl)
$xmlWriter.WriteEndElement()
$xmlWriter.Flush()
$xmlWriter.Close()

<#
[XML]$xmlMmat = (Get-Content -Encoding utf8 -Raw $XMLFile)
$xmlFragment = $xmlMmat.CreateDocumentFragment()
$xmlFragment.InnerXml =
@"
<NewElement><TestDate>$NewDate</TestDate><HostName>$env:COMPUTERNAME</HostName></NewElement>
"@

$null = $xmlMmat.TestReport.Hardware.Optics.AppendChild($xmlFragment)
$xmlWriter = [System.Xml.XmlTextWriter] [System.IO.StreamWriter] $XMLFile
	$xmlWriter.Formatting = 'indented'; $xmlWriter.Indentation = 4
	$xmlMMat.WriteContentTo($xmlWriter)
$xmlWriter.Flush()
$xmlWriter.Dispose()

#>