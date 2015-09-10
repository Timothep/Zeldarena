{JEU ZELDARENA - SAND
JOACHIM BOUSSOUMAH      GPBb
TIMOTHEE BOURGUIGNON    GPAa
EPF2}
unit U_Options;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg, Menus, MMSystem, ImgList, MPlayer, U_Types;

type
  TF_Options = class(TForm)
    Image1: TImage;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Img_PlayB: TImage;
    Img_Play: TImage;
    OpenDialog1: TOpenDialog;
    MainMenu1: TMainMenu;
    Fichier1: TMenuItem;
    Sauver1: TMenuItem;
    Quitter1: TMenuItem;
    RB1: TRadioButton;
    RB2: TRadioButton;
    RB3: TRadioButton;
    E_Chemin_Son: TEdit;
    B_Son: TButton;
    Defaut1: TMenuItem;
    Avatars_Bots: TGroupBox;
    Shape1: TShape;
    I_Avatar1: TImage;
    Shape2: TShape;
    I_Avatar2: TImage;
    Shape3: TShape;
    I_Avatar3: TImage;
    L_Bot1b: TLabel;
    L_Bot2b: TLabel;
    L_Bot3b: TLabel;
    B_Volume: TButton;
    ImageList1: TImageList;
    B_Changer1: TButton;
    B_Changer2: TButton;
    B_Changer3: TButton;
    OpenDialog2: TOpenDialog;
    procedure Img_PlayMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Img_PlayMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Sauver1Click(Sender: TObject);
    procedure Quitter1Click(Sender: TObject);
    procedure Img_PlayClick(Sender: TObject);
    procedure Defaut1Click(Sender: TObject);
    procedure B_SonClick(Sender: TObject);
    procedure B_VolumeClick(Sender: TObject);
    procedure B_Changer1Click(Sender: TObject);
    procedure B_Changer2Click(Sender: TObject);
    procedure B_Changer3Click(Sender: TObject);
  private
    { Private declarations }
    Procedure SOUND;
  public
    { Public declarations }
  end;

var
  F_Options: TF_Options;
  Num_Joueur:string;
implementation

uses U_Accueil;

{$R *.dfm}
//****************************************************************************//
procedure TF_Options.Img_PlayMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
Img_Play.Hide;
end;
//****************************************************************************//
procedure TF_Options.Img_PlayMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Img_Play.Show;
end;
//****************************************************************************//

//****************************************************************************//
procedure TF_Options.Sauver1Click(Sender: TObject);
Var
Fic:Textfile;
begin
        SetCurrentDir(Dossier_initial);
        //Sauvegarde
        Assignfile(Fic,FICHIER_CONFIG);
        Rewrite(Fic);
        Writeln(fic,L_Bot1b.Caption);
        Writeln(fic,L_Bot2b.Caption);
        Writeln(fic,L_Bot3b.Caption);
        If RB1.Checked=true then Writeln(fic,NIV_DEB);
        If RB2.Checked=true then Writeln(fic,NIV_NOR);
        If RB3.Checked=true then Writeln(fic,NIV_EXP);
        Closefile(Fic);
        Showmessage('Sauvegarde effectuée');
end;
//****************************************************************************//
procedure TF_Options.Quitter1Click(Sender: TObject);
begin
//Quitter
if MessageDlg('Vous êtes sur le point de quitter la fenêtre des options?'+#13+'Continuer?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        begin
        F_Options.Hide;
        F_Accueil.Show;
        end;
end;
//****************************************************************************//
Procedure TF_Options.SOUND;
Begin
playsound(Pchar(OpenDialog1.Filename),handle,snd_sync or snd_async);
End;
//****************************************************************************//
procedure TF_Options.Img_PlayClick(Sender: TObject);
begin
F_Options.SOUND;
end;
//****************************************************************************//
procedure TF_Options.Defaut1Click(Sender: TObject);
begin
RB1.checked:=False;
RB2.checked:=True;
RB3.checked:=False;
ImageList1.GetBitmap(NUM_IMG_BOT1,I_Avatar1.Picture.Bitmap);
ImageList1.GetBitmap(NUM_IMG_BOT2,I_Avatar2.Picture.Bitmap);
ImageList1.GetBitmap(NUM_IMG_BOT3,I_Avatar3.Picture.Bitmap);
I_Avatar1.Repaint;
I_Avatar2.Repaint;
I_Avatar3.Repaint;
L_Bot1b.Caption:=NOM_BOT1;
L_Bot2b.Caption:=NOM_BOT2;
L_Bot3b.Caption:=NOM_BOT3;
end;

procedure TF_Options.B_SonClick(Sender: TObject);
begin
If Opendialog1.execute
        then E_Chemin_son.Text:=Opendialog1.FileName;
end;

procedure TF_Options.B_VolumeClick(Sender: TObject);
begin
//Ouvre le module de gestion du son de Windows
WinExec(MODULE_SON_WINDOWS,SW_SHOW);
end;

//Changement du Bot 1
procedure TF_Options.B_Changer1Click(Sender: TObject);
Var
Fic:textfile;
Img,nom,avatar:string;
i,int:integer;
Nom_bot:string;
begin
If Opendialog2.execute then
        begin
        //Chargement du Bot 1
        AssignFile(Fic, Opendialog2.FileName);
        Reset(Fic);
        //On passe les premiers champs
        Readln(Fic,int);
        Readln(Fic,int);
        Readln(Fic,Nom_bot);
        Readln(Fic,img);
        //Capture du nom de l'image
        Readln(Fic,img);
        Closefile(Fic);
        //^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        For i:=LONGUEUR_AVATAR to length(img) do
                nom:=nom+img[i];
        For i:=1 to (length(nom)-LONGUEUR_EXTENSION) do
                avatar:=avatar+nom[i];
        int:=strtoint(avatar);
        F_Options.L_Bot1b.Caption:=Nom_Bot;
        ImageList1.GetBitmap(int,I_Avatar1.Picture.Bitmap);
        I_Avatar1.Repaint;
        //^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        end;
end;

//Changement du Bot 2
procedure TF_Options.B_Changer2Click(Sender: TObject);
Var
Fic:textfile;
Img,nom,avatar:string;
i,int:integer;
Nom_bot:string;
begin
If Opendialog2.execute then
        begin
        //Chargement du Bot 1
        AssignFile(Fic, Opendialog2.FileName);
        Reset(Fic);
        //On passe les premiers champs
        Readln(Fic,int);
        Readln(Fic,int);
        Readln(Fic,Nom_bot);
        Readln(Fic,img);
        //Capture du nom de l'image
        Readln(Fic,img);
        Closefile(Fic);
        //^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        For i:=LONGUEUR_AVATAR to length(img) do
                nom:=nom+img[i];
        For i:=1 to (length(nom)-LONGUEUR_EXTENSION) do
                avatar:=avatar+nom[i];
        int:=strtoint(avatar);
        F_Options.L_Bot2b.Caption:=Nom_Bot;
        ImageList1.GetBitmap(int,I_Avatar2.Picture.Bitmap);
        I_Avatar2.Repaint;
        //^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        end;
end;

//Changement du Bot 3
procedure TF_Options.B_Changer3Click(Sender: TObject);
Var
Fic:textfile;
Img,nom,avatar:string;
i,int:integer;
Nom_bot:string;
begin
If Opendialog2.execute then
        begin
        //Chargement du Bot 1
        AssignFile(Fic, Opendialog2.FileName);
        Reset(Fic);
        //On passe les premiers champs
        Readln(Fic,int);
        Readln(Fic,int);
        Readln(Fic,Nom_bot);
        Readln(Fic,img);
        //Capture du nom de l'image
        Readln(Fic,img);
        Closefile(Fic);
        //^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        For i:=LONGUEUR_AVATAR to length(img) do
                nom:=nom+img[i];
        For i:=1 to (length(nom)-LONGUEUR_EXTENSION) do
                avatar:=avatar+nom[i];
        int:=strtoint(avatar);
        F_Options.L_Bot3b.Caption:=Nom_Bot;
        ImageList1.GetBitmap(int,I_Avatar3.Picture.Bitmap);
        I_Avatar3.Repaint;
        //^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        end;
end;

end.
