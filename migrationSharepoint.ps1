# Sp�cifiez les informations de connexion SharePoint
$SiteUrl = "https://ulavaldti.sharepoint.com/sites/infra-collaboration"
$Username = "hazaa3@fsa.ulava.ca"
$Password = ConvertTo-SecureString "Lahtim07$" -AsPlainText -Force

# Sp�cifiez le chemin local du fichier � t�l�charger
$LocalFilePath = "C:\DataFillia\Archivage.docx"

# Sp�cifiez le chemin de la biblioth�que de documents SharePoint cible
$LibraryName = "DataFiliaTest"

# Chargez les assemblies SharePoint Online
Add-Type -Path "C:\Program Files\SharePoint Online Management Shell\Microsoft.Online.SharePoint.PowerShell\Microsoft.SharePoint.Client.dll"
Add-Type -Path "C:\Program Files\SharePoint Online Management Shell\Microsoft.Online.SharePoint.PowerShell\Microsoft.SharePoint.Client.Runtime.dll"

# Connectez-vous � SharePoint Online
$Credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($Username, $Password)
$Context = New-Object Microsoft.SharePoint.Client.ClientContext($SiteUrl)
$Context.Credentials = $Credentials

# Chargez la biblioth�que de documents SharePoint
$List = $Context.Web.Lists.GetByTitle($LibraryName)
$Context.Load($List)
$Context.ExecuteQuery()

# Convertissez le fichier en tableau de bytes
$fileContent = [System.IO.File]::ReadAllBytes($LocalFilePath)

# Cr�ez un fichier dans la biblioth�que de documents SharePoint
$fileCreationInfo = New-Object Microsoft.SharePoint.Client.FileCreationInformation
$fileCreationInfo.Overwrite = $true
$fileCreationInfo.Content = $fileContent
$fileCreationInfo.URL = (Get-Item $LocalFilePath).Name
$UploadFile = $List.RootFolder.Files.Add($fileCreationInfo)
$Context.Load($UploadFile)
$Context.ExecuteQuery()

# Obtenez le lien de partage pour le fichier
$ShareLink = $UploadFile.LinkingUrl

# Affichez le lien de partage
Write-Host "Le fichier a �t� t�l�charg� avec succ�s � l'emplacement suivant : $ShareLink"
