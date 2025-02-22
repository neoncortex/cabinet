unit recipes;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, FileCtrl, ExtCtrls,
  StdCtrls, processManager;

type

  { TForm3 }

  TForm3 = class(TForm)
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
    procedure SetProcessList(list: TList);
    procedure SetListFont(fontName: ansistring);
    procedure SetListFontSize(fontSize: integer);
    procedure SetListForeground(colorData: TColor);
    procedure SetTextFont(fontName: ansistring);
    procedure SetTextFontSize(fontSize: integer);
    procedure SetTextForeground(colorData: TColor);
    procedure SetTextBackground(colorData: TColor);

  private

  public

  end;

var
  CommandMemo: TMemo;
  configDir: ansistring;
  recipesDir: ansistring;
  processList: TList;
  Form3: TForm3;

implementation

{$R *.lfm}

{ TForm3 }

procedure TForm3.SetCommandMemo(commandMemoName: TMemo);
begin
  CommandMemo := commandMemoName;
end;

procedure TForm3.SetProcessList(list: TList);
begin
  processList := list;
end;

procedure TForm3.SetConfigDir(dirName: ansistring);
begin
  configDir := dirName;
  recipesDir := configDir + directorySeparator + 'recipes';
  recipesFileBox.Directory := recipesDir;
  recipesFileBox.UpdateFileList;
end;

// appearance
procedure TForm3.SetListFont(fontName: ansistring);
begin
  RecipesFileBox.Font.Name := fontName;
end;

procedure TForm3.SetListFontSize(fontSize: integer);
begin
  RecipesFileBox.Font.Size := fontSize;
end;

procedure TForm3.SetListForeground(colorData: TColor);
begin
  RecipesFileBox.Font.Color := colorData;
end;

procedure TForm3.SetTextFont(fontName: ansistring);
begin
  RecipesMemo.Font.Name := fontName;
end;

procedure TForm3.SetTextFontSize(fontSize: integer);
begin
  RecipesMemo.Font.Size := fontSize;
end;

procedure TForm3.SetTextForeground(colorData: TColor);
begin
  RecipesMemo.Font.Color := colorData;
end;

procedure TForm3.SetTextBackground(colorData: TColor);
begin
  RecipesMemo.Color := colorData;
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
  commandLine: ansistring;
  fileName: ansistring;
begin
  fileName := recipesDir + directorySeparator + recipesFileBox.GetSelectedText;
  if FileExists(fileName) Then
  begin
    commandLine := 'xdg-open "' + fileName + '"';
    processExecute(commandLine, processList);
  end;
end;

end
.

