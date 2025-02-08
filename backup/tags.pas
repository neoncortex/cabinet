unit tags;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls, FileCtrl,
  ExtCtrls, Menus, FileUtil, StrUtils;

type

  { TForm4 }

  TForm4 = class(TForm)
    AddButton: TButton;
    AddClearButton: TButton;
    AddToEdit: TEdit;
    AddToLabel: TLabel;
    AddToMemo: TMemo;
    AddToClearButton: TButton;
    AddToButton: TButton;
    SwapFromClearAddButton: TButton;
    SwapFromClearDeleteButton: TButton;
    SwapFromButton: TButton;
    DeleteFromButton: TButton;
    DeleteFromClearButton: TButton;
    DeleteFromEdit: TEdit;
    DeleteFromLabel: TLabel;
    DeleteFromMemo: TMemo;
    Splitter1: TSplitter;
    SwapFromAddBox: TGroupBox;
    SwapFromDeleteBox: TGroupBox;
    SwapFromAddMemo: TMemo;
    SwapFromDeleteMemo: TMemo;
    SwapFromEdit: TEdit;
    SwapFromLabel: TLabel;
    OpenDirectoryButton: TButton;
    SwapClearDeleteButton: TButton;
    SwapClearAddButton: TButton;
    SwapButton: TButton;
    DeleteButton: TButton;
    DeleteClearButton: TButton;
    DeployClearButton: TButton;
    DeployButton: TButton;
    DeployMemo: TMemo;
    AddMemo: TMemo;
    DeleteMemo: TMemo;
    SwapDeleteMemo: TMemo;
    SwapDeleteBox: TGroupBox;
    SwapAddMemo: TMemo;
    SwapAddBox: TGroupBox;
    SetMenuItem: TMenuItem;
    PathTagButton: TButton;
    CacheReloadButton: TButton;
    CacheBuildButton: TButton;
    CacheList: TListBox;
    PathTagEdit: TEdit;
    SearchPopupMenu: TPopupMenu;
    SearchResultBox: TGroupBox;
    SelectDirectoryDialog1: TSelectDirectoryDialog;
    AddToTab: TTabSheet;
    DeleteFromTab: TTabSheet;
    SwapFromTab: TTabSheet;
    TagListBox: TListBox;
    SearchTagButton: TButton;
    ContentBox: TGroupBox;
    CacheBox: TGroupBox;
    SearchTagEdit: TEdit;
    SearchTagResultList: TListBox;
    DeleteTab: TTabSheet;
    SwapTab: TTabSheet;
    DeployTab: TTabSheet;
    TagsTabs: TPageControl;
    SearchTab: TTabSheet;
    AddTab: TTabSheet;
    procedure AddButtonClick(Sender: TObject);
    procedure AddClearButtonClick(Sender: TObject);
    procedure AddToButtonClick(Sender: TObject);
    procedure AddToClearButtonClick(Sender: TObject);
    procedure CacheBuildButtonClick(Sender: TObject);
    procedure CacheListDblClick(Sender: TObject);
    procedure CacheReloadButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure DeleteClearButtonClick(Sender: TObject);
    procedure DeleteFromButtonClick(Sender: TObject);
    procedure DeleteFromClearButtonClick(Sender: TObject);
    procedure DeployButtonClick(Sender: TObject);
    procedure DeployClearButtonClick(Sender: TObject);
    procedure OpenDirectoryButtonClick(Sender: TObject);
    procedure PathTagButtonClick(Sender: TObject);
    procedure SearchTagButtonClick(Sender: TObject);
    procedure SearchTagEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SearchTagResultListClick(Sender: TObject);
    procedure SearchTagResultListDblClick(Sender: TObject);
    procedure SetMenuItemClick(Sender: TObject);
    procedure SetTagsDir(fileName: ansistring);
    procedure SetFileBox1(box: TFileListBox);
    procedure SetFileBox2(box: TFileListBox);
    procedure SetLeftPathEdit(pathEdit: TEdit);
    procedure SetRightPathEdit(pathEdit: TEdit);
    procedure SwapButtonClick(Sender: TObject);
    procedure SwapClearAddButtonClick(Sender: TObject);
    procedure SwapClearDeleteButtonClick(Sender: TObject);
    procedure AddTags(Memo: TMemo; path: TEdit = nil);
    procedure DeleteTags(Memo: TMemo; path: TEdit = nil);
    procedure SwapFromButtonClick(Sender: TObject);
    procedure SwapFromClearAddButtonClick(Sender: TObject);
    procedure SwapFromClearDeleteButtonClick(Sender: TObject);
    function collectFiles(dirName: ansistring): TStringList;
    function tagListUnique(list: TStringList): TStringList;
    function SearchTag(tags: ansistring): TStringList;
  private

  public

  end;

var
  Form4: TForm4;
  FileBox1: TFileListBox;
  FileBox2: TFileListBox;
  LeftPathEdit: TEdit;
  RightPathEdit: TEdit;
  tagsDir: ansistring;

implementation

{$R *.lfm}

{ TForm4 }

// data
procedure TForm4.SetFileBox1(box: TFileListBox);
begin
  FileBox1 := box;
  PathTagEdit.Text := FileBox1.Directory;
end;

procedure TForm4.SetFileBox2(box: TFileListBox);
begin
  FileBox2 := box;
end;

procedure TForm4.SetTagsDir(fileName: ansistring);
begin
  tagsDir := fileName;
end;

procedure TForm4.SetLeftPathEdit(pathEdit: TEdit);
begin
  leftPathEdit := pathEdit;
end;

procedure TForm4.SetRightPathEdit(pathEdit: TEdit);
begin
  rightPathEdit := pathEdit;
end;

// path
procedure TForm4.OpenDirectoryButtonClick(Sender: TObject);
begin
  if ((PathTagEdit.Text <> '') and (DirectoryExists(PathTagEdit.Text))) Then
    FileBox2.Directory := PathTagEdit.Text;
end;

procedure TForm4.PathTagButtonClick(Sender: TObject);
begin
  if SelectDirectoryDialog1.Execute Then
  begin
    PathTagEdit.Text := SelectDirectoryDialog1.FileName;
  end;
end;

procedure TForm4.SetMenuItemClick(Sender: TObject);
begin
  pathTagEdit.Text := SearchTagResultList.GetSelectedText;
end;

// collect
function TForm4.collectFiles(dirName: ansistring): TStringList;
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

function TForm4.TagListUnique(list: TStringList): TStringList;
var
  lastTag: ansistring;
  s: ansistring;
  tagList: TStringList;
begin
  tagList := TStringList.Create;
  list.Sort;
  for s in list do
  begin
    if lastTag <> '' Then
    begin
      if ((s <> lastTag) and (s <> '')) Then
        tagList.Append(s);
    end
    else
    begin
      if s <> '' Then
        tagList.Append(s);
    end;

    lastTag := s;
  end;

  TagListUnique := tagList;
end;

// cache
procedure TForm4.CacheReloadButtonClick(Sender: TObject);
var
  cacheDir: ansistring;
  cacheFile: ansistring;
begin
  CacheList.Items.Clear;
  cacheDir := tagsDir + pathTagEdit.Text;
  cacheFile := cacheDir + directorySeparator + 'tags.cache';
  if FileExists(cacheFile) Then
  begin
    CacheList.Items.LoadFromFile(cacheFile);
  end
  else
    CacheBuildButtonClick(nil);
end;

procedure TForm4.CacheBuildButtonClick(Sender: TObject);
var
  cacheDir: ansistring;
  cacheFile: ansistring;
  filep: textFile;
  fileName: ansistring;
  s: ansistring;
  tagList: TStringList;
  tagListTemp: TStringList;
  tagsFileList: TStringList;
begin
  tagsFileList := collectFiles(PathTagEdit.Text);
  tagListTemp := TStringList.Create;
  for fileName in tagsFileList do
  begin
    if FileExists(fileName) Then
    begin
      assignFile(filep, fileName);
      reset(filep);
      while not eof(filep) do
      begin
        readLn(filep, s);
        tagListTemp.Append(s);
      end;
    end;

    closeFile(filep);
  end;

  tagList := TagListUnique(tagListTemp);
  cacheDir := tagsDir + pathTagEdit.Text;
  if not DirectoryExists(cacheDir) Then
    ForceDirectories(cacheDir);

  cacheFile := cacheDir + directorySeparator + 'tags.cache';
  if not FileExists(cacheFile) Then
    FileCreate(cacheFile);

  if FileExists(cacheFile) Then
  begin
    tagList.SaveToFile(cacheFile);
    CacheList.Items.Clear;
    CacheList.Items.LoadFromFile(cacheFile);
  end;

  tagList.Free;
  tagListTemp.Free;
  tagsFileList.Free;
end;

procedure TForm4.CacheListDblClick(Sender: TObject);
begin
  if searchTab.IsVisible Then
  begin
    if searchTagEdit.Text = '' Then
    begin
      searchTagEdit.Text := CacheList.GetSelectedText;
    end
    else
      searchTagEdit.Text := searchTagEdit.Text + ' ' + CacheList.GetSelectedText;
  end;

  if deployTab.IsVisible Then
  begin
    deployMemo.Append(CacheList.GetSelectedText);
  end;

  if addTab.IsVisible Then
  begin
    addMemo.Append(CacheList.GetSelectedText);
  end;

  if deleteTab.IsVisible Then
  begin
    deleteMemo.Append(CacheList.GetSelectedText);
  end;
end;

// search
function TForm4.SearchTag(tags: ansistring): TStringList;
var
  directoryList: TStringList;
  fileName: ansistring;
  filep: textFile;
  firstPass: Boolean;
  match: Boolean;
  s: ansistring;
  t: ansistring;
  tagsForSearch: array of ansistring;
  tagsForSearchList: TStringList;
  tagsFileList: TStringList;
begin
  tagsForSearch := SplitString(tags, ' ');
  tagsForSearchList := TStringList.Create;
  for s in tagsForSearch do
    tagsForSearchList.Append(s);

  tagsForSearchList.Sort;
  directoryList := TStringList.Create;
  tagsFileList := collectFiles(PathTagEdit.Text);
  for fileName in tagsFileList do
  begin
    match := False;
    firstPass := True;
    for t in tagsForSearchList do
    begin
      if ((firstPass = False) and (match = False)) Then
        break;

      assignFile(filep, fileName);
      reset(filep);
      while not eof(filep) do
      begin
        readLn(filep, s);
        if s = t Then
        begin
          match := True;
          break;
        end
        else
          match := False;
      end;

      firstPass := False;
      closeFile(filep);
    end;

    if match = True Then
      directoryList.Append(fileName);
  end;

  SearchTag := directoryList;
  tagsForSearchList.Free;
  tagsFileList.Free;
end;

procedure TForm4.SearchTagButtonClick(Sender: TObject);
var
  fileList: TStringList;
  fileName: ansistring;
begin
  SearchTagResultList.Items.Clear;
  fileList := SearchTag(SearchTagEdit.Text);
  for fileName in fileList do
    SearchTagResultList.Items.Append(ExtractFilePath(fileName));

  fileList.Free;
end;

procedure TForm4.SearchTagEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 13 Then
    SearchTagButtonClick(nil);
end;

procedure TForm4.SearchTagResultListClick(Sender: TObject);
var
  fileName: ansistring;
begin
  TagListBox.Items.Clear;
  fileName := SearchTagResultList.GetSelectedText;
  if FileExists(fileName + directorySeparator + 'bashed-tags') Then
    fileName := fileName + directorySeparator + 'bashed-tags';

  if FileExists(fileName + directorySeparator + '.bashed-tags') Then
    fileName := fileName + directorySeparator + '.bashed-tags';

  if FileExists(fileName + directorySeparator + 'cabinet-tags') Then
    fileName := fileName + directorySeparator + 'cabinet-tags';

  if FileExists(fileName + directorySeparator + '.cabinet-tags') Then
    fileName := fileName + directorySeparator + '.cabinet-tags';

  if FileExists(fileName) Then
    TagListBox.Items.LoadFromFile(fileName);
end;

procedure TForm4.SearchTagResultListDblClick(Sender: TObject);
begin
  FileBox2.Directory := SearchTagResultList.GetSelectedText;
  RightPathEdit.Text := SearchTagResultList.GetSelectedText;
end;

// deploy
procedure TForm4.DeployButtonClick(Sender: TObject);
var
  fileName: ansistring;
begin
  fileName := PathTagEdit.Text + directorySeparator + '.cabinet-tags';
  if not FileExists(fileName) Then
  begin
    DeployMemo.Lines.SaveToFile(fileName);
  end
  else
    ShowMessage('File exists: ' + fileName);

end;

procedure TForm4.DeployClearButtonClick(Sender: TObject);
begin
  DeployMemo.Lines.Clear;
end;

// add
procedure TForm4.AddTags(Memo: TMemo; path: TEdit = nil);
var
  fileName: ansistring;
  s: ansistring;
  tagList: TStringList;
  tagListTemp: TStringList;
  tagsFileList: TSTringList;
begin
  if path = nil Then
  begin
    tagsFileList := collectFiles(PathTagEdit.Text);
  end
  else
    tagsFileList := searchTag(path.Text);

  for fileName in tagsFileList do
  begin
    tagListTemp := TStringList.Create;
    tagListTemp.LoadFromFile(fileName);
    for s in Memo.Lines do
      tagListTemp.Append(s);

    tagList := TagListUnique(tagListTemp);
    tagList.Sort;
    tagList.SaveToFile(fileName);
    tagList.Free;
    tagListTemp.Free;
  end;

  tagsFileList.Free;
end;

procedure TForm4.AddToButtonClick(Sender: TObject);
begin
  AddTags(AddToMemo, AddToEdit);
end;

procedure TForm4.AddButtonClick(Sender: TObject);
begin
  AddTags(AddMemo);
end;

procedure TForm4.AddClearButtonClick(Sender: TObject);
begin
  AddMemo.Lines.Clear;
end;

procedure TForm4.AddToClearButtonClick(Sender: TObject);
begin
  AddToMemo.Lines.Clear;
end;

// delete
procedure TForm4.DeleteTags(Memo: TMemo; path: TEdit = nil);
var
  counter: integer;
  fileName: ansistring;
  s: ansistring;
  t: ansistring;
  tagList: TStringList;
  tagsFileList: TStringList;
begin
  if path = nil Then
  begin
    tagsFileList := collectFiles(PathTagEdit.Text);
  end
  else
    tagsFileList := searchTag(path.Text);

  for fileName in tagsFileList do
  begin
    tagList := TStringList.Create;
    tagList.LoadFromFile(fileName);
    for s in Memo.Lines do
    begin
      counter := 0;
      for t in tagList do
      begin
        if s = t Then
          tagList.Delete(counter);

        counter := counter + 1;
      end;
    end;

    tagList.SaveToFile(fileName);
    tagList.Free;
  end;

  tagsFileList.Free;
end;

procedure TForm4.DeleteFromButtonClick(Sender: TObject);
begin
  DeleteTags(DeleteFromMemo, DeleteFromEdit);
end;

procedure TForm4.DeleteButtonClick(Sender: TObject);
begin
  DeleteTags(DeleteMemo);
end;

procedure TForm4.DeleteClearButtonClick(Sender: TObject);
begin
  DeleteMemo.Lines.Clear;
end;

procedure TForm4.DeleteFromClearButtonClick(Sender: TObject);
begin
  DeleteFromMemo.Lines.Clear;
end;

// swap
procedure TForm4.SwapButtonClick(Sender: TObject);
begin
  AddTags(SwapAddMemo);
  DeleteTags(SwapDeleteMemo);
end;

procedure TForm4.SwapFromButtonClick(Sender: TObject);
begin
  AddTags(SwapFromAddMemo, SwapFromEdit);
  DeleteTags(SwapFromDeleteMemo, SwapFromEdit);
end;

procedure TForm4.SwapFromClearAddButtonClick(Sender: TObject);
begin
  SwapFromAddMemo.Lines.Clear;
end;

procedure TForm4.SwapFromClearDeleteButtonClick(Sender: TObject);
begin
  SwapFromDeleteMemo.Lines.Clear;
end;

procedure TForm4.SwapClearAddButtonClick(Sender: TObject);
begin
  SwapAddMemo.Lines.Clear;
end;

procedure TForm4.SwapClearDeleteButtonClick(Sender: TObject);
begin
  SwapDeleteMemo.Lines.Clear;
end;


end.

