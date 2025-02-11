unit find;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, RegExpr, Clipbrd,
  FileCtrl, OpenFiles;

type

  { TForm5 }

  TForm5 = class(TForm)
    OpenButton: TButton;
    DepthCheck: TCheckBox;
    CopyPathButton: TButton;
    DepthEdit: TEdit;
    PatternLabel: TLabel;
    PathLabel: TLabel;
    SelectDirectoryDialog1: TSelectDirectoryDialog;
    SetPathButton: TButton;
    CopyButton: TButton;
    PathEdit: TEdit;
    OpenLeftButton: TButton;
    OpenRightButton: TButton;
    FindButton: TButton;
    FindEdit: TEdit;
    ByNameRadio: TRadioButton;
    ByContentRadio: TRadioButton;
    ResultList: TListBox;
    procedure CopyButtonClick(Sender: TObject);
    procedure CopyPathButtonClick(Sender: TObject);
    procedure DepthCheckChange(Sender: TObject);
    procedure FindButtonClick(Sender: TObject);
    function contentMatch(fileName: ansistring): TStringList;
    function collectFiles(dirName: ansistring): TStringList;
    procedure FindEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure OpenButtonClick(Sender: TObject);
    procedure OpenLeftButtonClick(Sender: TObject);
    procedure OpenRightButtonClick(Sender: TObject);
    procedure ResultListDblClick(Sender: TObject);
    procedure SetFileBox1(box: TFileListBox);
    procedure SetFileBox2(box: TFileListBox);
    procedure SetLeftPathEdit(edit: TEdit);
    procedure SetPathButtonClick(Sender: TObject);
    procedure SetRightPathEdit(edit: TEdit);
    procedure SetPatterns(list: TStringList);
    procedure SetFileCommand(command: ansistring);
  private

  public

  end;

var
  Form5: TForm5;
  FileBox1: TFileListBox;
  FileBox2: TFileListBox;
  LeftPathEdit: TEdit;
  RightPathEdit: TEdit;
  depthCounter: integer;
  fileCommand: ansistring;
  patterns: TStringList;
implementation

{$R *.lfm}

{ TForm5 }

procedure TForm5.SetFileBox1(box: TFileListBox);
begin
  FileBox1 := box;
  PathEdit.Text := FileBox1.Directory;
end;

procedure TForm5.SetFileBox2(box: TFileListBox);
begin
  FileBox2 := box;
end;

procedure TForm5.SetLeftPathEdit(edit: TEdit);
begin
  leftPathEdit := edit;
end;

procedure TForm5.SetPathButtonClick(Sender: TObject);
begin
  if SelectDirectoryDialog1.Execute Then
    PathEdit.Text := SelectDirectoryDialog1.FileName;
end;

procedure TForm5.SetFileCommand(command: ansistring);
begin
  fileCommand := command;
end;

procedure TForm5.SetRightPathEdit(edit: TEdit);
begin
  rightPathEdit := edit;
end;

procedure TForm5.SetPatterns(list: TStringList);
begin
  patterns := list;
end;

function TForm5.contentMatch(fileName: ansistring): TStringList;
var
  filep: textFile;
  list: TStringList;
  regex: TRegExpr;
  s: ansistring;
begin
  list := TStringList.Create;
  if FileExists(fileName) Then
  begin
    assignFile(filep, fileName);
    reset(filep);
    regex := TRegExpr.Create;
    while not eof(filep) do
    begin
      readLn(filep, s);
      regex.Expression := findEdit.Text;
      if regex.exec(s) Then
      begin
        list.Append(fileName);
        break;
      end;
    end;

    closeFile(filep);
    regex.Free;
  end;

  contentMatch := list;
end;

function TForm5.collectFiles(dirName: ansistring): TStringList;
var
  fileName: ansistring;
  list: TStringList;
  regex: TRegExpr;
  s: TRawByteSearchRec;
  t: ansistring;
  tempList: TStringList;
begin
  list := TStringList.Create;
  regex := TRegExpr.Create;
  try
    depthCounter := StrToInt(DepthEdit.Text);
  except
    on E: Exception do
      depthCounter := 0;
  end;

  if findFirst(dirName + directorySeparator + '*', faAnyFile or faSymLink, s) = 0 Then
  begin
    repeat
      if ((s.Name = '.') or (s.Name = '..')) Then
        continue;

      if (s.Attr and faSymLink) = faSymLink Then
        continue;

      fileName := expandFileName(dirName + directorySeparator + s.Name);
      if DirectoryExists(fileName) Then
      begin
        tempList := nil;
        if DepthCheck.Checked Then
        begin
          if depthCounter > 0 Then
          begin
            depthCounter := depthCounter - 1;
            tempList := collectFiles(fileName);
          end;
        end
        else
          tempList := collectFiles(fileName);

        if tempList <> nil Then
        begin
          for t in tempList do
            list.Append(t);

          tempList.Free;
        end;
      end
      else
      begin
        if ByNameRadio.Checked Then
        begin
          regex.Expression := findEdit.Text;
          if regex.exec(s.Name) Then
            list.Append(fileName);
        end;

        if ByContentRadio.Checked Then
        begin
          tempList := contentMatch(fileName);
          for t in tempList do
            list.Append(t);

          tempList.Free;
        end;
      end;

    until FindNext(s) <> 0;
  end;

  regex.Free;
  FindClose(s);
  collectFiles := list;
end;

procedure TForm5.FindEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 13 Then
    FindButtonClick(nil);
end;

procedure TForm5.OpenButtonClick(Sender: TObject);
begin
  OpenListFiles(ResultList, fileCommand, patterns);
end;

procedure TForm5.OpenLeftButtonClick(Sender: TObject);
begin
  LeftPathEdit.Text := ExtractFilePath(ResultList.GetSelectedText);
  FileBox1.Directory := ExtractFilePath(ResultList.GetSelectedText);
end;

procedure TForm5.OpenRightButtonClick(Sender: TObject);
begin
  RightPathEdit.Text := ExtractFilePath(ResultList.GetSelectedText);
  FileBox2.Directory := ExtractFilePath(ResultList.GetSelectedText);
end;

procedure TForm5.ResultListDblClick(Sender: TObject);
begin
  OpenButtonClick(nil);
end;

procedure TForm5.FindButtonClick(Sender: TObject);
var
  res: TStringList;
  s: ansistring;
begin
  if findEdit.Text <> '' Then
  begin
    ResultList.Items.Clear;
    res := collectFiles(pathEdit.Text);
    res.Sort;
    for s in res do
    begin
      ResultList.Items.Append(s);
    end;

    res.Free;
  end;
end;

procedure TForm5.CopyButtonClick(Sender: TObject);
begin
  Clipboard.AsText := ResultList.GetSelectedText;
end;

procedure TForm5.CopyPathButtonClick(Sender: TObject);
begin
  Clipboard.AsText := ExtractFilePath(ResultList.GetSelectedText);
end;

procedure TForm5.DepthCheckChange(Sender: TObject);
begin
  if DepthCheck.Checked Then
  begin
    DepthEdit.Enabled := True;
  end
  else
    DepthEdit.Enabled := False;
end;

end.

