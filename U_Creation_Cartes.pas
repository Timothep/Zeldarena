{JEU ZELDARENA - SAND
JOACHIM BOUSSOUMAH      GPBb
TIMOTHEE BOURGUIGNON    GPAa
EPF2}
unit U_Creation_Cartes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, Menus, ExtCtrls, U_types;

type
  TF_Crea_Carte = class(TForm)
    DG_Carte: TDrawGrid;
    MainMenu1: TMainMenu;
    Fichier1: TMenuItem;
    M_Quitter: TMenuItem;
    M_Ouvrir: TMenuItem;
    M_Sauver: TMenuItem;
    M_Nouvelle_carte: TMenuItem;
    Help1: TMenuItem;
    M_Regles: TMenuItem;
    Affichage1: TMenuItem;
    M_Banques_images: TMenuItem;
    M_Description_carte: TMenuItem;
    OD_Map: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Options1: TMenuItem;
    UniversHerbe: TMenuItem;
    UniversEau: TMenuItem;
    UniversTerre: TMenuItem;
    Masquerlesartefacts1: TMenuItem;
    Afficherlesartefacts1: TMenuItem;
    procedure M_QuitterClick(Sender: TObject);
    procedure M_Nouvelle_carteClick(Sender: TObject);
    procedure DG_CarteClick(Sender: TObject);
    procedure M_ReglesClick(Sender: TObject);
    procedure M_Banques_imagesClick(Sender: TObject);
    procedure M_Description_carteClick(Sender: TObject);
    procedure M_SauverClick(Sender: TObject);
    procedure M_OuvrirClick(Sender: TObject);
    procedure UniversHerbeClick(Sender: TObject);
    procedure UniversEauClick(Sender: TObject);
    procedure UniversTerreClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure Afficherlesartefacts1Click(Sender: TObject);
    procedure Masquerlesartefacts1Click(Sender: TObject);
  private
    { Private declarations }
    Procedure AFFICHAGE_ALL;
    Procedure MISE_A_ZERO;
  public
    { Public declarations }
    procedure NOUVELLE_CARTE(Nom:string;Taille:string);
    Procedure PUT_MATRICE(i,j,Nombre:integer);
    Function GET_MATRICE(i,j:integer):integer;
    Procedure PUT_MATRICE2(i,j,Nombre:integer);
    Function GET_MATRICE2(i,j:integer):integer;
    Procedure RAFFRAICH;
  end;
  Function REMPLI:boolean;
var
  F_Crea_Carte: TF_Crea_Carte;
  Scroll_H,Scroll_V:integer;
  Marchable:boolean;
  Matrice, Matrice2 : array of array of integer ;
  Termine:boolean;
implementation

uses U_Accueil, U_Param_Nouv_Carte, U_FA_creation_cartes,
  U_Regles_crea_cartes, U_Description_carte, U_Banque_Images, U_Splash;

{$R *.dfm}
//*****************************************************************************//
//*****************************************************************************//

Procedure TF_Crea_Carte.PUT_MATRICE(i,j,Nombre:integer);
Begin
Matrice[i,j]:=Nombre;
end;
Function TF_Crea_Carte.GET_MATRICE(i,j:integer):integer;
Begin
GET_MATRICE:=Matrice[i,j];
End;
Procedure TF_Crea_Carte.PUT_MATRICE2(i,j,Nombre:integer);
Begin
Matrice2[i,j]:=Nombre;
end;
Function TF_Crea_Carte.GET_MATRICE2(i,j:integer):integer;
Begin
GET_MATRICE2:=Matrice2[i,j];
End;

//*****************************************************************************//
//*****************************************************************************//

Procedure TF_Crea_Carte.RAFFRAICH;
Begin
F_Crea_Carte.DG_Carte.Repaint;
End;

//*****************************************************************************//
//*****************************************************************************//

//Module de vidage des deux tableaux
Procedure TF_Crea_Carte.MISE_A_ZERO;
//Vide les deux matrices en remplaçant toutes les valeurs par zéro
//En entrée et en sortie : rien
Var
i,j:integer;
Begin
//Effaçage de la première matrice
For i:=0 to High(Matrice) do
        For j:=0 to High(Matrice[i]) do
                PUT_MATRICE(i,j,0);
//Effaçage de la deuxième matrice
For i:=0 to High(Matrice2) do
        For j:=0 to High(Matrice2[i]) do
                PUT_MATRICE2(i,j,0);
//Repainting
F_Crea_Carte.RAFFRAICH;
End;

//*****************************************************************************//
//*****************************************************************************//

procedure TF_Crea_Carte.M_QuitterClick(Sender: TObject);
begin
//Quitter sans enregister
if MessageDlg('Vous êtes sur le point de quitter le mode de création de cartes?'+#13+'Continuer?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        begin
        F_Crea_Carte.MISE_A_ZERO;
        F_Crea_Carte.FormStyle:=fsNormal;
        F_Crea_Carte.Hide;
        F_Description_Carte.Hide;
        F_Banque_Images.Hide;
        F_Accueil.Show;
        end;
end;

//*****************************************************************************//
//*****************************************************************************//

procedure TF_Crea_Carte.M_Nouvelle_carteClick(Sender: TObject);
begin
//Reinitialisation du dossier initial
SetCurrentDir(Dossier_initial);
//Ouverture de la fiche de reglages d'une nouvelle carte
F_Param_Carte.show;
end;

//*****************************************************************************//
//*****************************************************************************//

//Module de mise à jour des informations concernant la nouvelle carte
procedure TF_Crea_Carte.NOUVELLE_CARTE(Nom:string;Taille:string);
//En entrée : Nom : Nom de la carte
//En entrée : Taille : Taille de la carte
begin
//Mise a zéro de la carte
F_Crea_Carte.MISE_A_ZERO;
//Remplissage des champs de description de la carte
F_Description_Carte.L_Nom_Carte.Caption:=Nom;
F_Description_Carte.L_Taille.Caption:=Taille;
F_Description_Carte.L_Date.Caption:=Datetostr(Now);
F_Description_Carte.L_Heure.Caption:=Timetostr(Now);
UniversHerbe.Enabled:=True;
UniversEau.Enabled:=True;
UniversTerre.Enabled:=True;
Masquerlesartefacts1.Enabled:=True;
Afficherlesartefacts1.Enabled:=True;
end;

//*****************************************************************************//
//*****************************************************************************//

//Module d'affichage de toutes les images deja insérées dans le tableau
Procedure TF_Crea_Carte.AFFICHAGE_ALL;
//Module graphique d'affichage des données
//En entrée et en sortie : rien
Var
i,j,k,l:integer; //Variables temporaires de visualisation des tableaux
Begin
//On passe en revue tout la matrice
//Pour i variant de 0 (première case de la matrice)...
//...au nombre de colonnes de la Matrice
For i:=0 to High(Matrice) do
        //Pour j variant de 0 (première case de la matrice)...
        //...au nombre de lignes de la Matrice
        For j:=0 to High(Matrice[i]) do
                Begin
                //Cas ou le numéro compris dans la matrice appartient à l'ensemble [1,40]+76 (ancien zéro)
                Case Matrice[i,j] of
                1 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image1.Picture.Graphic);
                2 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image2.Picture.Graphic);
                3 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image3.Picture.Graphic);
                4 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image4.Picture.Graphic);
                5 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image5.Picture.Graphic);
                6 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image6.Picture.Graphic);
                7 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image7.Picture.Graphic);
                8 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image8.Picture.Graphic);
                9 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image9.Picture.Graphic);

                10 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image10.Picture.Graphic);
                11 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image11.Picture.Graphic);
                12 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image12.Picture.Graphic);
                13 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image13.Picture.Graphic);
                14 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image14.Picture.Graphic);
                15 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image15.Picture.Graphic);
                16 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image16.Picture.Graphic);
                17 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image17.Picture.Graphic);
                18 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image18.Picture.Graphic);
                19 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image19.Picture.Graphic);

                20 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image20.Picture.Graphic);
                21 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image21.Picture.Graphic);
                22 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image22.Picture.Graphic);
                23 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image23.Picture.Graphic);
                24 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image24.Picture.Graphic);
                25 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image25.Picture.Graphic);
                26 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image26.Picture.Graphic);
                27 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image27.Picture.Graphic);
                28 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image28.Picture.Graphic);
                29 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image29.Picture.Graphic);

                30 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image30.Picture.Graphic);
                31 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image31.Picture.Graphic);
                32 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image32.Picture.Graphic);
                33 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image33.Picture.Graphic);
                34 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image34.Picture.Graphic);
                35 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image35.Picture.Graphic);
                36 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image36.Picture.Graphic);
                37 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image37.Picture.Graphic);
                38 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image38.Picture.Graphic);
                39 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image39.Picture.Graphic);

                40 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image40.Picture.Graphic);
                66 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image66.Picture.Graphic);

                End;
                End;
//Affichage des artefacts
For k:=0 to High(Matrice2) do
        //Pour j variant de 0 (première case de la matrice)...
        //...au nombre de lignes de la Matrice
        For l:=0 to High(Matrice2[k]) do
                Begin
                //Cas ou le numéro compris dans la matrice appartient à l'ensemble [41,75]
                Case Matrice2[k,l] of

                41 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*k+k,TILE_SIZE*l+l,F_Banque_Images.Image41.Picture.Graphic);
                42 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*k+k,TILE_SIZE*l+l,F_Banque_Images.Image42.Picture.Graphic);
                43 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*k+k,TILE_SIZE*l+l,F_Banque_Images.Image43.Picture.Graphic);
                44 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*k+k,TILE_SIZE*l+l,F_Banque_Images.Image44.Picture.Graphic);
                45 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*k+k,TILE_SIZE*l+l,F_Banque_Images.Image45.Picture.Graphic);
                46 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*k+k,TILE_SIZE*l+l,F_Banque_Images.Image46.Picture.Graphic);
                47 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*k+k,TILE_SIZE*l+l,F_Banque_Images.Image47.Picture.Graphic);
                48 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*k+k,TILE_SIZE*l+l,F_Banque_Images.Image48.Picture.Graphic);
                49 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*k+k,TILE_SIZE*l+l,F_Banque_Images.Image49.Picture.Graphic);

                50 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*k+k,TILE_SIZE*l+l,F_Banque_Images.Image50.Picture.Graphic);
                51 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*k+k,TILE_SIZE*l+l,F_Banque_Images.Image51.Picture.Graphic);
                52 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*k+k,TILE_SIZE*l+l,F_Banque_Images.Image52.Picture.Graphic);
                53 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*k+k,TILE_SIZE*l+l,F_Banque_Images.Image53.Picture.Graphic);
                54 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*k+k,TILE_SIZE*l+l,F_Banque_Images.Image54.Picture.Graphic);
                55 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*k+k,TILE_SIZE*l+l,F_Banque_Images.Image55.Picture.Graphic);
                56 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*k+k,TILE_SIZE*l+l,F_Banque_Images.Image56.Picture.Graphic);
                57 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*k+k,TILE_SIZE*l+l,F_Banque_Images.Image57.Picture.Graphic);
                58 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*k+k,TILE_SIZE*l+l,F_Banque_Images.Image58.Picture.Graphic);
                59 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*k+k,TILE_SIZE*l+l,F_Banque_Images.Image59.Picture.Graphic);

                60 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*k+k,TILE_SIZE*l+l,F_Banque_Images.Image60.Picture.Graphic);
                61 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*k+k,TILE_SIZE*l+l,F_Banque_Images.Image61.Picture.Graphic);
                62 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*k+k,TILE_SIZE*l+l,F_Banque_Images.Image62.Picture.Graphic);
                63 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*k+k,TILE_SIZE*l+l,F_Banque_Images.Image63.Picture.Graphic);
                64 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*k+k,TILE_SIZE*l+l,F_Banque_Images.Image64.Picture.Graphic);
                65 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*k+k,TILE_SIZE*l+l,F_Banque_Images.Image65.Picture.Graphic);
                66 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*k+k,TILE_SIZE*l+l,F_Banque_Images.Image66.Picture.Graphic);

                67 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*k+k,TILE_SIZE*l+l,F_Banque_Images.Image67.Picture.Graphic);
                68 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*k+k,TILE_SIZE*l+l,F_Banque_Images.Image68.Picture.Graphic);
                69 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*k+k,TILE_SIZE*l+l,F_Banque_Images.Image69.Picture.Graphic);
                70 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*k+k,TILE_SIZE*l+l,F_Banque_Images.Image70.Picture.Graphic);
                71 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*k+k,TILE_SIZE*l+l,F_Banque_Images.Image71.Picture.Graphic);
                72 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*k+k,TILE_SIZE*l+l,F_Banque_Images.Image72.Picture.Graphic);
                73 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*k+k,TILE_SIZE*l+l,F_Banque_Images.Image73.Picture.Graphic);
                74 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*k+k,TILE_SIZE*l+l,F_Banque_Images.Image74.Picture.Graphic);
                75 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*k+k,TILE_SIZE*l+l,F_Banque_Images.Image75.Picture.Graphic);
                76 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*k+k,TILE_SIZE*l+l,F_Banque_Images.Image76.Picture.Graphic);
                77 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*k+k,TILE_SIZE*l+l,F_Banque_Images.Image77.Picture.Graphic);
                78 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*k+k,TILE_SIZE*l+l,F_Banque_Images.Image78.Picture.Graphic);
                79 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*k+k,TILE_SIZE*l+l,F_Banque_Images.Image79.Picture.Graphic);
                80 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*k+k,TILE_SIZE*l+l,F_Banque_Images.Image80.Picture.Graphic);
                81 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*k+k,TILE_SIZE*l+l,F_Banque_Images.Image81.Picture.Graphic);
                82 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*k+k,TILE_SIZE*l+l,F_Banque_Images.Image82.Picture.Graphic);
                83 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*k+k,TILE_SIZE*l+l,F_Banque_Images.Image83.Picture.Graphic);
                84 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*k+k,TILE_SIZE*l+l,F_Banque_Images.Image84.Picture.Graphic);
                85 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*k+k,TILE_SIZE*l+l,F_Banque_Images.Image85.Picture.Graphic);
                86 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*k+k,TILE_SIZE*l+l,F_Banque_Images.Image86.Picture.Graphic);
                87 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*k+k,TILE_SIZE*l+l,F_Banque_Images.Image87.Picture.Graphic);
                88 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*k+k,TILE_SIZE*l+l,F_Banque_Images.Image88.Picture.Graphic);
                End;
                End;
End;

//*****************************************************************************//
//*****************************************************************************//

//Module d'ajout de la case courante dans le tableau lors du clic sur une cellule
procedure TF_Crea_Carte.DG_CarteClick(Sender: TObject);
Var
Col,row:integer;
begin
//Si la draw grid est active et que l'on souhaite ajouter un élément (89=gomme)
If (F_Crea_Carte.DG_Carte.Enabled=true) and (num<>NUM_GOMME) then
        Begin
        //Selection des colones et lignes courantes de la drawgrid
        Row:=F_Crea_Carte.DG_Carte.Row;
        Col:=F_Crea_Carte.DG_Carte.Col;
        //Insertion du n° de l'image courante dans la Matrice de sauvegarde
        //Si c'est un terrain
        If (num<DERNIER_TER) or (num=NUM_EAU)
                then //alors on l'ajoute dans la première matrice
                F_Crea_Carte.PUT_MATRICE(Col,Row,Num)
                Else //sinon on l'ajoute dans la deuxième matrice
                F_Crea_Carte.PUT_MATRICE2(Col,Row,Num);
        //Réaffichage de la case en cours
        F_Crea_carte.DG_Carte.Canvas.Draw(F_Crea_Carte.DG_Carte.Col*TILE_SIZE+F_Crea_Carte.DG_Carte.Col,F_Crea_Carte.DG_Carte.Row*TILE_SIZE+F_Crea_Carte.DG_Carte.Row,F_Banque_images.Im_Sur.Picture.Graphic);
        //Réaffichage de toutes les cases
        F_Crea_Carte.AFFICHAGE_ALL;
        //Repaint de tout le composant
        F_Crea_Carte.DG_Carte.Repaint;
        end
        else If num=NUM_GOMME //C'est la gomme
        then //on efface l'artefact courant
                begin
                Row:=F_Crea_Carte.DG_Carte.Row;
                Col:=F_Crea_Carte.DG_Carte.Col;
                F_Crea_Carte.PUT_MATRICE2(Col,Row,0);
                //Réaffichage de toutes les cases
                F_Crea_Carte.AFFICHAGE_ALL;
                //Repaint de tout le composant
                F_Crea_Carte.DG_Carte.Repaint;
                end;
End;

//*****************************************************************************//
//*****************************************************************************//

//*****************************************************************************//
//*****************************************************************************//

//Affichage de la fenetre contenant les rêgles
procedure TF_Crea_Carte.M_ReglesClick(Sender: TObject);
begin
F_Regles_crea_cartes.Show;
end;

//*****************************************************************************//
//*****************************************************************************//

//Affichage de la banque d'images
procedure TF_Crea_Carte.M_Banques_imagesClick(Sender: TObject);
begin
F_Banque_Images.Show;
end;

//*****************************************************************************//
//*****************************************************************************//

//Affichage de la description de la carte
procedure TF_Crea_Carte.M_Description_carteClick(Sender: TObject);
begin
F_Description_Carte.Show;
end;

//*****************************************************************************//
//*****************************************************************************//

//Teste si tout le terrain de niveau 1 est bien rempli
Function REMPLI:boolean;
Var
i,j:integer;
Begin
REMPLI:=true;
For i:=0 to High (Matrice[0]) do
        For j:=0 to High (Matrice) do
                If Matrice[j,i]=0 then REMPLI:=False;
End;

//*****************************************************************************//
//*****************************************************************************//

//Module d'enregistrement de la carte
procedure TF_Crea_Carte.M_SauverClick(Sender: TObject);
//En entrée et en sortie : rien
Var
Fic_Des, Fic_Ter, Fic_Art:Textfile;  //Noms logiques des fichiers Text utilisés
i,j:integer;                         //Variables lignes et colonnes de la matrice
begin
//Reinitialisation du dossier initial
SetCurrentDir(Dossier_initial);
//Si tout est bien rempli
If REMPLI then
Begin
//Initialisation du nom initial de la SaveBox
SaveDialog1.FileName:=F_Description_Carte.L_Nom_Carte.Caption;
//Si l'utilisateur a effectivement cliqué sur sauver
If savedialog1.execute
        then //Il faut enregistrer les informations concerntant les cartes dans les fichiers adéquats
        Begin
        //Assignation des noms logiques & Physiques
        Assignfile(Fic_Des,SaveDialog1.FileName+MAP_EXTENSION);
        Assignfile(Fic_Ter,SaveDialog1.FileName+TER_EXTENSION);
        Assignfile(Fic_Art,SaveDialog1.FileName+ART_EXTENSION);

        //Enregistrement du fichier de description
        //Ouverture du fichier de description (Avec écrasement)
        Rewrite(Fic_Des);
        //Ecriture des données
        Writeln(Fic_Des,F_Description_Carte.L_Nom_Carte.Caption);
        Writeln(Fic_Des,F_Description_Carte.L_Taille.Caption);
        Writeln(Fic_Des,F_Description_Carte.E_Description.Text);
        Writeln(Fic_Des,F_Description_Carte.E_Createur.Text);
        Writeln(Fic_Des,F_Description_Carte.L_Date.Caption);
        Writeln(Fic_Des,F_Description_Carte.L_Heure.Caption);
        //Fermeture du fichier
        CloseFile(Fic_Des);
        //Enregistrement du terrain
        //Ouverture du fichier de Terrain (Avec écrasement)
        Rewrite(Fic_Ter);
        //On parcours la matrice du terrain
        For i:=0 to High(Matrice[0]) do
                Begin
                For j:=0 to High(Matrice) do
                        begin
                        //Ecriture du numéro et d'un espace pour séparer les valeurs dans la matrice créée
                        Write(Fic_Ter,Matrice[j,i]);
                        Write(Fic_Ter,' ');
                        end;
                //Retour à la ligne
                Writeln(Fic_Ter);
                End;
        //Fermeture du fichier
        CloseFile(Fic_Ter);
        //Enregistrement des artefacts
        //Ouverture du fichier d'artefacts (Avec écrasement)
        Rewrite(Fic_Art);
        //On parcours la matrice des artefacts
        For i:=0 to High(Matrice2[0]) do
                Begin
                For j:=0 to High(Matrice2) do
                        begin
                        //Ecriture du numéro et d'un espace pour séparer les valeurs dans la matrice créée
                        Write(Fic_Art,Matrice2[j,i]);
                        Write(Fic_Art,' ');
                        end;
                //Retour à la ligne
                Writeln(Fic_Art);
                End;
        //Fermeture du fichier
        CloseFile(Fic_Art);
        end
        Else  //Sinon, l'utilisateur a annulé l'opération
        Showmessage('Opération annulée');
End
else
Showmessage('Action impossible car la carte n''est pas totalement remplie'+#13+'au niveau du terrain de permier niveau');
end;

//*****************************************************************************//
//*****************************************************************************//

//Module d'ouveture d'une carte déja créée
procedure TF_Crea_Carte.M_OuvrirClick(Sender: TObject);
Var
Fic_Des, Fic_Ter, Fic_Art:Textfile;   //Noms logiques des fichiers Text utilisés
i,j:integer;                          //Variables lignes et colonnes de la matrice
Taille, Descr, Auteur, Date, Heure, Nom, Nom_Fic:string;   //Variables temporaires de collecte d'informations
Space:char;                           //Caractère d'espacement
begin
//Reinitialisation du dossier initial
SetCurrentDir(Dossier_initial);
//$$$$$$$$$$$$$$$$//
//Si l'utilisateur a effectivement demandé l'ouverture d'un fichier carte
If OD_Map.Execute then
        Begin
        //Mise a zero des structures
        F_Crea_Carte.MISE_A_ZERO;
        //Capture du chemin d'accès au fichier à ouvrir
        For i:=1 to (length(OD_Map.FileName)-LONGUEUR_EXTENSION) do
                begin
                //Le nom et le chemin d'accès sont capturés sans l'extension (les 4 derniers caractères)
                Nom_Fic:=Nom_Fic+OD_Map.FileName[i];
                end;
        //Chargement des infos de description
        //Assignation des noms logiques et physiques et ajout de l'extension souhaitée
        AssignFile(Fic_Des,Nom_Fic+MAP_EXTENSION);
        //Ouverture du fichier (sans écrasement)
        Reset(Fic_Des);
        //Lecture des différentes informations contenues dans le fichier
        readln(Fic_Des,Nom);
        readln(Fic_Des,Taille);
        readln(Fic_Des,Descr);
        readln(Fic_Des,Auteur);
        readln(Fic_Des,Date);
        readln(Fic_Des,Heure);
        //Ecriture de ces variables dans les éléments voulus de la fiche de description
        F_Description_Carte.L_Nom_Carte.Caption:=Nom;
        F_Description_Carte.L_Taille.Caption:=Taille;
        F_Description_Carte.E_Description.Text:=Descr;
        F_Description_Carte.E_Createur.Text:=Auteur;
        F_Description_Carte.L_Date.Caption:=Date;
        F_Description_Carte.L_Heure.Caption:=Heure;
        //Fermeture du fichier
        CloseFile(Fic_Des);

//$$$$$$$$$$$$$$$$//
//Preset des tailles des matrices et de la drawgrid
//Si c'est une petite Carte
If Taille=CHAINE_PET
        then
                Begin
                //Définition de la taille de la Drawgrid
                F_Crea_Carte.DG_Carte.RowCount:=ROW_PET_DG_CARTE;
                F_Crea_Carte.DG_Carte.ColCount:=COL_PET_DG_CARTE;
                F_Crea_Carte.DG_Carte.Width:=WID_PET_DG_CARTE;
                F_Crea_Carte.DG_Carte.Height:=HEI_PET_DG_CARTE;
                //Définition des longueurs des tableaux dynamiques
                SetLength(Matrice, COL_PET_DG_CARTE);
                For i:=Low(Matrice) to High(Matrice) do
                        SetLength(Matrice[i], ROW_PET_DG_CARTE);
                SetLength(Matrice2, COL_PET_DG_CARTE);
                For i:=Low(Matrice2) to High(Matrice2) do
                        SetLength(Matrice2[i], ROW_PET_DG_CARTE);
                End;
//Si c'est une Carte moyenne
If Taille=CHAINE_MOY
        then
                Begin
                //Définition de la taille de la Drawgrid
                F_Crea_Carte.DG_Carte.RowCount:=ROW_MOY_DG_CARTE;
                F_Crea_Carte.DG_Carte.ColCount:=COL_MOY_DG_CARTE;
                F_Crea_Carte.DG_Carte.Width:=WID_MOY_DG_CARTE;
                F_Crea_Carte.DG_Carte.Height:=HEI_MOY_DG_CARTE;
                //Définition des longueurs du tableau dynamique
                SetLength(Matrice, COL_MOY_DG_CARTE);
                For i:=Low(Matrice) to High(Matrice) do
                        SetLength(Matrice[i], ROW_MOY_DG_CARTE);
                SetLength(Matrice2, COL_MOY_DG_CARTE);
                For i:=Low(Matrice2) to High(Matrice2) do
                        SetLength(Matrice2[i], ROW_MOY_DG_CARTE);
                End;
//Si c'est une grande Carte
If Taille=CHAINE_GRD
        then
                Begin
                //Remplissage des champs de description de la carte
                F_Crea_Carte.NOUVELLE_CARTE(F_Description_Carte.L_Nom_Carte.caption,CHAINE_GRD);
                //Définition de la taille de la Drawgrid
                F_Crea_Carte.DG_Carte.RowCount:=ROW_GRD_DG_CARTE;
                F_Crea_Carte.DG_Carte.ColCount:=COL_GRD_DG_CARTE;
                F_Crea_Carte.DG_Carte.Width:=WID_GRD_DG_CARTE;
                F_Crea_Carte.DG_Carte.Height:=HEI_GRD_DG_CARTE;
                //Définition des longueurs du tableau dynamique
                SetLength(Matrice, COL_GRD_DG_CARTE);
                For i:=Low(Matrice) to High(Matrice) do
                        SetLength(Matrice[i], ROW_GRD_DG_CARTE);
                SetLength(Matrice2, COL_GRD_DG_CARTE);
                For i:=Low(Matrice2) to High(Matrice2) do
                        SetLength(Matrice2[i], ROW_GRD_DG_CARTE);
                End;
//$$$$$$$$$$$$$$$$//

//On ouvre un Fichier terrain
//Chargement des infos de terrain
//Assignation des noms logiques et physiques et ajout de l'extension souhaitée
AssignFile(Fic_Ter,Nom_Fic+TER_EXTENSION);
//Ouverture du fichier (sans écrasement)
Reset(Fic_Ter);
//Parcour de la matrice des terrains
For j:=0 to High(Matrice[0]) do
        For i:=0 to High(Matrice) do
                Begin
                //Lecture des différentes informations contenues dans le fichier
                //Lecture Du numéro
                Read(Fic_Ter,Num);
                //Lecture de l'espace
                Read(Fic_Ter,Space);
                //Affectation du numéro à la place indiquée dans la matrice
                F_Crea_Carte.PUT_MATRICE(i,j,Num);
                End;
//Fermeture du fichier
CloseFile(Fic_Ter);
//$$$$$$$$$$$$$$$$//
//On ouvre un Fichier terrain
//Chargement des infos de terrain
//Assignation des noms logiques et physiques et ajout de l'extension souhaitée
AssignFile(Fic_Art,Nom_Fic+ART_EXTENSION);
//Ouverture du fichier (sans écrasement)
Reset(Fic_Art);
//Parcour de la matrice des artefacts
For j:=0 to High(Matrice[0]) do
        For i:=0 to High(Matrice) do
                Begin
                //Lecture Du numéro
                Read(Fic_Art,Num);
                //Lecture de l'espace
                Read(Fic_Art,Space);
                //Affectation du numéro à la place indiquée dans la matrice
                F_Crea_Carte.PUT_MATRICE2(i,j,Num);
                End;
//Fermeture du fichier
CloseFile(Fic_Art);
//Message de confirmation
Showmessage('Carte Chargée');
//Appel de la fonction de repaint
F_Crea_Carte.AFFICHAGE_ALL;
//Initialisations
UniversHerbe.Enabled:=True;
UniversEau.Enabled:=True;
UniversTerre.Enabled:=True;
Masquerlesartefacts1.Enabled:=True;
Afficherlesartefacts1.Enabled:=True;
F_Crea_Carte.DG_Carte.enabled:=true;
        End;
end;

//*****************************************************************************//
//*****************************************************************************//

procedure TF_Crea_Carte.UniversHerbeClick(Sender: TObject);
Var
i,j:integer;
begin
For i:=0 to High(Matrice) do
        For j:=0 to High(Matrice[i]) do
        F_Crea_Carte.PUT_MATRICE(i,j,NUM_HERBE);
F_Crea_Carte.AFFICHAGE_ALL;
end;

//*****************************************************************************//
//*****************************************************************************//

procedure TF_Crea_Carte.UniversEauClick(Sender: TObject);
Var
i,j:integer;
begin
For i:=0 to High(Matrice) do
        For j:=0 to High(Matrice[i]) do
        F_Crea_Carte.PUT_MATRICE(i,j,NUM_EAU);
F_Crea_Carte.AFFICHAGE_ALL;
end;

//*****************************************************************************//
//*****************************************************************************//

procedure TF_Crea_Carte.UniversTerreClick(Sender: TObject);
Var
i,j:integer;
begin
For i:=0 to High(Matrice) do
        For j:=0 to High(Matrice[i]) do
        F_Crea_Carte.PUT_MATRICE(i,j,NUM_TERRE);
F_Crea_Carte.AFFICHAGE_ALL;
end;

//*****************************************************************************//
//*****************************************************************************//

procedure TF_Crea_Carte.FormCreate(Sender: TObject);
begin
DG_Carte.ControlStyle:=Controlstyle + [csOpaque];
end;

//*****************************************************************************//
//*****************************************************************************//


procedure TF_Crea_Carte.FormPaint(Sender: TObject);
begin
F_Crea_Carte.AFFICHAGE_ALL;
end;

//*****************************************************************************//
//*****************************************************************************//

procedure TF_Crea_Carte.Afficherlesartefacts1Click(Sender: TObject);
begin
//On affiche tout, normal !
F_Crea_Carte.AFFICHAGE_ALL;
end;

procedure TF_Crea_Carte.Masquerlesartefacts1Click(Sender: TObject);
//On efface tout, et on affiche que les terrains
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//
Var
i,j:integer; //Variables temporaires de visualisation des tableaux
Begin
//On passe en revue tout la matrice
//Pour i variant de 0 (première case de la matrice)...
//...au nombre de colonnes de la Matrice
For i:=0 to High(Matrice) do
        //Pour j variant de 0 (première case de la matrice)...
        //...au nombre de lignes de la Matrice
        For j:=0 to High(Matrice[i]) do
                Begin
                //Cas ou le numéro compris dans la matrice appartient à l'ensemble [1,40]+76 (ancien zéro)
                Case Matrice[i,j] of
                1 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image1.Picture.Graphic);
                2 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image2.Picture.Graphic);
                3 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image3.Picture.Graphic);
                4 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image4.Picture.Graphic);
                5 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image5.Picture.Graphic);
                6 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image6.Picture.Graphic);
                7 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image7.Picture.Graphic);
                8 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image8.Picture.Graphic);
                9 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image9.Picture.Graphic);

                10 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image10.Picture.Graphic);
                11 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image11.Picture.Graphic);
                12 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image12.Picture.Graphic);
                13 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image13.Picture.Graphic);
                14 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image14.Picture.Graphic);
                15 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image15.Picture.Graphic);
                16 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image16.Picture.Graphic);
                17 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image17.Picture.Graphic);
                18 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image18.Picture.Graphic);
                19 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image19.Picture.Graphic);

                20 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image20.Picture.Graphic);
                21 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image21.Picture.Graphic);
                22 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image22.Picture.Graphic);
                23 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image23.Picture.Graphic);
                24 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image24.Picture.Graphic);
                25 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image25.Picture.Graphic);
                26 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image26.Picture.Graphic);
                27 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image27.Picture.Graphic);
                28 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image28.Picture.Graphic);
                29 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image29.Picture.Graphic);

                30 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image30.Picture.Graphic);
                31 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image31.Picture.Graphic);
                32 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image32.Picture.Graphic);
                33 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image33.Picture.Graphic);
                34 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image34.Picture.Graphic);
                35 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image35.Picture.Graphic);
                36 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image36.Picture.Graphic);
                37 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image37.Picture.Graphic);
                38 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image38.Picture.Graphic);
                39 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image39.Picture.Graphic);

                40 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image40.Picture.Graphic);
                66 : F_Crea_Carte.DG_Carte.Canvas.Draw(TILE_SIZE*i+i,TILE_SIZE*j+j,F_Banque_Images.Image66.Picture.Graphic);
                End;
                End;
//!!!!!!!!!!!!!!!!FIN!!!!!!!!!!!!!!!!!//
end;

end.
