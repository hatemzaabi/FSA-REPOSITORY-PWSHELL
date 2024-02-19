



$credential=get-credential
Connect-MicrosoftTeams -Credential $credential

$LocalFilePath = "C:\C:\DataFillia\Archivage.docx"
$UploadUrl = "https://graph.microsoft.com/v1.0/teams/{groupId}/channels/{channelId}/messages"
$GroupId ="d0b9c8cd-c259-417f-bd4d-32457934ae9f"
$ChannelId="19:477f709d0b524d1bb05922c34fa3b4a0@thread.tacv2"
# Construire le chemin de l'URL de l'API pour télécharger le fichier dans le canal
$GraphUrl = "https://graph.microsoft.com/v1.0/teams/$GroupId/drives/root:/channels/$ChannelId:/files/copy"
write-host $GraphUrl
# Construire le corps de la demande
$RequestBody = @{
    parentReference = @{
        driveId = "team"
        id = $ChannelId
        type = "driveItem"
    }
    name = "Archivage.docs"
    file = @{
        mimeType = "text/plain"
    }
} | ConvertTo-Json

# Envoyer la requête HTTP POST pour copier le fichier dans le canal
$response = Invoke-RestMethod -Uri $GraphUrl -Method Post -Headers @{Authorization = "Bearer $([System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes((Get-MicrosoftAccessToken -Scope 'https://graph.microsoft.com/.default').AccessToken)))"; "Content-Type" = "application/json"} -Body $RequestBody -ContentType "application/json"
# Vérifier la réponse
if ($response) {
    Write-Host "Le fichier a été copié avec succès dans le canal."
} else {
    Write-Host "Une erreur s'est produite lors de la copie du fichier dans le canal."
}