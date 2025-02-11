unit optionForm;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls, RegExpr,
  StrUtils;

type

  { TForm2 }

  TForm2 = class(TForm)
    DeletePatternButton: TButton;
    FileCommandList: TListBox;
    SetPatternButton: TButton;
    ReloadButton: TButton;
    FileCommandRegexEntry: TEdit;
    FileCommandCommandEntry: TEdit;
    FileCommandsTab: TTabSheet;
    FileCommandRegexLabel: TLabel;
    FileCommandCommandLabel: TLabel;
    FileCommandSetupBox: TGroupBox;
    FileCommandPatternsBox: TGroupBox;
    TerminalEmulatorLabel: TLabel;
    TerminalEmulatorEdit: TEdit;
    SaveButton: TButton;
    FileCommandEdit: TEdit;
    FileCommandLabel: TLabel;
    DefaultEditorEdit: TEdit;
    DefaultEditorLabel: TLabel;
    PageControl1: TPageControl;
    ExternalCommandsTab: TTabSheet;
    procedure DeletePatternButtonClick(Sender: TObject);
    procedure FileCommandListClick(Sender: TObject);
    procedure ReloadButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure setConfigFile(fileName: ansistring);
    procedure SetPatternButtonClick(Sender: TObject);
  private

  public

  end;

var
  Form2: TForm2;
  configFile: ansistring;

implementation

{$R *.lfm}

{ TForm2 }

procedure TForm2.SetConfigFile(fileName: ansistring);
var
  filep: textFile;
  r: array of ansistring;
  regex: TRegExpr;
  s: ansistring;
begin
  configFile := fileName;
  if FileExists(fileName) Then
  begin
    assignFile(filep, configFile);
    reset(filep);
    regex := TRegExpr.Create;
    while not eof(filep) do
    begin
      readln(filep, s);
      regex.Expression := '^file-command :::: .*';
      if regex.Exec(s) Then
      begin
        r := SplitString(s, ' :::: ');
        if r[1] <> '' Then
          FileCommandEdit.Text := r[1];
      end;

      regex.Expression := '^default-editor :::: .*';
      if regex.Exec(s) Then
      begin
        r := SplitString(s, ' :::: ');
        if r[1] <> '' Then
          DefaultEditorEdit.Text := r[1];
      end;

      regex.Expression := '^terminal-emulator :::: .*';
      if regex.Exec(s) Then
      begin
        r := SplitString(s, ' :::: ');
        if r[1] <> '' Then
          TerminalEmulatorEdit.Text := r[1];
      end;

      regex.Expression := '^pattern :::: .*';
      if regex.Exec(s) Then
      begin
        r := SplitString(s, ' :::: ');
        if ((r[1] <> '') and (r[2] <> '')) Then
          FileCommandList.Items.Append(s);
      end;
    end;

    regex.Free;
    closeFile(filep);
  end;
end;

procedure TForm2.SetPatternButtonClick(Sender: TObject);
var
  content: ansistring;
  counter: integer;
  pattern: array of ansistring;
  s: ansistring;
begin
  counter := 0;
  content := 'pattern :::: ' + FileCommandRegexEntry.Text
    + ' :::: ' + FileCommandCommandEntry.Text;
  for s in FileCommandList.Items do
  begin
    pattern := SplitString(s, ' :::: ');
    if pattern[1] = FileCommandRegexEntry.Text Then
    begin
      FileCommandList.Items[counter] := content;
      exit;
    end;

    counter := counter + 1;
  end;

  FileCommandList.Items.Append(content);
end;

procedure TForm2.SaveButtonClick(Sender: TObject);
var
  filep: textFile;
  s: ansistring;
begin
  assignFile(filep, configFile);
  rewrite(filep);
  writeln(filep, 'file-command :::: ' + FileCommandEdit.Text);
  writeln(filep, 'default-editor :::: ' + DefaultEditorEdit.Text);
  writeln(filep, 'terminal-emulator :::: ' + TerminalEmulatorEdit.Text);
  for s in FileCommandList.Items do
    writeln(filep, s);

  closeFile(filep);
end;

procedure TForm2.FileCommandListClick(Sender: TObject);
var
  pattern: array of ansistring;
begin
  pattern := SplitString(FileCommandList.GetSelectedText, ' :::: ');
  FileCommandRegexEntry.Text := pattern[1];
  FileCommandCommandEntry.Text := pattern[2];
end;

procedure TForm2.ReloadButtonClick(Sender: TObject);
begin
  setConfigFile(configFile);
end;

procedure TForm2.DeletePatternButtonClick(Sender: TObject);
begin
  FileCommandList.DeleteSelected;
  FileCommandRegexEntry.Text := '';
  FileCommandCommandEntry.Text := '';
end;

end.

