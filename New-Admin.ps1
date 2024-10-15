# Step 1: Generate a random temporary password
$temporaryPassword = [System.Web.Security.Membership]::GeneratePassword(12, 2)

# Step 2: Create the local user with the temporary password
New-LocalUser -Name "admin" -FullName "Administrator" -Description "Local admin account" -Password (ConvertTo-SecureString $temporaryPassword -AsPlainText -Force) -PasswordNeverExpires $false -AccountNeverExpires $true

# Step 3: Force password change at next login
Set-LocalUser -Name "admin" -PasswordExpired $true

# Step 4: Add the user to the Administrators group
Add-LocalGroupMember -Group "Administrators" -Member "admin"

# Step 5: Display the temporary password and prompt the user to copy it
Write-Host "The temporary password for the user 'admin' is: $temporaryPassword"
Write-Host "Please copy this password and provide it to the user. They will be prompted to change it on their first login."
