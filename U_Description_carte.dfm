object F_Description_Carte: TF_Description_Carte
  Left = 688
  Top = 485
  Width = 226
  Height = 227
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSizeToolWin
  Caption = 'Description de la carte'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GB_Description: TGroupBox
    Left = 0
    Top = 0
    Width = 217
    Height = 193
    Align = alLeft
    TabOrder = 0
    object Label_nom: TLabel
      Left = 2
      Top = 6
      Width = 81
      Height = 13
      Caption = 'Nom de la carte :'
    end
    object L_Nom_Carte: TLabel
      Left = 88
      Top = 6
      Width = 21
      Height = 13
      Caption = 'Vide'
    end
    object Label1: TLabel
      Left = 2
      Top = 22
      Width = 84
      Height = 13
      Caption = 'Taille de la carte :'
    end
    object L_Taille: TLabel
      Left = 88
      Top = 22
      Width = 21
      Height = 13
      Caption = 'Vide'
    end
    object Label2: TLabel
      Left = 8
      Top = 85
      Width = 112
      Height = 13
      Caption = 'Description de la carte :'
    end
    object Label3: TLabel
      Left = 8
      Top = 126
      Width = 40
      Height = 13
      Caption = 'Cr'#233'ateur'
    end
    object Label4: TLabel
      Left = 8
      Top = 152
      Width = 85
      Height = 13
      Caption = 'Date de cr'#233'ation :'
    end
    object L_Date: TLabel
      Left = 104
      Top = 152
      Width = 21
      Height = 13
      Caption = 'Vide'
    end
    object L_Heure: TLabel
      Left = 104
      Top = 164
      Width = 21
      Height = 13
      Caption = 'Vide'
    end
    object Label6: TLabel
      Left = 8
      Top = 164
      Width = 91
      Height = 13
      Caption = 'Heure de cr'#233'ation :'
    end
    object E_Description: TEdit
      Left = 8
      Top = 100
      Width = 201
      Height = 21
      TabOrder = 0
    end
    object E_Createur: TEdit
      Left = 64
      Top = 124
      Width = 145
      Height = 21
      TabOrder = 1
    end
    object B_Change: TButton
      Left = 72
      Top = 36
      Width = 89
      Height = 17
      Caption = 'Changer de nom'
      TabOrder = 2
      OnClick = B_ChangeClick
    end
    object E_Nom: TEdit
      Left = 64
      Top = 58
      Width = 113
      Height = 21
      TabOrder = 3
      Text = 'Nouveau_Nom'
    end
  end
  object StaticText1: TStaticText
    Left = 24
    Top = 0
    Width = 173
    Height = 17
    Caption = 'DESCRIPTION DE LA CARTE'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
  end
end
