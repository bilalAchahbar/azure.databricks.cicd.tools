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

$ScopeName = "DataThirst1"
$SecretName = "Test1"
$SecretValue = "mykey"


Describe "Set-DatabricksSecret" {
    It "Simple test value" {
        Set-DatabricksSecret -ScopeName $ScopeName -SecretName $SecretName -SecretValue $SecretValue  -Verbose
    }
}
