object F_Carte: TF_Carte
  Left = 214
  Top = 147
  Width = 919
  Height = 543
  Caption = 'Carte Stylis'#233'e'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object SG_Chemin: TStringGrid
    Left = 0
    Top = 0
    Width = 786
    Height = 509
    Cursor = crHandPoint
    Align = alCustom
    ColCount = 12
    DragCursor = crHandPoint
    FixedCols = 0
    RowCount = 20
    FixedRows = 0
    TabOrder = 0
    OnSelectCell = SG_CheminSelectCell
  end
  object B_Depart: TButton
    Left = 808
    Top = 104
    Width = 75
    Height = 25
    Caption = 'Ajout D'#233'part'
    TabOrder = 1
    OnClick = B_DepartClick
  end
  object B_Obstacle: TButton
    Left = 808
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Ajout Obstacle'
    TabOrder = 2
    OnClick = B_ObstacleClick
  end
  object B_Arrivee: TButton
    Left = 808
    Top = 232
    Width = 75
    Height = 25
    Caption = 'Ajout Arriv'#233'e'
    TabOrder = 3
    OnClick = B_ArriveeClick
  end
  object B_Quitter: TButton
    Left = 816
    Top = 448
    Width = 75
    Height = 25
    Caption = 'Quitter'
    TabOrder = 4
    OnClick = B_QuitterClick
  end
  object B_Recherche: TButton
    Left = 808
    Top = 328
    Width = 75
    Height = 25
    Caption = 'Recherche'
    TabOrder = 5
    OnClick = B_RechercheClick
  end
  object B_raz: TButton
    Left = 808
    Top = 48
    Width = 75
    Height = 25
    Caption = 'RAZ'
    TabOrder = 6
    OnClick = B_razClick
  end
end
