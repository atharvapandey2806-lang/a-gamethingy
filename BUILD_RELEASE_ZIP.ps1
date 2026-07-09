#!/usr/bin/env pwsh
$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "Packaging GameBot release ZIP..." -ForegroundColor Cyan

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$dist = Join-Path $root "dist"
$staging = Join-Path $dist "gamebot-staging"
$zipPath = Join-Path $dist "gamebot-release.zip"

if (Test-Path $staging) { Remove-Item $staging -Recurse -Force }
New-Item -ItemType Directory -Path $staging -Force | Out-Null
New-Item -ItemType Directory -Path $dist -Force | Out-Null

$files = @(
    "launcher.py",
    "gamebot_multiplayer_server.py",
    "login.html",
    "signup.html",
    "dashboard.html",
    "master.html",
    "requirements.txt",
    ".env.example",
    "START_SERVER.bat",
    "START_SERVER.ps1",
    "README.md"
)

foreach ($file in $files) {
    $source = Join-Path $root $file
    if (Test-Path $source) {
        Copy-Item $source (Join-Path $staging $file)
    }
}

$staticSource = Join-Path $root "static"
if (Test-Path $staticSource) {
    Copy-Item $staticSource (Join-Path $staging "static") -Recurse
}

if (Test-Path $zipPath) { Remove-Item $zipPath -Force }
Compress-Archive -Path (Join-Path $staging "*") -DestinationPath $zipPath -Force
Remove-Item $staging -Recurse -Force

Write-Host "Created: $zipPath" -ForegroundColor Green
