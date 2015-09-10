{JEU ZELDARENA - SAND
JOACHIM BOUSSOUMAH      GPBb
TIMOTHEE BOURGUIGNON    GPAa
EPF2}
unit U_Accueil;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, jpeg, U_Types;

type
  TF_Accueil = class(TForm)
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    Image10: TImage;
    I_Jeu: TImage;
    I_Joueur: TImage;
    I_Cartes: TImage;
    I_Options: TImage;
    I_Credits: TImage;
    I_quitter: TImage;
    Image2: TImage;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    procedure B_CreditsClick(Sender: TObject);
    procedure B_OptClick(Sender: TObject);
    procedure B_Crea_PersoClick(Sender: TObject);
    procedure B_Crea_CarteClick(Sender: TObject);
    procedure I_JeuMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure I_JeuMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure I_JoueurMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure I_JoueurMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure I_CartesMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure I_CartesMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure I_OptionsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure I_OptionsMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure I_CreditsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure I_CreditsMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure I_quitterMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure I_quitterMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure I_quitterClick(Sender: TObject);
    procedure I_JeuClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_Accueil: TF_Accueil;

implementation

uses U_Credits, U_Options, U_creation_player, U_Creation_Cartes,
  U_Banque_Images, U_Description_carte, U_Splash, U_Load, U_NB_joueurs;

{$R *.dfm}

procedure TF_Accueil.B_CreditsClick(Sender: TObject);
begin
//Affichage de la fiche des crédits
F_Credits.Show;
end;

procedure TF_Accueil.B_OptClick(Sender: TObject);
begin
F_Options.show;
F_Accueil.Hide;
end;

procedure TF_Accueil.B_Crea_PersoClick(Sender: TObject);
begin
F_Crea_Perso.show;
F_Accueil.Hide;
end;

procedure TF_Accueil.B_Crea_CarteClick(Sender: TObject);
begin
F_Crea_Carte.show;
F_Banque_Images.Show;
F_Description_Carte.Show;
F_Accueil.Hide;
end;

procedure TF_Accueil.I_JeuMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
I_Jeu.Hide;
end;

procedure TF_Accueil.I_JeuMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
I_Jeu.Show;
end;

procedure TF_Accueil.I_JoueurMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
I_Joueur.Hide;
end;

procedure TF_Accueil.I_JoueurMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
I_Joueur.Show;
end;

procedure TF_Accueil.I_CartesMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
I_Cartes.Hide;
end;

procedure TF_Accueil.I_CartesMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
I_Cartes.Show;
end;

procedure TF_Accueil.I_OptionsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
I_Options.Hide;
end;

procedure TF_Accueil.I_OptionsMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
I_Options.Show;
end;

procedure TF_Accueil.I_CreditsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
I_Credits.Hide;
end;

procedure TF_Accueil.I_CreditsMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
I_Credits.Show;
end;

procedure TF_Accueil.I_quitterMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
I_quitter.Hide;
end;

procedure TF_Accueil.I_quitterMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
I_quitter.Show;
end;

procedure TF_Accueil.I_quitterClick(Sender: TObject);
begin
if MessageDlg('Vous êtes sur le point de quitter le jeu'+#13+'Continuer?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then Close;
end;

procedure TF_Accueil.I_JeuClick(Sender: TObject);
begin
//Reinitialisation du dossier initial
SetCurrentDir(Dossier_initial);
F_accueil.Hide;
F_Nb_J.Show;
end;

procedure TF_Accueil.FormCreate(Sender: TObject);
begin
Dossier_initial:=GetCurrentDir;
end;

end.
