unit UMidiServer;

interface

uses IdContext, IdBaseComponent, IdComponent,IDGlobal,IdIOHandlerSocket,
  IdTCPServer;

type  TSysExData = array of integer;
  TonMidiInEvent = procedure (status,data1,data2:integer) of object;
  TonMidiInSysExEvent = procedure (sysEx:TSysExData) of object;

  TReceiving = record
                 ValuesReceived,HiNibble:integer;
                 MidiIn:TSysExData;
                 secondNibble,ReceivingSysEx:boolean;
               end;
  TMidiServer = class
    private
      FTCPServer: TIdTCPServer;
      FSocket: TIdIOHandlerSocket;
    FActive: boolean;
    FReceiving:TReceiving;
    FonMidiInEvent:TonMidiInEvent;
    FonMidiInSysExEvent:TonMidiInSysExEvent;

    procedure OnConnect(AContext: TIdContext);
    procedure OnDisconnect(AContext: TIdContext);
    procedure OnExecute(AContext: TIdContext);
    procedure SetActive(Value:boolean);
    public
       constructor Create(port:integer);
       procedure WriteMidi(status,data1,data2:integer);
       procedure WriteMidiSysEx(sysex:TSysExData);
       property Active: boolean read FActive write SetActive;
       property OnMidiInEvent: TonMidiInEvent read fonMidiInEvent write fonMidiInEvent;
       property OnMidiInSysExEvent: TonMidiInSysExEvent read fonMidiInSysExEvent write fonMidiInSysExEvent;
     end;

implementation

uses
  System.SysUtils;



{ TMidiServer }

constructor TMidiServer.Create(port: integer);
begin
  FTCPServer:=TIdTCPServer.Create(NIL);
  FTCPServer.DefaultPort:=port;
  FTCPServer.OnConnect:=OnConnect;
  FTCPServer.OnDisconnect:=OnDisconnect;
  FTCPServer.OnExecute:=OnExecute;

end;

procedure TMidiServer.OnConnect(AContext: TIdContext);
begin
  FSocket:=AContext.Connection.Socket;
end;

procedure TMidiServer.OnDisconnect(AContext: TIdContext);
begin
  FSocket:=NIL;
end;

procedure TMidiServer.OnExecute(AContext: TIdContext);
    procedure AddToMidin(n:integer);
    VAR l:integer;
    begin
      l:=Length(FReceiving.MidiIn);
      SetLength(FReceiving.MidiIn,l+1);
      FReceiving.MidiIn[l]:=n;
    end;
    procedure AddIntIn(n:integer);
    begin
      with FReceiving do
      begin
        if (ValuesReceived = 0 )  then
        begin
          ReceivingSysEx:=n = $F0;
          SetLength(MidiIn,0);
        end;
        AddToMidin(n);
        inc(ValuesReceived);
        if not ReceivingSysEx  then
        begin
          if  (ValuesReceived=3) then
          begin
            if assigned(OnMidiInEvent) then OnMidiInEvent(MidiIn[0],MidiIn[1],MidiIn[2]);
            FReceiving.ValuesReceived:=0;
          end
        end
        else
        begin
          if n=$F7 then
          begin
            if assigned(OnMidiInSysExEvent) then OnMidiInSysExEvent(MidiIn);
            ValuesReceived:=0;
          end;
        end;
      end;
    end;
    procedure endChar;
    begin

      FReceiving.secondNibble :=false;
      if not FReceiving.ReceivingSysEx then
        FReceiving.ValuesReceived := 0;
    end;
    procedure addCharIn(n:integer);
    begin
      with FReceiving do
      if (secondNibble) then begin AddIntIn(n+HiNibble); secondNibble:=false; end
                        else begin hiNibble:=16*n;          secondNibble:=true; end;
    end;
VAR Buffer:TIDBytes;
    i:integer;
    c:char;
Begin
//  Memo1.Lines.Add('Client Connected: ');
  FSocket:=AContext.Connection.Socket;
  AContext.Connection.Socket.ReadTimeout:=500;
  AContext.Connection.Socket.ReadBytes(buffer,-1);
  for i:=1 to length(buffer) do
  begin
    c:=chr(buffer[i-1]);
    if (c>='0') and (c<='9') then addCharIn(ord(c)-ord('0'))
    else
    if (c>='A') and (c<='F') then addCharIn(ord(c)-ord('A')+10)
    else
    if (c>='a') and (c<='f') then addCharIn(ord(c)-ord('a')+10)
    else
      endChar;
  end;
End;

procedure TMidiServer.SetActive(Value: boolean);
begin
  FTCPServer.Active:=Value;
  FActive:=FTCPServer.Active;
end;

procedure TMidiServer.WriteMidi(status, data1, data2: integer);
VAR s:string;
begin
  s:=IntToHex(status,2);
  s:=s+IntToHex(data1,2);
  s:=s+IntToHex(data2,2);
  if FSocket<>NIL then
    FSocket.WriteLn(s+'#');
end;

procedure TMidiServer.WriteMidiSysEx(sysex: TSysExData);
VAR s:string;
    i:integer;
begin
  s:='';
  for i:=0 to length(sysex)-1 do
    s:=s+IntToHex(sysex[i],2);
  if FSocket<>NIL then
    FSocket.WriteLn(s+'#');
end;



end.
