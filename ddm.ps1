Set-Location -Path D:\
New-Item -Path "D:\" -Name "packages" -ItemType Directory

${cache-array} = "npm", "vcpkg", "pip", "cargo", "maven"
foreach ($cache in ${cache-array}) {
    New-Item -Path "D:\packages" -Name "$cache" -ItemType Directory
}

setx    /M  NPM_CONFIG_CACHE            D:\packages\npm
setx    /M  VCPKG_DEFAULT_BINARY_CACHE  D:\packages\vcpkg
setx    /M  PIP_CACHE_DIR               D:\packages\pip
setx    /M  CARGO_HOME                  D:\packages\cargo

${origin-destination} = @{ 
    "%AppData%\npm-cache\*"             = "%NPM_CONFIG_CACHE%"; 
    "%LocalAppData%\vcpkg\archives\*"   = "%VCPKG_DEFAULT_BINARY_CACHE%"; 
    "%AppData%\vcpkg\archives\*"        = "%VCPKG_DEFAULT_BINARY_CACHE%";
    "%LocalAppData%\pip\Cache\*"        = "%PIP_CACHE_DIR%";
    "%USERPROFILE%\.cargo\*"            = "%CARGO_HOME%";
}

foreach ($origin in ${origin-destination}.Keys) {
    Copy-Item -Path $origin -Destination ${origin-destination}[$origin] -Recurse
}

# cd ../$Env:UserName
# mkdir .nuget\

# New-Item -Path "D:\" -Name "$Env:UserName" -ItemType Directory