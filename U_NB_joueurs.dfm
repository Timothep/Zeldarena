object F_Nb_J: TF_Nb_J
  Left = 180
  Top = 111
  Width = 194
  Height = 139
  Caption = 'Nombre de Joueurs'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 185
    Height = 105
    Caption = 'Nombre de joueurs humains'
    TabOrder = 0
    object Button1: TButton
      Left = 112
      Top = 80
      Width = 49
      Height = 17
      Caption = 'Continuer'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 24
      Top = 80
      Width = 49
      Height = 17
      Caption = 'Retour'
      TabOrder = 1
      OnClick = Button2Click
    end
    object RadioButton1: TRadioButton
      Left = 24
      Top = 24
      Width = 49
      Height = 17
      Caption = 'Un'
      Checked = True
      TabOrder = 2
      TabStop = True
    end
    object RadioButton2: TRadioButton
      Left = 24
      Top = 48
      Width = 57
      Height = 17
      Caption = 'Deux'
      TabOrder = 3
    end
    object RadioButton3: TRadioButton
      Left = 112
      Top = 24
      Width = 57
      Height = 17
      Caption = 'Trois'
      TabOrder = 4
    end
    object RadioButton4: TRadioButton
      Left = 112
      Top = 48
      Width = 65
      Height = 17
      Caption = 'Quatre'
      TabOrder = 5
    end
  end
end
