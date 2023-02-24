<#
.Title          : Powershell Utility for RHID Instrument
.Source         : https://github.com/chenyong-ng/AutoFAT-run-data-generator
.Version        :	v0.4
.License        : Public Domain
.Revision Date  : 10 JUL 2022
.Description    : This script are best viewed and edit in Visual Studio Code https://code.visualstudio.com/
.Todo           : 
#>

$htmlHeader = @"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<!-- Constructed with LabVIEW Report Generation -->
<HEAD>
<TITLE></TITLE>
</HEAD>

<BODY>
<TABLE WIDTH="100%">
<TR>
<TH ALIGN="LEFT"><H3>Instrument - 2462622080002 - Detailed Report</H3></TH>
<TH ALIGN="RIGHT"><H3></H3></TH>
</TR></TABLE><OL>
<LI>Instrument Serial Number: 2462622080002</LI>
<LI>Product Configuration: </LI>
<LI>Instrument Version: </LI>
<LI>Instrument Server Version: </LI>
<LI>Host Name: 2462622080002</LI>
<LI>MTSS Version: 1.2.1</LI>
<LI>MTSS Part Number: 100101404</LI>
<LI>TimeStamp: 10:56:58 AM 09/12/2022</LI>
<LI>Workstation ID: SGSI11-B6BZP73</LI>
<LI>User Name: test</LI>
<LI>White LED Control SN: </LI>
<LI>White LED Control HW: </LI>
<LI>White LED Control FW: </LI>
<LI>White LED Control Boot: </LI>
<LI>NearIR Control SN: </LI>
<LI>NearIR Control HW: </LI>
<LI>NearIR Control FW: </LI>
<LI>NearIR Control Boot: </LI>
<LI>Motion Control SN: </LI>
<LI>Motion Control HW: </LI>
<LI>Motion Control FW: </LI>
<LI>Motion Control Boot: </LI>
<LI>Camera SN: </LI>
<LI>Camera HW: </LI>
<LI>Camera FW: </LI>
<LI>Camera Boot: </LI>
<LI>Transillum Control SN: </LI>
<LI>Transillum Control HW: </LI>
<LI>Transillum Control FW: </LI>
<LI>Transillum Control Boot: </LI>
<LI>Optics Control SN: </LI>
<LI>Optics Control HW: </LI>
<LI>Optics Control FW: </LI>
<LI>Optics Control Boot: </LI>
<LI>Detection Module SN: </LI>
<LI>Excitation Module SN: </LI>
</OL>
<HR SIZE="1" WIDTH=" 100.000000%">
<TABLE BORDER="1">
<TR>
<TH ALIGN=LEFT>Test Name</TH>
<TH ALIGN=LEFT>Parameter</TH>
<TH ALIGN=LEFT>Output</TH>
<TH ALIGN=LEFT>Criteria</TH>
<TH ALIGN=LEFT>Result</TH>
</TR>
<TR>
<TD WIDTH="100">White Target</TD>
<TD WIDTH="100">Recipe State Update</TD>
<TD WIDTH="100">TRUE</TD>
<TD WIDTH="100">FIO</TD>
<TD WIDTH="100">Pass</TD>
</TR>
<TR>
<TD WIDTH="100">TransillumRod</TD>
<TD WIDTH="100">TransillumRod Align Result </TD>
<TD WIDTH="100">TRUE</TD>
<TD WIDTH="100">= "TRUE"</TD>
<TD WIDTH="100">Pass</TD>
</TR>
<TR>
<TD WIDTH="100">TransillumRod</TD>
<TD WIDTH="100">USL: 1516083 LSL: 1471925 2ndDerivative =</TD>
<TD WIDTH="100">1498750</TD>
<TD WIDTH="100">FIO</TD>
<TD WIDTH="100">Pass</TD>
</TR>
<TR>
<TD WIDTH="100">TransillumRod</TD>
<TD WIDTH="100">Uniformity =</TD>
<TD WIDTH="100">1.08</TD>
<TD WIDTH="100">1.00 <= & <= 1.20</TD>
<TD WIDTH="100">Pass</TD>
</TR>
<TR>
<TD WIDTH="100">Optic Contamin</TD>
<TD WIDTH="100">m6x1.(-4.15 Ratio) Count</TD>
<TD WIDTH="100">0</TD>
<TD WIDTH="100"><= 0</TD>
<TD WIDTH="100">Pass</TD>
</TR>
<TR>
<TD WIDTH="100">Optic Contamin</TD>
<TD WIDTH="100">m7x1.(-4.15 Ratio) Count</TD>
<TD WIDTH="100">0</TD>
<TD WIDTH="100"><= 0</TD>
<TD WIDTH="100">Pass</TD>
</TR>
<TR>
<TD WIDTH="100">Optic Contamin</TD>
<TD WIDTH="100">m7x2.(-4.15 Ratio) Count</TD>
<TD WIDTH="100">0</TD>
<TD WIDTH="100"><= 0</TD>
<TD WIDTH="100">Pass</TD>
</TR>
<TR>
<TD WIDTH="100">Optic Contamin</TD>
<TD WIDTH="100">m7x3.(-4.15 Ratio) Count</TD>
<TD WIDTH="100">0</TD>
<TD WIDTH="100"><= 0</TD>
<TD WIDTH="100">Pass</TD>
</TR>
<TR>
<TD WIDTH="100">Optic Contamin</TD>
<TD WIDTH="100">m7x4.(-4.15 Ratio) Count</TD>
<TD WIDTH="100">0</TD>
<TD WIDTH="100"><= 0</TD>
<TD WIDTH="100">Pass</TD>
</TR>
<TR>
<TD WIDTH="100">Optic Contamin</TD>
<TD WIDTH="100">m7x5.(-4.15 Ratio) Count</TD>
<TD WIDTH="100">0</TD>
<TD WIDTH="100"><= 0</TD>
<TD WIDTH="100">Pass</TD>
</TR>
<TR>
<TD WIDTH="100">LoadWhite</TD>
<TD WIDTH="100">White SN: WST412P</TD>
<TD WIDTH="100">TRUE</TD>
<TD WIDTH="100">= "TRUE"</TD>
<TD WIDTH="100">Pass</TD>
</TR>
<TR>
<TD WIDTH="100">LoadTarget</TD>
<TD WIDTH="100">LoadTarget</TD>
<TD WIDTH="100">TRUE</TD>
<TD WIDTH="100">= "TRUE"</TD>
<TD WIDTH="100">Pass</TD>
</TR>
<TR>
<TD WIDTH="100">Fluorescent Contamination</TD>
<TD WIDTH="100">m1x1.(-4.15 Ratio) Count</TD>
<TD WIDTH="100">0</TD>
<TD WIDTH="100"><= 0</TD>
<TD WIDTH="100">Pass</TD>
</TR>
<TR>
<TD WIDTH="100">Fluorescent Contamination</TD>
<TD WIDTH="100">m2x2.(-4.15 Ratio) Count</TD>
<TD WIDTH="100">0</TD>
<TD WIDTH="100"><= 0</TD>
<TD WIDTH="100">Pass</TD>
</TR>
<TR>
<TD WIDTH="100">Fluorescent Contamination</TD>
<TD WIDTH="100">m2x7_Trans.(-4.15 Ratio) Count</TD>
<TD WIDTH="100">0</TD>
<TD WIDTH="100"><= 0</TD>
<TD WIDTH="100">Pass</TD>
</TR>
<TR>
<TD WIDTH="100">Fluorescent Contamination</TD>
<TD WIDTH="100">m3x3.(-4.15 Ratio) Count</TD>
<TD WIDTH="100">0</TD>
<TD WIDTH="100"><= 0</TD>
<TD WIDTH="100">Pass</TD>
</TR>
<TR>
<TD WIDTH="100">Fluorescent Contamination</TD>
<TD WIDTH="100">m4x4.(-4.15 Ratio) Count</TD>
<TD WIDTH="100">0</TD>
<TD WIDTH="100"><= 0</TD>
<TD WIDTH="100">Pass</TD>
</TR>
<TR>
<TD WIDTH="100">Fluorescent Contamination</TD>
<TD WIDTH="100">m5x6.(-4.15 Ratio) Count</TD>
<TD WIDTH="100">0</TD>
<TD WIDTH="100"><= 0</TD>
<TD WIDTH="100">Pass</TD>
</TR>
<TR>
<TD WIDTH="100">DeCpCollectEpi</TD>
<TD WIDTH="100">Prescan.expo 10.00</TD>
<TD WIDTH="100">Good</TD>
<TD WIDTH="100"> { None, STR, %s, }</TD>
<TD WIDTH="100">Pass</TD>
</TR>
<TR>
<TD WIDTH="100">CpCollectEpi</TD>
<TD WIDTH="100">Prescan.expo 10.00</TD>
<TD WIDTH="100">Good</TD>
<TD WIDTH="100"> { None, STR, %s, }</TD>
<TD WIDTH="100">Pass</TD>
</TR>
<TR>
<TD WIDTH="100">CollectNIRG55</TD>
<TD WIDTH="100">Prescan.expo 18520.00</TD>
<TD WIDTH="100">Good</TD>
<TD WIDTH="100"> { None, STR, %s, }</TD>
<TD WIDTH="100">Pass</TD>
</TR>
<TR>
<TD WIDTH="100">CollectEpiImageG55</TD>
<TD WIDTH="100">Prescan.expo 1042.00</TD>
<TD WIDTH="100">Good</TD>
<TD WIDTH="100"> { None, STR, %s, }</TD>
<TD WIDTH="100">Pass</TD>
</TR>
<TR>
<TD WIDTH="100">BkgTestx1Prescan</TD>
<TD WIDTH="100">m2x7_Trans Saturation</TD>
<TD WIDTH="100">FALSE</TD>
<TD WIDTH="100">= "FALSE"</TD>
<TD WIDTH="100">Pass</TD>
</TR>
<TR>
<TD WIDTH="100">BkgTestx1Prescan</TD>
<TD WIDTH="100">m2x7_Trans Underexposed</TD>
<TD WIDTH="100">FALSE</TD>
<TD WIDTH="100">= "FALSE"</TD>
<TD WIDTH="100">Pass</TD>
</TR>
<TR>
<TD WIDTH="100">BkgTestx1Prescan</TD>
<TD WIDTH="100">m2x7_Trans (max 25000.0)</TD>
<TD WIDTH="100">10124.2</TD>
<TD WIDTH="100"><= 25000.0</TD>
<TD WIDTH="100">Pass</TD>
</TR>
<TR>
<TD WIDTH="100">BkgTestx1Prescan</TD>
<TD WIDTH="100">m2x7_Trans (ratio 1.30)</TD>
<TD WIDTH="100">TRUE</TD>
<TD WIDTH="100">FIO</TD>
<TD WIDTH="100">Pass</TD>
</TR>
<TR>
<TD WIDTH="100">BkgTestx1Prescan</TD>
<TD WIDTH="100">m1x1 Saturation</TD>
<TD WIDTH="100">FALSE</TD>
<TD WIDTH="100">= "FALSE"</TD>
<TD WIDTH="100">Pass</TD>
</TR>
<TR>
<TD WIDTH="100">BkgTestx1Prescan</TD>
<TD WIDTH="100">m1x1 Underexposed</TD>
<TD WIDTH="100">FALSE</TD>
<TD WIDTH="100">= "FALSE"</TD>
<TD WIDTH="100">Pass</TD>
</TR>
<TR>
<TD WIDTH="100">BkgTestx1Prescan</TD>
<TD WIDTH="100">m1x1 (max 298.3)</TD>
<TD WIDTH="100">261.5</TD>
<TD WIDTH="100"><= 298.3</TD>
<TD WIDTH="100">Pass</TD>
</TR>
<TR>
<TD WIDTH="100">BkgTestx1Prescan</TD>
<TD WIDTH="100">m1x1 (ratio 1.30)</TD>
<TD WIDTH="100">1.00</TD>
<TD WIDTH="100"><= 1.30</TD>
<TD WIDTH="100">Pass</TD>
</TR>
<TR>
<TD WIDTH="100">BkgTestx1Prescan</TD>
<TD WIDTH="100">m2x2 Saturation</TD>
<TD WIDTH="100">FALSE</TD>
<TD WIDTH="100">= "FALSE"</TD>
<TD WIDTH="100">Pass</TD>
</TR>
<TR>
<TD WIDTH="100">BkgTestx1Prescan</TD>
<TD WIDTH="100">m2x2 Underexposed</TD>
<TD WIDTH="100">FALSE</TD>
<TD WIDTH="100">= "FALSE"</TD>
<TD WIDTH="100">Pass</TD>
</TR>
<TR>
<TD WIDTH="100">BkgTestx1Prescan</TD>
<TD WIDTH="100">m2x2 (max 126.9)</TD>
<TD WIDTH="100">82.8</TD>
<TD WIDTH="100"><= 126.9</TD>
<TD WIDTH="100">Pass</TD>
</TR>
<TR>
<TD WIDTH="100">BkgTestx1Prescan</TD>
<TD WIDTH="100">m2x2 (ratio 1.30)</TD>
<TD WIDTH="100">1.00</TD>
<TD WIDTH="100"><= 1.30</TD>
<TD WIDTH="100">Pass</TD>
</TR>
<TR>
<TD WIDTH="100">BkgTestx1Prescan</TD>
<TD WIDTH="100">m3x3 Saturation</TD>
<TD WIDTH="100">FALSE</TD>
<TD WIDTH="100">= "FALSE"</TD>
<TD WIDTH="100">Pass</TD>
</TR>
<TR>
<TD WIDTH="100">BkgTestx1Prescan</TD>
<TD WIDTH="100">m3x3 Underexposed</TD>
<TD WIDTH="100">FALSE</TD>
<TD WIDTH="100">= "FALSE"</TD>
<TD WIDTH="100">Pass</TD>
</TR>
<TR>
<TD WIDTH="100">BkgTestx1Prescan</TD>
<TD WIDTH="100">m3x3 (max 71.4)</TD>
<TD WIDTH="100">58.9</TD>
<TD WIDTH="100"><= 71.4</TD>
<TD WIDTH="100">Pass</TD>
</TR>
<TR>
<TD WIDTH="100">BkgTestx1Prescan</TD>
<TD WIDTH="100">m3x3 (ratio 1.30)</TD>
<TD WIDTH="100">1.00</TD>
<TD WIDTH="100"><= 1.30</TD>
<TD WIDTH="100">Pass</TD>
</TR>
<TR>
<TD WIDTH="100">BkgTestx1Prescan</TD>
<TD WIDTH="100">m4x4 Saturation</TD>
<TD WIDTH="100">FALSE</TD>
<TD WIDTH="100">= "FALSE"</TD>
<TD WIDTH="100">Pass</TD>
</TR>
<TR>
<TD WIDTH="100">BkgTestx1Prescan</TD>
<TD WIDTH="100">m4x4 Underexposed</TD>
<TD WIDTH="100">FALSE</TD>
<TD WIDTH="100">= "FALSE"</TD>
<TD WIDTH="100">Pass</TD>
</TR>
<TR>
<TD WIDTH="100">BkgTestx1Prescan</TD>
<TD WIDTH="100">m4x4 (max 63.9)</TD>
<TD WIDTH="100">42.1</TD>
<TD WIDTH="100"><= 63.9</TD>
<TD WIDTH="100">Pass</TD>
</TR>
<TR>
<TD WIDTH="100">BkgTestx1Prescan</TD>
<TD WIDTH="100">m4x4 (ratio 1.40)</TD>
<TD WIDTH="100">1.00</TD>
<TD WIDTH="100"><= 1.40</TD>
<TD WIDTH="100">Pass</TD>
</TR>
<TR>
<TD WIDTH="100">BkgTestx1Prescan</TD>
<TD WIDTH="100">m5x6 Saturation</TD>
<TD WIDTH="100">FALSE</TD>
<TD WIDTH="100">= "FALSE"</TD>
<TD WIDTH="100">Pass</TD>
</TR>
<TR>
<TD WIDTH="100">BkgTestx1Prescan</TD>
<TD WIDTH="100">m5x6 Underexposed</TD>
<TD WIDTH="100">TRUE</TD>
<TD WIDTH="100">= "FALSE"</TD>
<TD WIDTH="100">Fail</TD>
</TR>
<TR>
<TD WIDTH="100">BkgTestx1Prescan</TD>
<TD WIDTH="100">m5x6 (max NaN)</TD>
<TD WIDTH="100">0.5</TD>
<TD WIDTH="100"><= NaN</TD>
<TD WIDTH="100">Fail</TD>
</TR>
<TR>
<TD WIDTH="100">BkgTestx1Prescan</TD>
<TD WIDTH="100">m5x6 (ratio 1.60)</TD>
<TD WIDTH="100">1.21</TD>
<TD WIDTH="100"><= 1.60</TD>
<TD WIDTH="100">Pass</TD>
</TR>
</TABLE>
<HR SIZE="1" WIDTH=" 100.000000%">
<OL>
<LI>Name & Sign: __________________________________</LI>
</OL>
</BODY>
</HTML>

"@

 $body = ""
 
 foreach ($sample in $samples) {
   $row = '<tr>'
   foreach ($property in $sample.PSObject.Properties.Name) {
     $row += "<td>$($sample.$property)</td>"
   }
   $row += '</tr>'
   $body += $row
 }
 $footer = "</tbody></table></body></html>"
 $html = $htmlHeader + $body + $footer
 $html | Out-File -FilePath 'C:\ServerPerformance.html' -Force
 