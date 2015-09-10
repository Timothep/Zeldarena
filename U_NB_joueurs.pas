unit U_NB_joueurs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, U_jeu;

type
  TF_Nb_J = class(TForm)
    GroupBox1: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  F_Nb_J: TF_Nb_J;

implementation

uses U_Load, U_Accueil;

{$R *.dfm}

procedure TF_Nb_J.Button1Click(Sender: TObject);
begin
If RadioButton1.Checked
   then
        NB_J_Humains:=1;
If RadioButton2.Checked
   then
        NB_J_Humains:=2;
If RadioButton3.Checked
   then
        NB_J_Humains:=3;
If RadioButton4.Checked
   then
        NB_J_Humains:=4;

F_load.show;
F_Nb_J.Hide;
end;

procedure TF_Nb_J.Button2Click(Sender: TObject);
begin
F_Accueil.show;
F_Nb_J.Hide;
end;

end.
