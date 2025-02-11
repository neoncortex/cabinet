unit openFiles;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, RegExpr, AsyncProcess, FileCtrl, StrUtils, StdCtrls;

  procedure OpenBoxFiles(box: TFileListBox; command: ansistring; patterns: TStringList);
  procedure OpenListFiles(list: TListBox; command: ansistring; patterns: TStringList);

implementation

procedure OpenBoxFiles(box: TFileListBox; command: ansistring; patterns: TStringList);
var
  boxDir: ansistring;
  commandLine: ansistring;
  fileName: ansistring;
  files: ansistring;
  patternItem: array of ansistring;
  process: TASyncProcess;
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
    if FileExists(fileName) = True Then
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

      process := TASyncProcess.Create(nil);
      process.CommandLine := commandLine;
      process.Execute;
      process.Free;
    end;
  end;

  regex.Free;
end;

procedure OpenListFiles(list: TListBox; command: ansistring; patterns: TStringList);
var
  boxDir: ansistring;
  commandLine: ansistring;
  fileName: ansistring;
  files: ansistring;
  patternItem: array of ansistring;
  process: TASyncProcess;
  regex: TRegExpr;
  s: ansistring;
  t: ansistring;
begin
  files := list.GetSelectedText;
  regex := TRegExpr.Create;
  for s in SplitString(files, LineEnding) do
  begin
    fileName := ExpandFileName(s);
    if FileExists(fileName) = True Then
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

      process := TASyncProcess.Create(nil);
      process.CommandLine := commandLine;
      process.Execute;
      process.Free;
    end;
  end;

  regex.Free;
end;

end.

