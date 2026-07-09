#define MyAppName "My Multi-Tool Suite"
#define MyAppVersion {#AppVersion}
#define MyAppPublisher "Your Name"
#define MyAppURL "https://yourwebsite.com"

[Setup]
; Standard Settings
AppVersion={#MyAppVersion}
AppName={#MyAppName}
DefaultDirName={autopf}\{#MyAppName}
DefaultGroupName={#MyAppName}
OutputDir=..
OutputBaseFilename=MyApp_Installer_{#AppVersion}
Compression=lzma
SolidCompression=yes
PrivilegesRequired=admin

; NO WizardStyle directive = Classic/Default Windows Look
; NO WizardImageFile = Default Windows Logo
; NO WizardSmallImageFile = Default Setup Icon

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
; Install ALL files from the source folder recursively
Source: "*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\main.exe"
Name: "{group}\Uninstall"; Filename: "{uninstallexe}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\main.exe"; Tasks: desktopicon
; Shortcuts for other file types
Name: "{group}\Open Dashboard (HTML)"; Filename: "{app}\dashboard.html"
Name: "{group}\Run Maintenance (Batch)"; Filename: "{app}\cleanup.bat"   
