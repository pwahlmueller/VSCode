########################################################################
##
## PSProfile for VSCode
## wahlpatr 2019-10-16
##
## 2020-09-02 v1.1.0   WahlPatr refreshed
## 2019-10-07 v1.0.0   WahlPatr Erstellt
##
########################################################################
 
function Set-ModulePath {
    <#
          .SYNOPSIS
          Shorten the PSModulePath

          .DESCRIPTION
          Shorten the PSModulePath
         
          If there is a long PPPodule path, PowerShell may experience slow intellisense. To avoid this you should shorten the PSModule Path.

          On the long term you should avoid using non standard pathes for the modules.

          .EXAMPLE
          Set-ModulePath -ModulePathSet Standard

          .EXAMPLE
          To set the Default Path
          Set-ModulePath -ModulePathSet Startup

      #>
        [CmdletBinding()]
        param (
            [ValidateSet('Standard','Standard+SMLets','Startup')]
            [string]$ModulePathSet
        )
       
        begin {
            if ($null -eq $script:Standardpath) {$script:Standardpath = $env:PSModulePath}
        }
       
        process {
            switch ($ModulePathSet) {
                 'Standard' {$env:PSModulePath = 'C:\Program Files\WindowsPowerShell\Modules;' }
                 'Startup' { $env:PSModulePath =  $script:Standardpath }
            }
            "Set env:PSModulePath to $ModulePathSet"
        }
        end {
        }
    }
 
Function prompt {
    # .Description
    # This custom version of the PowerShell prompt will present a colorized location value based on the current provider. It w
    # .Link
    # https://go.microsoft.com/fwlink/?LinkID=225750
    # .ExternalHelp System.Management.Automation.dll-help.xml
    function Get-LastCmdTime {
        $diffPromptTime = $null
        $lastCmd = Get-History -Count 1
        if ($lastCmd -ne $null) {
               ("{0:HH\:mm\:ss\.ffff}" -f ([datetime](New-TimeSpan -end $lastCmd.EndExecutionTime -start $lastCmd.StartExecutionTime).Ticks))
        }
    }
    $user = [Security.Principal.WindowsIdentity]::GetCurrent()
    if ( (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)) {
        $adminfg = "Red"
    }
    else {
        $adminfg = $host.ui.rawui.ForegroundColor
    }
    Switch ((get-location).provider.name) {
        "FileSystem" { $fg = "green" }
        "Registry" { $fg = "magenta" }
        "wsman" { $fg = "cyan" }
        "Environment" { $fg = "yellow" }
        "Certificate" { $fg = "darkcyan" }
        "Function" { $fg = "gray" }
        "alias" { $fg = "darkgray" }
        "variable" { $fg = "darkgreen" }
        "CMSite" { $fg = "darkyellow" }
        Default { $fg = $host.ui.rawui.ForegroundColor }
    }
 
    if ($adminfg -eq -1) { $adminfg = 'DarkGray' }
 
    if ($fg -eq -1) { $adminfg = 'DarkGray' }
 
    Write-host '[' -NoNewline
    Write-Host "$((Get-Date).timeofday.tostring().substring(0,8))-" -foregroundcolor cyan  -NoNewline
    write-host "$(Get-LastCmdTime)" -NoNewline -ForegroundColor Yellow
    Write-Host "] " -nonewline
    Write-Host "PS " -nonewline -ForegroundColor $adminfg
    Write-Host "$($executionContext.SessionState.Path.CurrentLocation)" -foregroundcolor $fg -nonewline
    Write-Output "$('>' * ($nestedPromptLevel + 1)) "
}
$host.PrivateData.ErrorForegroundColor = 'Yellow'
write-host "Hallo $env:UserName on $env:ComputerName" -ForegroundColor Green -NoNewline
$user = [Security.Principal.WindowsIdentity]::GetCurrent()
if ( (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)) {
    write-host " as ADMIN" -foregroundcolor yellow -NoNewline
}
write-host " (v2020-09-02)" -ForegroundColor DarkGray
#region
#Regin Systemspezifische Variablen automatisch setzen
Write-host ' '
Set-ModulePath -ModulePathSet Standard+SMLets
#endregion
 
Get-Date