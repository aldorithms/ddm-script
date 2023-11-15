# Check if D:\packages\npm exists, if not, create it.
if (!(Test-Path "D:\packages\npm")) {
    New-Item -Path "D:\packages" -Name "npm" -ItemType Directory
}

# Get the current value of the environmental variable npm_config_path
$npm_config_path = [Environment]::GetEnvironmentVariable("npm_config_path", "User")

# If the variable doesn't exist or is not equal to D:\packages\npm
if ($npm_config_path -ne "D:\packages\npm") {
    # Set the variable to D:\packages\npm
    [Environment]::SetEnvironmentVariable("npm_config_path", "D:\packages\npm", "User")
}

# If %AppData%\npm-cache exists, copy it's contents to %npm_config_path%
if (Test-Path "$env:AppData\npm-cache") {
    Copy-Item -Path "$env:AppData\npm-cache\*" -Destination "$env:npm_config_path" -Recurse
}