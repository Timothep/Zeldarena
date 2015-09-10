{JEU ZELDARENA - SAND
JOACHIM BOUSSOUMAH      GPBb
TIMOTHEE BOURGUIGNON    GPAa
EPF2}
{Unité contenant tous les types utilisés par le programme, 
ainsi que les constantes et certaines variables}
unit U_Types;

interface
//Définition des types utilisés dans le programme

Uses U_crea_terrain, U_crea_artefact, U_FA_Pts_Renaissance, U_crea_joueur, Graphics;

//****************************************************************************//
//********************************TYPES***************************************//
//****************************************************************************//
Type

//Ensembles pour la FA joueur
T_ptr_VD_Joueur = ^VD_Joueur;
nx_joueur       = TC_joueur;
VD_Joueur       = record
                        pt_visuel : TC_joueur;
                        psuiv : T_ptr_VD_Joueur;
                 end;
//Case élémentaire de la matrice principale du jeu
Ptr_Element_Base=^ELEMENT_BASE;
ELEMENT_BASE     =record
                 Ptr_Terrain : TC_terrain ; //Pointeur vers une instantce de la classe Terrain
                 Ptr_Artefact: TC_artefact; //Pointeur vers une instantce de la classe Artefact
                 Ptr_Joueur  : T_ptr_VD_Joueur  ; //Pointeur vers une instantce de la classe Joueur
                 end;
//VD de l'arbre des scores trié par scores
Ptr_Abr_scores=^ELEMENT_ABR_SCORES;
ELEMENT_ABR_SCORES= record
                Nom     : String;
                Score   : integer;
                psuiv   : Ptr_Abr_scores;
                end;


//****************************************************************************//
//*******************************CONST****************************************//
//****************************************************************************//
Const
//============================================================================//
//--------------------------Constantes nécessaires au jeu---------------------//
//============================================================================//
NB_JOUEURS      = 4;
NUM_PICTURES    = 89;       //Nombre de Tiles Disponibles
TILE_SIZE       = 32;      //Longueur (et Largeur) d'un Tile
TILE_SHIFT      = 5;       //2^5=32, Utilisé pour réduire les temps d'action du processeur
//============================================================================//
//--------------------------Constantes Graphiques-----------------------------//
//============================================================================//
//Numéros par défaut des tiles principales
NUM_TERRE       =1;
NUM_HERBE       =2;
NUM_EAU         =66;
NUM_GOMME       =89;
DERNIER_TER     =41;
//Constantes d'extensions
SLASH           ='\';
MAP_EXTENSION   ='.map';
TER_EXTENSION   ='.ter';
ART_EXTENSION   ='.art';
JOU_EXTENSION   ='.jou';
BMP_EXTENSION   ='.bmp';
LONGUEUR_EXTENSION=4;
//Nom sprite par défaut
SPRITE_DEFAUT   ='D0';
//Noms génériques des Sprites
UP_NOM          ='U';
DW_NOM          ='D';
LE_NOM          ='L';
RI_NOM          ='R';
//Directions
DIR_UP          =2;
DIR_LE          =1;
DIR_DW          =0;
DIR_RI          =3;
//Taille du champ de vision des Bots
L_VISION        =10;
//Fichiers Text
FICHIER_CONFIG  ='Config.txt';
FICHIER_AVATAR  ='Avatars.txt';
//Dossiers
DOSSIER_PLA     ='Player';
DOSSIER_MAP     ='Maps';
DOSSIER_AVA     ='Avatars';
DOSSIER_TIL     ='Tiles';
DOSSIER_SPRITES ='Sprites';
DOSSIER_ARMES   ='Armes';
DOSSIER_1       ='1';
DOSSIER_2       ='2';
DOSSIER_3       ='3';
DOSSIER_4       ='4';
//Strings des niveaux
NIV_DEB         ='debutant';
NIV_NOR         ='normal';
NIV_EXP         ='expert';
//Tailles respectives des petites, moyennes et grandes cartes à affecter à la drawgrid
WID_PET_DG_CARTE=665;
HEI_PET_DG_CARTE=505;
WID_MOY_DG_CARTE=1329;
HEI_MOY_DG_CARTE=1001;
WID_GRD_DG_CARTE=1985;
HEI_GRD_DG_CARTE=1489;
//NB colonnes et rang des petites, moyennes et grandes cartes à affecter à la drawgrid
COL_PET_DG_CARTE=20;
ROW_PET_DG_CARTE=15;
COL_MOY_DG_CARTE=40;
ROW_MOY_DG_CARTE=30;
COL_GRD_DG_CARTE=60;
ROW_GRD_DG_CARTE=45;
//Tailles des cartes
CHAINE_PET      ='Petite';
CHAINE_MOY      ='Moyenne';
CHAINE_GRD      ='Grande';
//Numéros d'images des Bots par défaut
NUM_IMG_BOT1    =10;
NUM_IMG_BOT2    =8;
NUM_IMG_BOT3    =14;
//Noms des bots par défaut
NOM_BOT1        ='Agamemnon';
NOM_BOT2        ='Omnius';
NOM_BOT3        ='Vorian';
//Nom du fichier son windows
MODULE_SON_WINDOWS='SNDVOL32.EXE';
//Lenght('avatar')+1
LONGUEUR_AVATAR =7;
STRING_AVATAR   ='Avatar';
//Images LINK 4 couleurs
IMG_LINK_BLE    ='linkble.bmp';
IMG_LINK_ROU    ='linkrou.bmp';
IMG_LINK_VER    ='linkver.bmp';
IMG_LINK_VIO    ='linkvio.bmp';
//Points créa perso
MAX_POINTS      =35;
POINTS_A_PLACER =10;
POINT_INIT      =5;
//Points de Vie Initial du jeu
INIT_POINTS_VIE =100;
MIN_VIE         =30;
//JAUGE DU SPLASH SCREEN
PAS_JAUGE       =Round(100/8);
//Numéros des points de passage
PASSAGE_1       =81;
PASSAGE_2       =82;
//Numéros des points de renaissance
RENAISS_1       =83;
RENAISS_2       =84;
//Délais inactivité (dormissage en millisecondes)
DELAI_ART       =10000;
DELAI_JOU_MORT  =1000;
DELAI_JOU_BLES  =500;
DELAI_JOU_MARCHE=100;
DELAI_JOU_FRAP  =100;
//Gains d'XP
XP_RUBIS        =10;
XP_EMMERAUDES   =10;
XP_KILL         =100;
XP_GAGNANT      =500;
//Bonus d'armes et d'armures
BONUS_NIV1      =2;
BONUS_NIV2      =5;
BONUS_NIV3      =8;
//Sons
SON_ATTAQUE     ='Sons\Sword.wav';
SON_MORT        ='Sons\Die.wav';
//****************************************************************************//
//******************************VAR*******************************************//
//****************************************************************************//
Var
Num:integer; //N° Tile pour création carte
Dossier_initial:String;//Adresse du dossier initial
Pdeb_FA_Renaissance,Pfin_FA_Renaissance,Pcour_FA_Renaissance:T_ptr_FA_Renaissance;
pnouv, Pdeb_FA_Joueur, Pfin_FA_Joueur, Pcour_FA_Joueur,PPremier_Joueur,PHumain,PHumain2,PHumain3,PHumain4,P_bot1,P_bot2,P_bot3: T_ptr_VD_Joueur;
Tab_Sprite_Rou,Tab_Sprite_Ver,Tab_Sprite_Ble,Tab_Sprite_Vio:Array [0..3,0..2] of Tbitmap;
//****************************************************************************//
//****************************************************************************//
//****************************************************************************//
implementation

end.
