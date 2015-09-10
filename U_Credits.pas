{JEU ZELDARENA - SAND
JOACHIM BOUSSOUMAH      GPBb
TIMOTHEE BOURGUIGNON    GPAa
EPF2}
unit U_Credits;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls;

type
  TF_Credits = class(TForm)
    B_Ok: TButton;
    StaticText17: TStaticText;
    Image1: TImage;
    procedure B_OkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_Credits: TF_Credits;

implementation

uses U_Accueil;

{$R *.dfm}

procedure TF_Credits.B_OkClick(Sender: TObject);
begin
F_Credits.Hide;
F_Accueil.Show;
end;

end.
