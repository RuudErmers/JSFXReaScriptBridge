object Form8: TForm8
  Left = 0
  Top = 0
  Caption = 'Client'
  ClientHeight = 355
  ClientWidth = 869
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 120
  TextHeight = 16
  object Memo1: TMemo
    Left = 168
    Top = 24
    Width = 609
    Height = 241
    TabOrder = 0
  end
  object Button1: TButton
    Left = 8
    Top = 80
    Width = 137
    Height = 25
    Caption = 'Connect To Server'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 128
    Width = 137
    Height = 25
    Caption = 'Msg To Server'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 176
    Width = 137
    Height = 25
    Caption = 'Disconnet From Server'
    TabOrder = 3
    OnClick = Button3Click
  end
  object IdTCPClient1: TIdTCPClient
    OnConnected = IdTCPClient1Connected
    ConnectTimeout = 0
    Host = '127.0.0.1'
    IPVersion = Id_IPv4
    Port = 1200
    ReadTimeout = 5
    Left = 48
    Top = 232
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 432
    Top = 184
  end
end
