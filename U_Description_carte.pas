{JEU ZELDARENA - SAND
JOACHIM BOUSSOUMAH      GPBb
TIMOTHEE BOURGUIGNON    GPAa
EPF2}
unit U_Description_carte;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TF_Description_Carte = class(TForm)
    GB_Description: TGroupBox;
    Label_nom: TLabel;
    L_Nom_Carte: TLabel;
    Label1: TLabel;
    L_Taille: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    L_Date: TLabel;
    L_Heure: TLabel;
    Label6: TLabel;
    E_Description: TEdit;
    E_Createur: TEdit;
    B_Change: TButton;
    E_Nom: TEdit;
    StaticText1: TStaticText;
    procedure B_ChangeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_Description_Carte: TF_Description_Carte;

implementation

{$R *.dfm}

//Module de changement de nom pour la carte
procedure TF_Description_Carte.B_ChangeClick(Sender: TObject);
begin
F_Description_Carte.L_Nom_Carte.Caption:=F_Description_Carte.E_Nom.Text;
end;

end.
