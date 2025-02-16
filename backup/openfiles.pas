unit openFiles;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, RegExpr, Process, AsyncProcess, FileCtrl, StrUtils, StdCtrls,
  processManager, Dialogs;

  procedure OpenBoxFiles(box: TFileListBox; command: ansistring; patterns: TStringList; processList: TList);
  procedure OpenListFiles(list: TListBox; command: ansistring; patterns: TStringList; processList: TList);
  procedure OpenWith(box: TFileListBox; processList: TList);

implementation

procedure OpenBoxFiles(box: TFileListBox; command: ansistring; patterns: TStringList; processList: TList);
var
  boxDir: ansistring;
  commandLine: ansistring;
  fileName: ansistring;
  files: ansistring;
  patternItem: array of ansistring;
  regex: TRegExpr;
  s: ansistring;
  t: ansistring;
begin
  boxDir := box.Directory;
  files := box.GetSelectedText;
  regex := TRegExpr.Create;
  for s in SplitString(files, LineEnding) do
  begin
    fileName := ExpandFileName(boxDir + DirectorySeparator + s);
    if FileExists(fileName) Then
    begin
      commandLine := StringReplace(command, '%s', fileName, [rfReplaceAll]);
      for t in patterns do
      begin
        patternItem := SplitString(t, ' :::: ');
        regex.Expression := patternItem[1];
        if regex.exec(fileName) Then
        begin
          commandLine := StringReplace(patternItem[2], '%s', fileName, [rfReplaceAll]);
          break;
        end;
      end;

      processExecute(commandLine, processList);
    end;
  end;

  regex.Free;
end;

procedure OpenListFiles(list: TListBox; command: ansistring; patterns: TStringList; processList: TList);
var
  commandLine: ansistring;
  fileName: ansistring;
  files: ansistring;
  patternItem: array of ansistring;
  regex: TRegExpr;
  s: ansistring;
  t: ansistring;
begin
  files := list.GetSelectedText;
  regex := TRegExpr.Create;
  for s in SplitString(files, LineEnding) do
  begin
    fileName := ExpandFileName(s);
    if FileExists(fileName) Then
    begin
      commandLine := StringReplace(command, '%s', fileName, [rfReplaceAll]);
      for t in patterns do
      begin
        patternItem := SplitString(t, ' :::: ');
        regex.Expression := patternItem[1];
        if regex.exec(fileName) Then
        begin
          commandLine := StringReplace(patternItem[2], '%s', fileName, [rfReplaceAll]);
          break;
        end;
      end;

      processExecute(commandLine, processList);
    end;
  end;

  regex.Free;
end;

procedure OpenWith(box: TFileListBox; processList: TList);
var
  commandLine: ansistring;
  files: ansistring;
  fileName: ansistring;
  s: ansistring;
begin
  if InputQuery('Cabinet - Open with', 'Type the command, use %s for the file name', False, commandLine) Then
  begin
    files := box.GetSelectedText;
    writeln(box.GetSelectedText);
    for s in SplitString(files, LineEnding) do
    begin
      fileName := ExpandFileName(box.Directory + DirectorySeparator + s);
      if FileExists(fileName) Then
      begin
        commandLine := StringReplace(commandLine, '%s', fileName, [rfReplaceAll]);
        processExecute(commandLine, processList)
      end;
    end;
  end;
end;

end.

