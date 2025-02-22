unit recipes;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, FileCtrl, ExtCtrls,
  StdCtrls, AsyncProcess;

type

  { TForm3 }

  TForm3 = class(TForm)
    AsyncProcess1: TAsyncProcess;
    RecipesFilterButton: TButton;
    ContentBox: TGroupBox;
    RecipesFilterEntry: TEdit;
    UseRecipeButton: TButton;
    SaveRecipeButton: TButton;
    EditRecipeButton: TButton;
    RenameRecipeButton: TButton;
    DeleteRecipeButton: TButton;
    NewRecipeButton: TButton;
    RecipesFileBox: TFileListBox;
    RecipesBox: TGroupBox;
    RecipesMemo: TMemo;
    procedure DeleteRecipeButtonClick(Sender: TObject);
    procedure EditRecipeButtonClick(Sender: TObject);
    procedure NewRecipeButtonClick(Sender: TObject);
    procedure RecipesFileBoxDblClick(Sender: TObject);
    procedure RecipesFilterButtonClick(Sender: TObject);
    procedure RenameRecipeButtonClick(Sender: TObject);
    procedure SaveRecipeButtonClick(Sender: TObject);
    procedure UseRecipeButtonClick(Sender: TObject);
    procedure SetCommandMemo(commandMemoName: TMemo);
    procedure SetConfigDir(dirName: ansistring);
  private

  public

  end;

var
  CommandMemo: TMemo;
  configDir: ansistring;
  recipesDir: ansistring;
  Form3: TForm3;

implementation

{$R *.lfm}

{ TForm3 }

procedure TForm3.SetCommandMemo(commandMemoName: TMemo);
begin
  CommandMemo := commandMemoName;
end;

procedure TForm3.SetConfigDir(dirName: ansistring);
begin
  configDir := dirName;
  recipesDir := configDir + directorySeparator + 'recipes';
  recipesFileBox.Directory := recipesDir;
  recipesFileBox.UpdateFileList;
end;

procedure TForm3.UseRecipeButtonClick(Sender: TObject);
begin
  CommandMemo.Lines.Text := RecipesMemo.Lines.Text;
end;

procedure TForm3.RecipesFilterButtonClick(Sender: TObject);
begin
  if RecipesFilterEntry.Text <> '' Then
  begin
    RecipesFileBox.Mask := RecipesFilterEntry.Text;
  end
  else
  begin
    RecipesFileBox.Mask := '*';
  end;
end;

procedure TForm3.RenameRecipeButtonClick(Sender: TObject);
var
  fileName: ansistring;
  newName: ansistring;
begin
  fileName := recipesDir + directorySeparator + recipesFileBox.GetSelectedText;
  if FileExists(fileName) Then
  begin
    if InputQuery('New recipe', 'Type the new recipe name', False, newName) Then
    begin
      RenameFile(fileName, recipesDir + directorySeparator + newName);
      RecipesFileBox.UpdateFileList;
    end;
  end;
end;

procedure TForm3.SaveRecipeButtonClick(Sender: TObject);
var
  fileName: ansistring;
begin
  fileName := recipesDir + directorySeparator + recipesFileBox.GetSelectedText;
  if FileExists(fileName) Then
  begin
    RecipesMemo.Lines.SaveToFile(fileName);
    RecipesFileBox.UpdateFileList;
  end
  else
    ShowMessage('File not found: ' + fileName);
end;

procedure TForm3.NewRecipeButtonClick(Sender: TObject);
var
  newFile: ansistring;
begin
  if InputQuery('New recipe', 'Type the new recipe name', False, newFile) Then
  begin
    FileCreate(recipesDir + directorySeparator + newFile);
    RecipesFileBox.UpdateFileList;
  end;
end;

procedure TForm3.RecipesFileBoxDblClick(Sender: TObject);
begin
  RecipesMemo.Lines.LoadFromFile(Recipesdir + directorySeparator + RecipesFileBox.GetSelectedText);
end;

procedure TForm3.DeleteRecipeButtonClick(Sender: TObject);
var
  fileName: ansistring;
begin
  fileName := recipesDir + directorySeparator + recipesFileBox.GetSelectedText;
  if FileExists(fileName) Then
  begin
    DeleteFile(fileName);
    RecipesFileBox.UpdateFileList;
  end;
end;

procedure TForm3.EditRecipeButtonClick(Sender: TObject);
var
  fileName: ansistring;
begin
  fileName := recipesDir + directorySeparator + recipesFileBox.GetSelectedText;
  if FileExists(fileName) Then
  begin
    ASyncProcess1.CommandLine := 'xdg-open "' + fileName + '"';
    ASyncProcess1.Execute;
  end;
end;

end
.

