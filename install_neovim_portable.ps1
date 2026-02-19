# Install latest Neovim portable version without admin rights
$neovimDir = "$env:USERPROFILE\AppData\Local\nvim-portable"
$tempDir = "$env:TEMP\nvim-download"

# Create directories
New-Item -ItemType Directory -Force -Path $neovimDir | Out-Null
New-Item -ItemType Directory -Force -Path $tempDir | Out-Null

Write-Host "Downloading latest Neovim release..." -ForegroundColor Green

# Get latest release info from GitHub
$releaseInfo = Invoke-RestMethod -Uri "https://api.github.com/repos/neovim/neovim/releases/latest"
$version = $releaseInfo.tag_name
$downloadUrl = $releaseInfo.assets | Where-Object { $_.name -like "*win64.zip" } | Select-Object -First 1 -ExpandProperty browser_download_url

if (-not $downloadUrl) {
    Write-Host "Error: Could not find Windows 64-bit download URL" -ForegroundColor Red
    exit 1
}

Write-Host "Found version: $version" -ForegroundColor Cyan
Write-Host "Download URL: $downloadUrl" -ForegroundColor Cyan

# Download the zip file
$zipPath = "$tempDir\nvim-win64.zip"
Write-Host "Downloading to: $zipPath" -ForegroundColor Yellow
Invoke-WebRequest -Uri $downloadUrl -OutFile $zipPath

# Extract the zip file
Write-Host "Extracting Neovim..." -ForegroundColor Green
Expand-Archive -Path $zipPath -DestinationPath $tempDir -Force

# Move to final location
$extractedDir = Get-ChildItem -Path $tempDir -Directory | Where-Object { $_.Name -like "nvim-win64*" } | Select-Object -First 1
if ($extractedDir) {
    # Remove old installation if exists
    if (Test-Path $neovimDir) {
        Remove-Item -Path $neovimDir -Recurse -Force
    }
    Move-Item -Path $extractedDir.FullName -Destination $neovimDir
} else {
    Write-Host "Error: Could not find extracted directory" -ForegroundColor Red
    exit 1
}

# Clean up temp files
Remove-Item -Path $tempDir -Recurse -Force

Write-Host "`nNeovim $version installed successfully to: $neovimDir" -ForegroundColor Green

# Create batch file to run Neovim
$batchContent = @"
@echo off
"%USERPROFILE%\AppData\Local\nvim-portable\bin\nvim.exe" %*
"@
$batchPath = "$env:USERPROFILE\AppData\Local\nvim-portable\nvim.bat"
Set-Content -Path $batchPath -Value $batchContent

Write-Host "`nTo use the new Neovim version, add this to your user PATH:" -ForegroundColor Yellow
Write-Host "$env:USERPROFILE\AppData\Local\nvim-portable\bin" -ForegroundColor Cyan

Write-Host "`nOr use the full path to run Neovim:" -ForegroundColor Yellow
Write-Host "$env:USERPROFILE\AppData\Local\nvim-portable\bin\nvim.exe" -ForegroundColor Cyan

# Optionally update user PATH
$currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
$nvimPath = "$env:USERPROFILE\AppData\Local\nvim-portable\bin"

if ($currentPath -notlike "*$nvimPath*") {
    Write-Host "`nWould you like to add Neovim to your user PATH? (Y/N): " -ForegroundColor Yellow -NoNewline
    $response = Read-Host
    if ($response -eq 'Y' -or $response -eq 'y') {
        [Environment]::SetEnvironmentVariable("Path", "$currentPath;$nvimPath", "User")
        Write-Host "PATH updated. Please restart your terminal for changes to take effect." -ForegroundColor Green
    }
}