object F_Regles_crea_cartes: TF_Regles_crea_cartes
  Left = 200
  Top = 200
  Width = 449
  Height = 312
  Caption = 'R'#234'gles de cr'#233'ation de cartes'
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
    Top = 0
    Width = 155
    Height = 13
    Caption = 'Cr'#233'er une nouvelle cartes :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 16
    Width = 352
    Height = 13
    Caption = 
      'Cliquez tout d'#39'abord sur Fichier/Nouvelle carte pour cr'#233'er une c' +
      'arte vierge.'
  end
  object Label3: TLabel
    Left = 8
    Top = 32
    Width = 352
    Height = 13
    Caption = 
      'N'#39'oubliez pas d'#39'entrer un nom et de s'#233'lectionner une taille pour' +
      ' votre carte.'
  end
  object Label4: TLabel
    Left = 8
    Top = 48
    Width = 127
    Height = 13
    Caption = 'Votre carte est alors cr'#233#233'e.'
  end
  object Label5: TLabel
    Left = 8
    Top = 80
    Width = 313
    Height = 13
    Caption = 'Vous devez d'#233'poser les diff'#233'rentes images composant votre carte.'
  end
  object Label6: TLabel
    Left = 16
    Top = 112
    Width = 317
    Height = 13
    Caption = 
      '...puis cliquez sur la case ou vous souhaitez voir l'#39'image appar' +
      'a'#238'tre.'
  end
  object Label7: TLabel
    Left = 16
    Top = 128
    Width = 422
    Height = 13
    Caption = 
      'Une fois que vous avez enti'#232'rement recouvert la carte, vous pouv' +
      'ez ajouter des artefacts'
  end
  object Label9: TLabel
    Left = 16
    Top = 96
    Width = 349
    Height = 13
    Caption = 
      'Cliquez sur l'#39'images que vous souhaitez ins'#233'rer dans la banque d' +
      #39'images...'
  end
  object Label12: TLabel
    Left = 8
    Top = 64
    Width = 205
    Height = 13
    Caption = 'Ajouter des '#233'l'#233'ments dans la carte :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label13: TLabel
    Left = 8
    Top = 144
    Width = 70
    Height = 13
    Caption = 'Enregistrer :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label14: TLabel
    Left = 8
    Top = 160
    Width = 416
    Height = 13
    Caption = 
      'Une fen'#234'tre d'#39'enregistrement s'#39'ouvre et vous choisissez le nom d' +
      'u fichier de sauvegarde'
  end
  object Label17: TLabel
    Left = 8
    Top = 224
    Width = 138
    Height = 13
    Caption = 'Description de la carte :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label18: TLabel
    Left = 8
    Top = 240
    Width = 400
    Height = 13
    Caption = 
      'Ins'#233'rez dans la rubrique description un commentaire sur la carte' +
      ' ainsi que votre nom..'
  end
  object Label8: TLabel
    Left = 8
    Top = 176
    Width = 389
    Height = 13
    Caption = 
      'Si vous entrez comme nom de fichier une extension, celle ci sera' +
      ' prise comme nom'
  end
  object Label10: TLabel
    Left = 16
    Top = 192
    Width = 354
    Height = 13
    Caption = 
      'Par ex si vous entrez "carte.map", le nom de la carte sera "cart' +
      'e.map.map"'
  end
  object Label11: TLabel
    Left = 8
    Top = 208
    Width = 335
    Height = 13
    Caption = 
      'Pour plus de facilit'#233's, sauvegardez les cartes dans le r'#233'pertoir' +
      'e "\Map"'
  end
  object B_Quitter: TButton
    Left = 192
    Top = 256
    Width = 57
    Height = 17
    Caption = 'Ok'
    TabOrder = 0
    OnClick = B_QuitterClick
  end
end
