{JEU ZELDARENA - SAND
JOACHIM BOUSSOUMAH      GPBb
TIMOTHEE BOURGUIGNON    GPAa
EPF2}
{Unité principale du jeu, unité graphique ratachée à la fiche "F_Jeu"
Cette Unité charge les données stockées en mémoire, en les affichant et gère
la boucle principale du Timer}
unit U_Jeu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ImgList, ComCtrls, U_Types, U_crea_terrain,
  U_crea_artefact, U_fa_joueur,U_crea_joueur,U_FA_Pts_Renaissance,
  Gauges, jpeg, U_crea_elt_non_permnt, U_test_deplace, U_priorite, U_Fa_inaction,
  U_FA_Pts_pass, U_tile_to_load, Grids;

type
  TF_Jeu = class(TForm)
    ImageList1: TImageList;
    Points_XP: TGroupBox;
    L_XP1: TLabel;
    L_XP2: TLabel;
    L_XP3: TLabel;
    L_XP4: TLabel;
    L_Nom_J1: TLabel;
    L_Nom_J2: TLabel;
    L_Nom_J3: TLabel;
    L_Nom_J4: TLabel;
    Shape6: TShape;
    Image1: TImage;
    Shape1: TShape;
    Timer1: TTimer;
    ImageList2: TImageList;
    GroupBox1: TGroupBox;
    Shape5: TShape;
    I_Avatar_J1: TImage;
    Label4: TLabel;
    NomJ1: TLabel;
    L_armure_J1: TLabel;
    Label7: TLabel;
    L_arme_J1: TLabel;
    Label9: TLabel;
    Shape7: TShape;
    Shape8: TShape;
    ImageList3: TImageList;
    ImageList4: TImageList;
    GroupBox5: TGroupBox;
    Shape9: TShape;
    I_Avatar_J2: TImage;
    GaugeJ2: TGauge;
    Label10: TLabel;
    NomJ2: TLabel;
    L_armure_J2: TLabel;
    Label13: TLabel;
    L_arme_J2: TLabel;
    Label15: TLabel;
    Shape10: TShape;
    Shape11: TShape;
    I_arme_J1: TImage;
    I_armure_J1: TImage;
    I_arme_J2: TImage;
    I_armure_J2: TImage;
    GaugeJ1: TGauge;
    ImageList5: TImageList;
    GroupBox4: TGroupBox;
    Shape12: TShape;
    I_Avatar_J3: TImage;
    GaugeJ3: TGauge;
    Label5: TLabel;
    NomJ3: TLabel;
    L_armure_J3: TLabel;
    Label11: TLabel;
    L_arme_J3: TLabel;
    Label14: TLabel;
    Shape13: TShape;
    Shape14: TShape;
    I_arme_J3: TImage;
    I_armure_J3: TImage;
    GroupBox7: TGroupBox;
    Shape15: TShape;
    I_Avatar_J4: TImage;
    GaugeJ4: TGauge;
    Label16: TLabel;
    NomJ4: TLabel;
    L_armure_J4: TLabel;
    Label19: TLabel;
    L_arme_J4: TLabel;
    Label21: TLabel;
    Shape16: TShape;
    Shape17: TShape;
    I_arme_J4: TImage;
    I_armure_J4: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    Procedure AFFICHAGE_CARTE;
    Procedure AFFICHAGE_JOUEURS;
    { Public declarations }
  end;
  Procedure CREA_JOUEURS(Var Ppremier:T_ptr_VD_joueur);
  Procedure SET__TAILLE_MATRICE(larg,haut:integer);
  Procedure LANCEMENT_JEU;
  Procedure LOADPICTURES;
  Procedure DESTROY_TABTILESET;
  Procedure CREA_TABTILESET;
  Procedure SET_MATRICE;
  Procedure CREA_ARTEFACT;
  Procedure DESTRUCTION_INSTANCES_TERRAINS;
  Procedure DESTRUCTION_INSTANCES_ARTEFACT;
  Function GET_LXP1:integer;
  Function GET_LXP2:integer;
  Function GET_LXP3:integer;
  Function GET_LXP4:integer;
  Procedure DETERMINATION_SKIN(Var skin_determine,skin_lu:string);
  Procedure INIT_MATRICE_STRUCTURE;

var
  F_Jeu: TF_Jeu;
  TABTileSet : Array [0 .. NUM_PICTURES -1] of TBitmap; //Tableau contenant l'ensemble des tiles utilisables
  Matrice_Structure: array of array of Ptr_Element_Base;//Matrice générale du programme
  Matrice_Structure2: array of array of integer;
  Armes: Array [0..3,0..2] of TBitmap;
  FBuffer,FBufferVide :Tbitmap;
  MAP_HEIGHT, MAP_WIDTH:integer;
  Ppremier:T_ptr_VD_Joueur;
  PPremier_Renaiss:T_ptr_FA_Renaissance;
  Deux_joueurs:boolean;
  NB_J_Humains:integer; //Nombre de joueurs humains
implementation

uses U_Accueil, U_Load, U_Splash, U_traitement, U_vision, U_chemin, U_avarie;


{$R *.dfm}

//****************************************************************************//
//****************************************************************************//

//Définition des différents buffers à utiliser
Procedure CREA_BUFFERS(Taille:string);
Begin
FBuffer := Tbitmap.Create;              //Création du Bitmap du buffer
FBufferVide := Tbitmap.Create;          //Création du Bitmap du buffer vide
//La taille du Buffer ne varie Jamais, on la rêgle à la taille de la zone écran (640*480)
MAP_HEIGHT:=ROW_PET_DG_CARTE;
MAP_WIDTH:=COL_PET_DG_CARTE;
FBuffer.Width := COL_PET_DG_CARTE * TILE_SIZE;  //Définition de la largeur du buffer image
FBuffer.Height := ROW_PET_DG_CARTE * TILE_SIZE;//Définition de la longueur du buffer image
FBufferVide.Width := COL_PET_DG_CARTE * TILE_SIZE;
FBufferVide.Height := ROW_PET_DG_CARTE * TILE_SIZE;
End;

//****************************************************************************//
//****************************************************************************//

//Affichage global de la carte sur la zone de dessin créée.
Procedure TF_Jeu.AFFICHAGE_CARTE;
Var
x,y,i,TileLeft,TileTop:integer;
Numimage,Numim:string;
Begin
        //initialisation de TileTop
        TileTop:=0;
        //Pour y variant de 0 à la hauteur de la carte
        For y:=0 to MAP_HEIGHT-1 do
                Begin
                //initialisation de Tileleft
                TileLeft:=0;
                //Pour y variant de 0 à la largeur de la carte
                For x:= 0 to MAP_WIDTH-1 do
                        Begin
                        //Affichage de l'image sur le buffer
                        //----AFFICHAGE DE L'IMAGE CONCERNANT LE NIVEAU 1----//
                                Numim:='';
                                //on va chercher le nom de l'image dans la structure totale (Modèle 'NUM.bmp')
                                Numimage:=Matrice_Structure[x,y].Ptr_Terrain.GETNUMIMAGE;
                                //Suppression de l'extension '.bmp'
                                For i:=1 to length (numimage)-LONGUEUR_EXTENSION do
                                        numim:=numim+Numimage[i];
                                //Commande d'impression sur le Buffer
                                //NomduBuffer.canvas.Commande'Draw'(COORD_Largeur,COORD_Hauteur,Type_Bitmap_contenu_dans_le_tableau)
                                //le '-1' provient du fait que le tableau débute à 0 et les images à 1
                                FBuffer.Canvas.Draw(TileLeft,TileTop,TABTileSet[strtoint(numim)-1]);
                        //----AFFICHAGE DE L'IMAGE CONCERNANT LE NIVEAU 2----//
                                Numim:='';
                                //on va chercher le nom de l'image dans la structure totale (Modèle 'NUM.bmp')
                                Numimage:=Matrice_Structure[x,y].Ptr_Artefact.GETNUMIMAGE;
                                //Suppression de l'extension '.bmp'
                                For i:=1 to length (numimage)-LONGUEUR_EXTENSION do
                                        numim:=numim+Numimage[i];
                                //Commande d'impression sur le Buffer
                                //NomduBuffer.canvas.Commande'Draw'(COORD_Largeur,COORD_Hauteur,Type_Bitmap_contenu_dans_le_tableau)
                                //le '-1' provient du fait que le tableau débute à 0 et les images à 1
                                If numim<>'0' then FBuffer.Canvas.Draw(TileLeft,TileTop,TABTileSet[strtoint(numim)-1]);
                        //---------------------------------------------------//
                        //Incrémentation des coordonnées TILELEFT de TILE_SIZE
                        Inc(TileLeft,TILE_SIZE);
                        End;
                //Incrémentation des coordonnées TILETOP de TILE_SIZE
                Inc(TileTop,TILE_SIZE);
                End;
End;

//****************************************************************************//
//****************************************************************************//

Procedure LOADPICTURES; //Procedure de Chargement du tableau de Tiles
{Procedure de remplissage du tableau FTileSet avec les images Tiles à utiliser}
Var
i,j:integer;
FileToLoad:String;
Begin
        For i:= 1 to NUM_PICTURES do
                Begin
                j:=i-1;
                FileToLoad:=inttostr(i)+BMP_EXTENSION;
                TABTileSet[j].LoadFromFile(DOSSIER_TIL+SLASH+FileToLoad);
                End;
End;

//****************************************************************************//
//****************************************************************************//

//Procedure de mise a la bonne taille de la matrice principale du programme
Procedure SET__TAILLE_MATRICE(larg,haut:integer);
//En entrée: larg, haut: la taille de la matrice en question
Var
i:integer;
Begin
SetLength(Matrice_Structure, larg);
For i:=Low(Matrice_Structure) to High(Matrice_Structure)
        do SetLength(Matrice_Structure[i], haut);
End;

//****************************************************************************//
//****************************************************************************//

//Procedure de définition de la taille de la matice générale "hôte"
Procedure SET_MATRICE;
Var
Fic:textfile;
Taille:string;
Begin
//Reinitialisation du dossier initial
SetCurrentDir(Dossier_initial);
//Collecte de la taille de la matrice
Assignfile(Fic,F_Load.E_Carte.text);
Reset(Fic);
Readln(fic,Taille);
Readln(fic,Taille);
Closefile(fic);
//Mise à la bonne taille de la matrice générale
If taille=CHAINE_PET
        then
        SET__TAILLE_MATRICE(COL_PET_DG_CARTE,ROW_PET_DG_CARTE);
If taille=CHAINE_MOY
        then
        SET__TAILLE_MATRICE(COL_MOY_DG_CARTE,ROW_MOY_DG_CARTE);
If taille=CHAINE_GRD
        then
        SET__TAILLE_MATRICE(COL_GRD_DG_CARTE,ROW_GRD_DG_CARTE);
CREA_BUFFERS(Taille);
End;

//****************************************************************************//
//****************************************************************************//

//Module de création des bitmaps contenus dans le tableau des tiles
Procedure CREA_TABTILESET;
Var
i:integer;
Begin
//Remplissage du tableau TABTileSet avec des composants TBitmap que l'on crée
For i:=0 to NUM_PICTURES -1
        do TABTileSet[i]:= Tbitmap.Create;
End;

//****************************************************************************//
//****************************************************************************//

//Module de destruction des bitmaps contenus dans le tableau des tiles
Procedure DESTROY_TABTILESET;
Var
i:integer;
Begin
//Vidage du tableau TABTileSet avec des composants TBitmap que l'on détruit
For i:=0 to NUM_PICTURES -1
        do TABTileSet[i].Free;
End;

//****************************************************************************//
//****************************************************************************//

procedure TF_Jeu.FormCreate(Sender: TObject);
begin
//Création des structures d'accueil d'images (Tableau de tiles)
CREA_TABTILESET;
//Remplissage de la structure (Tableau de tiles) avec les tiles considérées
LOADPICTURES;
//Initialisation des P_Humains
PHumain:=nil;
PHumain2:=nil;
PHumain3:=nil;
PHumain4:=nil;
end;

//****************************************************************************//
//****************************************************************************//

//Procedure de suppression de l'extension des noms et chemins d'accès aux fichiers ".ter" et ".art"
Procedure SUPPRESSION_EXTENSION(var Carte:string);
var
Nom_ss_ext:string;
i:integer;
Begin
Nom_ss_ext:='';
For i:=1 to length(Carte)-LONGUEUR_EXTENSION do
        Nom_ss_ext:=Nom_ss_ext+carte[i];
Carte:=Nom_ss_ext;
End;

//****************************************************************************//
//****************************************************************************//

//Retourne Vrai si la case est marchable, Faux sinon
Function GET_MARCHABLE(num:integer):boolean;
var
Marchable : set of byte;
Begin
Marchable:=[1,2,3,4,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,63,64];
If num in Marchable
        then
        GET_MARCHABLE:=true
        Else
        GET_MARCHABLE:=false;
End;

//****************************************************************************//
//****************************************************************************//

//Module de destruction des instances terrains contenues dans le tableau
Procedure DESTRUCTION_INSTANCES_TERRAINS;
{Var
i,j:integer;}
Begin
{For j:=0 to High(Matrice_Structure)-1 do
        For i:=0 to High(Matrice_Structure[0])-1 do
                Matrice_Structure[j,i].Ptr_Terrain.FreeInstance;}
End;

//****************************************************************************//
//****************************************************************************//

//Module de destruction des instances artefact contenues dans le tableau
Procedure DESTRUCTION_INSTANCES_ARTEFACT;
{Var
i,j:integer;}
Begin
{For j:=0 to High(Matrice_Structure)-1 do
        For i:=0 to High(Matrice_Structure[0])-1 do
                Matrice_Structure[j,i].Ptr_Artefact.FreeInstance;}
End;

//****************************************************************************//
//****************************************************************************//

//Module de création du terrain (1er niveau)
//Capture du n° d'image du terrain, création des VD et des instances de classes
Procedure CREA_TERRAIN;
Var
Fic_Terrain:textfile;
carte,newnumimage:string;
i,j,Num:integer;
Pnouv:Ptr_Element_Base;
Begin
//Suppression de l'extension
Carte:=F_Load.E_Carte.text;
SUPPRESSION_EXTENSION(carte);
//Ouverture du fichier terrain considéré
Assignfile(Fic_Terrain,carte+TER_EXTENSION);
Reset(Fic_Terrain);
//Lecture des nombres, création et remplissage des instances
For i:=0 to High(Matrice_Structure[0]) do
        Begin
        For j:=0 to High(Matrice_Structure) do
                Begin
                //Lecture du numéro de l'image dans le fichier terrain
                Read(Fic_Terrain,Num);
                //Création du pointeur vers ELEMENT DE BASE
                New(Pnouv);
                Matrice_Structure[j,i]:=Pnouv;
                //Création d'une instance de classe Terrain
                {Nom_Img, Ligne, Colonne, Marchable ou non}
                newnumimage:=inttostr(num)+BMP_EXTENSION;
                Matrice_Structure[j,i].Ptr_Terrain:=TC_terrain.INIT(inttostr(Num),i,j,GET_MARCHABLE(num),newnumimage);
                //Au passage, on initialise les pointeurs Joueurs à Nil
                Matrice_Structure[j,i].Ptr_Joueur:=Nil;
                End;
        Readln(Fic_Terrain);
        end;
//Showmessage('Chargement Terrains Terminés');
Closefile(Fic_Terrain);
End;

//****************************************************************************//
//****************************************************************************//

//Module de création des artefacts (2eme niveau)
//Capture du n° d'image des artefacts, création des VD et des instances de classes
Procedure CREA_ARTEFACT;
Var
Fic_Artefact:textfile;
carte:string;
i,j,Num:integer;
Begin
//Reinitialisation du dossier initial
SetCurrentDir(Dossier_initial);
//Suppression de l'extension
Carte:=F_Load.E_Carte.text;
SUPPRESSION_EXTENSION(carte);
//Ouverture du fichier terrain considéré
Assignfile(Fic_Artefact,carte+ART_EXTENSION);
Reset(Fic_Artefact);
//Lecture des nombres, création et remplissage des instances
For j:=0 to High(Matrice_Structure[0]) do
        Begin
        For i:=0 to High(Matrice_Structure) do
                Begin
                //Lecture du numéro de l'image dans le fichier terrain
                Read(Fic_Artefact,Num);
                //Création d'une instance de classe Terrain
                {Nom_Img, Ligne, Colonne, Marchable ou non}
                Case num of
                        67: Matrice_Structure[i,j].Ptr_Artefact:=TC_artefact.INIT(inttostr(Num),j,i,inttostr(num)+BMP_EXTENSION,True,BONUS_NIV1); //Epée niv 1
                        68: Matrice_Structure[i,j].Ptr_Artefact:=TC_artefact.INIT(inttostr(Num),j,i,inttostr(num)+BMP_EXTENSION,True,BONUS_NIV1);
                        69: Matrice_Structure[i,j].Ptr_Artefact:=TC_artefact.INIT(inttostr(Num),j,i,inttostr(num)+BMP_EXTENSION,True,BONUS_NIV2);//Epée niv 2
                        70: Matrice_Structure[i,j].Ptr_Artefact:=TC_artefact.INIT(inttostr(Num),j,i,inttostr(num)+BMP_EXTENSION,True,BONUS_NIV2);
                        71: Matrice_Structure[i,j].Ptr_Artefact:=TC_artefact.INIT(inttostr(Num),j,i,inttostr(num)+BMP_EXTENSION,True,BONUS_NIV3);//Epée niv 3
                        72: Matrice_Structure[i,j].Ptr_Artefact:=TC_artefact.INIT(inttostr(Num),j,i,inttostr(num)+BMP_EXTENSION,True,BONUS_NIV3);

                        73: Matrice_Structure[i,j].Ptr_Artefact:=TC_artefact.INIT(inttostr(Num),j,i,inttostr(num)+BMP_EXTENSION,True,BONUS_NIV1);//Armure niv 1
                        74: Matrice_Structure[i,j].Ptr_Artefact:=TC_artefact.INIT(inttostr(Num),j,i,inttostr(num)+BMP_EXTENSION,True,BONUS_NIV1);
                        75: Matrice_Structure[i,j].Ptr_Artefact:=TC_artefact.INIT(inttostr(Num),j,i,inttostr(num)+BMP_EXTENSION,True,BONUS_NIV2);//Armure niv 2
                        76: Matrice_Structure[i,j].Ptr_Artefact:=TC_artefact.INIT(inttostr(Num),j,i,inttostr(num)+BMP_EXTENSION,True,BONUS_NIV2);
                        77: Matrice_Structure[i,j].Ptr_Artefact:=TC_artefact.INIT(inttostr(Num),j,i,inttostr(num)+BMP_EXTENSION,True,BONUS_NIV3);//Armure niv 3
                        78: Matrice_Structure[i,j].Ptr_Artefact:=TC_artefact.INIT(inttostr(Num),j,i,inttostr(num)+BMP_EXTENSION,True,BONUS_NIV3);

                        79: Matrice_Structure[i,j].Ptr_Artefact:=TC_artefact.INIT(inttostr(Num),j,i,inttostr(num)+BMP_EXTENSION,True,INIT_POINTS_VIE);//Vie
                        80: Matrice_Structure[i,j].Ptr_Artefact:=TC_artefact.INIT(inttostr(Num),j,i,inttostr(num)+BMP_EXTENSION,True,INIT_POINTS_VIE);
                        85: Matrice_Structure[i,j].Ptr_Artefact:=TC_artefact.INIT(inttostr(Num),j,i,inttostr(num)+BMP_EXTENSION,True,XP_RUBIS);//Rubis
                        86: Matrice_Structure[i,j].Ptr_Artefact:=TC_artefact.INIT(inttostr(Num),j,i,inttostr(num)+BMP_EXTENSION,True,XP_RUBIS);
                        87: Matrice_Structure[i,j].Ptr_Artefact:=TC_artefact.INIT(inttostr(Num),j,i,inttostr(num)+BMP_EXTENSION,True,XP_EMMERAUDES);//Emmeraude
                        88: Matrice_Structure[i,j].Ptr_Artefact:=TC_artefact.INIT(inttostr(Num),j,i,inttostr(num)+BMP_EXTENSION,True,XP_EMMERAUDES);
                        else Matrice_Structure[i,j].Ptr_Artefact:=TC_artefact.INIT(inttostr(Num),j,i,inttostr(num)+BMP_EXTENSION,True,0);
                        end;
                //Au passage, on initialise tous les pointeurs des joueurs de la matrice
                Matrice_Structure[i,j].Ptr_Joueur:=Nil;
                End;
        Readln(Fic_Artefact);
        end;
Closefile(Fic_Artefact);
End;

//****************************************************************************//
//****************************************************************************//

//Détermination du Skin a apposer au perso
Procedure DETERMINATION_SKIN(Var skin_determine,skin_lu:string);
Begin
If Skin_lu='linkble.bmp'
        then skin_determine:=DOSSIER_SPRITES+SLASH+'1'+SLASH+SPRITE_DEFAUT+BMP_EXTENSION;
If Skin_lu='linkrou.bmp'
        then skin_determine:=DOSSIER_SPRITES+SLASH+'2'+SLASH+SPRITE_DEFAUT+BMP_EXTENSION;
If Skin_lu='linkver.bmp'
        then skin_determine:=DOSSIER_SPRITES+SLASH+'3'+SLASH+SPRITE_DEFAUT+BMP_EXTENSION;
If Skin_lu='linkvio.bmp'
        then skin_determine:=DOSSIER_SPRITES+SLASH+'4'+SLASH+SPRITE_DEFAUT+BMP_EXTENSION;
End;

//****************************************************************************//
//****************************************************************************//

//Module de capture des coordonnées de placement du joueur parmi les points de renaissance
Procedure COORD_INITIALES(Var CoordX,CoordY:integer; pcour:T_ptr_FA_Renaissance);
Begin
CoordX:=pcour^.CoordX;
CoordY:=pcour^.CoordY;
End;

//****************************************************************************//
//****************************************************************************//

//Module de création des instances de classe Joueur,
//Creation de la FA Joueurs,
//Chainage dans la matrice principale
Procedure CREA_JOUEURS(Var Ppremier:T_ptr_VD_joueur);
//***********//
Var
Pnouv:T_ptr_VD_Joueur;
Nouveau_joueur:TC_joueur;
i,XP,Points,Force,Armure,Attaque,Precision,Endurance,CoordX,CoordY:integer;
Fic_player:textfile;
Tab : array of string;
Nom,skin_lu,skin_determine,phrase,avatar:string;
pdebl_prio: T_ptr_prio; //pointeur de début de liste des priorités
nb_it,nb_it2:integer; //Sert a compter les humains
//***********//
Begin
nb_it:=1;
nb_it2:=1;
//On remplit un mini tableau avec les noms de joueurs
Setlength(tab,NB_JOUEURS);
        Tab[0]:=F_Jeu.L_Nom_J1.Caption;
        Tab[1]:=F_Jeu.L_Nom_J2.Caption;
        Tab[2]:=F_Jeu.L_Nom_J3.Caption;
        Tab[3]:=F_Jeu.L_Nom_J4.Caption;
//Création de la structure FA des joueurs (mais elle est vide)
U_Fa_joueur.INIT_FA_JOUEUR(Pdeb_FA_Joueur,Pfin_FA_Joueur);
Pcour_FA_Renaissance:=Pdeb_FA_Renaissance;
//On passe en revue tous les joueurs
For i:=1 to NB_JOUEURS do
        Begin
        //Lecture des infos dans les fichiers
        Assignfile(Fic_player,DOSSIER_PLA+SLASH+TAB[i-1]+JOU_EXTENSION);
        Reset(Fic_player);
                Readln(Fic_player,XP);
                Readln(Fic_player,Points);
                Readln(Fic_player,Nom);
                Readln(Fic_player,Skin_lu);
                Readln(Fic_player,avatar);
                Readln(Fic_player,Force);
                Readln(Fic_player,Armure);
                Readln(Fic_player,Attaque);
                Readln(Fic_player,Precision);
                Readln(Fic_player,Endurance);
                Readln(Fic_player,phrase);
        Closefile(Fic_player);
        //Détermination de l'image a appliquer en fonction du skin lu
        DETERMINATION_SKIN(skin_determine,skin_lu);
        //Détermination des coordonnées initiales
        COORD_INITIALES(CoordX,CoordY,Pcour_FA_Renaissance);
        //Initialisation de la liste des priorités
        pdebl_prio:=nil;
        INIT_FA_PRIORITES(pdebl_prio);
        //Création de l'instance de classe TC_Joueur
        Nouveau_joueur:=TC_joueur.INIT(nom,CoordY,CoordX,skin_determine,true,0,0,INIT_POINTS_VIE,Force,Attaque,Precision,Endurance,Armure,0,0,0,'D',Nil,pdebl_prio);
        Nouveau_joueur.numimage:=0;
        /////// MULTI ///////
        //Si c'est un Humain
        If nb_it <= NB_J_Humains
                then Nouveau_joueur.Bot:=false
                else Nouveau_joueur.Bot:=true;
        //Bouclage
        nb_it:=nb_it+1;
        /////////////////////
        //Création et chainage de la VD avec l'instance de la classe lui correspondant
        U_Fa_joueur.CREA_VD_JOUEUR(Pnouv);
        U_Fa_joueur.INIT_VD_JOUEUR(Pnouv, Nouveau_joueur);
        U_Fa_joueur.AJOUT_JOUEUR(Pdeb_FA_Joueur,Pfin_FA_Joueur,pnouv);
        //Linkage du nouveau joueur dans la Matrice Structure
        Matrice_Structure[CoordX,CoordY].Ptr_Joueur:=pnouv;
        //Pointeurs initiaux
        //on capture la VD humaine histoire de pouvoir retrouver l'humain plus facilement plus tard lol
        If nb_it2<=NB_J_Humains
                then //alors c'est un humain
                        begin
                        Case nb_it2 of
                        1: begin
                           PHumain:=pnouv;
                           PPremier:=pnouv;
                           end;
                        2:PHumain2:=pnouv;
                        3:PHumain3:=pnouv;
                        4:PHumain4:=pnouv;
                        End;
                        end
                else
                begin
                If Nb_It2=1
                        then
                        P_bot1:=pnouv;
                If Nb_It2=2
                        then
                        P_bot2:=pnouv;
                If Nb_It2=3
                        then
                        P_bot3:=pnouv;
                end;
        Nb_It2:=Nb_it2+1;
        Pcour_FA_Renaissance:=Pcour_FA_Renaissance^.psuiv;
        End;
End;

//****************************************************************************//
//****************************************************************************//

//Affichages des joueurs aux positions où ils sont cénsés être
Procedure TF_Jeu.AFFICHAGE_JOUEURS;
Var
Pcour:T_ptr_VD_Joueur;
i:integer;
Begin
Pcour:=Pdeb_FA_Joueur;
//Pour les 4 joueurs présents
For i:=0 to 3 do
        begin
        FBuffer.Canvas.Draw(Pcour^.pt_visuel.GETLIGNE Shl TILE_SHIFT + Pcour^.pt_visuel.GETOFFSET_X,Pcour^.pt_visuel.GETCOLONNE Shl TILE_SHIFT + Pcour^.pt_visuel.GETOFFSET_Y, Pcour^.pt_visuel.Sprites[0,0]);
        Pcour:=Pcour^.psuiv;
        end;
End;

//****************************************************************************//
//****************************************************************************//

//Module de remplissage de la structure Armes (tableau de TBitmap)...
//... avec les images des épées
Procedure CREA_TAB_ARMES;
Var
Filetoload:string;
x:integer;
Begin
        //Tant qu'on a pas rempli toutes les cases du tableau
        For x:= 0 to 2 do
                Begin
                FileToLoad:=DOSSIER_SPRITES+SLASH+DOSSIER_ARMES+SLASH+DW_NOM+inttostr(x)+BMP_EXTENSION;
                Armes[DIR_DW,x]:= Tbitmap.Create;
                Armes[DIR_DW,x].LoadFromFile(FileToLoad);
                Armes[DIR_DW,x].Transparent := True;
                Armes[DIR_DW,x].TransParentColor := Armes[DIR_DW,x].canvas.pixels[0,0];
                End;
        For x:= 0 to 2 do
                Begin
                FileToLoad:=DOSSIER_SPRITES+SLASH+DOSSIER_ARMES+SLASH+LE_NOM+inttostr(x)+BMP_EXTENSION;
                Armes[DIR_LE,x]:= Tbitmap.Create;
                Armes[DIR_LE,x].LoadFromFile(FileToLoad);
                Armes[DIR_LE,x].Transparent := True;
                Armes[DIR_LE,x].TransParentColor := Armes[DIR_LE,x].canvas.pixels[0,0];
                End;
        For x:= 0 to 2 do
                Begin
                FileToLoad:=DOSSIER_SPRITES+SLASH+DOSSIER_ARMES+SLASH+UP_NOM+inttostr(x)+BMP_EXTENSION;
                Armes[DIR_UP,x]:= Tbitmap.Create;
                Armes[DIR_UP,x].LoadFromFile(FileToLoad);
                Armes[DIR_UP,x].Transparent := True;
                Armes[DIR_UP,x].TransParentColor := Armes[DIR_UP,x].canvas.pixels[0,0];
                End;
        For x:= 0 to 2 do
                Begin
                FileToLoad:=DOSSIER_SPRITES+SLASH+DOSSIER_ARMES+SLASH+RI_NOM+inttostr(x)+BMP_EXTENSION;
                Armes[DIR_RI,x]:= Tbitmap.Create;
                Armes[DIR_RI,x].LoadFromFile(FileToLoad);
                Armes[DIR_RI,x].Transparent := True;
                Armes[DIR_RI,x].TransParentColor := Armes[DIR_RI,x].canvas.pixels[0,0];
                End;
End;
//****************************************************************************//
//****************************************************************************//

//Module d'initialisation de la matrice structure
Procedure INIT_MATRICE_STRUCTURE;
//Var
//i,j:integer;
Begin
{For j:=0 to MAP_HEIGHT-1 do
        For i:=0 to MAP_WIDTH-1 do
                begin
                Matrice_structure[i,j].Ptr_Terrain:=Nil;
                Matrice_structure[i,j].Ptr_Artefact:=Nil;
                Matrice_structure[i,j].Ptr_Joueur:=Nil;
                end;}
end;

//****************************************************************************//
//****************************************************************************//

//LANCEMENT du jeu et chargement des structures de donnée                       //Infos sur le Splash
Procedure LANCEMENT_JEU;
Begin
F_load.Hide; {A débloquer quand la suite marchera}
                                                                                F_Splash.show;
//Création de la structure de données d'ensemble du programme
SET_MATRICE;
                                                                                F_Splash.PUT_JAUGE(PAS_JAUGE);
//Création des instances de classe Terrain
CREA_TERRAIN;
                                                                                F_Splash.PUT_JAUGE(PAS_JAUGE);
//Création des instances de classe Artefact
CREA_ARTEFACT;
                                                                                F_Splash.PUT_JAUGE(PAS_JAUGE);
//Création de la liste des points de passages
CREA_PTS_PASSAGE(pcour_Fa_Pass,Pdeb_FA_PASS,Pfin_FA_PASS);
                                                                                F_Splash.PUT_JAUGE(PAS_JAUGE);
//Création de la liste des points de renaissance
CREA_PTS_RENAISSANCE(PPremier_Renaiss);
                                                                                F_Splash.PUT_JAUGE(PAS_JAUGE);

//Création des instances de classe Joueur, chainage dans la FA Joueurs, chainage dans la matrice principale, activation dans la FA joueurs
CREA_JOUEURS(Ppremier);
                                                                                F_Splash.PUT_JAUGE(PAS_JAUGE);
//Création du tableau contenant les armes entrain de frapper
CREA_TAB_ARMES;
                                                               F_Splash.PUT_JAUGE(PAS_JAUGE);
//Initialisation des images armes et armures
        F_Jeu.ImageList2.GetBitmap(6,F_jeu.I_arme_J1.Picture.Bitmap);
        F_Jeu.ImageList2.GetBitmap(6,F_jeu.I_arme_J2.Picture.Bitmap);
        F_Jeu.ImageList2.GetBitmap(6,F_jeu.I_armure_J1.Picture.Bitmap);
        F_Jeu.ImageList2.GetBitmap(6,F_jeu.I_armure_J2.Picture.Bitmap);
        F_Jeu.ImageList2.GetBitmap(6,F_jeu.I_arme_J3.Picture.Bitmap);
        F_Jeu.ImageList2.GetBitmap(6,F_jeu.I_arme_J4.Picture.Bitmap);
        F_Jeu.ImageList2.GetBitmap(6,F_jeu.I_armure_J3.Picture.Bitmap);
        F_Jeu.ImageList2.GetBitmap(6,F_jeu.I_armure_J4.Picture.Bitmap);
        F_jeu.I_arme_J1.Repaint;
        F_jeu.I_armure_J1.Repaint;
        F_jeu.I_arme_J2.Repaint;
        F_jeu.I_armure_J2.Repaint;
        F_jeu.I_arme_J3.Repaint;
        F_jeu.I_armure_J3.Repaint;
        F_jeu.I_arme_J4.Repaint;
        F_jeu.I_armure_J4.Repaint;
//Joujou avec les fiches
F_Splash.Hide;
F_Load.Hide;
F_Jeu.show;
//Affichage de la carte
F_Jeu.AFFICHAGE_CARTE;
F_Jeu.AFFICHAGE_JOUEURS;
//Impression du buffer sur le canvas
F_Jeu.Canvas.Draw(1,1,FBuffer);
//Showmessage('Commencer');
F_Jeu.Timer1.Enabled:=true;
End;

//****************************************************************************//
//****************************************************************************//

//Détection des touches enfoncées
procedure TF_Jeu.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
Var
Keys:TKeyboardState;
BEgin
//Capture de la touche
GetKeyboardState(Keys);
//Si la touches est "escape"
If Keys[VK_Escape] and $80<>0 then
        Begin //alors on quitte le jeu
        F_jeu.Timer1.Enabled:=false;
        F_Jeu.Hide;
        F_Splash.Hide;
        //F_Load.show;
        F_Accueil.Show;
        End;
end;

//****************************************************************************//
//****************************************************************************//

//Destruction des différentes images
Procedure TF_Jeu.FormDestroy(Sender: TObject);
begin
//Destruction des images de la matrice des tiles
DESTROY_TABTILESET;
end;

//****************************************************************************//
//****************************************************************************//

procedure TF_Jeu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
F_Jeu.Timer1.Enabled:=False;
DESTRUCTION_INSTANCES_TERRAINS;
DESTRUCTION_INSTANCES_ARTEFACT;
F_Jeu.Hide;
F_Load.show;
end;

//****************************************************************************//
//****************************************************************************//

//Module de capture dans un fichier text du niveau d'XP du joueur 1
Function GET_LXP1:integer;
{Var
Fic_Joueur:textfile;
Nom_fic:string;     }
Begin
{//Reinitialisation du dossier initial
SetCurrentDir(Dossier_initial);
Nom_fic:=DOSSIER_PLA+SLASH+F_Jeu.L_Nom_J1.Caption+JOU_EXTENSION;
AssignFile(Fic_Joueur,Nom_fic);
Reset(Fic_Joueur);
Readln(Fic_Joueur,Result);
F_Jeu.L_XP1.Caption:=inttostr(Result);
Closefile(Fic_Joueur);  }
End;

//****************************************************************************//
//****************************************************************************//

//Module de capture dans un fichier text du niveau d'XP du joueur 2
Function GET_LXP2:integer;
{Var
Fic_Joueur:textfile;
Nom_fic:string;      }
Begin
{Nom_fic:=DOSSIER_PLA+SLASH+F_Jeu.L_Nom_J2.Caption+JOU_EXTENSION;
AssignFile(Fic_Joueur,Nom_fic);
Reset(Fic_Joueur);
Readln(Fic_Joueur,Result);
F_Jeu.L_XP2.Caption:=inttostr(Result);
Closefile(Fic_Joueur);  }
End;

//****************************************************************************//
//****************************************************************************//

//Module de capture dans un fichier text du niveau d'XP du joueur 3
Function GET_LXP3:integer;
{Var
Fic_Joueur:textfile;
Nom_fic:string;    }
Begin
{Nom_fic:=DOSSIER_PLA+SLASH+F_Jeu.L_Nom_J3.Caption+JOU_EXTENSION;
AssignFile(Fic_Joueur,Nom_fic);
Reset(Fic_Joueur);
Readln(Fic_Joueur,Result);
F_Jeu.L_XP3.Caption:=inttostr(Result);
Closefile(Fic_Joueur);  }
End;

//****************************************************************************//
//****************************************************************************//

//Module de capture dans un fichier text du niveau d'XP du joueur 4
Function GET_LXP4:integer;
{Var
Fic_Joueur:textfile;
Nom_fic:string; }
Begin
{Nom_fic:=DOSSIER_PLA+SLASH+F_Jeu.L_Nom_J4.Caption+JOU_EXTENSION;
AssignFile(Fic_Joueur,Nom_fic);
Reset(Fic_Joueur);
Readln(Fic_Joueur,Result);
F_Jeu.L_XP4.Caption:=inttostr(Result);
Closefile(Fic_Joueur); }
End;

//****************************************************************************//
//****************************************************************************//

procedure TF_Jeu.FormShow(Sender: TObject);
begin
        //Chargement des avatars
        ImageList1.GetBitmap(int_Avatar,I_Avatar_J1.Picture.Bitmap);
        ImageList1.GetBitmap(int_Avatar2,I_Avatar_J2.Picture.Bitmap);
        ImageList1.GetBitmap(int_Avatar3,I_Avatar_J3.Picture.Bitmap);
        ImageList1.GetBitmap(int_Avatar4,I_Avatar_J4.Picture.Bitmap);
        //Chargement des noms
        F_Jeu.NomJ1.Caption:=F_Load.E_Avatar1.Text;
        F_Jeu.NomJ2.Caption:=F_Load.E_Avatar2.Text;
        F_Jeu.NomJ3.Caption:=F_Load.E_Avatar3.Text;
        F_Jeu.NomJ4.Caption:=F_Load.E_Avatar4.Text;
        F_Jeu.GaugeJ1.Progress:=INIT_POINTS_VIE;
        F_Jeu.GaugeJ2.Progress:=INIT_POINTS_VIE;
        F_Jeu.GaugeJ3.Progress:=INIT_POINTS_VIE;
        F_Jeu.GaugeJ4.Progress:=INIT_POINTS_VIE;
        F_Jeu.L_XP1.Caption:=inttostr(0);
        F_Jeu.L_XP2.Caption:=inttostr(0);
        F_Jeu.L_XP3.Caption:=inttostr(0);
        F_Jeu.L_XP4.Caption:=inttostr(0);
end;

//****************************************************************************//
//****************************************************************************//

//Module d'affichage de toutes les entités à afficher
Procedure MODULE_AFFICHAGE(phumain:T_Ptr_VD_joueur; var pdebl_toload:T_ptr_toload);
Var
OrigineX,OrigineY,i,j,x:integer;
Numimage,Numim:string;
Now,a,b,c,d,num:integer;
Pcour_Aff,pcour_ret:T_ptr_toload;
Begin
//Définition des origines (Current Coord du player -10 et -7)
//OrigineX:=phumain.pt_visuel.GETCOLONNE-10;
//OrigineY:=phumain.pt_visuel.GETLIGNE-8;
//TEst
OrigineX:=0;
OrigineY:=0;

//Affichage de la carte
For j:=0 to MAP_HEIGHT-1 do
        For i:=0 to MAP_WIDTH-1 do
                begin
                //Impression terrain
                //Selection du numéro d'image à imprimer
                Numim:='';
                Numimage:=Matrice_Structure[i,j].Ptr_Terrain.GETNUMIMAGE;
                                //Suppression de l'extension '.bmp'
                                For x:=1 to length (numimage)-LONGUEUR_EXTENSION do
                                        numim:=numim+Numimage[x];
                FBuffer.Canvas.Draw(i*TILE_SIZE,j*TILE_SIZE,TABTileSet[strtoint(numim)-1]);
                //Impression Artefact
                Numim:='';
                Numimage:=Matrice_Structure[i,j].Ptr_Artefact.GETNUMIMAGE;
                                //Suppression de l'extension '.bmp'
                                For x:=1 to length (numimage)-LONGUEUR_EXTENSION do
                                        numim:=numim+Numimage[x];
                If Matrice_Structure[i,j].Ptr_Artefact.GETACTIF=true
                        then //comme l'artefact est actif, il faut l'imprimer
                        FBuffer.Canvas.Draw(i*TILE_SIZE,j*TILE_SIZE,TABTileSet[strtoint(numim)-1])
                        else
                        FBuffer.Canvas.Draw(i*TILE_SIZE,j*TILE_SIZE,TABTileSet[62-1]);
                end;
//Impression des perso actifs
For j:=0 to MAP_HEIGHT-1 do
        For i:=0 to MAP_WIDTH-1 do
                begin
                //Impression Personnages actifs (cad statiques)
                If Matrice_Structure[i,j].Ptr_Joueur<>Nil then
                        If (Matrice_Structure[i,j].Ptr_Joueur.pt_visuel.GETACTIF=true) or (Matrice_Structure[i+OrigineX,j+OrigineY].Ptr_Joueur.pt_visuel.GETVIE>0)
                                then
                                begin
                                        a:=Matrice_Structure[i,j].Ptr_Joueur.pt_visuel.GETLIGNE;
                                        b:=Matrice_Structure[i,j].Ptr_Joueur.pt_visuel.GETCOLONNE;
                                        c:=Matrice_Structure[i,j].Ptr_Joueur.pt_visuel.GETOFFSET_X;
                                        d:=Matrice_Structure[i,j].Ptr_Joueur.pt_visuel.GETOFFSET_Y;
                                        //Affichage
                                        num:=Matrice_Structure[i,j].Ptr_Joueur.pt_visuel.numimage;
                                        Case Matrice_Structure[i,j].Ptr_Joueur.pt_visuel.GETORIENTATION of
                                                'D': FBuffer.Canvas.Draw(b*TILE_SIZE+c,a*TILE_SIZE+d,Matrice_Structure[i,j].Ptr_Joueur.pt_visuel.Sprites[0,num]);
                                                'L': FBuffer.Canvas.Draw(b*TILE_SIZE+c,a*TILE_SIZE+d,Matrice_Structure[i,j].Ptr_Joueur.pt_visuel.Sprites[1,num]);
                                                'U': FBuffer.Canvas.Draw(b*TILE_SIZE+c,a*TILE_SIZE+d,Matrice_Structure[i,j].Ptr_Joueur.pt_visuel.Sprites[2,num]);
                                                'R': FBuffer.Canvas.Draw(b*TILE_SIZE+c,a*TILE_SIZE+d,Matrice_Structure[i,j].Ptr_Joueur.pt_visuel.Sprites[3,num]);
                                        end;
                                end;
                end;
If pdebl_toload <> Nil then
        begin
        //Affichage des elements inactifs dont le temps est passé et suppression de ceux-ci
        Now:=GetTickCount;
        Pcour_Aff:=pdebl_toload;
        //Tant qu'on a pas parcouru toute la FA d'affichage
        While pcour_aff<>nil do
                begin
                //Si l'élément est a afficher
                If (pcour_aff.h_eveil <= now) and (pcour_aff.h_mort > now) then
                        begin
                        FBuffer.Canvas.Draw(pcour_aff.pos_x,pcour_aff.pos_y,pcour_aff.image);
                        end;
                If (pcour_aff.h_mort <= now) then
                        begin
                        //Si l'élément est a supprimer
                        pcour_ret:=pcour_aff;
                        RERTAIT_ELEM_STR_AFFICHAGE(pdebl_toload,pcour_aff,pcour_ret);
                        end;
                pcour_aff:=pcour_aff.psuiv_toload;
                end;
        end;
F_Jeu.Canvas.Draw(1,1,FBuffer);
End;


//*****************************************************************************//
//===============================BOUCLE DU TIMER===============================//
//*****************************************************************************//

{Procédure principale du jeu, Schéma coordinatif de l'ensemble du jeu}
procedure TF_Jeu.Timer1Timer(Sender: TObject);
Var
Pcour_joueur:T_ptr_VD_Joueur; //Pointeur visant le joueur courant dans la FA des Joueurs (4 VD)
Joueur:integer; //variable compteur des joueurs (car la liste des joueurs est un cycle donc il faut compter les joueurs au passage)
direction:char; //variable revenant du module de vérif du déplacement avec la direction choisie (Up,Dw,Le,Ri)
ligne,colonne:integer; //coordonnées de la case avec laquelle on est en contact
Vitesse:integer;//c'est le nombre de cases dont on peut se déplacer (sans recouvrement etc.)
contact_entite:boolean;//Bouleen permettant de savoir si le joueur est au contact d'une entité
//P_ennemi:T_ptr_VD_Joueur;//pointeur vers l'instance de classe joueur de l'ennemi avec lequel on est en contact
dist:integer; //Distance jusqu'a l'élément de contact
but_x,but_y:integer; //Coordonnées de la case cible du A*
paux_chemin:T_ptr_case_chemin; //Pointeur auxiliaire nous permettant de choppe la case d'arrivée du chemin
paux_prio:t_ptr_prio;
begin
pdebl_toload:=Nil;
//Randomisation de l'ordre de passage
pcour_joueur:=PPremier; //Selection du premier joueur
//Boucle générale
For Joueur:=1 to NB_JOUEURS do //On fait la boucle pour tous les joueurs
        Begin
        //initialisation de la direction a qqch de neutre
        Direction:='a';
        If pcour_joueur.pt_visuel.GETACTIF=true //Si le joueur est actif
                then //alors on peut agir sur lui (actif)
                        If pcour_joueur.pt_visuel.bot=false //Si le joueur est humain
                                 then //Alors test de contact
                                 //***********PARTIE DU MODULE "HUMAIN"**********//
                                      begin
                                      //Cet ordre des procédures (<> de celui pour les bots permet de tapper dans le vide)
                         {VF ---------} If (Not CONTACT_ENNEMI(pcour_joueur.pt_visuel.GETLIGNE,pcour_joueur.pt_visuel.GETCOLONNE,contact_entite,pcour_joueur) and (contact_entite=true)) //Si on est au contact d'un artefact
	                                        Then //Alors on interagit automatiquement avec lui
		         {VF  ------------------------} INTERACTION_ARTEFACT(pcour_joueur,pcour_joueur.pt_visuel.GETLIGNE,pcour_joueur.pt_visuel.GETCOLONNE);
                         {VF  ------- } If COMBAT_DESIRE(pcour_joueur) //Si l'utilisateur a pressé le bouton de combat
                                                Then //Alors il faut tester si il est au contact d'un autre joueur
                                                        begin
		         {VF -------------------------} If CONTACT_ENNEMI(pcour_joueur.pt_visuel.GETLIGNE,pcour_joueur.pt_visuel.GETCOLONNE,trouve,pcour_joueur) //Si il y a bien un joueur dans la direction du coup
			                                        Then //Combat possible
			 {VF -----------------------------------------} COMBAT(pcour_joueur,GET_POINTEUR_ENNEMI(pcour_joueur)); //Application des dégats, modifs des priorités du coupable (+désactivation du touché)
		         {VF -------------------------} AFFICHE_COMBAT(pcour_joueur) //Affiche le personnage entrain de tapper (+désactivation du combattant)
                                                        end
	                                        Else //Le joueur souhaite t-il se déplacer?
		         {VF -------------------------} If DEPLACEMENT_DESIRE(Direction,pcour_joueur) //S'il souhaite se déplacer (touche de mouvement)
			                                        Then //Alors on teste le déplacement
                                                                        begin
                                                                        pcour_joueur.pt_visuel.PUTORIENTATION(Direction);
			 {VF -----------------------------------------} If DEPLACEMENT_POSSIBLE(vitesse,dist,i,j,x,y,trouve,pcour_joueur) //Si le déplacement est effetivement possible
					                                        Then //Alors on se déplace
			 {VF ---------------------------------------------------------} DEPLACEMENT_JOUEUR(pcour_joueur,Direction,vitesse); //direction est la direction dans laquelle on souhaite se déplacer et déplacement est la distance dont on peut se déplacer
                                                                        end;
                                        end
                                 //*********FIN PARTIE DU MODULE "HUMAIN"********//
                                Else//Sinon c'est un bot
                                //*************PARTIE DU MODULE "BOT"************//
                                begin
                         {Test -------} If CONTACT_JOUEUR(pcour_joueur.pt_visuel.GETLIGNE,pcour_joueur.pt_visuel.GETCOLONNE,ligne,colonne,trouve,pcour_joueur)//Si le bot est au contact
                                                then //Alors il faut déterminer ce qu'il touche
                         {Test -----------------------} If CONTACT_ENNEMI(pcour_joueur.pt_visuel.GETLIGNE,pcour_joueur.pt_visuel.GETCOLONNE,trouve,pcour_joueur) //Si il touche un ennemi
                                                                then //Alors combat possible
                         {Test ---------------------------------------} if not PRIORITE_IS_VIE(pcour_joueur){PRIORITE_IS_COMBAT(pcour_joueur)} //Si combat désiré (1°Element de la liste des priorités)
                                                                                then //Alors module de combat
                                                                                        begin
                         {Test -------------------------------------------------------} COMBAT(pcour_joueur,GET_POINTEUR_ENNEMI(pcour_joueur));
                         {Test -------------------------------------------------------} AFFICHE_COMBAT(pcour_joueur);
                                                                                        //Met a jour les priorités du bot
                                                                                        MOV_FRONT(ANALYSE_BESOIN(pcour_joueur),pcour_joueur);
                                                                                        end
                                                                                else //Sinon déplacement possible
                                                                                        begin
                         {Test -------------------------------------------------------} If (CASE_SUIVANTE_OCCUPEE(pcour_joueur)=true) or (CHEMIN_AVARIE(Pcour_joueur.pt_visuel.GETCHEMIN,pcour_joueur)=true)//Si la case suivante est occupée ou si le chemin pointe sur "rien"
                                                                                                then //Alors calcul d'un nouveau chemin
                                                                                                        begin
                         {Test -----------------------------------------------------------------------} SCAN_VISION(pcour_joueur);
                         {Test -----------------------------------------------------------------------} RECUP_COORD(pcour_joueur.pt_visuel.Liste_priorites,but_x,but_y,Pdeb_FA_PASS,pcour_joueur);
                         {Test -----------------------------------------------------------------------} CALCUL_CHEMIN(pcour_joueur.pt_visuel.GETCOLONNE,pcour_joueur.pt_visuel.GETLIGNE,but_x,but_y,pdeb_chemin2);
                                                                                                        //Sauvegarde du chemin
                                                                                                        //Désactivation dans le cas ou a plus chemin
                                                                                                        If pdeb_chemin2<>nil then
                                                                                                                pcour_joueur.pt_visuel.PUTCHEMIN(pdeb_chemin2.ptr_suivant);
                                                                                                        end;
                                                                                        //on appelle le module de deplacement uniquement si le chemin existe
                                                                                        if pcour_joueur.pt_visuel.GETCHEMIN <> nil then
                         {Test ------------------------------------------------------}  DEPLACEMENT_BOT(pcour_joueur); //Déplacement avec mise a jour de la structure d'affichage
                                                                                        end
                                                                Else //Sinon interaction avec un artefact
                                                                        begin
                                                                        //interaction avec l'artefact
                         {Test ---------------------------------------} INTERACTION_ARTEFACT(pcour_joueur,ligne,colonne);
                                                                        //Met a jour les priorités du bot
                                                                        MOV_FRONT(ANALYSE_BESOIN(pcour_joueur),pcour_joueur);
                                                                        //Possibilité de déplacement (pour éviter de rester sur la même case en permanence)
                         {Test ---------------------------------------} If (CASE_SUIVANTE_OCCUPEE(pcour_joueur)=true) or (CHEMIN_AVARIE(Pcour_joueur.pt_visuel.GETCHEMIN,pcour_joueur)=true)//Si la case suivante est occupée ou si le chemin pointe sur "rien"
                                                                                then //Alors calcul d'un nouveau chemin
                                                                                        begin
                         {Test -------------------------------------------------------} SCAN_VISION(pcour_joueur);
                         {Test -------------------------------------------------------} RECUP_COORD(pcour_joueur.pt_visuel.Liste_priorites,but_x,but_y,Pdeb_FA_PASS,pcour_joueur);
                         {Test -------------------------------------------------------} CALCUL_CHEMIN(pcour_joueur.pt_visuel.GETCOLONNE,pcour_joueur.pt_visuel.GETLIGNE,but_x,but_y,pdeb_chemin2);
                                                                                        //Sauvegarde du chemin
                                                                                        //Désactivation dans le cas ou a plus chemin
                                                                                        If pdeb_chemin2<>nil then
                                                                                                pcour_joueur.pt_visuel.PUTCHEMIN(pdeb_chemin2.ptr_suivant);
                                                                                        end;
                                                                        //on appelle le module de deplacement uniquement si le chemin existe
                                                                        if pcour_joueur.pt_visuel.GETCHEMIN <> nil then
                         {Test ---------------------------------------} DEPLACEMENT_BOT(pcour_joueur); //Déplacement avec mise a jour de la structure d'affichage
                                                                        end
                                                Else//Sinon déplacement
                                                        begin
                         {Test -----------------------} If (CASE_SUIVANTE_OCCUPEE(pcour_joueur)=true) or (CHEMIN_AVARIE(Pcour_joueur.pt_visuel.GETCHEMIN,pcour_joueur)=true)//Si la case suivante est occupée ou si le chemin pointe sur "rien"
                                                                then //Alors calcul d'un nouveau chemin
                                                                        begin
                         {Test ---------------------------------------} SCAN_VISION(pcour_joueur);
                         {Test ---------------------------------------} RECUP_COORD(pcour_joueur.pt_visuel.Liste_priorites,but_x,but_y,Pdeb_FA_PASS,pcour_joueur);
                         {Test ---------------------------------------} CALCUL_CHEMIN(pcour_joueur.pt_visuel.GETCOLONNE,pcour_joueur.pt_visuel.GETLIGNE,but_x,but_y,pdeb_chemin2);
                                                                        //Sauvegarde du chemin
                                                                        //Désactivation dans le cas ou a plus chemin
                                                                        If pdeb_chemin2<>nil then
                                                                                pcour_joueur.pt_visuel.PUTCHEMIN(pdeb_chemin2.ptr_suivant);
                                                                        end;
                                                        //on appelle le module de deplacement uniquement si le chemin existe
                                                        if pcour_joueur.pt_visuel.GETCHEMIN <> nil then                
                         {Test -----------------------} DEPLACEMENT_BOT(pcour_joueur); //Déplacement avec mise a jour de la structure d'affichage
                                                        end;
                                //Met a jour les priorités du bot
                                MOV_FRONT(ANALYSE_BESOIN(pcour_joueur),pcour_joueur);
                                SCAN_VISION(pcour_joueur);
                                //on récupère les coordonnées du premier elem <>(-1,-1) dans la liste des priorités
                                RECUP_COORD(pcour_joueur.pt_visuel.Liste_priorites,but_x,but_y,Pdeb_FA_PASS,pcour_joueur);
                                //Si la case suivante est occupée
                                If (CASE_SUIVANTE_OCCUPEE(pcour_joueur)=true) or (CHEMIN_AVARIE(Pcour_joueur.pt_visuel.GETCHEMIN,pcour_joueur)=true)//Si la case suivante est occupée ou si le chemin pointe sur "rien"
                                        then
                                        begin
                                        CALCUL_CHEMIN(pcour_joueur.pt_visuel.GETCOLONNE,pcour_joueur.pt_visuel.GETLIGNE,but_x,but_y,pdeb_chemin2);
                                        If pdeb_chemin2<>nil then pcour_joueur.pt_visuel.PUTCHEMIN(pdeb_chemin2.ptr_suivant);
                                        end;
                                end;
                         //***********FIN PARTIE DU MODULE "BOT"**********//
{VF - } REACTIVATION(pdeb_FA_inact);    //réactivation de tous les éléments qui doivent être réactivés
{VF - } MODULE_AFFICHAGE(PHumain,pdebl_toload); //Affichage des élements a afficher en fonction du Timer
{VF - } VERIF_XP(pcour_joueur); //vérification de l'XP du personnage en cours, histoire de voir s'il n'a pas gagné
{VF - } MORT(pcour_joueur, PPremier_Renaiss);
{VF - } MAJ_DONNEES_ECRAN(Pcour_joueur,Phumain);//Mise a jour des données à l'écran
        pcour_joueur:=pcour_joueur^.psuiv;  //on passe au personnage suivant
        End;
PPremier:=PPremier^.psuiv;//Fin de la randomisation (feinte par cycle)
end;

//*****************************************************************************//
//===============================FIN BOUCLE DU TIMER===========================//
//*****************************************************************************//

end.
