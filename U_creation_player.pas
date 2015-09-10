{JEU ZELDARENA - SAND
JOACHIM BOUSSOUMAH      GPBb
TIMOTHEE BOURGUIGNON    GPAa
EPF2}
unit U_creation_player;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, ImgList, jpeg, Menus, U_types;

type
  TF_Crea_Perso = class(TForm)
    E_nom: TEdit;
    L_Nom: TLabel;
    GroupBox3: TGroupBox;
    SB_Force: TScrollBar;
    Label1: TLabel;
    L_F: TLabel;
    Label3: TLabel;
    SB_Armure: TScrollBar;
    L_S: TLabel;
    Label5: TLabel;
    SB_Attaque: TScrollBar;
    L_A: TLabel;
    SB_endurance: TScrollBar;
    SB_precision: TScrollBar;
    Label9: TLabel;
    Label10: TLabel;
    L_P: TLabel;
    L_E: TLabel;
    Label7: TLabel;
    L_Points: TLabel;
    Label2: TLabel;
    L_Max: TLabel;
    CB_Avatar: TComboBox;
    Label6: TLabel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Shape1: TShape;
    OpenPlayer: TOpenDialog;
    E_Phrase: TEdit;
    Label4: TLabel;
    Label8: TLabel;
    L_XP: TLabel;
    MainMenu1: TMainMenu;
    Fichier1: TMenuItem;
    Charger1: TMenuItem;
    Enregistrer1: TMenuItem;
    Quitter1: TMenuItem;
    Nouveau1: TMenuItem;
    Image4: TImage;
    RB_vi: TRadioButton;
    Image1: TImage;
    Image2: TImage;
    RB_ro: TRadioButton;
    Image5: TImage;
    RB_Bl: TRadioButton;
    RB_ve: TRadioButton;
    Image3: TImage;
    I_Avatar: TImage;
    ImageList1: TImageList;
    procedure SB_ForceChange(Sender: TObject);
    procedure SB_ArmureChange(Sender: TObject);
    procedure SB_enduranceChange(Sender: TObject);
    procedure SB_AttaqueChange(Sender: TObject);
    procedure SB_precisionChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CB_AvatarChange(Sender: TObject);
    procedure Charger1Click(Sender: TObject);
    procedure Quitter1Click(Sender: TObject);
    procedure Enregistrer1Click(Sender: TObject);
    procedure Nouveau1Click(Sender: TObject);
  private
    { Private declarations }
    Procedure CHANGE_AVATAR;
    Function  VERIF_EXACTE:Boolean;
    Procedure ECRITURE_DONNEES(Fic:string);
    Function  GET_E_PHRASE:string;
    Procedure PUT_E_PHRASE(Phrase:string);
    Function  GET_E_NOM:string;
    Procedure PUT_E_NOM(Nom:string);
    Procedure PUT_CB_AVATAR_TEXT(Avatar:string);
    Function  GET_CB_AVATAR_TEXT:string;
    Procedure PUT_L_MAX(Pts:integer);
    Function  GET_L_MAX:integer;
    Procedure PUT_L_POINTS(Pts:integer);
    Function  GET_L_POINTS:integer;
    Procedure PUT_L_XP(Pts:integer);
    Function  GET_L_XP:integer;
    Procedure CHARGER;
    Procedure ENREGISTRER;
    Procedure ZERO;
  public
    { Public declarations }
  end;
//*****************************************************************************//
var
  F_Crea_Perso: TF_Crea_Perso;
  Buffer_Avatar,Buffer_Avatar2:Tbitmap;
  Chemin_Avatar:string;
  Img_Avatar,Img_Avatar2:Tbitmap;
  Load_Avatar:String;   //Variable contenant le nom de l'avatar à charger
  //*****************************************************************************//
implementation
uses U_Accueil;
{$R *.dfm}
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Modules orienté objet  %%%%%%%%%%%%%%%%%%%%//
//*****************************************************************************//
Procedure TF_Crea_Perso.PUT_E_NOM(Nom:string);
Begin
E_Nom.Text:=Nom;
End;
                                //----------//
Function TF_Crea_Perso.GET_E_NOM:string;
Begin
GET_E_NOM:=E_nom.Text;
End;
//*****************************************************************************//
Procedure TF_Crea_Perso.PUT_E_PHRASE(Phrase:string);
Begin
E_Phrase.Text:=Phrase;
End;
                                //----------//
Function TF_Crea_Perso.GET_E_PHRASE:string;
Begin
GET_E_PHRASE:=E_Phrase.Text;
End;
//*****************************************************************************//
Procedure TF_Crea_Perso.PUT_CB_AVATAR_TEXT(Avatar:string);
Begin
CB_Avatar.Text:=Avatar;
End;
                                //----------//
Function TF_Crea_Perso.GET_CB_AVATAR_TEXT:string;
Begin
GET_CB_AVATAR_TEXT:=CB_Avatar.Text;
End;
//*****************************************************************************//
Procedure TF_Crea_Perso.PUT_L_MAX(Pts:integer);
Begin
L_Max.Caption:=Inttostr(Pts);
End;
                                //----------//
Function TF_Crea_Perso.GET_L_MAX:integer;
Begin
GET_L_MAX:=strtoint(L_Max.Caption);
End;
//*****************************************************************************//
Procedure TF_Crea_Perso.PUT_L_POINTS(Pts:integer);
Begin
L_Points.Caption:=Inttostr(Pts);
End;
                                //----------//
Function TF_Crea_Perso.GET_L_POINTS:integer;
Begin
GET_L_POINTS:=strtoint(L_Points.Caption);
End;
//*****************************************************************************//
Procedure TF_Crea_Perso.PUT_L_XP(Pts:integer);
Begin
L_XP.Caption:=Inttostr(Pts);
End;
                                //----------//
Function TF_Crea_Perso.GET_L_XP:integer;
Begin
GET_L_XP:=strtoint(L_XP.Caption);
End;
//*****************************************************************************//

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%  Modules de traitement des players  %%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

//*****************************************************************************//

//Module permettant de savoir si tous les champs sont remplis et exact
Function TF_Crea_Perso.VERIF_EXACTE:Boolean;
//En Sortie: VERIF_EXACT contient vrai si tout est bien rempli
Begin
//Si tous les champs sont bien remplis
If   (F_Crea_Perso.GET_E_NOM<>'')   and (GET_CB_AVATAR_TEXT<>STRING_AVATAR) and (L_Points.caption=inttostr(0))
                        and (strtoint(L_F.caption)<>0) and (strtoint(L_A.caption)<>0) and (strtoint(L_S.caption)<>0) and (strtoint(L_P.caption)<>0) and (strtoint(L_E.caption)<>0)
                        and ((RB_Bl.Checked=true) or (RB_Ro.Checked=true) or (RB_Ve.Checked=true) or (RB_Vi.Checked=true))
        Then    //Alors la vérification est exacte
                VERIF_EXACTE:=true
        Else    //Sinon, la vérification n'est pas bonne
                VERIF_EXACTE:=false;
End;

//*****************************************************************************//
//*****************************************************************************//

//Module d'ecriture des données concernant le joueur dans le fichier text créé à son nom
Procedure TF_Crea_Perso.ECRITURE_DONNEES(Fic:string);
//En entrée: Le chemin d'accès au fichier dans lequel on va sauvegarder
//En Sortie: Rien
Var
fic_P:textfile;
Begin
//Reinitialisation de la directory initiale
SetCurrentDir(Dossier_initial);
//Assignement et Ouverture du fichier text
Assignfile(Fic_P,fic);
Rewrite(Fic_P);
//Ecritures dans le fichier
//XP
Writeln(Fic_P,inttostr(F_Crea_Perso.GET_L_XP));
//Points
Writeln(Fic_P,inttostr(F_Crea_Perso.GET_L_MAX));
//NOM
Writeln(Fic_P,F_Crea_Perso.GET_E_NOM);
//SKIN
If (RB_Bl.Checked=true) then Writeln(fic_P,IMG_LINK_BLE);
If (RB_Ro.Checked=true) then Writeln(fic_P,IMG_LINK_ROU);
If (RB_Ve.Checked=true) then Writeln(fic_P,IMG_LINK_VER);
If (RB_Vi.Checked=true) then Writeln(fic_P,IMG_LINK_VIO);
//AVATAR
Writeln(fic_P,CB_Avatar.text);
//CARACTERISTIQUES
Writeln(fic_P,L_F.caption);
Writeln(fic_P,L_S.caption);
Writeln(fic_P,L_A.caption);
Writeln(fic_P,L_P.caption);
Writeln(fic_P,L_E.caption);
Writeln(fic_P,E_Phrase.Text);
//fermeture d fichier
Closefile(fic_P);
End;

//*****************************************************************************//
//*****************************************************************************//
//Module de sauvegarde des informations concernant le joueur dans un fichier text
Procedure TF_Crea_Perso.ENREGISTRER;
//En entrée: rien
//En Sortie: rien
Var
Fic:string;
Begin
//Chemin d'acces au fichier de sauvegarde
fic:=DOSSIER_PLA+SLASH+E_nom.Text+JOU_EXTENSION;
//Sauvegarde
//Si tous les champs sont bien remplis et que le fichier n'existe pas
If (VERIF_EXACTE=true) and (not FileExists(fic))
        then    //Alors on peut enregistrer
                Begin
                //Enregistrement des données dans le fichier text
                F_Crea_Perso.ECRITURE_DONNEES(fic);
                //Affichage
                Showmessage('Enregistrement effectué!');
                //Switch des fenetres
                F_Crea_Perso.Hide;
                F_Accueil.Show;
                end
        Else    //Sinon, soit le fichier existe soit tout n'est pas bien rempli
                //Si est bien rempli
                if VERIF_EXACTE=True
                        then    //Alors le nom de fichier est deja utilisé
                                Showmessage('Ce nom de joueur est déjà utilisé!')
                        Else    //Sinon, tout n'est pas bien rempli
                                Showmessage('Certains champs ne sont pas remplis, ou mal remplis!!');
End;
//*****************************************************************************//
//*****************************************************************************//

//PROCEDURES DE CHANGEMENT DES SCROLL BARS DE DEFINITION DE POINTS DE COMPETENCE
Procedure TF_Crea_Perso.SB_ForceChange(Sender: TObject);
Begin
L_F.caption:=inttostr(SB_Force.Position);
L_Points.Caption:=inttostr(F_Crea_Perso.GET_L_MAX-(SB_Force.Position+SB_armure.Position+SB_endurance.Position+SB_Attaque.Position+SB_precision.Position));
End;
Procedure TF_Crea_Perso.SB_ArmureChange(Sender: TObject);
Begin
L_S.caption:=inttostr(SB_armure.Position);
L_Points.Caption:=inttostr(F_Crea_Perso.GET_L_MAX-(SB_Force.Position+SB_armure.Position+SB_endurance.Position+SB_Attaque.Position+SB_precision.Position));
End;
Procedure TF_Crea_Perso.SB_enduranceChange(Sender: TObject);
Begin
L_E.caption:=inttostr(SB_endurance.Position);
L_Points.Caption:=inttostr(F_Crea_Perso.GET_L_MAX-(SB_Force.Position+SB_armure.Position+SB_endurance.Position+SB_Attaque.Position+SB_precision.Position));
End;
Procedure TF_Crea_Perso.SB_AttaqueChange(Sender: TObject);
Begin
L_A.caption:=inttostr(SB_Attaque.Position);
L_Points.Caption:=inttostr(F_Crea_Perso.GET_L_MAX-(SB_Force.Position+SB_armure.Position+SB_endurance.Position+SB_Attaque.Position+SB_precision.Position));
End;
Procedure TF_Crea_Perso.SB_precisionChange(Sender: TObject);
Begin
L_P.caption:=inttostr(SB_precision.Position);
L_Points.Caption:=inttostr(F_Crea_Perso.GET_L_MAX-(SB_Force.Position+SB_armure.Position+SB_endurance.Position+SB_Attaque.Position+SB_precision.Position));
End;

//*****************************************************************************//
//*****************************************************************************//

//Module d'initlialisation de différentes variables
Procedure TF_Crea_Perso.FormCreate(Sender: TObject);
//En entrée: rien
//En Sortie: rien
Begin
//Initialisation de l'élément courant de la combobox Avatar
CB_Avatar.Text:='';
//Chargement des Elements de la combobox Avatar
CB_Avatar.Items.LoadFromFile(DOSSIER_AVA+SLASH+FICHIER_AVATAR);
End;

//*****************************************************************************//
//*****************************************************************************//

//Module d'affichage de l'image
Procedure TF_Crea_Perso.CHANGE_AVATAR;
//En entrée : Rien
//En sortie : Rien
Var
int,i:integer;
Avatar, nom:string;
Begin
For i:=LONGUEUR_AVATAR to length(CB_Avatar.Text) do
        nom:=nom+CB_Avatar.Text[i];
For i:=1 to (length(nom)-LONGUEUR_EXTENSION) do
        avatar:=avatar+nom[i];
int:=strtoint(avatar);
ImageList1.GetBitmap(int,I_Avatar.Picture.Bitmap);
I_Avatar.Repaint;
End;

//*****************************************************************************//
//*****************************************************************************//

//Module de changement de l'image Avatar
Procedure TF_Crea_Perso.CB_AvatarChange(Sender: TObject);
//En entrée : Rien
//En sortie : Rien
Begin
//Appel de la procedure d'affichage de l'avatar
F_Crea_Perso.CHANGE_AVATAR;
End;

//*****************************************************************************//
//*****************************************************************************//

//Module de chargement d'un perso deja créé
Procedure TF_Crea_Perso.CHARGER;
//En entrée : Rien
//En sortie : Rien
Var
fic_Player:textfile;            //Variable correspondant au fichier du joueur
Nom,Avatar,Skin,Phrase:string;  //Variable correspondans aux données à lire
XP,Pts,F,A,S,P,E:integer;       //Variable correspondans aux données à lire
Begin
//Si l'utilisateur clique sur ouvrir dans l'OpenDialog
If OpenPlayer.Execute
        then //Alors on charge les caractéristiques du joueur
        Begin
        //Assignation du nom physique et du nom logique
        Assignfile(Fic_Player,OpenPlayer.FileName);
        //Ouveture du fichier
        Reset(Fic_Player);
        //Capture des données
        readln(Fic_Player,XP);
        readln(Fic_Player,Pts);
        readln(Fic_Player,nom);
        readln(Fic_Player,Skin);
        readln(Fic_Player,avatar);
        readln(Fic_Player,f);
        readln(Fic_Player,s);
        readln(Fic_Player,a);
        readln(Fic_Player,p);
        readln(Fic_Player,e);
        readln(Fic_Player,Phrase);
        //Fermeture du fichier
        Closefile(Fic_Player);
        //Attributions des données
        E_nom.text:=nom;
        //Valeurs numériques
        F_Crea_Perso.PUT_L_MAX(Pts);
        F_Crea_Perso.PUT_L_Points(Pts);
        //Points d'Expérience
        PUT_L_XP(XP);
        //Checkbox
        If Skin=IMG_LINK_BLE
                then RB_Bl.Checked:=true;
        if Skin=IMG_LINK_ROU
                then RB_ro.Checked:=true;
        if Skin=IMG_LINK_VER
                then RB_ve.Checked:=true;
        if Skin=IMG_LINK_VIO
                then RB_vi.Checked:=true;
        //Attribution des Caractéristiques
        SB_Force.Position:=(f);
        SB_Armure.Position:=(s);
        SB_Attaque.Position:=(a);
        SB_precision.Position:=(p);
        SB_endurance.Position:=(e);
        //Phrase
        E_Phrase.Text:=Phrase;
        //Changement de l'avatar courant dans la combobox
        CB_Avatar.Text:=Avatar;
        //Appel de la procedure de changement de l'image
        F_Crea_Perso.CHANGE_AVATAR;
        End;
End;

//*****************************************************************************//
//*****************************************************************************//

//Module d'appel du chargement d'un joueur
Procedure TF_Crea_Perso.Charger1Click(Sender: TObject);
//En entrée : Rien
//En sortie : Rien
Begin
SetCurrentDir(Dossier_initial);
F_Crea_Perso.CHARGER;
End;

//*****************************************************************************//
//*****************************************************************************//

//Module pemettant de quitter le mode de création de joueurs
procedure TF_Crea_Perso.Quitter1Click(Sender: TObject);
//En entrée: rien
//En Sortie: rien
Begin
//Quitter sans enregister
if MessageDlg('Vous êtes sur le point de quitter le mode de création de joueur?'+#13+'Continuer?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        begin
        F_Crea_Perso.hide;
        F_Accueil.Show;
        end;
End;

//*****************************************************************************//
//*****************************************************************************//

//Module d'enregistrement du joueur créé
Procedure TF_Crea_Perso.Enregistrer1Click(Sender: TObject);
//En entrée: rien
//En Sortie: rien
Begin
F_Crea_Perso.ENREGISTRER;
End;

//*****************************************************************************//
//*****************************************************************************//

//Procedure de mise a zéro de tous les champs
Procedure TF_Crea_Perso.ZERO;
//En entrée: rien
//En Sortie: rien
Begin
F_Crea_Perso.PUT_E_NOM('');
F_Crea_Perso.PUT_CB_AVATAR_TEXT(STRING_AVATAR);
F_Crea_Perso.PUT_L_MAX(MAX_POINTS);
F_Crea_Perso.PUT_L_POINTS(POINTS_A_PLACER);
F_Crea_Perso.PUT_E_PHRASE('');
SB_Force.Position:=POINT_INIT;
SB_Armure.Position:=POINT_INIT;
SB_Attaque.Position:=POINT_INIT;
SB_Precision.Position:=POINT_INIT;
SB_Endurance.Position:=POINT_INIT;
End;

//*****************************************************************************//
//*****************************************************************************//

//Module d'appel de mise a zéro de tous les champs
procedure TF_Crea_Perso.Nouveau1Click(Sender: TObject);
//En entrée: rien
//En Sortie: rien
begin
SetCurrentDir(Dossier_initial);
F_Crea_Perso.ZERO;
end;
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
End.
