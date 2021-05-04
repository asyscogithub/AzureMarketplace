  
param (
  
    [string]$username,
    [string]$password,
    [string]$sqlserver,
    [string]$sqladmin,
    [string]$sqlpassword,
    [string]$amtSettings,
    [switch]$allinone

)

Start-Transcript -Path "C:\amt\transcript.txt" -NoClobber

C:\AMT\FixSettings.ps1 -sqlserver $sqlserver

if (-not $allinone)
{
  #pwsh.exe -ExecutionPolicy Unrestricted -File C:\\AMT\\AdjustEnvironmentFile.ps1 -jsonstring $amtSettings
  New-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce\" -Name "Adjust AMT xml" -Value 'pwsh.exe  -WorkingDirectory C:\AMT -ExecutionPolicy Bypass -File "C:\AMT\AdjustEnvironmentFile.ps1 -jsonstring $amtSettings" -WindowStyle Normal' -PropertyType "String" 


  C:\AMT\SetupAmt.ps1 -adminname $username -adminpassword $password -sqladminname $sqladmin -sqladminpassword $sqlpassword

}
else 
{
  Invoke-Expression "C:\\AMT\\SetupAllInOne.ps1 -adminname $username -adminpassword $password -sqladminname $sqladmin -sqladminpassword $sqlpassword" -Verbose
}



#Add AMT install script as a run once script during first login.
New-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce\" -Name "Install AMT" -Value 'pwsh.exe  -WorkingDirectory C:\AMT -ExecutionPolicy Bypass -File "c:\AMT\InstallAmt_AzureMarket.ps1" -WindowStyle Normal' -PropertyType "String" 

Stop-Transcript
