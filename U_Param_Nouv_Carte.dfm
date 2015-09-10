object F_Param_Carte: TF_Param_Carte
  Left = 200
  Top = 100
  Width = 226
  Height = 228
  Caption = 'Nouvelle Carte'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 24
    Width = 75
    Height = 13
    Caption = 'Nom de la carte'
  end
  object Label3: TLabel
    Left = 40
    Top = 6
    Width = 133
    Height = 13
    Caption = 'Cr'#233'ation nouvelle carte'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object B_Annuler: TButton
    Left = 24
    Top = 168
    Width = 75
    Height = 17
    Caption = 'Annuler'
    TabOrder = 0
    OnClick = B_AnnulerClick
  end
  object B_Creer: TButton
    Left = 120
    Top = 168
    Width = 75
    Height = 17
    Caption = 'Cr'#233'er'
    TabOrder = 1
    OnClick = B_CreerClick
  end
  object E_Nom_Carte: TEdit
    Left = 88
    Top = 24
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'Carte'
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 48
    Width = 201
    Height = 113
    Caption = 'Taille'
    TabOrder = 3
    object RB_petite: TRadioButton
      Left = 40
      Top = 16
      Width = 113
      Height = 17
      Caption = 'Petite       (20*15)'
      TabOrder = 0
    end
    object RB_Moyenne: TRadioButton
      Left = 40
      Top = 32
      Width = 113
      Height = 17
      Caption = 'Moyenne (40*30)'
      Enabled = False
      TabOrder = 1
    end
    object RB_Grande: TRadioButton
      Left = 40
      Top = 48
      Width = 113
      Height = 17
      Caption = 'Grande    (60*45)'
      Enabled = False
      TabOrder = 2
    end
    object StaticText1: TStaticText
      Left = 8
      Top = 72
      Width = 174
      Height = 17
      Caption = '(Vous ne pouvez actuellement cr'#233'er'
      TabOrder = 3
    end
    object StaticText2: TStaticText
      Left = 16
      Top = 88
      Width = 145
      Height = 17
      Caption = 'que des cartes de petite taille)'
      TabOrder = 4
    end
  end
end
