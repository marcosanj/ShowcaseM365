Connect-MgGraph -Scopes "Application.ReadWrite.All", "AppRoleAssignment.ReadWrite.All", "Directory.ReadWrite.All"

# Obter ID do tenant
$tenantId = (Get-MgOrganization).Id

# Criar a aplicação
$app = New-MgApplication -DisplayName "Showcase M365 - Dedalus" `
    -RequiredResourceAccess @(
        @{
            ResourceAppId = "00000003-0000-0000-c000-000000000000"
            ResourceAccess = @(
                @{Id="b0afded3-3588-46d8-8b3d-9842eff778da"; Type="Role"} # AuditLog.Read.All
                @{Id="5e1e9171-754d-478c-812c-f1755a9a4c2d"; Type="Role"} # AuditLogsQuery.Read.All
                @{Id="7ab1d382-f21e-4acd-a863-ba3e13f7da61"; Type="Role"} # Directory.Read.All
                @{Id="498476ce-e0fe-48b0-b801-37ba7e2685c6"; Type="Role"} # Organization.Read.All
                @{Id="246dd0d5-5bd0-4def-940b-0421030a5b68"; Type="Role"} # Policy.Read.All
                @{Id="230c1aed-a721-4c5d-9cb4-a90514e508ef"; Type="Role"} # Reports.Read.All
                @{Id="bf394140-e372-4bf9-a898-299cfc7564e5"; Type="Role"} # SecurityEvents.Read.All
                @{Id="79c261e0-fe76-4144-aad5-bdc68fbe4037"; Type="Role"} # ServiceHealth.Read.All
                @{Id="332a536c-c7ef-4017-ab91-336970924f0d"; Type="Role"} # Sites.Read.All
                @{Id="df021288-bdef-4463-88db-98f22de89214"; Type="Role"} # User.Read.All
                @{Id="38d9df27-64da-44fd-b7c5-a6fbac20248f"; Type="Role"} # UserAuthenticationMethod.Read.All
            )
        }
    )

# Criar segredo com validade de 720 dias
$startDate = Get-Date
$endDate = $startDate.AddDays(720)
$secret = Add-MgApplicationPassword -ApplicationId $app.Id -PasswordCredential @{
    DisplayName = "Secret-720days"
    StartDateTime = $startDate
    EndDateTime = $endDate
}

# Criar o Service Principal da aplicação
$sp = New-MgServicePrincipal -AppId $app.AppId

# Obter o Service Principal do Microsoft Graph
$graphSp = Get-MgServicePrincipal -Filter "appId eq '00000003-0000-0000-c000-000000000000'"

# Lista de App Role IDs a serem atribuídos (admin consent)
$appRoleIds = @(
                "b0afded3-3588-46d8-8b3d-9842eff778da", # AuditLog.Read.All
                "5e1e9171-754d-478c-812c-f1755a9a4c2d", # AuditLogsQuery.Read.All
                "7ab1d382-f21e-4acd-a863-ba3e13f7da61", # Directory.Read.All
                "498476ce-e0fe-48b0-b801-37ba7e2685c6", # Organization.Read.All
                "246dd0d5-5bd0-4def-940b-0421030a5b68", # Policy.Read.All
                "230c1aed-a721-4c5d-9cb4-a90514e508ef", # Reports.Read.All
                "bf394140-e372-4bf9-a898-299cfc7564e5", # SecurityEvents.Read.All
                "79c261e0-fe76-4144-aad5-bdc68fbe4037", # ServiceHealth.Read.All
                "332a536c-c7ef-4017-ab91-336970924f0d", # Sites.Read.All
                "df021288-bdef-4463-88db-98f22de89214", # User.Read.All
                "38d9df27-64da-44fd-b7c5-a6fbac20248f" # UserAuthenticationMethod.Read.All
)

# Conceder admin consent (App Role Assignments)
foreach ($roleId in $appRoleIds) {
    New-MgServicePrincipalAppRoleAssignment -ServicePrincipalId $sp.Id `
        -PrincipalId $sp.Id `
        -AppRoleId $roleId `
        -ResourceId $graphSp.Id
}

# Exibir resultados
#Write-Host "Tenant ID: $tenantId"
#Write-Host "Application (Client) ID: $($app.AppId)"
#Write-Host "Client Secret: $($secret.SecretText)"

Clear-Host

Write-Host "=========================================" -ForegroundColor Cyan
Write-Host " Aplicação registrada com sucesso! " -ForegroundColor Green
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Tenant ID:               $tenantId" -ForegroundColor Yellow
Write-Host "Application (Client) ID: $($app.AppId)" -ForegroundColor Yellow
Write-Host "Client Secret:           $($secret.SecretText)" -ForegroundColor Yellow
Write-Host ""
Write-Host "Copie essas informações e envie para o responsável técnico." -ForegroundColor Gray
Write-Host "=========================================" -ForegroundColor Cyan


