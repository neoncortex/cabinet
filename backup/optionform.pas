unit optionForm;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls, RegExpr,
  StrUtils;

type

  { TForm2 }

  TForm2 = class(TForm)
    SaveButton: TButton;
    FileCommandEdit: TEdit;
    FileCommandLabel: TLabel;
    DefaultEditorEdit: TEdit;
    DefaultEditorLabel: TLabel;
    PageControl1: TPageControl;
    ExternalCommandsTab: TTabSheet;
    procedure SaveButtonClick(Sender: TObject);
    procedure setConfigFile(fileName: ansistring);
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
    end;

    regex.Free;
    closeFile(filep);
  end;
end;

procedure TForm2.SaveButtonClick(Sender: TObject);
var
  filep: textFile;
begin
  assignFile(filep, configFile);
  rewrite(filep);
  writeln(filep, 'file-command :::: ' + FileCommandEdit.Text);
  writeln(filep, 'default-editor :::: ' + DefaultEditorEdit.Text);
  closeFile(filep);
end;

end.

