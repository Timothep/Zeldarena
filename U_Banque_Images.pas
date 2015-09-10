{JEU ZELDARENA - SAND
JOACHIM BOUSSOUMAH      GPBb
TIMOTHEE BOURGUIGNON    GPAa
EPF2}
unit U_Banque_Images;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, U_Types;

type
  TF_Banque_Images = class(TForm)
    ScrollBox5: TScrollBox;
    Image41: TImage;
    Image42: TImage;
    Image43: TImage;
    Image44: TImage;
    Image47: TImage;
    Image48: TImage;
    Image61: TImage;
    Image45: TImage;
    Image49: TImage;
    Image50: TImage;
    Image46: TImage;
    Image51: TImage;
    Image52: TImage;
    Image53: TImage;
    Image54: TImage;
    Image57: TImage;
    Image58: TImage;
    Image55: TImage;
    Image56: TImage;
    Image59: TImage;
    Image60: TImage;
    Image65: TImage;
    Image62: TImage;
    Image64: TImage;
    Image63: TImage;
    ScrollBox2: TScrollBox;
    Image21: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    Image10: TImage;
    Image11: TImage;
    Image12: TImage;
    Image18: TImage;
    Image19: TImage;
    Image20: TImage;
    Image22: TImage;
    Image23: TImage;
    Image24: TImage;
    Image17: TImage;
    Image34: TImage;
    Image35: TImage;
    Image36: TImage;
    Image29: TImage;
    Image30: TImage;
    Image31: TImage;
    Image32: TImage;
    Image33: TImage;
    Image13: TImage;
    Image15: TImage;
    Image14: TImage;
    Image16: TImage;
    Image37: TImage;
    Image39: TImage;
    Image40: TImage;
    Image38: TImage;
    Image25: TImage;
    Image27: TImage;
    Image28: TImage;
    Image26: TImage;
    GB_Elem_Courant: TGroupBox;
    Im_Sur: TImage;
    L_Desc: TLabel;
    L_Descr: TLabel;
    Label8: TLabel;
    Label12: TLabel;
    L_Marchable: TLabel;
    Label5: TLabel;
    Label9: TLabel;
    Label13: TLabel;
    Label11: TLabel;
    ScrollBox4: TScrollBox;
    ScrollBox1: TScrollBox;
    Image66: TImage;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image67: TImage;
    Image68: TImage;
    Image69: TImage;
    Image70: TImage;
    Image71: TImage;
    Image72: TImage;
    Image73: TImage;
    Image74: TImage;
    Image75: TImage;
    Image76: TImage;
    Image77: TImage;
    Image78: TImage;
    Label1: TLabel;
    ScrollBox3: TScrollBox;
    Image81: TImage;
    Image82: TImage;
    Image83: TImage;
    Image84: TImage;
    Image86: TImage;
    Image85: TImage;
    Image80: TImage;
    Image79: TImage;
    Image87: TImage;
    Image88: TImage;
    GroupBox1: TGroupBox;
    Image89: TImage;
    Button2: TButton;
    Button3: TButton;
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Image7Click(Sender: TObject);
    procedure Image8Click(Sender: TObject);
    procedure Image9Click(Sender: TObject);
    procedure Image10Click(Sender: TObject);
    procedure Image11Click(Sender: TObject);
    procedure Image12Click(Sender: TObject);
    procedure Image13Click(Sender: TObject);
    procedure Image14Click(Sender: TObject);
    procedure Image15Click(Sender: TObject);
    procedure Image16Click(Sender: TObject);
    procedure Image18Click(Sender: TObject);
    procedure Image19Click(Sender: TObject);
    procedure Image20Click(Sender: TObject);
    procedure Image25Click(Sender: TObject);
    procedure Image26Click(Sender: TObject);
    procedure Image21Click(Sender: TObject);
    procedure Image22Click(Sender: TObject);
    procedure Image27Click(Sender: TObject);
    procedure Image28Click(Sender: TObject);
    procedure Image23Click(Sender: TObject);
    procedure Image24Click(Sender: TObject);
    procedure Image17Click(Sender: TObject);
    procedure Image41Click(Sender: TObject);
    procedure Image42Click(Sender: TObject);
    procedure Image43Click(Sender: TObject);
    procedure Image57Click(Sender: TObject);
    procedure Image58Click(Sender: TObject);
    procedure Image47Click(Sender: TObject);
    procedure Image48Click(Sender: TObject);
    procedure Image61Click(Sender: TObject);
    procedure Image59Click(Sender: TObject);
    procedure Image60Click(Sender: TObject);
    procedure Image49Click(Sender: TObject);
    procedure Image50Click(Sender: TObject);
    procedure Image65Click(Sender: TObject);
    procedure Image53Click(Sender: TObject);
    procedure Image54Click(Sender: TObject);
    procedure Image51Click(Sender: TObject);
    procedure Image52Click(Sender: TObject);
    procedure Image62Click(Sender: TObject);
    procedure Image55Click(Sender: TObject);
    procedure Image56Click(Sender: TObject);
    procedure Image44Click(Sender: TObject);
    procedure Image45Click(Sender: TObject);
    procedure Image46Click(Sender: TObject);
    procedure Image63Click(Sender: TObject);
    procedure Image64Click(Sender: TObject);
    procedure Image66Click(Sender: TObject);
    procedure Image34Click(Sender: TObject);
    procedure Image35Click(Sender: TObject);
    procedure Image36Click(Sender: TObject);
    procedure Image30Click(Sender: TObject);
    procedure Image29Click(Sender: TObject);
    procedure Image31Click(Sender: TObject);
    procedure Image32Click(Sender: TObject);
    procedure Image33Click(Sender: TObject);
    procedure Image39Click(Sender: TObject);
    procedure Image40Click(Sender: TObject);
    procedure Image38Click(Sender: TObject);
    procedure Image37Click(Sender: TObject);

    procedure Image67Click(Sender: TObject);
    procedure Image68Click(Sender: TObject);
    procedure Image69Click(Sender: TObject);
    procedure Image70Click(Sender: TObject);
    procedure Image71Click(Sender: TObject);
    procedure Image72Click(Sender: TObject);
    procedure Image73Click(Sender: TObject);
    procedure Image74Click(Sender: TObject);
    procedure Image75Click(Sender: TObject);
    procedure Image76Click(Sender: TObject);
    procedure Image77Click(Sender: TObject);
    procedure Image78Click(Sender: TObject);
    procedure Image79Click(Sender: TObject);
    procedure Image80Click(Sender: TObject);
    procedure Image81Click(Sender: TObject);
    procedure Image82Click(Sender: TObject);
    procedure Image83Click(Sender: TObject);
    procedure Image84Click(Sender: TObject);
    procedure Image85Click(Sender: TObject);
    procedure Image86Click(Sender: TObject);
    procedure Image87Click(Sender: TObject);
    procedure Image88Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Image89Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  F_Banque_Images: TF_Banque_Images;
  //Num:integer;
  Marchable:Boolean;
implementation

uses U_Description_carte;

{$R *.dfm}

//*****************************************************************************//
//*****************************************************************************//
//*****************************************************************************//
//*****************************************************************************//
//*****************************************************************************//
//*****************************************************************************//
//*****************************************************************************//
//*****************************************************************************//
//*****************************************************************************//

procedure TF_Banque_Images.Image1Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image1.picture;
Num:=1;
F_Banque_Images.L_Descr.Caption:='Terre';
Marchable:=True;
F_Banque_Images.L_Marchable.Caption:='Oui';
end;

procedure TF_Banque_Images.Image2Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image2.picture;
Num:=2;
F_Banque_Images.L_Descr.Caption:='Herbe';
Marchable:=True;
F_Banque_Images.L_Marchable.Caption:='Oui';
end;

procedure TF_Banque_Images.Image3Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image3.picture;
Num:=3;
F_Banque_Images.L_Descr.Caption:='Herbe touffue';
Marchable:=True;
F_Banque_Images.L_Marchable.Caption:='Oui';
end;

procedure TF_Banque_Images.Image4Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image4.picture;
Num:=4;
F_Banque_Images.L_Descr.Caption:='Herbe fleurie';
Marchable:=True;
F_Banque_Images.L_Marchable.Caption:='Oui';
end;

procedure TF_Banque_Images.Image5Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image5.picture;
Num:=5;
F_Banque_Images.L_Descr.Caption:='Bordure Herbe Eau';
Marchable:=False;
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image6Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image6.picture;
Num:=6;
F_Banque_Images.L_Descr.Caption:='Bordure Herbe Eau';
Marchable:=False;
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image7Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image7.picture;
Num:=7;
F_Banque_Images.L_Descr.Caption:='Bordure Herbe Eau';
Marchable:=False;
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image8Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image8.picture;
Num:=8;
F_Banque_Images.L_Descr.Caption:='Bordure Herbe Eau';
Marchable:=False;
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image9Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image9.picture;
Num:=9;
F_Banque_Images.L_Descr.Caption:='Bordure Herbe Eau';
Marchable:=False;
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image10Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image10.picture;
Num:=10;
F_Banque_Images.L_Descr.Caption:='Bordure Herbe Eau';
Marchable:=False;
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image11Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image11.picture;
Num:=11;
F_Banque_Images.L_Descr.Caption:='Bordure Herbe Eau';
Marchable:=False;
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image12Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image12.picture;
Num:=12;
F_Banque_Images.L_Descr.Caption:='Bordure Herbe Eau';
Marchable:=False;
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image13Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image13.picture;
Num:=13;
F_Banque_Images.L_Descr.Caption:='Bordure Herbe Eau';
Marchable:=False;
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image14Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image14.picture;
Num:=14;
F_Banque_Images.L_Descr.Caption:='Bordure Herbe Eau';
Marchable:=False;
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image15Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image15.picture;
Num:=15;
F_Banque_Images.L_Descr.Caption:='Bordure Herbe Eau';
Marchable:=False;
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image16Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image16.picture;
Num:=16;
F_Banque_Images.L_Descr.Caption:='Bordure Herbe Eau';
Marchable:=False;
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image18Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image18.picture;
Num:=18;
F_Banque_Images.L_Descr.Caption:='Bordure Terre Herbe';
Marchable:=true;
F_Banque_Images.L_Marchable.Caption:='Oui';
end;

procedure TF_Banque_Images.Image19Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image19.picture;
Num:=19;
F_Banque_Images.L_Descr.Caption:='Bordure Terre Herbe';
Marchable:=true;
F_Banque_Images.L_Marchable.Caption:='Oui';
end;

procedure TF_Banque_Images.Image20Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image20.picture;
Num:=20;
F_Banque_Images.L_Descr.Caption:='Bordure Terre Herbe';
Marchable:=true;
F_Banque_Images.L_Marchable.Caption:='Oui';
end;

procedure TF_Banque_Images.Image25Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image25.picture;
Num:=25;
F_Banque_Images.L_Descr.Caption:='Bordure Terre Herbe';
Marchable:=true;
F_Banque_Images.L_Marchable.Caption:='Oui';
end;

procedure TF_Banque_Images.Image26Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image26.picture;
Num:=26;
F_Banque_Images.L_Descr.Caption:='Bordure Terre Herbe';
Marchable:=true;
F_Banque_Images.L_Marchable.Caption:='Oui';
end;

procedure TF_Banque_Images.Image21Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image21.picture;
Num:=21;
F_Banque_Images.L_Descr.Caption:='Bordure Terre Herbe';
Marchable:=true;
F_Banque_Images.L_Marchable.Caption:='Oui';
end;

procedure TF_Banque_Images.Image22Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image22.picture;
Num:=22;
F_Banque_Images.L_Descr.Caption:='Bordure Terre Herbe';
Marchable:=true;
F_Banque_Images.L_Marchable.Caption:='Oui';
end;

procedure TF_Banque_Images.Image27Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image27.picture;
Num:=27;
F_Banque_Images.L_Descr.Caption:='Bordure Terre Herbe';
Marchable:=true;
F_Banque_Images.L_Marchable.Caption:='Oui';
end;

procedure TF_Banque_Images.Image28Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image28.picture;
Num:=28;
F_Banque_Images.L_Descr.Caption:='Bordure Terre Herbe';
Marchable:=true;
F_Banque_Images.L_Marchable.Caption:='Oui';
end;

procedure TF_Banque_Images.Image23Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image23.picture;
Num:=23;
F_Banque_Images.L_Descr.Caption:='Bordure Terre Herbe';
Marchable:=true;
F_Banque_Images.L_Marchable.Caption:='Oui';
end;

procedure TF_Banque_Images.Image24Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image24.picture;
Num:=24;
F_Banque_Images.L_Descr.Caption:='Bordure Terre Herbe';
Marchable:=true;
F_Banque_Images.L_Marchable.Caption:='Oui';
end;

procedure TF_Banque_Images.Image17Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image17.picture;
Num:=17;
F_Banque_Images.L_Descr.Caption:='Bordure Terre Herbe';
Marchable:=true;
F_Banque_Images.L_Marchable.Caption:='Oui';
end;

procedure TF_Banque_Images.Image41Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image41.picture;
Num:=41;
F_Banque_Images.L_Descr.Caption:='Haie';
Marchable:=False;
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image42Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image42.picture;
Num:=42;
F_Banque_Images.L_Descr.Caption:='Haie';
Marchable:=False;
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image43Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image43.picture;
Num:=43;
F_Banque_Images.L_Descr.Caption:='Haie';
Marchable:=False;
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image57Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image57.picture;
Num:=57;
F_Banque_Images.L_Descr.Caption:='Souche';
Marchable:=False;
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image58Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image58.picture;
Num:=58;
F_Banque_Images.L_Descr.Caption:='Souche';
Marchable:=False;     
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image47Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image47.picture;
Num:=47;
F_Banque_Images.L_Descr.Caption:='Haie';
Marchable:=False;        
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image48Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image48.picture;
Num:=48;
F_Banque_Images.L_Descr.Caption:='Haie';
Marchable:=False;       
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image61Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image61.picture;
Num:=61;
F_Banque_Images.L_Descr.Caption:='Pierre flottante';
Marchable:=False;       
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image59Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image59.picture;
Num:=59;
F_Banque_Images.L_Descr.Caption:='Souche';
Marchable:=False;      
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image60Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image60.picture;
Num:=60;
F_Banque_Images.L_Descr.Caption:='Souche';
Marchable:=False;      
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image49Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image49.picture;
Num:=49;
F_Banque_Images.L_Descr.Caption:='Haie';
Marchable:=False;      
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image50Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image50.picture;
Num:=50;
F_Banque_Images.L_Descr.Caption:='Haie';
Marchable:=False;       
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image65Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image65.picture;
Num:=65;
F_Banque_Images.L_Descr.Caption:='Tronc';
Marchable:=False;     
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image53Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image53.picture;
Num:=53;
F_Banque_Images.L_Descr.Caption:='Arbre';
Marchable:=False;    
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image54Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image54.picture;
Num:=54;
F_Banque_Images.L_Descr.Caption:='Arbre';
Marchable:=False;    
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image51Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image51.picture;
Num:=51;
F_Banque_Images.L_Descr.Caption:='Haie';
Marchable:=False;      
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image52Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image52.picture;
Num:=52;
F_Banque_Images.L_Descr.Caption:='Haie';
Marchable:=False;     
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image62Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image62.picture;
Num:=62;
F_Banque_Images.L_Descr.Caption:='Buisson';
Marchable:=False;      
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image55Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image55.picture;
Num:=55;
F_Banque_Images.L_Descr.Caption:='Arbre';
Marchable:=False;       
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image56Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image56.picture;
Num:=56;
F_Banque_Images.L_Descr.Caption:='Arbre';
Marchable:=False;      
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image44Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image44.picture;
Num:=44;
F_Banque_Images.L_Descr.Caption:='Haie';
Marchable:=False;      
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image45Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image45.picture;
Num:=45;
F_Banque_Images.L_Descr.Caption:='Haie';
Marchable:=False;      
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image46Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image46.picture;
Num:=46;
F_Banque_Images.L_Descr.Caption:='Haie';
Marchable:=False;      
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image63Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image63.picture;
Num:=63;
F_Banque_Images.L_Descr.Caption:='Feuilles';
Marchable:=True;
F_Banque_Images.L_Marchable.Caption:='Oui';
end;

procedure TF_Banque_Images.Image64Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image64.picture;
Num:=64;
F_Banque_Images.L_Descr.Caption:='Petite Souche';
Marchable:=True;
F_Banque_Images.L_Marchable.Caption:='Oui';
end;

procedure TF_Banque_Images.Image66Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image66.picture;
Num:=66;
F_Banque_Images.L_Descr.Caption:='Eau';
Marchable:=False;
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image34Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image34.picture;
Num:=34;
F_Banque_Images.L_Descr.Caption:='Bordure Terre Herbe';
Marchable:=true;
F_Banque_Images.L_Marchable.Caption:='Oui';
end;

procedure TF_Banque_Images.Image35Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image35.picture;
Num:=35;
F_Banque_Images.L_Descr.Caption:='Bordure Terre Herbe';
Marchable:=true;
F_Banque_Images.L_Marchable.Caption:='Oui';
end;

procedure TF_Banque_Images.Image36Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image36.picture;
Num:=36;
F_Banque_Images.L_Descr.Caption:='Bordure Terre Herbe';
Marchable:=true;
F_Banque_Images.L_Marchable.Caption:='Oui';
end;

procedure TF_Banque_Images.Image30Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image30.picture;
Num:=30;
F_Banque_Images.L_Descr.Caption:='Bordure Terre Herbe';
Marchable:=true;
F_Banque_Images.L_Marchable.Caption:='Oui';
end;

procedure TF_Banque_Images.Image29Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image29.picture;
Num:=29;
F_Banque_Images.L_Descr.Caption:='Bordure Terre Herbe';
Marchable:=true;
F_Banque_Images.L_Marchable.Caption:='Oui';
end;

procedure TF_Banque_Images.Image31Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image31.picture;
Num:=31;
F_Banque_Images.L_Descr.Caption:='Bordure Terre Herbe';
Marchable:=true;
F_Banque_Images.L_Marchable.Caption:='Oui';
end;

procedure TF_Banque_Images.Image32Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image32.picture;
Num:=32;
F_Banque_Images.L_Descr.Caption:='Bordure Terre Herbe';
Marchable:=true;
F_Banque_Images.L_Marchable.Caption:='Oui';
end;

procedure TF_Banque_Images.Image33Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image33.picture;
Num:=33;
F_Banque_Images.L_Descr.Caption:='Bordure Terre Herbe';
Marchable:=true;
F_Banque_Images.L_Marchable.Caption:='Oui';
end;

procedure TF_Banque_Images.Image39Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image39.picture;
Num:=39;
F_Banque_Images.L_Descr.Caption:='Bordure Terre Herbe';
Marchable:=true;
F_Banque_Images.L_Marchable.Caption:='Oui';
end;

procedure TF_Banque_Images.Image40Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image40.picture;
Num:=40;
F_Banque_Images.L_Descr.Caption:='Bordure Terre Herbe';
Marchable:=true;
F_Banque_Images.L_Marchable.Caption:='Oui';
end;

procedure TF_Banque_Images.Image38Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image38.picture;
Num:=38;
F_Banque_Images.L_Descr.Caption:='Bordure Terre Herbe';
Marchable:=true;
F_Banque_Images.L_Marchable.Caption:='Oui';
end;

procedure TF_Banque_Images.Image37Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image37.picture;
Num:=37;
F_Banque_Images.L_Descr.Caption:='Bordure Terre Herbe';
Marchable:=true;
F_Banque_Images.L_Marchable.Caption:='Oui';
end;

//*****************************************************************************//

procedure TF_Banque_Images.Image67Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image67.picture;
Num:=67;
F_Banque_Images.L_Descr.Caption:='Epée Niv 1';
Marchable:=False;
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image68Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image68.picture;
Num:=68;
F_Banque_Images.L_Descr.Caption:='Epée Niv 1';
Marchable:=False;
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image69Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image69.picture;
Num:=69;
F_Banque_Images.L_Descr.Caption:='Epée Niv 2';
Marchable:=False;
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image70Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image70.picture;
Num:=70;
F_Banque_Images.L_Descr.Caption:='Epée Niv 2';
Marchable:=False;
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image71Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image71.picture;
Num:=71;
F_Banque_Images.L_Descr.Caption:='Epée Niv 3';
Marchable:=False;
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image72Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image72.picture;
Num:=72;
F_Banque_Images.L_Descr.Caption:='Epée Niv 3';
Marchable:=False;
F_Banque_Images.L_Marchable.Caption:='Non';
end;

//*****************************************************************************//

procedure TF_Banque_Images.Image73Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image73.picture;
Num:=73;
F_Banque_Images.L_Descr.Caption:='Armure Niv 1';
Marchable:=False;
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image74Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image74.picture;
Num:=74;
F_Banque_Images.L_Descr.Caption:='Armure Niv 1';
Marchable:=False;
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image75Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image75.picture;
Num:=75;
F_Banque_Images.L_Descr.Caption:='Armure Niv 2';
Marchable:=False;
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image76Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image76.picture;
Num:=76;
F_Banque_Images.L_Descr.Caption:='Armure Niv 2';
Marchable:=False;
F_Banque_Images.L_Marchable.Caption:='Non';
end;


procedure TF_Banque_Images.Image77Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image77.picture;
Num:=77;
F_Banque_Images.L_Descr.Caption:='Armure Niv 3';
Marchable:=False;
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image78Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image78.picture;
Num:=78;
F_Banque_Images.L_Descr.Caption:='Armure Niv 3';
Marchable:=False;
F_Banque_Images.L_Marchable.Caption:='Non';
end;
//*****************************************************************************//

procedure TF_Banque_Images.Image79Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image79.picture;
Num:=79;
F_Banque_Images.L_Descr.Caption:='Vie';
Marchable:=False;
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image80Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image80.picture;
Num:=80;
F_Banque_Images.L_Descr.Caption:='Vie';
Marchable:=False;
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image81Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image81.picture;
Num:=81;
F_Banque_Images.L_Descr.Caption:='Point de passage';
Marchable:=False;
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image82Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image82.picture;
Num:=82;
F_Banque_Images.L_Descr.Caption:='Point de passage';
Marchable:=False;
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image83Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image83.picture;
Num:=83;
F_Banque_Images.L_Descr.Caption:='Point de Renaissance';
Marchable:=False;
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image84Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image84.picture;
Num:=84;
F_Banque_Images.L_Descr.Caption:='Point de Renaissance';
Marchable:=False;
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image85Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image85.picture;
Num:=85;
F_Banque_Images.L_Descr.Caption:='Rubis';
Marchable:=False;
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image86Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image86.picture;
Num:=86;
F_Banque_Images.L_Descr.Caption:='Rubis';
Marchable:=False;
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image87Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image87.picture;
Num:=87;
F_Banque_Images.L_Descr.Caption:='Saphir';
Marchable:=False;
F_Banque_Images.L_Marchable.Caption:='Non';
end;

procedure TF_Banque_Images.Image88Click(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image88.picture;
Num:=88;
F_Banque_Images.L_Descr.Caption:='Saphir';
Marchable:=False;
F_Banque_Images.L_Marchable.Caption:='Non';
end;
//*****************************************************************************//
//*****************************************************************************//
//*****************************************************************************//
//*****************************************************************************//
//*****************************************************************************//
//*****************************************************************************//


procedure TF_Banque_Images.FormCreate(Sender: TObject);
begin
F_Banque_Images.Im_Sur.Picture:=Image2.picture;
Num:=2;
end;

procedure TF_Banque_Images.Button1Click(Sender: TObject);
begin
Showmessage(
'Ces éléments sont obligatoires!'+#13+
'Les panneaux sont des points de passages, ils servent à l''intelligence artificielle.'+#13+
'Les Bornes sont des points de renaissance, vous devez en placer exactement 4 sur votre carte.'
);
end;

procedure TF_Banque_Images.Image89Click(Sender: TObject);
begin
Num:=89;
end;

procedure TF_Banque_Images.Button3Click(Sender: TObject);
begin
Showmessage(
'Outil Gomme'+#13+
'La gomme est le seul moyen d''effacer un artefact'+#13+
'Cliquez sur la Gomme, puis sur l''artefact que vous souhaitez retirer.'
);
end;

end.
