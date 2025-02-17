unit processManager;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Process, ASyncProcess;

  procedure ProcessExecute(commandLine: ansistring; list: TList);
  procedure ProcessFree(list: TList);
  procedure ProcessTerminateAll(list: TList);

implementation

procedure ProcessExecute(commandLine: ansistring; list: TList);
var
  process: TASyncProcess;
begin
  process := TASyncProcess.Create(nil);
  process.CommandLine := commandLine;
  process.Options := process.Options + [poUsePipes];
  list.Add(process);
  process.Execute;
end;

procedure ProcessFree(list: TList);
type
  processItem = ^TAsyncProcess;
var
  counter: integer;
  item: Pointer;
  itemsToDelete: array of integer;
  itemsToDeleteCounter: integer;
  process: processItem;
begin
  counter := 0;
  itemsToDeleteCounter := 0;
  for item in list do
  begin
    process := @item;
    if process <> nil Then
    begin
      if process^.Running = False Then
      begin
        try
          setLength(itemsToDelete, length(itemsToDelete) + 1);
          process^.WaitOnExit;
          process^.Free;
          itemsToDelete[itemsToDeleteCounter] := counter;
          itemsToDeleteCounter := itemsToDeleteCounter + 1;
        except
          on E: Exception
          do
            writeln('On processFree: ' + E.ToString);
        end;
      end;

      counter := counter + 1;
    end;
  end;

  for counter := length(itemsToDelete) downto 0 do
  begin
    try
      if list[itemsToDelete[counter]] <> nil Then
        list.Delete(itemsToDelete[counter]);
    except
      on E: Exception do
        writeln('On processFree: ' + E.ToString);
    end;
  end;
end;

procedure ProcessTerminateAll(list: TList);
type
  processItem = ^TAsyncProcess;
var
  item: Pointer;
  process: processItem;
begin
  for item in list do
  begin
    process := @item;
    if process <> nil Then
    begin
      try
        process^.Terminate(1);
        process^.Free;
      except
        on E: Exception do
          writeln('on processTerminateAll: ' + E.ToString);
      end;
    end;
  end;

  list.Clear;
end;

end.

