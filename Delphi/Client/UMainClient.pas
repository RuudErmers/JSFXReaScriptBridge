unit UMainClient;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  IdCustomTCPServer, IdTCPServer, Vcl.StdCtrls,
  Web.Win.Sockets, IdContext, IdBaseComponent, IdComponent,IDGlobal,
  IdTCPConnection, IdTCPClient, Vcl.ExtCtrls;

type
  TForm8 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    IdTCPClient1: TIdTCPClient;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure IdTCPClient1Connected(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  Form8: TForm8;

implementation

{$R *.dfm}

procedure TForm8.Button1Click(Sender: TObject);
begin
  IdTCPClient1.Connect;
  Memo1.Lines.Add('Try Connect To Server');
end;

procedure TForm8.Button2Click(Sender: TObject);
begin
  IdTCPClient1.Socket.WriteLn('fiets');
  Memo1.Lines.Add('Message Send');
end;

procedure TForm8.Button3Click(Sender: TObject);
begin
  IdTCPClient1.Disconnect;
end;

procedure TForm8.IdTCPClient1Connected(Sender: TObject);
begin
  Memo1.Lines.Add('Connected');
end;


procedure TForm8.Timer1Timer(Sender: TObject);
VAR b:integer;
begin
  try
    b:=IdTCPClient1.IOHandler.ReadByte;
    Memo1.Lines.Add(inttostr(ord(b)));
  except end;
end;

end.
