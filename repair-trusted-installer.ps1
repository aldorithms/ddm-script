$TrustedInstallerStartupType = Get-Service -Name TrustedInstaller | Select-Object -ExpandProperty StartType
if ($TrustedInstallerStartupType -ne "Demand") { # Check if TrustedInstaller service startup is set to type "Demand"
    Write-Output "Setting Trusted Installer to Demand" | Get-Member
    Set-Service -Name TrustedInstaller -StartupType Demand    # Set the TrustedInstaller service startup type to "Demand"
}

$TrustedInstallerStatus = Get-Service -Name TrustedInstaller | Select-Object -ExpandProperty Status
if ($TrustedInstallerStatus -ne "Running") { # Check if Trusted service startup is already started
    Write-Output "Starting Trusted Installer" | Get-Member
    Start-Service -Name TrustedInstaller # Start the TrustedInstaller service
}

Sfc /scannow
DISM /Online /Cleanup-Image /RestoreHealth