<# 
    These scripts should be run at Administrator privilege User.
    -Script Scope
    Create a Local User for New Onboarded Employee.
    Add user created to Local Group ('Users')
    Changing computer Name
    Set the timezone to Japanese

    #Check if local user is existing, if not do create...
#>

<# Directory Creation Starts Here
function DirectoryCreation {
    if (Test-Path c:\Tools\){

    [System.Windows.MessageBox]::Show('C:\Tools\ is already existing')
        $answer = "Press any key to quit"
        Read-Host $answer

    } else {

        Write-Host "Completed"
        Set-Location -Path $getPWd.Path
        Copy-Item $getPWd.Path -Destination "c:\Tools\" -Recurse
        $answer = "Press any key to quit"
        Read-Host $answer
    }
   
}
DirectoryCreation
#>

<#2 Creation of User Local will be started here! #>
function LocalUserCreation{

    Write-Host "Local User Creation"

    Set-Location C:\Tools\01_FB\AccountCreation
    $NewUserCreation = Import-Csv -Path C:\Tools\01_FB\localuser.csv

    #Check if user is existing
    $checkUserExist = Get-LocalUser

    if ($checkUserExist | Where-Object Name -eq $NewUserCreation.Username) {
    Write-Host "Account is already exist"
    }
    else {
    Write-Host "Account is not exist!!, procedd on account creation"
    $LocalUserPassword = ConvertTo-SecureString $NewUserCreation.Password -AsPlainText -Force
    New-LocalUser -Name $NewUserCreation.Username -Password $LocalUserPassword -FullName $NewUserCreation.Username
    Add-LocalGroupMember -Group 'Users' -Member $NewUserCreation.Username
    }
<#Creation of User Local will be ends here! #>
}

LocalUserCreation

function SetTimezone{
    <#Setting the timezone #>
    Write-Host "Timezone setting here..."

    Set-TimeZone -Id "Tokyo Standard Time"
    }

SetTimezone

<#Computer Renaming Starts here! #>
function ComputerRename {
    Write-Host "Computer rename and reboot is required" 
    $NewHostName0 = $NewUserCreation.Username
    $NewHostName = $NewHostName0 +"-ATCP"
    $CurrentHostName = HOSTNAME.EXE
    if ($NewHostName -eq $CurrentHostName) {
    Write-Host "Matched"
    Write-Warning "No action required!!"
    } else {
    
    Write-Host "Does Not Match"
    Rename-Computer $NewHostName
    }

}
<#Computer Renaming Ends here! #>
ComputerRename

function ProxySettingsUpdate {
    Write-Host "Updating Proxy settings here!!"
    Write-Host  "Pulling current proxy data below"
    $GetProxyServer = Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings"
    Write-Host "Assigning new variable for ProxyOverride and ProxyServer"
    #$ProxyOverride = "*.fujixerox.co.jp;*.fxis.co.jp;172.23.5.*;172.23.11.*;129.249.17.*"
    $ProxyOverride = "*.fujixerox.co.jp;*.fujixerox.net;fbcmg01.fujifilm.com;*.microsoftonline.com;*.windows.net;mscrl.microsoft.com;secure.aadcdn.microsoftonline-p.com;*.adhybridhealth.azure.com;management.azure.com;policykeyservice.dc.ad.msft.net;*129.249.17.147*"
    $ProxyServer = "202.221.125.164:8080"

    Write-Host "Updating ProxyOverride"
    Set-ItemProperty  -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" -Name ProxyOverride -Type String -Value $ProxyOverride
    Write-Host "Updating ProxyServer"
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" -Name ProxyServer -Type String -Value $ProxyServer

    Write-Host "Done updating proxy settings and was changed to the following"
    $GetProxyServer.ProxyOverride
    $GetProxyServer.ProxyEnable
    $GetProxyServer.ProxyServer
}

ProxySettingsUpdate

function FnctionNameFFFTP{
    Write-Host "FFFTP Installation starts here" 
    Write-Host "FFFTP Installation Ends here" 
}
FnctionNameFFFTP

function FunctionMyLogStarInstallation {
    Write-Host "FFFTP Installation starts here" 
    Write-Host "FFFTP Installation Ends here" 
}
FunctionMyLogStarInstallation

function FunctionDocuWorksInstallation {
    Write-Host "FFFTP Installation starts here" 
    Write-Host "FFFTP Installation Ends here" 
}
FunctionDocuWorksInstallation