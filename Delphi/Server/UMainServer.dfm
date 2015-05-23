object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'Server (Not Active)'
  ClientHeight = 355
  ClientWidth = 869
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Memo1: TMemo
    Left = 136
    Top = 8
    Width = 609
    Height = 241
    TabOrder = 0
  end
  object Button1: TButton
    Left = 8
    Top = 80
    Width = 90
    Height = 25
    Caption = 'Start Server'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 128
    Width = 90
    Height = 25
    Caption = 'Msg To Client'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 176
    Width = 90
    Height = 25
    Caption = 'Stop Server'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 23
    Top = 296
    Width = 75
    Height = 25
    Caption = 'Start Client'
    TabOrder = 4
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 136
    Top = 279
    Width = 105
    Height = 25
    Caption = 'Open Plugin'
    TabOrder = 5
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 272
    Top = 279
    Width = 105
    Height = 25
    Caption = 'Close Plugin'
    TabOrder = 6
  end
end
