object F_Crea_Carte: TF_Crea_Carte
  Left = 3
  Top = 3
  Width = 683
  Height = 563
  Caption = 'Cr'#233'ation Carte'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object DG_Carte: TDrawGrid
    Left = 0
    Top = 0
    Width = 664
    Height = 499
    ColCount = 20
    DefaultColWidth = 32
    DefaultRowHeight = 32
    DefaultDrawing = False
    Enabled = False
    FixedCols = 0
    RowCount = 15
    FixedRows = 0
    Options = [goVertLine, goHorzLine]
    ScrollBars = ssNone
    TabOrder = 0
    OnClick = DG_CarteClick
  end
  object MainMenu1: TMainMenu
    Top = 32
    object Fichier1: TMenuItem
      Caption = 'Fichier'
      object M_Nouvelle_carte: TMenuItem
        Caption = 'Nouvelle carte'
        ShortCut = 16462
        OnClick = M_Nouvelle_carteClick
      end
      object M_Ouvrir: TMenuItem
        Caption = 'Ouvrir'
        ShortCut = 16463
        OnClick = M_OuvrirClick
      end
      object M_Sauver: TMenuItem
        Caption = 'Enregistrer'
        ShortCut = 16467
        OnClick = M_SauverClick
      end
      object M_Quitter: TMenuItem
        Caption = 'Quitter'
        ShortCut = 16467
        OnClick = M_QuitterClick
      end
    end
    object Affichage1: TMenuItem
      Caption = 'Affichage'
      object M_Banques_images: TMenuItem
        Caption = 'Banques d'#39'images'
        OnClick = M_Banques_imagesClick
      end
      object M_Description_carte: TMenuItem
        Caption = 'Description de la carte'
        OnClick = M_Description_carteClick
      end
    end
    object Options1: TMenuItem
      Caption = 'Options'
      object UniversHerbe: TMenuItem
        Caption = 'Univers Herbe'
        Enabled = False
        OnClick = UniversHerbeClick
      end
      object UniversEau: TMenuItem
        Caption = 'Univers Eau'
        Enabled = False
        OnClick = UniversEauClick
      end
      object UniversTerre: TMenuItem
        Caption = 'Univers Terre'
        Enabled = False
        OnClick = UniversTerreClick
      end
      object Masquerlesartefacts1: TMenuItem
        Caption = 'Masquer les artefacts'
        Enabled = False
        OnClick = Masquerlesartefacts1Click
      end
      object Afficherlesartefacts1: TMenuItem
        Caption = 'Tout afficher'
        Enabled = False
        OnClick = Afficherlesartefacts1Click
      end
    end
    object Help1: TMenuItem
      Caption = 'Help'
      object M_Regles: TMenuItem
        Caption = 'R'#234'gles'
        OnClick = M_ReglesClick
      end
    end
  end
  object OD_Map: TOpenDialog
    Filter = 'Fichiers  Cartes (*.map)|*.map'
    InitialDir = 'Maps'
  end
  object SaveDialog1: TSaveDialog
    Filter = 'Fichiers Cartes (*.map)|*.map'
    Left = 32
  end
end
