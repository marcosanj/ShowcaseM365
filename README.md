
# Script de Registro de Aplicação "Showcase M365 - Dedalus" no EntraID via Microsoft Graph

Este script PowerShell automatiza o processo de criação de uma aplicação registrada no Azure Active Directory (Azure AD), atribuição de permissões via Microsoft Graph, geração de segredo (client secret) com validade de 720 dias e exibição das credenciais essenciais ao final.

## 🔧 Funcionalidades

- Conecta ao Microsoft Graph com permissões administrativas.
- Cria uma aplicação com nome "Showcase M365 - Dedalus".
- Atribui permissões do tipo Application (App Roles) com consentimento de administrador.
- Gera um segredo (client secret) válido por 720 dias.
- Exibe na tela apenas:
  - Tenant ID
  - Client ID
  - Client Secret

## 📋 Pré-requisitos

- PowerShell 5.1 ou superior
- Módulo Microsoft.Graph instalado:

```powershell
Install-Module Microsoft.Graph -Scope CurrentUser
```

- Permissões administrativas no Azure AD

## ▶️ Como executar

1. Abra o PowerShell como administrador.
2. Execute o script:

```powershell
./ShowcaseM365.ps1
```

3. Após a execução, será exibida uma tela com as credenciais geradas.

## 🔐 Permissões atribuídas

O script atribui as seguintes permissões do Microsoft Graph:

- AuditLog.Read.All
- AuditLogsQuery.Read.All
- Directory.Read.All
- Organization.Read.All
- Policy.Read.All
- Reports.Read.All
- SecurityEvents.Read.All
- ServiceHealth.Read.All
- Sites.Read.All
- User.Read.All
- UserAuthenticationMethod.Read.All

## ⚠️ Importante

- As permissões atribuídas são do tipo "Application" e exigem consentimento de administrador.
- As credenciais geradas devem ser armazenadas com segurança (ex: Azure Key Vault).

## 📬 Suporte

Em caso de dúvidas ou problemas, entre em contato com o administrador responsável pela integração Microsoft 365.
