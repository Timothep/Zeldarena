unit U_Load;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ImgList, StdCtrls, jpeg, U_types;

type
  TF_Load = class(TForm)
    ImageList1: TImageList;
    Image1: TImage;
    Timer1: TTimer;
    Label5: TLabel;
    Shape2: TShape;
    I_Avatar1: TImage;
    Shape1: TShape;
    I_Avatar2: TImage;
    Shape3: TShape;
    I_Avatar3: TImage;
    Shape4: TShape;
    I_Avatar4: TImage;
    E_Avatar1: TEdit;
    E_Avatar2: TEdit;
    E_Avatar3: TEdit;
    E_Avatar4: TEdit;
    E_Niveau: TEdit;
    Label1: TLabel;
    E_Carte: TEdit;
    Image2: TImage;
    ImageList2: TImageList;
    B_Choix_Joueur: TButton;
    B_Choix_Carte: TButton;
    OpenDialog2: TOpenDialog;
    OpenDialog1: TOpenDialog;
    B_retour: TButton;
    B_Continuer: TButton;
    B_Choix_Joueur2: TButton;
    B_Choix_Joueur3: TButton;
    B_Choix_Joueur4: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    procedure Timer1Timer(Sender: TObject);
    procedure B_retourClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure B_Choix_JoueurClick(Sender: TObject);
    procedure B_Choix_CarteClick(Sender: TObject);
    procedure B_ContinuerClick(Sender: TObject);
    procedure B_Choix_Joueur2Click(Sender: TObject);
    procedure B_Choix_Joueur3Click(Sender: TObject);
    procedure B_Choix_Joueur4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Procedure AFF_TIMER;
    Procedure REMPLISSAGE;
  end;
  
Const

//Const animations
NUM_ANIM_IMAGE_VIDE=20;
NUM_ANIM_DER_IMAGE=19;

var
  F_Load: TF_Load;
  Numero,int_avatar,int_avatar2,int_avatar3,int_avatar4:integer;
implementation

uses U_Accueil, U_Jeu, U_NB_joueurs;

{$R *.dfm}

//*****************************************************************************//
//*****************************************************************************//

Procedure TF_Load.AFF_TIMER;
Begin
ImageList1.GetBitmap(NUM_ANIM_IMAGE_VIDE,Image1.Picture.Bitmap);
ImageList1.GetBitmap(Numero,Image1.Picture.Bitmap);
Image1.Repaint;
If numero=NUM_ANIM_DER_IMAGE
        then numero:=0
        else Numero:=Numero+1;
End;

//*****************************************************************************//
//*****************************************************************************//

procedure TF_Load.Timer1Timer(Sender: TObject);
begin
F_Load.AFF_TIMER;
end;

//*****************************************************************************//
//*****************************************************************************//

procedure TF_Load.B_retourClick(Sender: TObject);
begin
//
F_NB_J.show;
F_Load.Hide;
end;

//*****************************************************************************//
//*****************************************************************************//

Procedure TF_Load.REMPLISSAGE;
Var
Fic_Config,Fic_player:textfile;
Nom,Image,Avatar, Num:string;
i, Int:integer;
begin
//Reinitialisation du dossier initial
SetCurrentDir(Dossier_initial);
Assignfile(Fic_Config,FICHIER_CONFIG);
Reset(Fic_Config);
//Ajout un bot dans le cas ou il n'y a pas 4 humains sur la carte
If Nb_J_Humains < 2 then
begin
        //---------------//
        //Joueur 2
        //---------------//
        nom:='';
        image:='';
        Avatar:='';
        Num:='';
        Readln(Fic_Config,Nom);
        Assignfile(Fic_player,DOSSIER_PLA+SLASH+nom+JOU_EXTENSION);
        Reset(Fic_Player);
        Readln(Fic_Player);   //  On passe les
        Readln(Fic_Player);   //  différentes
        Readln(Fic_Player);   //  variables
        Readln(Fic_Player);   //  non voulues
        Readln(Fic_Player,Image); //Lecture du nom d'image
        //Nom du bot
        E_Avatar2.Text:=Nom;
        //Image du bot
        For i:=LONGUEUR_AVATAR to length(Image) do
                Avatar:=Avatar+Image[i];
        For i:=1 to (length(Avatar)-LONGUEUR_EXTENSION) do
                Num:=Num+Avatar[i];
        int:=strtoint(Num);
        int_avatar2:=int;
        ImageList2.GetBitmap(int,I_Avatar2.Picture.Bitmap);
        Closefile(Fic_Player);
End;
//Ajout un bot dans le cas ou il n'y a pas 3 humains sur la carte
If Nb_J_Humains < 3 then
begin
        //---------------//
        //Joueur3
        //===============//
        nom:='';
        image:='';
        Avatar:='';
        Num:='';
        Readln(Fic_Config,Nom);
        Assignfile(Fic_player,DOSSIER_PLA+SLASH+nom+JOU_EXTENSION);
        Reset(Fic_Player);
        Readln(Fic_Player);   //  On passe les
        Readln(Fic_Player);   //  différentes
        Readln(Fic_Player);   //  variables
        Readln(Fic_Player);   //  non voulues
        Readln(Fic_Player,Image); //Lecture du nom d'image
        //Nom du bot
        E_Avatar3.Text:=Nom;
        //Image du bot
        For i:=LONGUEUR_AVATAR to length(Image) do
                Avatar:=Avatar+Image[i];
        For i:=1 to (length(Avatar)-LONGUEUR_EXTENSION) do
                Num:=Num+Avatar[i];
        int:=strtoint(Num);
        int_avatar3:=int;
        ImageList2.GetBitmap(int,I_Avatar3.Picture.Bitmap);
        Closefile(Fic_Player);
end;
//Ajout un bot dans le cas ou il n'y a pas 2 humains sur la carte
If Nb_J_Humains < 4 then
begin
        ///////////////////
        //Joueur4
        ///////////////////
        nom:='';
        image:='';
        Avatar:='';
        Num:='';
        Readln(Fic_Config,Nom);
        Assignfile(Fic_player,DOSSIER_PLA+SLASH+nom+JOU_EXTENSION);
        Reset(Fic_Player);
        Readln(Fic_Player);   //  On passe les
        Readln(Fic_Player);   //  différentes
        Readln(Fic_Player);   //  variables
        Readln(Fic_Player);   //  non voulues
        Readln(Fic_Player,Image); //Lecture du nom d'image
        //Nom du bot
        E_Avatar4.Text:=Nom;
        //Image du bot
        For i:=LONGUEUR_AVATAR to length(Image) do
                Avatar:=Avatar+Image[i];
        For i:=1 to (length(Avatar)-LONGUEUR_EXTENSION) do
                Num:=Num+Avatar[i];
        int:=strtoint(Num);
        int_avatar4:=int;
        ImageList2.GetBitmap(int,I_Avatar4.Picture.Bitmap);
        Closefile(Fic_Player);
end;
///////////////////
//Niveau
Readln(Fic_Config,Nom);
E_Niveau.Text:=Nom;     
//Repaint
I_Avatar1.Repaint;
I_Avatar2.Repaint;
I_Avatar3.Repaint;
I_Avatar4.Repaint;
//fermeture du fichier
Closefile(Fic_Config);
end;

//*****************************************************************************//
//*****************************************************************************//

procedure TF_Load.FormShow(Sender: TObject);
Begin
//Cas des joueurs Humains, désactivation des boutons
Case NB_J_Humains of
        1:
        Begin
        B_Choix_Joueur.Visible:=True;
        B_Choix_Joueur2.Visible:=false;
        B_Choix_Joueur3.Visible:=false;
        B_Choix_Joueur4.Visible:=false;
        End;
        2:
        Begin
        B_Choix_Joueur.Visible:=True;
        B_Choix_Joueur2.Visible:=True;
        B_Choix_Joueur3.Visible:=false;
        B_Choix_Joueur4.Visible:=false;
        End;
        3:
        Begin
        B_Choix_Joueur.Visible:=True;
        B_Choix_Joueur2.Visible:=True;
        B_Choix_Joueur3.Visible:=True;
        F_load.B_Choix_Joueur4.Visible:=false;
        End;
        4:
        Begin
        B_Choix_Joueur.Visible:=True;
        B_Choix_Joueur2.Visible:=True;
        B_Choix_Joueur3.Visible:=True;
        F_load.B_Choix_Joueur4.Visible:=True;
        End;
End;
//Remplissage Champs
F_Load.REMPLISSAGE;
End;

//*****************************************************************************//
//*****************************************************************************//

procedure TF_Load.B_Choix_JoueurClick(Sender: TObject);
Var
Fic:textfile;
num,i,int:integer;
Nom,Avat,Numero,Avatar:string;
begin
//Reinitialisation du dossier initial
SetCurrentDir(Dossier_initial);
If Opendialog1.execute
        then
        begin
        //Gestion Fichier
        Assignfile(Fic,Opendialog1.FileName);
        reset(Fic);
        readln(Fic,Num);
        readln(Fic,Num);
        readln(Fic,Nom);
        readln(Fic,Avat);
        readln(Fic,Avat);
        CloseFile(Fic);
        //Affichages
        E_Avatar1.Text:=Nom;
        //Suppression Texte
        Avatar:='';
        For i:=LONGUEUR_AVATAR to length(Avat) do
                Avatar:=Avatar+Avat[i];
        For i:=1 to (length(Avatar)-LONGUEUR_EXTENSION) do
                Numero:=Numero+Avatar[i];
        int:=strtoint(Numero);
        int_avatar:=int;
        ImageList2.GetBitmap(int,I_Avatar1.Picture.Bitmap);
        I_Avatar1.Repaint;
        End;
end;

//*****************************************************************************//
//*****************************************************************************//

procedure TF_Load.B_Choix_CarteClick(Sender: TObject);
begin
//Reinitialisation du dossier initial
SetCurrentDir(Dossier_initial);
If Opendialog2.Execute then
        begin
        E_Carte.text:=Opendialog2.FileName;
        end;
end;

//*****************************************************************************//
//*****************************************************************************//

procedure TF_Load.B_ContinuerClick(Sender: TObject);
begin
//Reinitialisation du dossier initial
SetCurrentDir(Dossier_initial);
//Vérification des champs
If (E_Carte.Text<>'') and (E_Avatar1.Text<>'')
        Then
                begin
                //On assigne les noms dans les zones textuelles
                        F_Jeu.L_Nom_J1.Caption:=F_Load.E_Avatar1.Text;
                        F_Jeu.L_Nom_J2.Caption:=F_Load.E_Avatar2.Text;
                        F_Jeu.L_Nom_J3.Caption:=F_Load.E_Avatar3.Text;
                        F_Jeu.L_Nom_J4.Caption:=F_Load.E_Avatar4.Text;
                //Procédure de chargement total du jeu
                Deux_joueurs:=false;
                LANCEMENT_JEU;
                End
        Else
        Showmessage('Veuillez choisir un joueur et une cartes!');
end;

//*****************************************************************************//
//*****************************************************************************//

procedure TF_Load.B_Choix_Joueur2Click(Sender: TObject);
Var
Fic:textfile;
num,i,int:integer;
Nom,Avat,Numero,Avatar:string;
begin
//Reinitialisation du dossier initial
SetCurrentDir(Dossier_initial);
If Opendialog1.execute
        then
        begin
        //Gestion Fichier
        Assignfile(Fic,Opendialog1.FileName);
        reset(Fic);
        readln(Fic,Num);
        readln(Fic,Num);
        readln(Fic,Nom);
        readln(Fic,Avat);
        readln(Fic,Avat);
        CloseFile(Fic);
        //Affichages
        E_Avatar2.Text:=Nom;
        //Suppression Texte
        Avatar:='';
        For i:=LONGUEUR_AVATAR to length(Avat) do
                Avatar:=Avatar+Avat[i];
        For i:=1 to (length(Avatar)-LONGUEUR_EXTENSION) do
                Numero:=Numero+Avatar[i];
        int:=strtoint(Numero);
        int_avatar2:=int;
        ImageList2.GetBitmap(int,I_Avatar2.Picture.Bitmap);
        I_Avatar2.Repaint;
        End;
end;

//*****************************************************************************//
//*****************************************************************************//

procedure TF_Load.B_Choix_Joueur3Click(Sender: TObject);
Var
Fic:textfile;
num,i,int:integer;
Nom,Avat,Numero,Avatar:string;
begin
//Reinitialisation du dossier initial
SetCurrentDir(Dossier_initial);
If Opendialog1.execute
        then
        begin
        //Gestion Fichier
        Assignfile(Fic,Opendialog1.FileName);
        reset(Fic);
        readln(Fic,Num);
        readln(Fic,Num);
        readln(Fic,Nom);
        readln(Fic,Avat);
        readln(Fic,Avat);
        CloseFile(Fic);
        //Affichages
        E_Avatar3.Text:=Nom;
        //Suppression Texte
        Avatar:='';
        For i:=LONGUEUR_AVATAR to length(Avat) do
                Avatar:=Avatar+Avat[i];
        For i:=1 to (length(Avatar)-LONGUEUR_EXTENSION) do
                Numero:=Numero+Avatar[i];
        int:=strtoint(Numero);
        int_avatar3:=int;
        ImageList2.GetBitmap(int,I_Avatar3.Picture.Bitmap);
        I_Avatar3.Repaint;
        End;
End;

//*****************************************************************************//
//*****************************************************************************//

procedure TF_Load.B_Choix_Joueur4Click(Sender: TObject);
Var
Fic:textfile;
num,i,int:integer;
Nom,Avat,Numero,Avatar:string;
begin
//Reinitialisation du dossier initial
SetCurrentDir(Dossier_initial);
If Opendialog1.execute
        then
        begin
        //Gestion Fichier
        Assignfile(Fic,Opendialog1.FileName);
        reset(Fic);
        readln(Fic,Num);
        readln(Fic,Num);
        readln(Fic,Nom);
        readln(Fic,Avat);
        readln(Fic,Avat);
        CloseFile(Fic);
        //Affichages
        E_Avatar4.Text:=Nom;
        //Suppression Texte
        Avatar:='';
        For i:=LONGUEUR_AVATAR to length(Avat) do
                Avatar:=Avatar+Avat[i];
        For i:=1 to (length(Avatar)-LONGUEUR_EXTENSION) do
                Numero:=Numero+Avatar[i];
        int:=strtoint(Numero);
        int_avatar4:=int;
        ImageList2.GetBitmap(int,I_Avatar4.Picture.Bitmap);
        I_Avatar4.Repaint;
        End;
End;

//*****************************************************************************//
//*****************************************************************************//

end.
