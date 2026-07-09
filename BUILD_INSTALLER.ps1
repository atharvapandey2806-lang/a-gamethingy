#!/usr/bin/env pwsh
$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "Building GameBot Windows installer..." -ForegroundColor Cyan

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $root

& "$root\BUILD_EXE.ps1"
& "$root\BUILD_RELEASE_ZIP.ps1"

$isccCandidates = @(
    "${env:ProgramFiles(x86)}\Inno Setup 6\ISCC.exe",
    "$env:ProgramFiles\Inno Setup 6\ISCC.exe"
)

$iscc = $isccCandidates | Where-Object { Test-Path $_ } | Select-Object -First 1

if (-not $iscc) {
    Write-Host ""
    Write-Host "Inno Setup 6 not found." -ForegroundColor Yellow
    Write-Host "Install from https://jrsoftware.org/isinfo.php then run:" -ForegroundColor Yellow
    Write-Host "  iscc installer\gamebot.iss" -ForegroundColor White
    Write-Host ""
    Write-Host "Prepared artifacts:" -ForegroundColor Green
    Write-Host "  dist\GameBot.exe" -ForegroundColor Green
    Write-Host "  dist\gamebot-release.zip" -ForegroundColor Green
    exit 0
}

& $iscc "$root\installer\gamebot.iss"

Write-Host ""
Write-Host "Done: dist\installation-for-gamebot.exe" -ForegroundColor Green
