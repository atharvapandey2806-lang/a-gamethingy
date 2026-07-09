#!/usr/bin/env pwsh
$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "Building GameBot.exe..." -ForegroundColor Cyan

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $root

try {
    python --version | Out-Host
} catch {
    Write-Host "Python is not installed or not in PATH." -ForegroundColor Red
    exit 1
}

Write-Host "Installing runtime dependencies..." -ForegroundColor Yellow
python -m pip install -r requirements.txt pyinstaller

python -c "import jwt; assert hasattr(jwt, 'encode'), 'Wrong jwt package. Run: pip uninstall jwt -y && pip install PyJWT'"

$dataFiles = @(
    "gamebot_multiplayer_server.py;.",
    "master.html;.",
    "login.html;.",
    "signup.html;.",
    "dashboard.html;.",
    "requirements.txt;.",
    ".env.example;."
)

$hiddenImports = @(
    "bcrypt",
    "cryptography",
    "cryptography.fernet",
    "dotenv",
    "flask",
    "flask_cors",
    "flask_sqlalchemy",
    "jwt",
    "redis",
    "sqlalchemy"
)

$args = @(
    "--clean",
    "--noconsole",
    "--onefile",
    "--name", "GameBot"
)

foreach ($item in $dataFiles) {
    $args += "--add-data"
    $args += $item
}

$args += "--add-data"
$args += "static;static"

foreach ($item in $hiddenImports) {
    $args += "--hidden-import"
    $args += $item
}

$args += "launcher.py"

python -m PyInstaller @args

Write-Host ""
Write-Host "Done: dist\GameBot.exe" -ForegroundColor Green
