object Form1: TForm1
  Border = efbSizable
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Size = 8
  Font.Style = []
  FormContainer = 'body'
  FormStyle = fsNormal
  Height = 480
  Left = 0
  OnCreate = Form1Create
  TabOrder = 0
  Top = 0
  Width = 640
  object WebButton1: TWebButton
    Caption = 'GetSDKVersion'
    Color = clNone
    Default = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Size = 8
    Font.Style = []
    Height = 25
    Left = 5
    OnClick = WebButton1Click
    Role = 'button'
    TabOrder = 0
    Top = 6
    Width = 100
  end
  object WebButton2: TWebButton
    Caption = 'GetServerTime'
    Color = clNone
    Default = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Size = 8
    Font.Style = []
    Height = 25
    Left = 5
    OnClick = WebButton2Click
    Role = 'button'
    TabOrder = 0
    Top = 46
    Width = 100
  end
  object WebButton3: TWebButton
    Caption = 'Uninit'
    Color = clNone
    Default = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Size = 8
    Font.Style = []
    Height = 24
    Left = 5
    OnClick = WebButton3Click
    Role = 'button'
    TabOrder = 0
    Top = 84
    Width = 100
  end
  object WebButton4: TWebButton
    Caption = 'Init'
    Color = clNone
    Default = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Size = 8
    Font.Style = []
    Height = 25
    Left = 5
    OnClick = WebButton4Click
    Role = 'button'
    TabOrder = 0
    Top = 123
    Width = 100
  end
end
