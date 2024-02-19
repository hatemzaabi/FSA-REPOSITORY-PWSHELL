# Spécifiez les informations de connexion SharePoint
$SiteUrl = "https://ulavaldti.sharepoint.com/sites/infra-collaboration"
$Username = "hazaa3@fsa.ulava.ca"
$Password = ConvertTo-SecureString "Lahtim07$" -AsPlainText -Force

# Spécifiez le chemin local du fichier à télécharger
$LocalFilePath = "C:\DataFillia\Archivage.docx"

# Spécifiez le chemin de la bibliothèque de documents SharePoint cible
$LibraryName = "DataFiliaTest"

# Chargez les assemblies SharePoint Online
Add-Type -Path "C:\Program Files\SharePoint Online Management Shell\Microsoft.Online.SharePoint.PowerShell\Microsoft.SharePoint.Client.dll"
Add-Type -Path "C:\Program Files\SharePoint Online Management Shell\Microsoft.Online.SharePoint.PowerShell\Microsoft.SharePoint.Client.Runtime.dll"

# Connectez-vous à SharePoint Online
$Credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($Username, $Password)
$Context = New-Object Microsoft.SharePoint.Client.ClientContext($SiteUrl)
$Context.Credentials = $Credentials

# Chargez la bibliothèque de documents SharePoint
$List = $Context.Web.Lists.GetByTitle($LibraryName)
$Context.Load($List)
$Context.ExecuteQuery()

# Convertissez le fichier en tableau de bytes
$fileContent = [System.IO.File]::ReadAllBytes($LocalFilePath)

# Créez un fichier dans la bibliothèque de documents SharePoint
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
Write-Host "Le fichier a été téléchargé avec succès à l'emplacement suivant : $ShareLink"
