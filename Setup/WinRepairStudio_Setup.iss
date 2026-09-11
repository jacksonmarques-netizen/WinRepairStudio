; =====================================================================
; Inno Setup Script - WinRepair & Optimizer Studio
; Configuração para compilação do Instalador Automático (.EXE)
; Compatível com Inno Setup 6+ / Windows 10 e Windows 11 (x64)
; =====================================================================

#define MyAppName "WinRepair & Optimizer Studio"
#define MyAppVersion "1.0.0"
#define MyAppPublisher "WinRepair Studio Team"
#define MyAppExeName "WinRepairStudio.exe"
#define MyAppURL "https://github.com/jacksonmarques-netizen/WinRepairStudio"

[Setup]
AppId={{A8B9C1D2-E3F4-4567-8901-23456789ABCD}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\{#MyAppName}
DefaultGroupName={#MyAppName}
AllowNoIcons=yes
LicenseFile=LICENSE.txt
InfoBeforeFile=INSTALL_INFO.txt
OutputDir=bin\Installer
OutputBaseFilename=WinRepairStudio_Setup_x64
SetupIconFile=Setup\app.ico
Compression=lzma2/ultra64
SolidCompression=yes
WizardStyle=modern
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
PrivilegesRequired=admin
PrivilegesRequiredOverridesAllowed=dialog
MinVersion=10.0.17763
CloseApplications=no
ShowLanguageDialog=auto
UninstallDisplayIcon={app}\{#MyAppExeName}

[Languages]
Name: "brazilianportuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "portuguese"; MessagesFile: "compiler:Languages\Portuguese.isl"
Name: "spanish"; MessagesFile: "compiler:Languages\Spanish.isl"

[CustomMessages]
english.WelcomeTitle=Welcome to WinRepair & Optimizer Studio
english.WelcomeSubtitle=Professional Windows 10/11 Repair and Maintenance Tool
english.AdminRequired=Administrator privileges are required to install this application
english.DiskSpaceWarning=Not enough disk space. At least 500 MB required.

brazilianportuguese.WelcomeTitle=Bem-vindo ao WinRepair & Optimizer Studio
brazilianportuguese.WelcomeSubtitle=Ferramenta Profissional de Reparo e Manutenção do Windows 10/11
brazilianportuguese.AdminRequired=Privilégios de Administrador são necessários para instalar este aplicativo
brazilianportuguese.DiskSpaceWarning=Espaço em disco insuficiente. Mínimo de 500 MB necessário.

portuguese.WelcomeTitle=Bem-vindo ao WinRepair & Optimizer Studio
portuguese.WelcomeSubtitle=Ferramenta Profissional de Reparação e Manutenção do Windows 10/11
portuguese.AdminRequired=Privilégios de Administrador são necessários para instalar este aplicativo
portuguese.DiskSpaceWarning=Espaço em disco insuficiente. Mínimo de 500 MB necessário.

spanish.WelcomeTitle=Bienvenido a WinRepair & Optimizer Studio
spanish.WelcomeSubtitle=Herramienta Profesional de Reparación y Mantenimiento de Windows 10/11
spanish.AdminRequired=Se requieren privilegios de Administrador para instalar esta aplicación
spanish.DiskSpaceWarning=Espacio en disco insuficiente. Se requieren mínimo 500 MB.

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "quicklaunch"; Description: "Create Quick Launch icon"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "runonstartup"; Description: "Run on Windows Startup (Optional)"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "bin\Release\net8.0-windows10.0.22621.0\win-x64\publish\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "LICENSE.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "INSTALL_INFO.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "Setup\app.ico"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; IconFilename: "{app}\app.ico"; Comment: "Launch {#MyAppName}"; Flags: runascurrentuser
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; IconFilename: "{app}\app.ico"; Tasks: desktopicon; Flags: runascurrentuser
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; IconFilename: "{app}\app.ico"; Tasks: quicklaunch; Flags: runascurrentuser

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "Launch {#MyAppName} now"; Flags: nowait postinstall skipifsilent runascurrentuser
Filename: "explorer.exe"; Parameters: "{app}"; Description: "Open installation folder"; Flags: nowait skipifsilent

[UninstallDelete]
Type: dirifempty; Name: "{app}"
Type: dirifempty; Name: "{group}"
Type: files; Name: "{commonappdata}\WinRepairStudio\Logs\*"
Type: dirifempty; Name: "{commonappdata}\WinRepairStudio\Logs"

[Registry]
Root: HKLM; Subkey: "Software\Microsoft\Windows\CurrentVersion\Uninstall\{#SetupSetting('AppId')}"; ValueType: string; ValueName: "DisplayName"; ValueData: "{#MyAppName}"; Flags: uninsdeletekey
Root: HKLM; Subkey: "Software\Microsoft\Windows\CurrentVersion\Uninstall\{#SetupSetting('AppId')}"; ValueType: string; ValueName: "DisplayVersion"; ValueData: "{#MyAppVersion}"
Root: HKLM; Subkey: "Software\Microsoft\Windows\CurrentVersion\Uninstall\{#SetupSetting('AppId')}"; ValueType: string; ValueName: "Publisher"; ValueData: "{#MyAppPublisher}"
Root: HKLM; Subkey: "Software\Microsoft\Windows\CurrentVersion\Uninstall\{#SetupSetting('AppId')}"; ValueType: string; ValueName: "URLInfoAbout"; ValueData: "{#MyAppURL}"
Root: HKCU; Subkey: "Software\WinRepairStudio"; ValueType: string; ValueName: "InstallPath"; ValueData: "{app}"; Flags: createvalueifdoesntexist
Root: HKCU; Subkey: "Software\WinRepairStudio"; ValueType: string; ValueName: "Version"; ValueData: "{#MyAppVersion}"; Flags: createvalueifdoesntexist

[Code]
var
  AdminCheckPage: TOutputMsgMemoWizardPage;

function IsAdminLoggedOn: Boolean;
var
  ResultCode: Integer;
begin
  Result := ShellExec('', 'cmd.exe', '/c whoami /groups | find "S-1-5-32-544" > nul', '', SW_HIDE, ewWaitUntilTerminated, ResultCode) and (ResultCode = 0);
end;

procedure InitializeWizard;
var
  AdminMsg: String;
begin
  if not IsAdminLoggedOn then
  begin
    AdminCheckPage := CreateOutputMsgMemoWizardPage(
      wpWelcome,
      'Administrator Privileges Required',
      'Important System Requirements',
      'WinRepair & Optimizer Studio requires the following:' + #13#10 + #13#10 +
      '✓ Windows 10 (Build 17763) or Windows 11' + #13#10 +
      '✓ Administrator (Run as Administrator)' + #13#10 +
      '✓ .NET Runtime 8.0 or Higher' + #13#10 +
      '✓ At least 500 MB free disk space' + #13#10 +
      '✓ Active internet connection (optional)' + #13#10 + #13#10 +
      'This tool will create System Restore Points before' + #13#10 +
      'performing critical repairs. No data is deleted without' + #13#10 +
      'explicit user confirmation.',
      '');
    
    MsgBox('This installer requires Administrator privileges.' + #13#10#13#10 +
           'Please close this installer and run it again as Administrator.' + #13#10 +
           '(Right-click the setup file > Run as Administrator)',
           'Administrator Required',
           MB_ICONEXCLAMATION);
  end;
end;

function PrepareToInstall(var NeedsRestart: Boolean): String;
begin
  { Check minimum disk space (500 MB) }
  if DiskSpaceFree(WizardDirValue) < 524288000 then
  begin
    Result := 'Not enough disk space available. At least 500 MB required.' + #13#10 +
              'Current free space: ' + IntToStr(DiskSpaceFree(WizardDirValue) div 1024 div 1024) + ' MB';
    NeedsRestart := False;
  end;
  
  Result := '';
  NeedsRestart := False;
end;

function NextButtonClick(CurPageID: Integer): Boolean;
begin
  Result := True;
  
  { Validate installation path }
  if CurPageID = wpSelectDir then
  begin
    if Pos('System32', WizardDirValue) > 0 then
    begin
      MsgBox('Cannot install in System32 directory. Please choose another location.',
             'Invalid Installation Path',
             MB_ICONERROR);
      Result := False;
    end;
  end;
end;

procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
var
  LogPath: String;
begin
  if CurUninstallStep = usPostUninstall then
  begin
    LogPath := ExpandConstant('{commonappdata}\WinRepairStudio');
    
    { Optional: Prompt to delete logs }
    if DirExists(LogPath) then
    begin
      if MsgBox('Delete application logs and cached data?' + #13#10#13#10 +
                'This cannot be undone.',
                'Cleanup on Uninstall',
                MB_YESNO or MB_ICONQUESTION) = IDYES then
      begin
        DelTree(LogPath, True, True, True);
      end;
    end;
  end;
end;
