unit UMainServer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  IdCustomTCPServer, IdTCPServer, Vcl.StdCtrls,UMidiServer ;

type
  TFormMain = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
    FMidiServer:TMidiServer;
    procedure OnMidiInEvent(status, data1, data2: integer);
    procedure OnMidiInSysExEvent(sysex: TSysExData);
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

const MIDI_CC = $B0;

procedure TFormMain.Button1Click(Sender: TObject);
begin
  FMidiServer.Active:=true;
  Memo1.Lines.Add('Server Activated');
  Caption:='Server (Activate)';
end;

procedure TFormMain.Button2Click(Sender: TObject);
begin
  FMidiServer.WriteMidi(MIDI_CC,$22,$5);
end;

procedure TFormMain.Button3Click(Sender: TObject);
begin
  FMidiServer.Active:=false;
  Caption:='Server (Not Active)';
end;

procedure TFormMain.Button4Click(Sender: TObject);
VAr s:string;
begin
  s:=ParamStr(0);
  s:=Copy(s,1,length(s)-13)+'PrjClient.exe';
  WinExec(PAnsiChar(AnsiString(s)),SW_SHOWNORMAL);
  end;

procedure TFormMain.Button5Click(Sender: TObject);
VAr sysex:TSysExData;
begin
  SetLength(SysEx,5);
  SysEx[0]:=$F0;
  SysEx[1]:=$1;
  SysEx[2]:=$2;
  SysEx[3]:=$3;
  SysEx[4]:=$F0;
  FMidiServer.WriteMidiSysEx(SysEx);
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  Left:=2000;
  FMidiServer:=TMidiServer.Create(1200);
  FMidiServer.OnMidiInEvent:=OnMidiInEvent;
  FMidiServer.OnMidiInSysExEvent:=OnMidiInSysExEvent;
end;

procedure TFormMain.OnMidiInEvent(status,data1,data2:integer);
VAR s:string;
begin
  s:=IntToHex(status,2);
  s:=s+IntToHex(data1,2);
  s:=s+IntToHex(data2,2);
  Memo1.Lines.Add('MidiIn:'+ s);
end;

procedure TFormMain.OnMidiInSysExEvent(sysex:TSysExData);
VAR s:string;
    i:integer;
begin
  s:='';
  for i:=0 to length(sysex)-1 do
    s:=s+IntToHex(sysex[i],2);
  Memo1.Lines.Add('MidiInSysEx:'+s);
end;



end.
