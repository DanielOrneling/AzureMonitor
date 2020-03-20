<#
Author:		Daniel Örneling
Date:		28/12/2016
Updated:    5/3/2020
Script:  	InstallMicrosoftMonitoringAgent.ps1
Version: 	1.1
Twitter: 	@DanielOrneling
#>

# Set the Workspace ID and Primary Key for the Log Analytics workspace.
[CmdletBinding(SupportsShouldProcess=$true)]
param(
    [parameter(Mandatory=$true, HelpMessage="The ID of the Log Analytics workspace you want to connect the agent to.")]
    [ValidateNotNullOrEmpty()]
    [string]$WorkSpaceID,

    [parameter(Mandatory=$true, HelpMessage="The primary key of the Log Analytics workspace you want to connect the agent to.")]
    [ValidateNotNullOrEmpty()]
    [string]$WorkSpaceKey
)

# Set the parameters
$FileName = "MMASetup-AMD64.exe"
$AzureMonitorFolder = 'C:\Source'
$MMAFile = $AzureMonitorFolder + "\" + $FileName

# Start logging the actions
Start-Transcript -Path C:\MMAInstallLog.txt -NoClobber

# Check if folder exists, if not, create it
 if (Test-Path $AzureMonitorFolder){
 Write-Host "The folder $AzureMonitorFolder already exists."
 } 
 else 
 {
 Write-Host "The folder $AzureMonitorFolder does not exist, creating..." -NoNewline
 New-Item $AzureMonitorFolder -type Directory | Out-Null
 Write-Host "done!" -ForegroundColor Green
 }

# Change the location to the specified folder
Set-Location $AzureMonitorFolder

# Check if file exists, if not, download it
 if (Test-Path $FileName){
 Write-Host "The file $FileName already exists."
 }
 else
 {
 Write-Host "The file $FileName does not exist, downloading..." -NoNewline
 $URL = "http://download.microsoft.com/download/1/5/E/15E274B9-F9E2-42AE-86EC-AC988F7631A0/MMASetup-AMD64.exe"
 Invoke-WebRequest -Uri $URl -OutFile $MMAFile | Out-Null
 Write-Host "done!" -ForegroundColor Green
 }
 
# Install the agent
Write-Host "Installing Microsoft Monitoring Agent.." -nonewline
$ArgumentList = '/C:"setup.exe /qn ADD_OPINSIGHTS_WORKSPACE=1 '+  "OPINSIGHTS_WORKSPACE_ID=$WorkspaceID " + "OPINSIGHTS_WORKSPACE_KEY=$WorkSpaceKey " +'AcceptEndUserLicenseAgreement=1"'
Start-Process $FileName -ArgumentList $ArgumentList -ErrorAction Stop -Wait | Out-Null
Write-Host "done!" -ForegroundColor Green

# Change the location to C: to remove the created folder
Set-Location -Path "C:\"

<#
# Remove the folder with the agent
 if (-not (Test-Path $AzureMonitorFolder)) {
 Write-Host "The folder $AzureMonitorFolder does not exist."
 } 
 else 
 {
 Write-Host "Removing the folder $AzureMonitorFolder ..." -NoNewline
 Remove-Item $AzureMonitorFolder -Force -Recurse | Out-Null
 Write-Host "done!" -ForegroundColor Green
 }
#>

Stop-Transcript