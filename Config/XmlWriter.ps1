$XMLFile = "$PSScriptRoot\..\config\ScriptConfig_Experimental.xml"
$NewDate = Get-Date -format "dddd dd MMMM yyyy hh:mm"
$NewGuid = [guid]::NewGuid().guid.toUpper()

$xmlsettings = New-Object System.Xml.XmlWriterSettings
$xmlsettings.Indent = $true
$xmlsettings.IndentChars = "	"

$xmlWriter = [System.XML.XmlWriter]::Create($XMLFile, $xmlsettings)
$xmlWriter.WriteStartElement("TestResult") 
$xmlWriter.WriteAttributeString("Version", "1.0")
$XmlWriter.WriteAttributeString("xmlns", "xsi", 
    "http://www.w3.org/2000/xmlns/", 
    "http://www.w3.org/2001/XMLSchema-instance");
$XmlWriter.WriteAttributeString("xmlns","xsd",
	"http://www.w3.org/2000/xmlns/",
	"http://www.w3.org/2001/XMLSchema");
$xmlWriter.WriteElementString("StartDate", $NewDate)
$xmlWriter.WriteElementString("MachineName", "$HostName")
$xmlWriter.WriteEndElement()

$xmlWriter.Flush()
$xmlWriter.Close()


<#
[XML]$xmlMmat = (Get-Content -Encoding utf8 -Raw $XMLFile)
$xmlFragment = $xmlMmat.CreateDocumentFragment()
$xmlFragment.InnerXml =
"
<TestProgress>
<TestDate>$NewCDate</TestDate>
<HostName>$env:COMPUTERNAME</HostName>
</TestProgress>
"

$null = $xmlMmat.TestResult.AppendChild($xmlFragment.TestProgress)
$xmlWriter = [System.Xml.XmlTextWriter] [System.IO.StreamWriter] $XMLFile
  $xmlWriter.Formatting = 'indented'; $xmlWriter.Indentation = 4
  $xmlMMat.WriteContentTo($xmlWriter)
$xmlWriter.Dispose()
#>
