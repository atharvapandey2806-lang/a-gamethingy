#define MyAppName "My Multi-Tool Suite"
#define MyAppVersion {#AppVersion}
#define MyAppPublisher "YTC"
#define MyAppURL "https://yourwebsite.com"

[Setup]
; Use the version passed from GitHub Actions
AppVersion={#MyAppVersion}
AppName={#MyAppName}
DefaultDirName={autopf}\{#MyAppName}
DefaultGroupName={#MyAppName}
OutputDir=..
OutputBaseFilename=MyApp_Installer_{#AppVersion}
Compression=lzma
SolidCompression=yes
; Require admin rights to install to Program Files and run scripts
PrivilegesRequired=admin

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
; Option to create a desktop icon for the main launcher
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
; SOURCE: Matches EVERYTHING in the installer_source folder recursively
; This includes your .exe, .bat, .ps1, .html, and assets folders
Source: "installer_source\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

; NOTE: If you have specific large files to exclude, add: Excludes: "*.pdb,*.zip"

[Icons]
; Start Menu Group
Name: "{group}\{#MyAppName}"; Filename: "{app}\main.exe"
Name: "{group}\Uninstall"; Filename: "{uninstallexe}"

; Desktop Icon (if selected in Tasks)
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\main.exe"; Tasks: desktopicon

; Optional: Create specific shortcuts for your HTML or Batch files
Name: "{group}\Open Dashboard (HTML)"; Filename: "{app}\dashboard.html"
Name: "{group}\Run Maintenance (Batch)"; Filename: "{app}\cleanup.bat"

[Run]
; Optional: Run a specific batch file immediately after installation
; Filename: "{app}\setup_config.bat"; Flags: runhidden

[UninstallDelete]
; Ensure clean uninstall of all file types
Type: filesandordirs; Name: "{app}"   
