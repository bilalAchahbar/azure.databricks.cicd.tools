param(
    [ValidateSet('Bearer','ServicePrincipal')][string]$Mode="ServicePrincipal"
)

Set-Location $PSScriptRoot
Import-Module "..\azure.databricks.cicd.Tools.psd1" -Force
$Config = (Get-Content '.\config.json' | ConvertFrom-Json)

switch ($mode){
    ("Bearer"){
        Connect-Databricks -Region $Config.Region -BearerToken $Config.BearerToken
    }
    ("ServicePrincipal"){
        Connect-Databricks -Region $Config.Region -DatabricksOrgId $Config.DatabricksOrgId -ApplicationId $Config.ApplicationId -Secret $Config.Secret -TenantId $Config.TenantId
    }
}

$ScopeName = "DataThirstTest123"

Describe "Remove-DatabricksSecretScope" {
    BeforeAll{
        Add-DatabricksSecretScope -ScopeName $ScopeName  -Verbose
    }
    It "Simple addition"{
        Remove-DatabricksSecretScope -ScopeName $ScopeName  -Verbose
    }

    It "Delete non existent should not fail"{
        Remove-DatabricksSecretScope -ScopeName "Doesnt exist"  -Verbose
    }
}
