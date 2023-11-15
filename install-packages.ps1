# Check if MSYS2 is installed
if (-not (Test-Path "C:\msys64")) {
    winget install -e --id MSYS2.MSYS2

    # Open MSYS2 ucrt64 shell
    &'C:\msys64\ucrt64.exe' -c "pacman -Syu --noconfirm"

    # Update the package database and upgrade all packages
    &'C:\msys64\ucrt64.exe' -c "pacman -Syu --noconfirm"

    # Install development tools
    &'C:\msys64\ucrt64.exe' -c "pacman -S --needed base-devel mingw-w64-x86_64-toolchain --noconfirm"
}

# add C:\msys64\ucrt64\bin to user PATH
$env:Path += ";C:\msys64\ucrt64\bin"

# add C:\msys64\ucrt64\bin to global PATH
$machinePath = [Environment]::GetEnvironmentVariable("Path", [EnvironmentVariableTarget]::Machine)
$machinePath += ";C:\msys64\ucrt64\bin"

