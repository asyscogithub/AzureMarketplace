#Requires -Version 5.0 -RunAsAdministrator
#This PowerShell script is generated by the AMT Component Deployment Center
param (
  
    [string]$username,
    [string]$password
)

Invoke-Expression "C:\\AMT\\DeployCobol.ps1  -adminname $username -adminpassword $password"
     


