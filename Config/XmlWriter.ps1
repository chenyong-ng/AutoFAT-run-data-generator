$XMLFile = "$PSScriptRoot\..\config\ScriptConfig_Experimental.xml"
$NewCDate = ([String]$Date = Get-Date)
$NewGuid = [string](new-guid).guid.toUpper()

$myProject = 'Myproject'
$xmlsettings = New-Object System.Xml.XmlWriterSettings
$xmlsettings.Indent = $true
$xmlsettings.IndentChars = "	"

$xmlWriter = [System.XML.XmlWriter]::Create($XMLFile, $xmlsettings)
$xmlWriter.WriteStartElement("Item") 
$xmlWriter.WriteAttributeString("Version", "1.0")
$XmlWriter.WriteAttributeString("xmlns", "xsi", 
    "http://www.w3.org/2000/xmlns/", 
    "http://www.w3.org/2001/XMLSchema-instance");
$XmlWriter.WriteAttributeString("xmlns","xsd",
	"http://www.w3.org/2000/xmlns/",
	"http://www.w3.org/2001/XMLSchema");
$xmlWriter.WriteElementString("Name", $myProject)
$xmlWriter.WriteElementString("GUID", "bjhjh")
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

<#
$xml = New-Object xml
$xml.PreserveWhitespace = $true
$xml.Load("$XMLFile")

<#
$txtFrag = "
<dummy xmlns=""http://www.microsoft.com/MdmMigrationAnalysisTool""
       xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"">
  <PolicyMap xsi:type=""OptionalPolicyMap"">
    $NewCDate
  </PolicyMap>
</dummy>
"

$txtFrag = "
<TestProgress>
<TestDate>$NewCDate</TestDate>
</TestProgress>
"

$xmlFrag = $xml.CreateDocumentFragment()
$xmlFrag.InnerXml = $txtFrag

#$xml.MDMPolicyMappings.Computer.AppendChild($xmlFrag.dummy.PolicyMap)
$xml.TestResult.AppendChild($xmlFrag.TestProgress)

$xml.Save("$XMLFile")
$xml.OuterXml

<#
[xml]$xml = '<Date></Date>'
$NewDate = $xml.CreateElement('Date')
$attr = $xml.CreateAttribute('code')
$attr.Value = $NewCDate
$NewDate.Attributes.Append($attr)
$products = $xml.SelectSingleNode('//Date')
$products.AppendChild($NewDate)
$xml.Save("$XMLFile.new.xml")
#>
# Worked, but failed to append childnode and overwrite original files