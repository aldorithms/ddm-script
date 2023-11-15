# Check if D:\packages\vcpkg exists, if not, create it.
if (!(Test-Path "D:\packages\vcpkg")) {
    New-Item -Path "D:\packages" -Name "vcpkg" -ItemType Directory
}

# Get the current value of the environmental variable npm_config_path
$VCPKG_DEFAULT_BINARY_CACHE = [Environment]::GetEnvironmentVariable("VCPKG_DEFAULT_BINARY_CACHE", "User")

# If the variable doesn't exist or is not equal to D:\packages\npm
if ($npm_config_path -ne "D:\packages\vcpkg") {
    # Set the variable to D:\packages\npm
    [Environment]::SetEnvironmentVariable("VCPKG_DEFAULT_BINARY_CACHE", "D:\packages\vcpkg", "User")
}

#if %AppData%\npm-cache exists, copy it's contents to %npm_config_path%
if (Test-Path "$env:AppData\vcpkg") {
    Copy-Item -Path "$env:AppData\vcpkg\*" -Destination "$env:VCPKG_DEFAULT_BINARY_CACHE" -Recurse
}