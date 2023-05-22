$XMLFile = "$PSScriptRoot\..\config\ScriptConfig_Experimental.xml"
$NewCDate = ([String]$Date = Get-Date)

<#
$myProject = 'Myproject'
$xmlsettings = New-Object System.Xml.XmlWriterSettings
$xmlsettings.Indent = $true

$xmlWriter = [System.XML.XmlWriter]::Create($XMLFile, $xmlsettings)
$xmlWriter.WriteStartElement("Item") 
$xmlWriter.WriteAttributeString("Version", "1.0")
$xmlWriter.WriteElementString("Name", $myProject)
$xmlWriter.WriteElementString("GUID", (New-Guid).Guid.ToUpper())
$xmlWriter.WriteEndElement()

$xmlWriter.Flush()
$xmlWriter.Close()
#>

<#
[XML]$xmlMmat = (Get-Content -Encoding utf8 -Raw $XMLFile)
$xmlFragment = $xmlMmat.CreateDocumentFragment()
$xmlFragment.InnerXml =
@'
<aux xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.microsoft.com/MdmMigrationAnalysisTool">
  <PolicyMap xsi:type="OptionalPolicyMap">
    <Name>Test Policy</Name>
    <CspUri>./Device/Vendor/MSFT/Policy/Config/Test</CspUri>
    <CspName>Policy</CspName>
    <Version>0000</Version>
  </PolicyMap>
</aux>
'@

$null = $xmlMmat.MDMPolicyMappings.Computer.AppendChild(
          $xmlFragment.aux.PolicyMap
        )
$xmlWriter = [System.Xml.XmlTextWriter] [System.IO.StreamWriter] $XMLFile
  $xmlWriter.Formatting = 'indented'; $xmlWriter.Indentation = 2
  $xmlMMat.WriteContentTo($xmlWriter)
$xmlWriter.Dispose()
#>


$xml = New-Object xml
$xml.PreserveWhitespace = $true
$xml.Load("$XMLFile")

$txtFrag = "
<dummy xmlns=""http://www.microsoft.com/MdmMigrationAnalysisTool""
       xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"">
  <PolicyMap xsi:type=""OptionalPolicyMap"">
    $NewCDate
  </PolicyMap>
</dummy>
"

$xmlFrag = $xml.CreateDocumentFragment()
$xmlFrag.InnerXml = $txtFrag

$xml.MDMPolicyMappings.Computer.AppendChild($xmlFrag.dummy.PolicyMap)

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