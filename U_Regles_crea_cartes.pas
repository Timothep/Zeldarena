{JEU ZELDARENA - SAND
JOACHIM BOUSSOUMAH      GPBb
TIMOTHEE BOURGUIGNON    GPAa
EPF2}
unit U_Regles_crea_cartes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TF_Regles_crea_cartes = class(TForm)
    B_Quitter: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    procedure B_QuitterClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  F_Regles_crea_cartes: TF_Regles_crea_cartes;

implementation

{$R *.dfm}

procedure TF_Regles_crea_cartes.B_QuitterClick(Sender: TObject);
begin
F_Regles_crea_cartes.Hide;
end;

end.
