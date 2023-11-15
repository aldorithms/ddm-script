#check if windows subsystem for linux feature is enabled
$wsl = dism.exe /online /get-features /format:table | findstr /c:"Enabled" | findstr /c:"Microsoft-Windows-Subsystem-Linux"
if ($wsl -eq $null) {
    # Enable Windows Subsystem for Linux feature
    dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart 
}
#check if virtual machine platform feature is enabled
$vm = dism.exe /online /get-features /format:table | findstr /c:"Enabled" | findstr /c:"VirtualMachinePlatform"
if ($vm -eq $null) {
    # Enable Virtual Machine Platform feature
    dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart 
}

wsl --install
wsl --set-default-version 2

# If Visual Studio Code is installed, install extension for WSL
if (Test-Path "C:\Program Files\Microsoft VS Code\Code.exe") {
    code --install-extension ms-vscode-remote.remote-wsl
}
