unit commandOutput;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm6 }

  TForm6 = class(TForm)
    UpdateButton: TButton;
    OutputMemo: TMemo;
    procedure SetCommandOutput(fileName: ansistring);
    procedure UpdateButtonClick(Sender: TObject);
  private

  public

  end;

var
  Form6: TForm6;
  commandOutputFile: ansistring;

implementation

procedure TForm6.SetCommandOutput(fileName: ansistring);
begin
  commandOutputFile := fileName;
  if FileExists(commandOutputFile) Then
    OutputMemo.Lines.LoadFromFile(commandOutputFile);
end;

procedure TForm6.UpdateButtonClick(Sender: TObject);
begin
  if FileExists(commandOutputFile) Then
    OutputMemo.Lines.LoadFromFile(commandOutputFile);
end;

{$R *.lfm}

end.

