{JEU ZELDARENA - SAND
JOACHIM BOUSSOUMAH      GPBb
TIMOTHEE BOURGUIGNON    GPAa
EPF2}
unit U_Param_Nouv_Carte;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, U_types;

type
  TF_Param_Carte = class(TForm)
    Label1: TLabel;
    B_Annuler: TButton;
    B_Creer: TButton;
    Label3: TLabel;
    E_Nom_Carte: TEdit;
    GroupBox1: TGroupBox;
    RB_petite: TRadioButton;
    RB_Moyenne: TRadioButton;
    RB_Grande: TRadioButton;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    procedure B_AnnulerClick(Sender: TObject);
    procedure B_CreerClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  F_Param_Carte: TF_Param_Carte;

implementation

uses U_Creation_Cartes, U_FA_creation_cartes;

{$R *.dfm}

//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-//
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-//

procedure TF_Param_Carte.B_AnnulerClick(Sender: TObject);
begin
//Masquer la fiche
F_Param_Carte.Hide;
end;

//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-//
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-//

procedure TF_Param_Carte.B_CreerClick(Sender: TObject);
Var
i:integer;  //Variable de comptage
begin
//Si les champs sont bien remplis et si une carte du même nom n'existe pas
If (Not FileExists(MAP_EXTENSION+SLASH+E_Nom_Carte.Text+MAP_EXTENSION)) and ((RB_Petite.Checked=true) or (RB_Moyenne.Checked=true) or (RB_Grande.Checked=true))
        Then    //Alors on peut créer une nouvelle carte
                Begin
                F_Param_Carte.Hide;
                //Si la carte a créer est "Petite"
                If (RB_Petite.Checked=true)
                        then
                        Begin
                        //Remplissage des champs de description de la carte
                        F_Crea_Carte.NOUVELLE_CARTE(E_Nom_Carte.Text,CHAINE_PET);
                        //Définition de la taille de la Drawgrid
                        F_Crea_Carte.DG_Carte.RowCount:=ROW_PET_DG_CARTE;
                        F_Crea_Carte.DG_Carte.ColCount:=COL_PET_DG_CARTE;
                        F_Crea_Carte.DG_Carte.Width:=WID_PET_DG_CARTE;
                        F_Crea_Carte.DG_Carte.Height:=HEI_PET_DG_CARTE;
                        //Définition des longueurs des tableaux dynamiques
                        SetLength(Matrice, COL_PET_DG_CARTE);
                        For i:=Low(Matrice) to High(Matrice) do SetLength(Matrice[i], ROW_PET_DG_CARTE);
                        SetLength(Matrice2, COL_PET_DG_CARTE);
                        For i:=Low(Matrice2) to High(Matrice2) do SetLength(Matrice2[i], ROW_PET_DG_CARTE);
                        End;
                //Si la carte a créer est "Moyenne"
                If (RB_Moyenne.Checked=true)
                        then
                        Begin
                        //Remplissage des champs de description de la carte
                        F_Crea_Carte.NOUVELLE_CARTE(E_Nom_Carte.Text,CHAINE_MOY);
                        //Définition de la taille de la Drawgrid
                        F_Crea_Carte.DG_Carte.RowCount:=ROW_MOY_DG_CARTE;
                        F_Crea_Carte.DG_Carte.ColCount:=COL_MOY_DG_CARTE;
                        F_Crea_Carte.DG_Carte.Width:=WID_MOY_DG_CARTE;
                        F_Crea_Carte.DG_Carte.Height:=HEI_MOY_DG_CARTE;
                        //Définition des longueurs du tableau dynamique
                        SetLength(Matrice, COL_MOY_DG_CARTE);
                        For i:=Low(Matrice) to High(Matrice) do SetLength(Matrice[i], ROW_MOY_DG_CARTE);
                        SetLength(Matrice2, COL_MOY_DG_CARTE);
                        For i:=Low(Matrice2) to High(Matrice2) do SetLength(Matrice2[i], ROW_MOY_DG_CARTE);
                        End;
                //Si la carte a créer est "Grande"
                If (RB_Grande.Checked=true)
                        then
                        Begin
                        //Remplissage des champs de description de la carte
                        F_Crea_Carte.NOUVELLE_CARTE(E_Nom_Carte.Text,CHAINE_GRD);
                        //Définition de la taille de la Drawgrid
                        F_Crea_Carte.DG_Carte.RowCount:=ROW_GRD_DG_CARTE;
                        F_Crea_Carte.DG_Carte.ColCount:=COL_GRD_DG_CARTE;
                        F_Crea_Carte.DG_Carte.Width:=WID_GRD_DG_CARTE;
                        F_Crea_Carte.DG_Carte.Height:=HEI_GRD_DG_CARTE;
                        //Définition des longueurs du tableau dynamique
                        SetLength(Matrice, COL_GRD_DG_CARTE);
                        For i:=Low(Matrice) to High(Matrice) do SetLength(Matrice[i], ROW_GRD_DG_CARTE);
                        SetLength(Matrice2, COL_GRD_DG_CARTE);
                        For i:=Low(Matrice2) to High(Matrice2) do SetLength(Matrice2[i], ROW_GRD_DG_CARTE);
                        //
                        End;
                //Initialisation de la DrawGrid
                F_Crea_Carte.RAFFRAICH;
                //Enabeling de la drawgrid
                F_Crea_Carte.DG_Carte.Enabled:=true;
                End
        Else    //On ne peut pas créer de nouvelle carte
                Showmessage('Impossible de créer la carte avec les informations spécifiées!');
end;

//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-//
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-//

end.
