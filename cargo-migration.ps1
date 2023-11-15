# Define the Cargo cache directory
$cargoDir = "D:\packages\cargo"

# Create the directory if it doesn't exist
if (!(Test-Path -Path $cargoDir)) {
    New-Item `
        -ItemType Directory `
        -Path $cargoDir
}

# Set the CARGO_HOME environment variable
[Environment]::SetEnvironmentVariable("CARGO_HOME", $cargoDir, "Machine")

# Move existing Cargo packages to the new directory
$userProfileDir = [Environment]::GetFolderPath("UserProfile")
$cargoUserProfileDir `
    = Join-Path `
        -Path $userProfileDir `
        -ChildPath ".cargo"

if (Test-Path -Path $cargoUserProfileDir) {
    Get-ChildItem `
        -Path $cargoUserProfileDir `
        | Move-Item `
                -Destination $cargoDir
}