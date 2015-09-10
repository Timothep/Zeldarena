unit U_Splash;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, ImgList, Gauges, jpeg;

type
  TF_Splash = class(TForm)
    Image1: TImage;
    Jauge: TGauge;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
  private
    { Private declarations }
  public
    { Public declarations }
    Procedure PUT_JAUGE(num_prog:integer);
  end;

var
  F_Splash: TF_Splash;
  //num:integer;
implementation

{$R *.dfm}

Procedure TF_Splash.PUT_JAUGE(num_prog:integer);
Begin
F_Splash.Jauge.Progress:=F_Splash.Jauge.Progress+num_prog;
End;


end.
