unit collect;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, StrUtils;

function collectFiles(dirName: ansistring): TStringList;

implementation

function collectFiles(dirName: ansistring): TStringList;
var
  fileName: ansistring;
  list: TStringList;
  s: TRawByteSearchRec;
  t: ansistring;
  tempList: TStringList;
begin
  list := TStringList.Create;
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
        tempList := collectFiles(fileName);
        for t in tempList do
          list.Append(t);
      end
      else
      begin
        {
        it checks for bashed-tags files because the tagging idea came from
        other project, and it used that as file names for tags.  It is not
        relevant for anyone else but me, I guess.
        }
        if ((s.Name = 'bashed-tags') or (s.Name = '.bashed-tags')
        or (s.Name = 'cabinet-tags') or (s.Name = '.cabinet-tags')) Then
          list.Append(fileName);
      end;

    until FindNext(s) <> 0;
  end;

  FindClose(s);
  collectFiles := list;
end;

end.

