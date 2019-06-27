function Get-AzWebAppPublishingProfile_ListBySiteObject {
    [OutputType('System.Boolean')]
    [CmdletBinding(PositionalBinding=$false, SupportsShouldProcess)]
    [Microsoft.Azure.PowerShell.Cmdlets.WebSite.Profile('latest-2019-04-30')]
    param(
        [Parameter(Mandatory, HelpMessage='Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).')]
        [Microsoft.Azure.PowerShell.Cmdlets.WebSite.Category('Path')]
        [System.String[]]
        ${SubscriptionId},

        [Parameter(Mandatory, HelpMessage='The object representation of the web app or slot.')]
        [Alias('WebApp', 'WebAppSlot')]
        [Microsoft.Azure.PowerShell.Cmdlets.WebSite.Category('Body')]
        [Microsoft.Azure.PowerShell.Cmdlets.WebSite.Models.Api20180201.ISite]
        ${SiteObject},

        [Parameter(HelpMessage='When specified, PassThru will force the cmdlet return a ''bool'' given that there isn''t a return type by default.')]
        [Microsoft.Azure.PowerShell.Cmdlets.WebSite.Category('Body')]
        [System.Management.Automation.SwitchParameter]
        ${PassThru},

        [Parameter(HelpMessage='Name of the format. Valid values are: FileZilla3WebDeploy -- defaultFtp')]
        [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.WebSite.Support.PublishingProfileFormat])]
        [Microsoft.Azure.PowerShell.Cmdlets.WebSite.Category('Body')]
        [Microsoft.Azure.PowerShell.Cmdlets.WebSite.Support.PublishingProfileFormat]
        ${Format},

        [Parameter(HelpMessage='Include the DisasterRecover endpoint if true')]
        [Microsoft.Azure.PowerShell.Cmdlets.WebSite.Category('Body')]
        [System.Management.Automation.SwitchParameter]
        ${IncludeDisasterRecoveryEndpoints},

        [Parameter(HelpMessage='The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRMContext', 'AzureCredential')]
        [ValidateNotNull()]
        [Microsoft.Azure.PowerShell.Cmdlets.WebSite.Category('Azure')]
        [System.Management.Automation.PSObject]
        ${DefaultProfile},

        [Parameter(DontShow, HelpMessage='Wait for .NET debugger to attach')]
        [Microsoft.Azure.PowerShell.Cmdlets.WebSite.Category('Runtime')]
        [System.Management.Automation.SwitchParameter]
        ${Break},

        [Parameter(DontShow, HelpMessage='SendAsync Pipeline Steps to be appended to the front of the pipeline')]
        [ValidateNotNull()]
        [Microsoft.Azure.PowerShell.Cmdlets.WebSite.Category('Runtime')]
        [Microsoft.Azure.PowerShell.Cmdlets.WebSite.Runtime.SendAsyncStep[]]
        ${HttpPipelineAppend},

        [Parameter(DontShow, HelpMessage='SendAsync Pipeline Steps to be prepended to the front of the pipeline')]
        [ValidateNotNull()]
        [Microsoft.Azure.PowerShell.Cmdlets.WebSite.Category('Runtime')]
        [Microsoft.Azure.PowerShell.Cmdlets.WebSite.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend},

        [Parameter(DontShow, HelpMessage='The URI for the proxy server to use')]
        [Microsoft.Azure.PowerShell.Cmdlets.WebSite.Category('Runtime')]
        [System.Uri]
        ${Proxy},

        [Parameter(DontShow, HelpMessage='Credentials for a proxy server to use for the remote call')]
        [ValidateNotNull()]
        [Microsoft.Azure.PowerShell.Cmdlets.WebSite.Category('Runtime')]
        [System.Management.Automation.PSCredential]
        ${ProxyCredential},

        [Parameter(DontShow, HelpMessage='Use the default credentials for the proxy')]
        [Microsoft.Azure.PowerShell.Cmdlets.WebSite.Category('Runtime')]
        [System.Management.Automation.SwitchParameter]
        ${ProxyUseDefaultCredentials}
    )

    process {
        $Tokens = $SiteObject.Id.Split("/", [System.StringSplitOptions]::RemoveEmptyEntries)
        $PSBoundParameters.Add("ResourceGroupName", $Tokens[3]) | Out-Null
        $PSBoundParameters.Add("Name", $Tokens[7]) | Out-Null
        if ($Tokens.Length -eq 10)
        {
            $PSBoundParameters.Add("Slot", $Tokens[9]) | Out-Null
        }

        $PSBoundParameters.Remove("SiteObject") | Out-Null
        Az.WebSite\Get-AzWebAppPublishingProfile @PSBoundParameters
    }
}