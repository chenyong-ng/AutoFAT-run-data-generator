
$a = Get-ChildItem "U:\RHID-0890\*GFE-BV Allelic Ladder*"
$ab = $a.FullName.count
$ac = $a[0].Name
$image = ($a.fullname[0] | Get-ChildItem -i "*.png" -r).fullname
$imageNameAlt = ($a.fullname[0] | Get-ChildItem -i "*.png" -r).name
# Start of the HTML code
clear-variable html
$html = @"
<!DOCTYPE html>
<html lang='en'>
<head>
    <meta charset=utf-8; http-equiv='Content-Type' content='text/html'>
    <meta name='viewport' content='width=device-width, initial-scale=1.0'>
    <title>$ac</title>
    <style>
        table {
            width: 100%;
        }
        td {
            width: 33%;
        }
        img
        /* Height disabled */
        {
            width: 45%;
        }
            table, th, td, Caption
        {
            border: 1px solid black;
            font-family: "Lucida Console";
            font-size: 12px;
            Font-Weight: Bold;
        }
    </style>
</head>
<body>
    <table>
        <caption>
            Full test gallery of $ac
        </caption>
            <tr>
                <th scope=""col"">Name</th>
                <th scope=""col"">Name2</th>
            </tr>
"@

# Loop through each image and add it to the HTML code

$i = $image.count
$i = 0
foreach ($a in $image) {
    $imageHTML = $image.replace("\", "/").replace(" ","%20")
    $html += @"
        <tr>
            <td><img src="file:///$($imageHTML[$i])" alt="$($imageNameAlt[$i])"></td>
        </tr>
"@
    $i = $i + 1
}

# End of the HTML code
$html += @"
    </table>
</body>
</html>
"@

# Write the HTML code to a file
$html | Out-File -FilePath "U:\RHID-0890\RHID-0890_2023-09-18_(05.10) GFE-BV Allelic Ladder\$ac.html"

#>