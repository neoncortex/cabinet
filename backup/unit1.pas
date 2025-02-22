unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, FileCtrl,
  StdCtrls, Menus, ExtCtrls, StrUtils, FileUtil, RegExpr, Clipbrd,
  Buttons, optionForm, recipes, tags, find, openFiles, processManager;

type

  { TForm1 }

  TForm1 = class(TForm)
    CommandStopButton: TButton;
    CopyFilePathLeftMenuItem: TMenuItem;
    CopyFilePathRightMenuItem: TMenuItem;
    FindMenuItem: TMenuItem;
    OpenWithRightMenuItem: TMenuItem;
    OpenWithLeftMenuItem: TMenuItem;
    TagsMenuItem: TMenuItem;
    RecipesMenuItem: TMenuItem;
    Separator9: TMenuItem;
    commandFreeTimer: TTimer;
    ToolsMenuItem: TMenuItem;
    RecipesButton: TButton;
    RightFilterCheck: TCheckBox;
    LeftFilterCheck: TCheckBox;
    LeftPathButton: TButton;
    FilterLeftButton: TButton;
    PreferencesMenuItem: TMenuItem;
    RightPathButton: TButton;
    RightPathEdit: TEdit;
    LeftPathEdit: TEdit;
    FilterRightEdit: TEdit;
    FilterRightButton: TButton;
    FilterLeftEdit: TEdit;
    EditRightButton: TButton;
    EditLeftButton: TButton;
    DeleteRightButton: TButton;
    DeleteLeftButton: TButton;
    DeleteLeftMenu: TMenuItem;
    EditLeftMenu: TMenuItem;
    CopyLeftMenuItem: TMenuItem;
    CopyLeftToRightMenuItem: TMenuItem;
    CopyRightMenuItem: TMenuItem;
    CopyRightToLeftMenuitem: TMenuItem;
    GoToLeftMenuItem: TMenuItem;
    GoToRightMenuItem: TMenuItem;
    CopyPathLeftMenuItem: TMenuItem;
    CopyPathRightMenuItem: TMenuItem;
    LinkLeftMenuItem: TMenuItem;
    LinkRightMenuItem: TMenuItem;
    RenameRightMenuItem: TMenuItem;
    RenameLeftMenuItem: TMenuItem;
    SelectDirectoryDialog1: TSelectDirectoryDialog;
    Separator7: TMenuItem;
    Separator8: TMenuItem;
    Splitter1: TSplitter;
    TerminalRightMenuItem: TMenuItem;
    TerminalLeftMenuItem: TMenuItem;
    OpenRightMenu: TMenuItem;
    DeleteRightMenu: TMenuItem;
    EditRightMenu: TMenuItem;
    MoveLeftRightMenu: TMenuItem;
    NewFileRightMenu: TMenuItem;
    NewDirectoryRightMenu: TMenuItem;
    Separator3: TMenuItem;
    Separator4: TMenuItem;
    Separator5: TMenuItem;
    Separator6: TMenuItem;
    UpdateRightMenu: TMenuItem;
    UpdateLeftMenu: TMenuItem;
    MoveRightLeftMenu: TMenuItem;
    OpenLeftMenu: TMenuItem;
    NewFileLeftMenu: TMenuItem;
    NewDirLeftMenu: TMenuItem;
    Separator1: TMenuItem;
    Separator2: TMenuItem;
    ShowHiddenRightMenu: TMenuItem;
    ViewMenuRight: TMenuItem;
    ShowHiddenLeftMenu: TMenuItem;
    OpenRightButton: TButton;
    OpenLeftButton: TButton;
    CommandClearButton: TButton;
    MoveLeftButton: TButton;
    MoveRightButton: TButton;
    CommandExecuteButton: TButton;
    FileBox1: TFileListBox;
    FileBox2: TFileListBox;
    FilesBox: TGroupBox;
    CommandBox: TGroupBox;
    RightFileBox: TGroupBox;
    LeftFileBox: TGroupBox;
    MainMenu: TMainMenu;
    CommandMemo: TMemo;
    FileMenu: TMenuItem;
    FileMenuQuit: TMenuItem;
    MainSplitter: TSplitter;
    ViewMenuLeft: TMenuItem;
    procedure CommandStopButtonClick(Sender: TObject);
    procedure CommandClearButtonClick(Sender: TObject);
    procedure CommandExecuteButtonClick(Sender: TObject);
    procedure CopyFilePathLeftMenuItemClick(Sender: TObject);
    procedure CopyFilePathRightMenuItemClick(Sender: TObject);
    procedure CopyLeftMenuItemClick(Sender: TObject);
    procedure CopyLeftToRightMenuItemClick(Sender: TObject);
    procedure CopyPathLeftMenuItemClick(Sender: TObject);
    procedure CopyPathRightMenuItemClick(Sender: TObject);
    procedure CopyRightMenuItemClick(Sender: TObject);
    procedure CopyRightToLeftMenuitemClick(Sender: TObject);
    procedure DeleteLeftButtonClick(Sender: TObject);
    procedure DeleteLeftMenuClick(Sender: TObject);
    procedure DeleteRightButtonClick(Sender: TObject);
    procedure DeleteRightMenuClick(Sender: TObject);
    procedure EditLeftButtonClick(Sender: TObject);
    procedure EditLeftMenuClick(Sender: TObject);
    procedure EditRightButtonClick(Sender: TObject);
    procedure EditRightMenuClick(Sender: TObject);
    procedure FileBox1DblClick(Sender: TObject);
    procedure FileBox1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure FileBox2DblClick(Sender: TObject);
    procedure FileBox2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure FileMenuQuitClick(Sender: TObject);
    procedure FilterLeftButtonClick(Sender: TObject);
    procedure FilterLeftEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FilterRightButtonClick(Sender: TObject);
    procedure FilterRightEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FindMenuItemClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GoToLeftMenuItemClick(Sender: TObject);
    procedure GoToRightMenuItemClick(Sender: TObject);
    procedure LeftPathButtonClick(Sender: TObject);
    procedure LeftPathEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LinkLeftMenuItemClick(Sender: TObject);
    procedure LinkRightMenuItemClick(Sender: TObject);
    procedure MoveLeftButtonClick(Sender: TObject);
    procedure MoveLeftRightMenuClick(Sender: TObject);
    procedure MoveRightButtonClick(Sender: TObject);
    procedure MoveRightLeftMenuClick(Sender: TObject);
    procedure NewDirectoryRightMenuClick(Sender: TObject);
    procedure NewDirLeftMenuClick(Sender: TObject);
    procedure NewFileLeftMenuClick(Sender: TObject);
    procedure NewFileRightMenuClick(Sender: TObject);
    procedure OpenLeftButtonClick(Sender: TObject);
    procedure OpenLeftMenuClick(Sender: TObject);
    procedure OpenRightButtonClick(Sender: TObject);
    procedure OpenRightMenuClick(Sender: TObject);
    procedure OpenWithLeftMenuItemClick(Sender: TObject);
    procedure OpenWithRightMenuItemClick(Sender: TObject);
    procedure PreferencesMenuItemClick(Sender: TObject);
    procedure RecipesButtonClick(Sender: TObject);
    procedure RecipesMenuItemClick(Sender: TObject);
    procedure RenameLeftMenuItemClick(Sender: TObject);
    procedure RenameRightMenuItemClick(Sender: TObject);
    procedure RightPathButtonClick(Sender: TObject);
    procedure RightPathEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ShowHiddenLeftMenuClick(Sender: TObject);
    procedure ShowHiddenRightMenuClick(Sender: TObject);
    function GetDirectoryName(box: integer): ansistring;
    procedure TagsMenuItemClick(Sender: TObject);
    procedure commandFreeTimerTimer(Sender: TObject);
    function UnpackDirName(dirName: ansistring): ansistring;
    procedure OpenDirectories(box: integer);
    procedure DeleteFiles(box: integer);
    procedure ManipulateFiles(box: integer; what: ansistring);
    procedure DynamicManipulateFiles(box: integer; what: ansistring);
    procedure DoubleClickFiles(box: integer);
    procedure setHidden(box: integer);
    procedure CreateNewDirectory(box: integer);
    procedure CreateNewFile(box: integer);
    procedure TerminalLeftMenuItemClick(Sender: TObject);
    procedure TerminalRightMenuItemClick(Sender: TObject);
    procedure UpdateLeftMenuClick(Sender: TObject);
    procedure UpdateRightMenuClick(Sender: TObject);
    procedure CopyFilePath(box: TFileListBox);
    procedure ReadConfig;
    procedure SetAppearance;
  private

  public

  end;

var
  Form1: TForm1;
  cabinetDirectory: ansistring;
  configFile: ansistring;
  recipesDir: ansistring;
  tagsDir: ansistring;
  commandScript: ansistring;
  defaultEditor: ansistring;
  fileCommand: ansistring;
  patterns: TStringList;
  terminalEmulator: ansistring;
  homeDir: ansistring;
  FileBox1ShowHidden: Boolean;
  FileBox2ShowHidden: Boolean;
  processList: TList;
  commandList: TList;

  // appearance
  defaultLeftFont: ansistring;
  defaultLeftFontSize: integer;
  defaultLeftForeground: TColor;
  defaultRightFont: ansistring;
  defaultRightfontSize: integer;
  defaultRightForeground: TColor;
  defaultCommandFont: ansistring;
  defaultCommandFontSize: integer;
  defaultCommandBackground: TColor;
  defaultCommandForeground: TColor;

  // tag dialog appearance
  tagCacheFont: ansistring;
  tagCacheFontSize: integer;
  tagCacheForegroundColor: TColor;
  tagSearchTagListFont: ansistring;
  tagSearchTagListFontSize: integer;
  tagSearchTagListForegroundColor: TColor;
  tagSearchResultFont: ansistring;
  tagSearchResultFontSize: integer;
  tagSearchResultForegroundColor: TColor;
  tagContentFont: ansistring;
  tagContentFontSize: integer;
  tagContentBackgroundColor: TColor;
  tagContentForegroundColor: TColor;

  // find dialog appearance
  findForeground: TColor;
  findFont: ansistring;
  findFontSize: integer;

  // recipes dialog appearance
  recipesListFont: ansistring;
  recipesListFontSize: integer;
  recipesListForeground: TColor;
  recipesTextFont: ansistring;
  recipesTextFontSize: integer;
  recipesTextForeground: TColor;
  recipesTextBackground: TColor;
implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var
  filep: textFile;
begin
  FileBox1ShowHidden := True;
  FileBox2ShowHidden := True;
  homeDir := getEnvironmentVariable('HOME');
  FileBox1.Directory := homeDir;
  FileBox2.Directory := homeDir;
  if paramStr(1) <> '' Then
    FileBox1.Directory := paramStr(1);

  if paramStr(2) <> '' Then
    FileBox2.Directory := paramStr(2);

  LeftPathEdit.Text := ExpandFileName(FileBox1.Directory);
  RightPathEdit.Text := ExpandFileName(FileBox2.Directory);

  // appearance
  defaultLeftFont := FileBox1.Font.Name;
  defaultLeftFontSize := FileBox1.Font.Size;
  defaultLeftForeground := FileBox1.Font.Color;
  defaultRightFont := FileBox2.Font.Name;
  defaultRightfontSize := FileBox2.Font.Size;
  defaultRightForeground := FileBox2.Font.Color;
  defaultCommandFont := commandMemo.Font.Name;
  defaultCommandFontSize := commandMemo.Font.Size;
  defaultCommandForeground := commandMemo.Font.Color;
  defaultCommandBackground := commandMemo.Color;
  setAppearance;

  // files
  cabinetDirectory := homeDir + directorySeparator + '.cabinet';
  recipesDir := cabinetDirectory + directorySeparator + 'recipes';
  configFile := cabinetDirectory + directorySeparator + 'config.cfg';
  tagsDir := cabinetDirectory + directorySeparator + 'tags';
  defaultEditor := 'gvim "%s"';
  fileCommand := 'xdg-open "%s"';
  terminalEmulator := 'xterm';
  patterns := TStringList.Create;

  // external processes
  processList := TList.Create;
  commandList := TList.Create;
  commandFreeTimer.Enabled := True;

  if not DirectoryExists(cabinetDirectory) Then
    CreateDir(cabinetDirectory);

  if DirectoryExists(cabinetDirectory) Then
  begin
    commandScript := cabinetDirectory + directorySeparator + 'command.sh';
    if not DirectoryExists(recipesDir) Then
      CreateDir(recipesDir);

    if not DirectoryExists(tagsDir) Then
      CreateDir(tagsDir);

    if not FileExists(configFile) Then
    begin
      assignFile(filep, configFile);
      rewrite(filep);
      writeln(filep, 'file-command :::: ' + fileCommand);
      writeln(filep, 'default-editor :::: ' + defaultEditor);
      writeln(filep, 'terminal-emulator :::: ' + terminalEmulator);
      closeFile(filep);
    end;

    readConfig;
  end
  else
    ShowMessage('Unable to create ' + cabinetDirectory + ' directory');

end;

procedure TForm1.SetAppearance;
begin
  // appearance
  FileBox1.Font.Color := defaultLeftForeground;
  FileBox1.Font.Name := defaultLeftFont;
  FileBox1.Font.Size := defaultLeftFontSize;
  FileBox2.Font.Color := defaultRightForeground;
  FileBox2.Font.Name := defaultRightFont;
  FileBox2.Font.Size := defaultRightFontSize;
  commandMemo.Font.Name := defaultCommandFont;
  commandMemo.Font.Size := defaultCommandFontSize;
  commandMemo.Color := defaultCommandBackground;
  commandMemo.Font.Color := defaultCommandForeground;

  // tag dialog appearance
  tagCacheFont := defaultLeftFont;
  tagCacheFontSize := defaultLeftFontSize;
  tagCacheForegroundColor := defaultLeftForeground;
  tagSearchTagListFont := defaultLeftFont;
  tagSearchTagListFontSize := defaultLeftFontSize;
  tagSearchTagListForegroundColor := defaultLeftForeground;
  tagSearchResultFont := defaultLeftFont;
  tagSearchResultFontSize := defaultLeftFontSize;
  tagSearchResultForegroundColor := defaultLeftForeground;
  tagContentFont := defaultLeftFont;
  tagContentFontSize := defaultLeftFontSize;
  tagContentBackgroundColor := defaultCommandBackground;
  tagContentForegroundColor := defaultCommandForeground;

  // find dialog appearance
  findForeground := defaultLeftForeground;
  findFont := defaultLeftFont;
  findFontSize := defaultLeftFontSize;

  // recipes dialog appearance
  recipesListFont := defaultLeftFont;
  recipesListFontSize := defaultLeftFontSize;
  recipesListForeground := defaultLeftForeground;
  recipesTextFont := defaultLeftFont;
  recipesTextFontSize := defaultLeftFontSize;
  recipesTextForeground := defaultLeftForeground;
  recipesTextBackground := defaultCommandBackground;
end;

procedure TForm1.ReadConfig;
var
  filep: textFile;
  regex: TRegExpr;
  res: array of ansistring;
  s: ansistring;
begin
  if FileExists(configFile) Then
  begin
    setAppearance;
    patterns.Clear;
    assignFile(filep, configFile);
    reset(filep);
    regex := TRegExpr.Create;
    while not eof(filep) do
    begin
      readln(filep, s);
      regex.Expression := '^file-command ::::';
      if regex.exec(s) Then
      begin
        res := SplitString(s, ' :::: ');
        if res[1] <> '' Then
        begin
          fileCommand := res[1];
          continue;
        end;
      end;

      regex.Expression := '^default-editor ::::';
      if regex.exec(s) Then
      begin
        res := SplitString(s, ' :::: ');
        if res[1] <> '' Then
        begin
          defaultEditor := res[1];
          continue;
        end;
      end;

      regex.Expression := '^terminal-emulator ::::';
      if regex.exec(s) Then
      begin
        res := SplitString(s, ' :::: ');
        if res[1] <> '' Then
        begin
          terminalEmulator := res[1];
          continue;
        end;
      end;

      regex.Expression := '^left-foreground ::::';
      if regex.exec(s) Then
      begin
        res := SplitString(s, ' :::: ');
        if res[1] <> '' Then
        begin
          FileBox1.Font.Color := StrToInt(res[1]);
          continue;
        end;
      end;

      regex.Expression := '^right-foreground ::::';
      if regex.exec(s) Then
      begin
        res := SplitString(s, ' :::: ');
        if res[1] <> '' Then
        begin
          FileBox2.Font.Color := StrToInt(res[1]);
          continue;
        end;
      end;
 
      regex.Expression := '^left-font ::::';
      if regex.exec(s) Then
      begin
        res := SplitString(s, ' :::: ');
        if res[1] <> '' Then
        begin
          FileBox1.Font.Name := res[1];
          FileBox1.Font.Size := StrToInt(res[2]);
          continue;
        end;
      end;

      regex.Expression := '^right-font ::::';
      if regex.exec(s) Then
      begin
        res := SplitString(s, ' :::: ');
        if res[1] <> '' Then
        begin
          FileBox2.Font.Name := res[1];
          FileBox2.Font.Size := StrToInt(res[2]);
          continue;
        end;
      end;

      regex.Expression := '^command-background ::::';
      if regex.exec(s) Then
      begin
        res := SplitString(s, ' :::: ');
        if res[1] <> '' Then
        begin
          CommandMemo.Color := StrToInt(res[1]);
          continue;
        end;
      end;

      regex.Expression := '^command-foreground ::::';
      if regex.exec(s) Then
      begin
        res := SplitString(s, ' :::: ');
        if res[1] <> '' Then
        begin
          CommandMemo.Font.Color := StrToInt(res[1]);
          continue;
        end;
      end;

      regex.Expression := '^command-font ::::';
      if regex.exec(s) Then
      begin
        res := SplitString(s, ' :::: ');
        if res[1] <> '' Then
        begin
          CommandMemo.Font.Name := res[1];
          CommandMemo.Font.Size := StrToInt(res[2]);
          continue;
        end;
      end;

      regex.Expression := '^find-foreground ::::';
      if regex.exec(s) Then
      begin
        res := SplitString(s, ' :::: ');
        if res[1] <> '' Then
        begin
          findForeground := StrToInt(res[1]);
          continue;
        end;
      end;

      regex.Expression := '^find-font ::::';
      if regex.exec(s) Then
      begin
        res := SplitString(s, ' :::: ');
        if res[1] <> '' Then
        begin
          findFont := res[1];
          findFontSize := StrToInt(res[2]);
          continue;
        end;
      end;

      regex.Expression := '^tag-cache-foreground :::: .*';
      if regex.Exec(s) Then
      begin
        res := SplitString(s, ' :::: ');
        if res[1] <> '' Then
        begin
          tagCacheForeGroundColor := StrToInt(res[1]);
          continue;
        end;
      end;

      regex.Expression := '^tag-cache-font :::: .*';
      if regex.Exec(s) Then
      begin
        res := SplitString(s, ' :::: ');
        if res[1] <> '' Then
        begin
          tagCacheFont := res[1];
          tagCacheFontSize := StrToInt(res[2]);
          continue;
        end;
      end;

      regex.Expression := '^tag-search-foreground :::: .*';
      if regex.Exec(s) Then
      begin
        res := SplitString(s, ' :::: ');
        if res[1] <> '' Then
        begin
          tagSearchResultForegroundColor := StrToInt(res[1]);
          continue;
        end;
      end;

      regex.Expression := '^tag-search-font :::: .*';
      if regex.Exec(s) Then
      begin
        res := SplitString(s, ' :::: ');
        if res[1] <> '' Then
        begin
          tagSearchResultFont := res[1];
          continue;
        end;
      end;

      regex.Expression := '^tag-content-foreground :::: .*';
      if regex.Exec(s) Then
      begin
        res := SplitString(s, ' :::: ');
        if res[1] <> '' Then
        begin
          tagContentForegroundColor := StrToInt(res[1]);
          continue;
        end;
      end;

      regex.Expression := '^tag-content-background :::: .*';
      if regex.Exec(s) Then
      begin
        res := SplitString(s, ' :::: ');
        if res[1] <> '' Then
        begin
          tagContentBackgroundColor := StrToInt(res[1]);
          continue;
        end;
      end;

      regex.Expression := '^tag-content-font :::: .*';
      if regex.Exec(s) Then
      begin
        res := SplitString(s, ' :::: ');
        if res[1] <> '' Then
        begin
          tagContentFont := res[1];
          tagContentFontSize := StrToInt(res[2]);
          continue;
        end;
      end;

      regex.Expression := '^recipes-list-foreground :::: .*';
      if regex.Exec(s) Then
      begin
        res := SplitString(s, ' :::: ');
        if res[1] <> '' Then
        begin
          recipesListForeground := StrToInt(res[1]);
          continue;
        end;
      end;

      regex.Expression := '^recipes-list-font :::: .*';
      if regex.Exec(s) Then
      begin
        res := SplitString(s, ' :::: ');
        if res[1] <> '' Then
        begin
          recipesListFont := res[1];
          recipesListFontSize := StrToInt(res[2]);
          continue;
        end;
      end;

      regex.Expression := '^recipes-text-foreground :::: .*';
      if regex.Exec(s) Then
      begin
        res := SplitString(s, ' :::: ');
        if res[1] <> '' Then
        begin
          recipesTextForeground := StrToInt(res[1]);
          continue;
        end;
      end;

      regex.Expression := '^recipes-text-background :::: .*';
      if regex.Exec(s) Then
      begin
        res := SplitString(s, ' :::: ');
        if res[1] <> '' Then
        begin
          recipesTextBackground := StrToInt(res[1]);
          continue;
        end;
      end;

      regex.Expression := '^recipes-text-font :::: .*';
      if regex.Exec(s) Then
      begin
        res := SplitString(s, ' :::: ');
        if res[1] <> '' Then
        begin
          recipesTextFont := res[1];
          recipesTextFontSize := StrToInt(res[2]);
          continue;
        end;
      end;

      regex.Expression := '^pattern ::::';
      if regex.exec(s) Then
        patterns.Append(s);
    end;

    regex.Free;
    closeFile(filep);
  end;
end;

procedure TForm1.GoToLeftMenuItemClick(Sender: TObject);
begin
  if SelectDirectoryDialog1.Execute Then
    FileBox1.Directory := SelectDirectoryDialog1.FileName;
end;

procedure TForm1.GoToRightMenuItemClick(Sender: TObject);
begin
  if SelectDirectoryDialog1.Execute Then
    FileBox2.Directory := SelectDirectoryDialog1.FileName;
end;

procedure TForm1.LeftPathButtonClick(Sender: TObject);
begin
  if DirectoryExists(LeftPathEdit.Text) Then
    FileBox1.Directory := LeftPathEdit.Text;
end;

procedure TForm1.LeftPathEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 13 Then
    LeftPathButtonClick(nil);
end;

procedure TForm1.LinkLeftMenuItemClick(Sender: TObject);
begin
  DynamicManipulateFiles(1, 'link');
end;

procedure TForm1.LinkRightMenuItemClick(Sender: TObject);
begin
  DynamicManipulateFiles(2, 'link');
end;

function TForm1.UnpackDirName(dirName: ansistring): ansistring;
begin
  UnpackDirName :=  Copy(dirName, 2, (length(dirName)-2));
end;

function TForm1.GetDirectoryName(box: integer): ansistring;
var
  boxDir: ansistring;
  directoryName: ansistring;
  files: ansistring;
begin
  if box = 1 Then
  begin
    boxDir := FileBox1.Directory;
    files := FileBox1.GetSelectedText;
  end
  else
  begin
    boxDir := FileBox2.Directory;
    files := FileBox2.GetSelectedText;
  end;

  directoryName := UnpackDirName(files);
  GetDirectoryName := ExpandFileName(boxDir + DirectorySeparator + directoryName);
end;

procedure TForm1.TagsMenuItemClick(Sender: TObject);
begin
  Form4 := TForm4.Create(nil);
  Form4.SetConfigDir(cabinetDirectory);
  Form4.SetTagsDir(tagsDir);
  Form4.SetFileBox1(FileBox1);
  Form4.SetFileBox2(FileBox2);
  Form4.SetLeftPathEdit(LeftPathEdit);
  Form4.SetRightPathEdit(RightPathEdit);
  Form4.SetCacheListFont(tagCacheFont);
  Form4.SetCacheListFontSize(tagCacheFontSize);
  Form4.SetCacheListForeground(tagCacheForegroundColor);
  Form4.SetSearchResultFont(tagSearchResultfont);
  Form4.SetSearchResultFontSize(tagSearchResultFontSize);
  Form4.SetSearchResultForeground(tagSearchResultForegroundColor);
  Form4.SetContentFont(tagContentFont);
  Form4.SetContentFontSize(tagContentFontSize);
  Form4.SetContentForeground(tagContentForegroundColor);
  Form4.SetContentBackground(tagContentBackgroundColor);
  Form4.Show;
end;

procedure TForm1.commandFreeTimerTimer(Sender: TObject);
begin
  processFree(processList);
  processFree(commandList);
end;

procedure TForm1.OpenDirectories(box: integer);
var
  directoryName: ansistring;
begin
  directoryName := getDirectoryName(box);
  if DirectoryExists(directoryName) Then
  begin
    if box = 1 Then
    begin
      FileBox1.Directory := directoryName;
      LeftPathEdit.Text := directoryName;
    end
    else
    begin
      Filebox2.Directory := directoryName;
      RightPathEdit.Text := directoryName;
    end;
  end;
end;

procedure TForm1.DeleteFiles(box: integer);
var
  fbox: TFileListBox;
  boxDir: ansistring;
  directoryName: ansistring;
  fileName: ansistring;
  files: ansistring;
  regex: TRegExpr;
  s: ansistring;
begin
  if box = 1 Then
  begin
    fbox := FileBox1;
  end
  else
    fbox := FileBox2;

  boxDir := fbox.Directory;
  files := fbox.GetSelectedText;
  regex := TRegExpr.Create;
  for s in SplitString(files, LineEnding) do
  begin
    regex.Expression := '^\[.*\]';
    if regex.exec(files) Then
    begin
      directoryName := getDirectoryName(box);
      if DirectoryExists(directoryName) Then
      begin
        if not DeleteDirectory(directoryName, False) Then
          ShowMessage('Cannot delete directory: ' + directoryName);
      end;
    end
    else
    begin
      fileName := boxDir + DirectorySeparator + s;
      if FileExists(fileName) Then
      begin
        if not DeleteFile(fileName) Then
          ShowMessage('Cannot delete file: ' + fileName);
      end;
    end;
  end;

  fbox.UpdateFileList;
  regex.Free;
end;

procedure TForm1.DynamicManipulateFiles(box: integer; what: ansistring);
var
  commandLine: ansistring;
  dialogRes: boolean;
  directoryName: ansistring;
  directoryNewPath: ansistring;
  directoryPath: ansistring;
  fbox: TFileListBox;
  fileName: ansistring;
  fileNewName: ansistring;
  newName: ansistring;
  regex: TRegExpr;
  s: ansistring;
  selection: ansistring;
begin
  if box = 1 Then
  begin
    fbox := FileBox1;
  end
  else
    fbox := FileBox2;

  if what = 'rename' Then
    dialogRes := InputQuery(what, 'Type the new file name', False, newName);

  if ((what = 'copy') or (what = 'link')) Then
  begin
    dialogRes := InputQuery(what, 'Type the path', False, newName);
    if dialogRes Then
    begin
      regex := TRegExpr.Create;
      regex.Expression := '^\/';
      if not regex.Exec(newName) Then
      begin
        newName := fbox.Directory + directorySeparator + newName;
      end;
    end;
  end;

  if dialogRes Then
  begin
    selection := fbox.GetSelectedText;
    regex := TRegExpr.Create;
    regex.Expression := '^\[.*\]';
    for s in SplitString(selection, lineEnding) do
    begin
      if regex.exec(s) Then
      begin
        directoryName := UnpackDirName(s);
        directoryPath := fbox.Directory + directorySeparator + directoryName;
        directoryNewPath := fbox.Directory + directorySeparator + newName;
        if what = 'rename' Then
        begin
          if DirectoryExists(directoryPath) Then
          begin
            if not RenameFile(directoryPath, directoryNewPath) Then
              ShowMessage('Cannot rename file: ' + directoryPath);
          end;
        end;

        if what = 'copy' Then
        begin
          CreateDir(newName);
          if DirectoryExists(newName) Then
          begin
            if not CopyDirTree(directoryPath, newName) Then
              ShowMessage('Errors while copying' + directoryPath);
          end
          else
            ShowMessage('failed to create directory: ' + newName);
        end;

        if what = 'link' Then
        begin
          commandLine := 'bash -c'
            + ' "' + 'ln -s'
            + ' "' + directoryPath + '"'
            + ' "' + newName + '"'
            + '"';
          processExecute(commandLine, processList);
        end;
      end
      else
      begin
        fileName := fbox.Directory + directorySeparator + s;
        fileNewName := fbox.Directory + directorySeparator + newName;
        if what = 'rename' Then
        begin
          if FileExists(fileName) Then
          begin
            if not RenameFile(fileName, fileNewName) Then
              ShowMessage('Cannot rename file: ' + fileName);
          end;
        end;

        if what = 'copy' Then
        begin
          if not CopyFile(fileName, newName) Then
            ShowMessage('Cannot copy file: ' + fileName);
        end;

        if what = 'link' Then
        begin
          commandLine := 'bash -c'
            + ' "' + 'ln -s'
            + ' "' + fileName + '"'
            + ' "' + newName + '"'
            + '"';
          processExecute(commandLine, processList);
        end;
      end;
    end;

    regex.Free;
    fbox.UpdateFileList;
  end;
end;

procedure TForm1.DoubleClickFiles(box: integer);
var
  boxList: TFileListBox;
  files: ansistring;
  filter: TEdit;
  filterButton: TButton;
  keep: TCheckBox;
  regex: TRegExpr;
begin
  if box = 1 Then
  begin
    boxList := FileBox1;
    files := FileBox1.GetSelectedText;
    filter := FilterLeftEdit;
    filterButton := FilterLeftButton;
    keep := LeftFilterCheck;
  end
  else
  begin
    boxList := FileBox2;
    files := FileBox2.GetSelectedText;
    filter := FilterRightEdit;
    filterButton := FilterRightButton;
    keep := RightFilterCheck;
  end;

  regex := TRegExpr.Create;
  regex.Expression := '^\[.*\]';
  if regex.exec(files) Then
  begin
    OpenDirectories(box);
  end
  else
  begin
    OpenBoxFiles(boxList, fileCommand, patterns, processList);
  end;

  if not keep.Checked Then
  begin
    filter.Text := '';
    filterButton.Click;
  end;

  regex.Free;
end;

procedure TForm1.FileBox2DblClick(Sender: TObject);
begin
  DoubleClickFiles(2);
  RightPathEdit.Text := ExpandFileName(FileBox2.Directory);
end;

procedure TForm1.FileBox2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 13 Then
    DoubleClickFiles(2);
end;

procedure TForm1.FileMenuQuitClick(Sender: TObject);
begin
  Form1.Close;
end;

procedure TForm1.FilterLeftButtonClick(Sender: TObject);
begin
  if FilterLeftEdit.Text <> '' Then
  begin
    FileBox1.Mask := FilterLeftEdit.Text;
  end
  else
    FileBox1.Mask := '*';
end;

procedure TForm1.FilterLeftEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 13 Then
    FilterLeftButtonClick(nil);
end;

procedure TForm1.FilterRightButtonClick(Sender: TObject);
begin
  if FilterRightEdit.Text <> '' Then
  begin
    FileBox2.Mask := FilterRightEdit.Text;
  end
  else
    FileBox2.Mask := '*';
end;

procedure TForm1.FilterRightEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 13 Then
    FilterRightButtonClick(nil);
end;

procedure TForm1.FindMenuItemClick(Sender: TObject);
begin
  Form5 := TForm5.Create(nil);
  Form5.SetFileBox1(FileBox1);
  Form5.SetFileBox2(FileBox2);
  Form5.SetLeftPathEdit(LeftPathEdit);
  Form5.SetRightPathEdit(RightPathEdit);
  Form5.SetFileCommand(fileCommand);
  Form5.SetPatterns(patterns);
  Form5.SetProcessList(processList);
  Form5.SetForeground(findForeground);
  Form5.SetFont(findFont);
  Form5.SetFontSize(findFontSize);
  Form5.Show;
end;

procedure TForm1.ManipulateFiles(box: integer; what: ansistring);
var
  destDir: ansistring;
  directoryName: ansistring;
  directoryPath: ansistring;
  fbox: TFileListBox;
  fileName: ansistring;
  regex: TRegExpr;
  s: ansistring;
  sourceDir: ansistring;
  sourceFiles: ansistring;
begin
  if box = 1 Then
  begin
    fbox := FileBox2;
    destDir := FileBox2.Directory;
    sourceDir := FileBox1.Directory;
    sourceFiles := FileBox1.GetSelectedText;
  end
  else
  begin
    fbox := FileBox1;
    destDir := FileBox1.Directory;
    sourceDir := FileBox2.Directory;
    sourceFiles := FileBox2.GetSelectedText;
  end;

  regex := TRegExpr.Create;
  for s in SplitString(sourceFiles, LineEnding) do
  begin
    regex.Expression := '^\[.*\]$';
    if regex.exec(s) Then
    begin
      directoryName := UnpackDirName(s);
      directoryPath := sourceDir + directorySeparator + directoryName;
      if what = 'copy' Then
      begin
        CreateDir(destDir + directorySeparator + directoryName);
        if DirectoryExists(destDir + directorySeparator + directoryName) Then
        begin
          CopyDirTree(directoryPath, destDir + directorySeparator + directoryName);
          fbox.UpdateFileList;
        end
        else
          ShowMessage('failed to create directory: ' + destDir + directorySeparator
            + directoryName);

        continue;
      end;

      if what = 'move' Then
      begin
        if not CreateDir(destDir + directorySeparator + directoryName) Then
        begin
          ShowMessage('Cannot create directory: ' + destDir + directorySeparator + directoryName);
        end
        else
        begin
          CopyDirTree(directoryPath, destDir + directorySeparator + directoryName);
          DeleteDirectory(directoryPath, False);
          FileBox1.UpdateFileList;
          FileBox2.UpdateFileList;
          continue;
        end;
      end;
    end
    else
    begin
      fileName := sourceDir + directorySeparator + s;
      if what = 'copy' Then
      begin
        if not copyFile(fileName, destDir + directorySeparator + s) Then
        begin
          ShowMessage('Cannot copy file: ' + fileName);
        end
        else
          fbox.UpdateFileList;

        continue;
      end;

      if what = 'move' Then
      begin
        if not copyFile(fileName, destDir + directorySeparator + s) Then
        begin
          ShowMessage('Cannot move file: ' + fileName);
        end
        else
        begin
          DeleteFile(fileName);
          FileBox1.UpdateFileList;
          FileBox2.UpdateFileList;
        end;
      end;
    end;
  end;

  regex.Free;
end;

procedure TForm1.MoveLeftButtonClick(Sender: TObject);
begin
  ManipulateFiles(2, 'move');
end;

procedure TForm1.MoveLeftRightMenuClick(Sender: TObject);
begin
  ManipulateFiles(2, 'move');
end;

procedure TForm1.MoveRightButtonClick(Sender: TObject);
begin
  ManipulateFiles(1, 'move');
end;

procedure TForm1.MoveRightLeftMenuClick(Sender: TObject);
begin
  ManipulateFiles(1, 'move');
end;

procedure TForm1.NewDirectoryRightMenuClick(Sender: TObject);
begin
  CreateNewDirectory(2);
end;

procedure TForm1.CreateNewDirectory(box: integer);
var
  boxDir: ansistring;
  fbox: TFileListBox;
  newDirName: ansistring;
begin
  if box = 1 Then
  begin
    fbox := FileBox1;
  end
  else
  begin
    fbox := FileBox2;
  end;

  boxDir := fbox.Directory;
  if boxDir <> '' Then
  begin
    if InputQuery('New Directory', 'Type the new directory name', False, newDirName) Then
    begin
      if not CreateDir(boxDir + directorySeparator + newDirName) Then
      begin
        ShowMessage('Cannot create directory: ' + boxDir + directorySeparator + newDirName);
      end
      else
        fbox.UpdateFileList;
    end;
  end;
end;

procedure TForm1.CreateNewFile(box: integer);
var
  boxDir: ansistring;
  fbox: TFileListBox;
  newFile: ansistring;
  newFileFullPath: ansistring;
begin
  if box = 1 Then
  begin
    fbox := FileBox1;
  end
  else
  begin
    fbox := FileBox2;
  end;

  boxDir := fbox.Directory;
  if boxDir <> '' Then
  begin
    if InputQuery('New File', 'Type the new file name', False, newFile) Then
    begin
      newFileFullPath := boxDir + directorySeparator + newFile;
      FileCreate(newFileFullPath);
      if not FileExists(newFileFullPath) Then
      begin
        ShowMessage('Cannot Crete file: ' + newFileFullPath);
      end
      else
        fbox.UpdateFileList;
    end;
  end;
end;

procedure TForm1.TerminalLeftMenuItemClick(Sender: TObject);
var
  commandLine: ansistring;
begin
  commandLine := 'bash -c "cd "'
    + FileBox1.Directory + '";'
    + terminalEmulator + '"';
  processExecute(commandLine, processList);
end;

procedure TForm1.TerminalRightMenuItemClick(Sender: TObject);
var
  commandLine: ansistring;
begin
  commandLine := 'bash -c "cd "'
    + FileBox2.Directory + '";'
    + terminalEmulator + '"';
  processExecute(commandLine, processList);
end;

procedure TForm1.UpdateLeftMenuClick(Sender: TObject);
begin
  FileBox1.UpdateFileList;
end;

procedure TForm1.UpdateRightMenuClick(Sender: TObject);
begin
  FileBox2.UpdateFileList;
end;

procedure TForm1.NewDirLeftMenuClick(Sender: TObject);
begin
  CreateNewDirectory(1);
end;

procedure TForm1.NewFileLeftMenuClick(Sender: TObject);
begin
  CreateNewFile(1);
end;

procedure TForm1.NewFileRightMenuClick(Sender: TObject);
begin
 CreateNewFile(2);
end;

procedure TForm1.OpenLeftButtonClick(Sender: TObject);
begin
  OpenBoxFiles(FileBox1, fileCommand, patterns, processList);
end;

procedure TForm1.OpenLeftMenuClick(Sender: TObject);
begin
  OpenBoxFiles(FileBox1, fileCommand, patterns, processList);
end;

procedure TForm1.OpenRightButtonClick(Sender: TObject);
begin
  OpenBoxFiles(FileBox2, fileCommand, patterns, processList);
end;

procedure TForm1.OpenRightMenuClick(Sender: TObject);
begin
  OpenBoxFiles(FileBox2, fileCommand, patterns, processList);
end;

procedure TForm1.OpenWithLeftMenuItemClick(Sender: TObject);
begin
  OpenWith(FileBox1, processList);
end;

procedure TForm1.OpenWithRightMenuItemClick(Sender: TObject);
begin
  OpenWith(FileBox2, processList);
end;

procedure TForm1.PreferencesMenuItemClick(Sender: TObject);
begin
  Form2 := TForm2.Create(nil);
  Form2.setConfigFile(configFile);
  Form2.ShowModal;
  ReadConfig;
end;

procedure TForm1.RecipesButtonClick(Sender: TObject);
begin
  RecipesMenuItem.Click;
end;

procedure TForm1.RecipesMenuItemClick(Sender: TObject);
begin
  Form3 := TForm3.Create(nil);
  Form3.SetCommandMemo(CommandMemo);
  Form3.SetConfigDir(cabinetDirectory);
  Form3.SetListFont(recipesListFont);
  Form3.SetListFontSize(recipesListFontSize);
  Form3.SetListForeground(recipesListForeground);
  Form3.SetTextFont(recipesTextFont);
  Form3.SetTextFontSize(recipesTextFontSize);
  Form3.SetTextForeground(recipesTextForeground);
  Form3.SetTextBackground(recipesTextBackground);
  Form3.Show;
end;

procedure TForm1.RenameLeftMenuItemClick(Sender: TObject);
begin
  DynamicManipulateFiles(1, 'rename');
end;

procedure TForm1.RenameRightMenuItemClick(Sender: TObject);
begin
  DynamicManipulateFiles(2, 'rename');
end;

procedure TForm1.RightPathButtonClick(Sender: TObject);
begin
  if DirectoryExists(RightPathEdit.Text) Then
    FileBox2.Directory := RightPathEdit.Text;
end;

procedure TForm1.RightPathEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  RightPathButtonClick(nil);
end;

procedure TForm1.SetHidden(box: integer);
var
  fbox: TFileListBox;
  setting: ^Boolean;
begin
  if box = 1 Then
  begin
    fbox := FileBox1;
    setting := @FileBox1ShowHidden;
  end
  else
  begin
    fbox := FileBox2;
    setting := @fileBox2ShowHidden;
  end;

  if setting^ = True Then
  begin
    fbox.FileType:= [ftDirectory, ftNormal, ftReadOnly, ftSystem];
    setting^ := False;
  end
  else
  begin
    fbox.FileType:= [ftDirectory, ftHidden, ftNormal, ftReadOnly, ftSystem];
    setting^ := True;
  end;
end;

procedure TForm1.ShowHiddenLeftMenuClick(Sender: TObject);
begin
  setHidden(1);
end;

procedure TForm1.ShowHiddenRightMenuClick(Sender: TObject);
begin
  setHidden(2);
end;

procedure TForm1.FileBox1DblClick(Sender: TObject);
begin
  DoubleClickFiles(1);
  LeftPathEdit.Text := ExpandFileName(FileBox1.Directory);
end;

procedure TForm1.FileBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 13 Then
    DoubleClickFiles(1);
end;

procedure TForm1.DeleteLeftButtonClick(Sender: TObject);
begin
  DeleteFiles(1);
end;

procedure TForm1.DeleteLeftMenuClick(Sender: TObject);
begin
  DeleteFiles(1);
end;

procedure TForm1.CommandClearButtonClick(Sender: TObject);
begin
  CommandMemo.Clear;
end;

procedure TForm1.CommandExecuteButtonClick(Sender: TObject);
var
  selectionLeft: ansistring;
  selectionRight: ansistring;
  commandLine: ansistring;
begin
  selectionLeft := FileBox1.GetSelectedText;
  if selectionLeft = '' Then
    selectionLeft := 'noSelection';

  selectionRight := FileBox2.GetSelectedText;
  if selectionRight = '' Then
    selectionRight := 'noSelection';

  CommandMemo.Lines.SaveToFile(commandScript);
  commandLine := 'bash'
    + ' "' + commandScript + '"'
    + ' "' + ExpandFileName(FileBox1.Directory) + '"'
    + ' "' + ExpandFileName(FileBox2.Directory) + '"'
    + ' "' + selectionLeft + '"'
    + ' "' + selectionRight + '"';

  processExecute(commandLine, CommandList);
end;

procedure TForm1.CommandStopButtonClick(Sender: TObject);
begin
  processTerminateAll(commandList);
end;

procedure TForm1.CopyFilePath(box: TFileListBox);
var
  fileName: ansistring;
  files: TStringList;
  regex: TRegExpr;
  res: ansistring;
  s: ansistring;
begin
  files := TStringList.Create;
  regex := TRegExpr.Create;
  regex.Expression := '^\[.*\]$';
  for s in SplitString(box.GetSelectedText, LineEnding) do
  begin
    fileName := box.Directory + DirectorySeparator;
    if regex.exec(s) Then
    begin
      fileName := fileName + UnpackDirName(s);
    end
    else
      fileName := fileName + s;

    files.Append(fileName);
  end;

  for fileName in files do
  begin
    if res = '' Then
    begin
      res := fileName;
    end
    else
      res := res + lineEnding + fileName;
  end;

  regex.Free;
  files.Free;
  Clipboard.AsText := res;
end;

procedure TForm1.CopyFilePathLeftMenuItemClick(Sender: TObject);
begin
  CopyFilePath(FileBox1);
end;

procedure TForm1.CopyFilePathRightMenuItemClick(Sender: TObject);
begin
  CopyFilePath(FileBox2);
end;

procedure TForm1.CopyLeftMenuItemClick(Sender: TObject);
begin
  DynamicManipulateFiles(1, 'copy');
end;

procedure TForm1.CopyLeftToRightMenuItemClick(Sender: TObject);
begin
 ManipulateFiles(1, 'copy');
end;

procedure TForm1.CopyPathLeftMenuItemClick(Sender: TObject);
begin
  Clipboard.AsText := ExpandFileName(FileBox1.Directory);
end;

procedure TForm1.CopyPathRightMenuItemClick(Sender: TObject);
begin
  Clipboard.AsText := ExpandFileName(FileBox2.Directory);
end;

procedure TForm1.CopyRightMenuItemClick(Sender: TObject);
begin
  DynamicManipulateFiles(2, 'copy');
end;

procedure TForm1.CopyRightToLeftMenuitemClick(Sender: TObject);
begin
  ManipulateFiles(2, 'copy');
end;

procedure TForm1.DeleteRightButtonClick(Sender: TObject);
begin
  DeleteFiles(2);
end;

procedure TForm1.DeleteRightMenuClick(Sender: TObject);
begin
  DeleteFiles(2);
end;

procedure TForm1.EditLeftButtonClick(Sender: TObject);
begin
  OpenBoxFiles(FileBox1, defaultEditor, patterns, processList);
end;

procedure TForm1.EditLeftMenuClick(Sender: TObject);
begin
  OpenBoxFiles(FileBox1, defaultEditor, patterns, processList);
end;

procedure TForm1.EditRightButtonClick(Sender: TObject);
begin
  OpenBoxFiles(FileBox2, defaultEditor, patterns, processList);
end;

procedure TForm1.EditRightMenuClick(Sender: TObject);
begin
  OpenBoxFiles(FileBox2, defaultEditor, patterns, processList);
end;


end.

