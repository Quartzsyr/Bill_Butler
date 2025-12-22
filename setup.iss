[Setup]
; 基本应用信息
AppId={{A6B6C8F5-9E7B-4C9D-AF21-5D3E9A1C2B77}
AppName=Quartz发票账单助手
AppVersion=2.4.3
AppPublisher=石殷睿
AppPublisherURL=https://quartzsyr.github.io/photograph/

; 默认安装目录：D:\Qz_Billsorter\发票账单助手（显示名）
DefaultDirName={pf}\Quartz发票账单助手
DefaultGroupName=Quartz发票账单助手

DisableDirPage=no
DisableProgramGroupPage=no

; 输出安装包设置
OutputDir=Output
OutputBaseFilename=Qz发票账单生成
; 如有图标，可将 icon.ico 放在同级目录并取消下一行注释
SetupIconFile=.\logo.ico

Compression=lzma
SolidCompression=yes

; 需要管理员权限安装
PrivilegesRequired=admin

[Languages]
Name: "chinesesimp"; MessagesFile: "compiler:Default.isl"

[Tasks]
; 桌面快捷方式（默认不勾选）
Name: "desktopicon"; Description: "创建桌面快捷方式"; GroupDescription: "附加任务:"; Flags: unchecked

[Files]
; 假设你用 PyInstaller 打包，生成的文件在 dist 目录
; 先用命令（示例）：pyinstaller -F -w main.py
; 再用本安装脚本把 dist 目录整体打进安装包
Source: "dist\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
; 开始菜单快捷方式
Name: "{group}\发票账单助手"; Filename: "{app}\main.exe"
; 桌面快捷方式（按任务选择）
Name: "{commondesktop}\发票账单助手"; Filename: "{app}\main.exe"; Tasks: desktopicon

[Run]
; 安装完成后运行主程序
Filename: "{app}\main.exe"; Description: "运行 发票账单助手"; Flags: nowait postinstall skipifsilent

[Code]
// 安装前提示：简单介绍用途和安装建议
procedure InitializeWizard;
begin
  MsgBox(
    '欢迎安装“发票账单助手”！' #13#13 +
    '本软件用于辅助整理和初步识别发票、账单信息，' #13 +
    '方便进行分类、统计与简单核对。' #13#13 +
    '开发者：石殷睿 22电信',
    mbInformation, MB_OK
  );
end;

// 安装完成后弹出使用说明和免责声明
procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssPostInstall then
  begin
    MsgBox(
      '【使用说明】' #13#13 +
      '1. 本软件仅对票据/账单信息进行初步识别和整理，' #13 +
      '   识别结果可能存在错误、遗漏或不完整的情况；' #13 +
      '2. 请务必对软件输出结果进行人工复核，' #13 +
      '   不要将识别结果作为唯一依据进行财务或法律决策；' #13 +
      '3. 如遇到明显异常结果，建议重新导入数据或联系作者反馈。' #13#13 +
      '【重要提示】' #13 +
      '软件可能出错，仅供参考，请务必注意辨别结果。' #13#13 +
      '【免责声明】' #13 +
      '1. 本软件以“现状”提供，不对功能的准确性、完整性或适用性作出任何明示或默示担保；' #13 +
      '2. 因使用或无法使用本软件所产生的任何直接或间接损失，' #13 +
      '   由使用者自行承担，作者不对由此造成的后果承担任何责任；' #13 +
      '3. 安装和使用本软件即视为您已充分理解并同意本免责声明的全部内容。',
      mbInformation, MB_OK
    );
  end;
end;