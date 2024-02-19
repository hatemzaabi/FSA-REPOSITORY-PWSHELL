


Import-Module -Name PnP.PowerShell
$LocalFilePath = "C:\DataFillia\Archivage.docx"
$FullFilePath = (Resolve-Path $LocalFilePath).Path
$FileName = (Split-Path $FullFilePath -Leaf)
Connect-PnPOnline -Url $SiteUrl -UseWebLogin

$SiteUrl = "https://ulavaldti.sharepoint.com/sites/infra-collaboration"
$Username = "hazaa3@ulaval.ca"
$Password = ConvertTo-SecureString "Lahtim07$" -AsPlainText -Force

# Connectez-vous à SharePoint Online
$FileName
Copy-PnPFile "file:///C:\DataFillia\Archivage.docx" -TargetUrl "/sites/infra-collaboration/general"