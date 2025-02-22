unit optionForm;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls, RegExpr,
  StrUtils;

type

  { TForm2 }

  TForm2 = class(TForm)
   AppearanceRightBox: TGroupBox;
   AppearanceTabs: TPageControl;
   ApparearanceCacheBox: TGroupBox;
   AppearanceSearchContentGroupBox: TGroupBox;
   AppearanceFindTab: TTabSheet;
   AppearanceRecipesTab: TTabSheet;
   AppearanceRecipesListGroup: TGroupBox;
   AppearanceRecipesBox: TGroupBox;
   backgroundRecipesTextColorButton: TColorButton;
   useRecipesFontTextCheck: TCheckBox;
   selectFontRecipesTextButton: TButton;
   fontRecipesTextEdit: TEdit;
   useRecipesBackgroundTextColorCheck: TCheckBox;
   useRecipesForegroundTextCheck: TCheckBox;
   foregroundRecipesTextColorButton: TColorButton;
   useRecipesFontCheck: TCheckBox;
   selectFontRecipesButton: TButton;
   recipesListFontEdit: TEdit;
   useRecipesForegroundColorCheck: TCheckBox;
   foregroundRecipesColorButton: TColorButton;
   useFindFontCheck: TCheckBox;
   selectFontFindButton: TButton;
   findFontEdit: TEdit;
   useFindForegroundColorCheck: TCheckBox;
   findForegroundColorButton: TColorButton;
   useContentFontCheck: TCheckBox;
   selectContentFontButton: TButton;
   contentFontEdit: TEdit;
   useContentBackgroundColorCheck: TCheckBox;
   contentBackgroundColorButton: TColorButton;
   useContentForegroundColorCheck: TCheckBox;
   contentForegroundColorButton: TColorButton;
   useSearchFontCheck: TCheckBox;
   searchSelectFontButton: TButton;
   cacheSelectFontButton: TButton;
   cacheFontEdit: TEdit;
   AppareanceTagControlsGroup: TGroupBox;
   AppearanceSearchBox: TGroupBox;
   useSearchForegroundColorCheck: TCheckBox;
   searchFontEdit: TEdit;
   tagSearchForegroundColorButton: TColorButton;
   useCacheFontCheck: TCheckBox;
   useCacheForegroundColorCheck: TCheckBox;
   cacheForegroundColorButton: TColorButton;
   selectCommandFontButton: TButton;
   ManagerTab: TTabSheet;
   AppearanceTagsTab: TTabSheet;
   useForegroundCommandCheck: TCheckBox;
   useBackgroundCommandCheck: TCheckBox;
   useCommandFontCheck: TCheckBox;
   commandForegroundColorButton: TColorButton;
   commandBackgroundColorButton: TColorButton;
   commandFontEdit: TEdit;
   leftFontSelectButton: TButton;
   rightFontSelectButton: TButton;
   AppearanceCommandBox: TGroupBox;
   FontDialog1: TFontDialog;
   useRightFontCheck: TCheckBox;
   UseLeftFontCheck: TCheckBox;
   leftFontEdit: TEdit;
   rightFontEdit: TEdit;
   AppearancePanesBox: TGroupBox;
   useRightForegroundColorCheck: TCheckBox;
   rightForegroundColorButton: TColorButton;
   useLeftForegroundColorCheck: TCheckBox;
   LeftForegroundColorButton: TColorButton;
   DeletePatternButton: TButton;
   FileCommandList: TListBox;
   AppearanceLeftBox: TGroupBox;
   SetPatternButton: TButton;
   ReloadButton: TButton;
   FileCommandRegexEntry: TEdit;
   FileCommandCommandEntry: TEdit;
   FileCommandsTab: TTabSheet;
   FileCommandRegexLabel: TLabel;
   FileCommandCommandLabel: TLabel;
   FileCommandSetupBox: TGroupBox;
   FileCommandPatternsBox: TGroupBox;
   AppearanceTab: TTabSheet;
   TerminalEmulatorLabel: TLabel;
   TerminalEmulatorEdit: TEdit;
   SaveButton: TButton;
   FileCommandEdit: TEdit;
   FileCommandLabel: TLabel;
   DefaultEditorEdit: TEdit;
   DefaultEditorLabel: TLabel;
   PageControl1: TPageControl;
   ExternalCommandsTab: TTabSheet;
   procedure cacheSelectFontButtonClick(Sender: TObject);
   procedure DeletePatternButtonClick(Sender: TObject);
   procedure FileCommandListClick(Sender: TObject);
   procedure leftFontSelectButtonClick(Sender: TObject);
   procedure ReloadButtonClick(Sender: TObject);
   procedure rightFontSelectButtonClick(Sender: TObject);
   procedure SaveButtonClick(Sender: TObject);
   procedure searchSelectFontButtonClick(Sender: TObject);
   procedure selectCommandFontButtonClick(Sender: TObject);
   procedure selectContentFontButtonClick(Sender: TObject);
   procedure selectFontFindButtonClick(Sender: TObject);
   procedure selectFontRecipesButtonClick(Sender: TObject);
   procedure selectFontRecipesTextButtonClick(Sender: TObject);
   procedure setConfigFile(fileName: ansistring);
   procedure SetPatternButtonClick(Sender: TObject);
   procedure SelectFont(entry: TEdit);
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

      regex.Expression := '^left-foreground :::: .*';
      if regex.Exec(s) Then
      begin
        r := SplitString(s, ' :::: ');
        if r[1] <> '' Then
        begin
          useLeftForegroundColorCheck.Checked := True;
          leftForegroundColorButton.ButtonColor := StrToInt(r[1]);
        end;
      end;

      regex.Expression := '^right-foreground :::: .*';
      if regex.Exec(s) Then
      begin
        r := SplitString(s, ' :::: ');
        if r[1] <> '' Then
        begin
          useRightForegroundColorCheck.Checked := True;
          rightForegroundColorButton.ButtonColor := StrToInt(r[1]);
        end;
      end;

      regex.Expression := '^left-font :::: .*';
      if regex.Exec(s) Then
      begin
        r := SplitString(s, ' :::: ');
        if r[1] <> '' Then
        begin
          useLeftFontCheck.Checked := True;
          leftFontEdit.Text := r[1] + ' :::: ' + r[2];
        end;
      end;

      regex.Expression := '^right-font :::: .*';
      if regex.Exec(s) Then
      begin
        r := SplitString(s, ' :::: ');
        if r[1] <> '' Then
        begin
          useRightFontCheck.Checked := True;
          rightFontEdit.Text := r[1] + ' :::: ' + r[2];
        end;
      end;

      regex.Expression := '^command-foreground :::: .*';
      if regex.Exec(s) Then
      begin
        r := SplitString(s, ' :::: ');
        if r[1] <> '' Then
        begin
          useForegroundCommandCheck.Checked := True;
          commandForegroundColorButton.ButtonColor := StrToInt(r[1]);
        end;
      end;

      regex.Expression := '^command-background :::: .*';
      if regex.Exec(s) Then
      begin
        r := SplitString(s, ' :::: ');
        if r[1] <> '' Then
        begin
          useBackgroundCommandCheck.Checked := True;
          commandBackgroundColorButton.ButtonColor := StrToInt(r[1]);
        end;
      end;

      regex.Expression := '^command-font :::: .*';
      if regex.Exec(s) Then
      begin
        r := SplitString(s, ' :::: ');
        if r[1] <> '' Then
        begin
          useCommandFontCheck.Checked := True;
          commandFontEdit.Text := r[1] + ' :::: ' + r[2];
        end;
      end;

      regex.Expression := '^find-foreground :::: .*';
      if regex.Exec(s) Then
      begin
        r := SplitString(s, ' :::: ');
        if r[1] <> '' Then
        begin
          useFindForegroundColorCheck.Checked := True;
          findForegroundColorButton.ButtonColor := StrToInt(r[1]);
        end;
      end;

      regex.Expression := '^find-font :::: .*';
      if regex.Exec(s) Then
      begin
        r := SplitString(s, ' :::: ');
        if r[1] <> '' Then
        begin
          useFindFontCheck.Checked := True;
          findFontEdit.Text := r[1] + ' :::: ' + r[2];
        end;
      end;

      regex.Expression := '^tag-cache-foreground :::: .*';
      if regex.Exec(s) Then
      begin
        r := SplitString(s, ' :::: ');
        if r[1] <> '' Then
        begin
          useCacheForegroundColorCheck.Checked := True;
          cacheForegroundColorButton.ButtonColor := StrToInt(r[1]);
        end;
      end;

      regex.Expression := '^tag-cache-font :::: .*';
      if regex.Exec(s) Then
      begin
        r := SplitString(s, ' :::: ');
        if r[1] <> '' Then
        begin
          useCacheFontCheck.Checked := True;
          cacheFontEdit.Text := r[1] + ' :::: ' + r[2];
        end;
      end;

      regex.Expression := '^tag-search-foreground :::: .*';
      if regex.Exec(s) Then
      begin
        r := SplitString(s, ' :::: ');
        if r[1] <> '' Then
        begin
          useSearchForegroundColorCheck.Checked := True;
          tagSearchForegroundColorButton.ButtonColor := StrToInt(r[1]);
        end;
      end;

      regex.Expression := '^tag-search-font :::: .*';
      if regex.Exec(s) Then
      begin
        r := SplitString(s, ' :::: ');
        if r[1] <> '' Then
        begin
          useSearchFontCheck.Checked := True;
          searchFontEdit.Text := r[1] + ' :::: ' + r[2];
        end;
      end;

      regex.Expression := '^tag-content-foreground :::: .*';
      if regex.Exec(s) Then
      begin
        r := SplitString(s, ' :::: ');
        if r[1] <> '' Then
        begin
          useContentForegroundColorCheck.Checked := True;
          contentForegroundColorButton.ButtonColor := StrToInt(r[1]);
        end;
      end;

      regex.Expression := '^tag-content-background :::: .*';
      if regex.Exec(s) Then
      begin
        r := SplitString(s, ' :::: ');
        if r[1] <> '' Then
        begin
          useContentBackgroundColorCheck.Checked := True;
          contentBackgroundColorButton.ButtonColor := StrToInt(r[1]);
        end;
      end;

      regex.Expression := '^tag-content-font :::: .*';
      if regex.Exec(s) Then
      begin
        r := SplitString(s, ' :::: ');
        if r[1] <> '' Then
        begin
          useContentFontCheck.Checked := True;
          contentFontEdit.Text := r[1] + ' :::: ' + r[2];
        end;
      end;

      regex.Expression := '^recipes-list-foreground :::: .*';
      if regex.Exec(s) Then
      begin
        r := SplitString(s, ' :::: ');
        if r[1] <> '' Then
        begin
          useRecipesForegroundColorCheck.Checked := True;
          foregroundRecipesColorButton.ButtonColor := StrToInt(r[1]);
        end;
      end;

      regex.Expression := '^recipes-list-font :::: .*';
      if regex.Exec(s) Then
      begin
        r := SplitString(s, ' :::: ');
        if r[1] <> '' Then
        begin
          useRecipesFontCheck.Checked := True;
          recipesListFontEdit.Text := r[1] + ' :::: ' + r[2];
        end;
      end;

      regex.Expression := '^recipes-text-foreground :::: .*';
      if regex.Exec(s) Then
      begin
        r := SplitString(s, ' :::: ');
        if r[1] <> '' Then
        begin
          useRecipesForegroundTextCheck.Checked := True;
          foregroundRecipesTextColorButton.ButtonColor := StrToInt(r[1]);
        end;
      end;

      regex.Expression := '^recipes-text-background :::: .*';
      if regex.Exec(s) Then
      begin
        r := SplitString(s, ' :::: ');
        if r[1] <> '' Then
        begin
          useRecipesBackgroundTextColorCheck.Checked := True;
          backgroundRecipesTextColorButton.ButtonColor := StrToInt(r[1]);
        end;
      end;

      regex.Expression := '^recipes-text-font :::: .*';
      if regex.Exec(s) Then
      begin
        r := SplitString(s, ' :::: ');
        if r[1] <> '' Then
        begin
          useRecipesFontTextCheck.Checked := True;
          fontRecipesTextEdit.Text := r[1] + ' :::: ' + r[2];
        end;
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
  if useLeftForegroundColorCheck.Checked Then
    writeln(filep, 'left-foreground :::: ' + IntToStr(leftForegroundColorButton.ButtonColor));

  if useRightForegroundColorCheck.Checked Then
    writeln(filep, 'right-foreground :::: ' + IntToStr(rightForegroundColorButton.ButtonColor));

  if useLeftFontCheck.Checked Then
    writeln(filep, 'left-font :::: ' + leftFontEdit.Text);

  if useLeftFontCheck.Checked Then
    writeln(filep, 'right-font :::: ' + rightFontEdit.Text);

  if useForegroundCommandCheck.Checked Then
    writeln(filep, 'command-foreground :::: ' + IntToStr(commandForegroundColorButton.ButtonColor));

  if useBackgroundCommandCheck.Checked Then
    writeln(filep, 'command-background :::: ' + IntToStr(commandBackgroundColorButton.ButtonColor));

  if useCommandFontCheck.Checked Then
    writeln(filep, 'command-font :::: ' + commandFontEdit.Text);

  if useFindForegroundColorCheck.Checked Then
    writeln(filep, 'find-foreground :::: ' + IntToStr(findForegroundColorButton.ButtonColor));

  if useFindFontCheck.Checked Then
    writeln(filep, 'find-font :::: ' + findFontEdit.Text);

  if useCacheForegroundColorCheck.Checked Then
    writeln(filep, 'tag-cache-foreground :::: ' + IntToStr(cacheForegroundColorButton.ButtonColor));

  if useCacheFontCheck.Checked Then
    writeln(filep, 'tag-cache-font :::: ' + cacheFontEdit.Text);

  if useSearchForegroundColorCheck.Checked Then
    writeln(filep, 'tag-search-foreground :::: ' + IntToStr(tagSearchForegroundColorButton.ButtonColor));

  if useSearchFontCheck.Checked Then
    writeln(filep, 'tag-search-font :::: ' + searchFontEdit.Text);

  if useContentForegroundColorCheck.Checked Then
    writeln(filep, 'tag-content-foreground :::: ' + IntToStr(contentForegroundColorButton.ButtonColor));

  if useContentBackgroundColorCheck.Checked Then
    writeln(filep, 'tag-content-background :::: ' + IntToStr(contentBackgroundColorButton.ButtonColor));

  if useContentFontCheck.Checked Then
    writeln(filep, 'tag-content-font :::: ' + contentFontEdit.Text);

  if useRecipesForegroundColorCheck.Checked Then
    writeln(filep, 'recipes-list-foreground :::: ' + IntToStr(foregroundRecipesColorButton.ButtonColor));

  if useRecipesFontCheck.Checked Then
    writeln(filep, 'recipes-list-font :::: ' + recipesListFontEdit.Text);

  if useRecipesForegroundTextCheck.Checked Then
    writeln(filep, 'recipes-text-foreground :::: ' + IntToStr(foregroundRecipesTextColorButton.ButtonColor));

  if useRecipesBackgroundTextColorCheck.Checked Then
    writeln(filep, 'recipes-text-background :::: ' + IntToStr(backgroundRecipesTextColorButton.ButtonColor));

  if useRecipesFontTextCheck.Checked Then
    writeln(filep, 'recipes-text-font :::: ' + fontRecipesTextEdit.Text);

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

procedure TForm2.DeletePatternButtonClick(Sender: TObject);
begin
  FileCommandList.DeleteSelected;
  FileCommandRegexEntry.Text := '';
  FileCommandCommandEntry.Text := '';
end;

procedure TForm2.ReloadButtonClick(Sender: TObject);
begin
  setConfigFile(configFile);
end;

procedure TForm2.SelectFont(entry: TEdit);
begin
  if FontDialog1.Execute Then
    entry.Text := FontDialog1.Font.Name + ' :::: ' + IntToStr(FontDialog1.Font.Size);
end;

procedure TForm2.searchSelectFontButtonClick(Sender: TObject);
begin
  selectFont(searchFontEdit);
end;

procedure TForm2.selectCommandFontButtonClick(Sender: TObject);
begin
  selectFont(commandFontEdit);
end;

procedure TForm2.selectContentFontButtonClick(Sender: TObject);
begin
  selectFont(contentFontEdit);
end;

procedure TForm2.selectFontFindButtonClick(Sender: TObject);
begin
  selectFont(findFontEdit);
end;

procedure TForm2.selectFontRecipesButtonClick(Sender: TObject);
begin
  selectFont(recipesListFontEdit);
end;

procedure TForm2.selectFontRecipesTextButtonClick(Sender: TObject);
begin
  selectFont(fontRecipesTextEdit);
end;

procedure TForm2.leftFontSelectButtonClick(Sender: TObject);
begin
  selectFont(leftFontEdit);
end;

procedure TForm2.rightFontSelectButtonClick(Sender: TObject);
begin
  selectFont(rightFontEdit);
end;

procedure TForm2.cacheSelectFontButtonClick(Sender: TObject);
begin
  selectFont(cacheFontEdit);
end;

end.

