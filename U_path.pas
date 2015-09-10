unit U_path;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, U_Traitement, StdCtrls;

type
  TF_Carte = class(TForm)
    SG_Chemin: TStringGrid;
    B_Depart: TButton;
    B_Obstacle: TButton;
    B_Arrivee: TButton;
    B_Quitter: TButton;
    B_Recherche: TButton;
    B_raz: TButton;
    procedure B_QuitterClick(Sender: TObject);
    procedure B_DepartClick(Sender: TObject);
    procedure B_ObstacleClick(Sender: TObject);
    procedure B_ArriveeClick(Sender: TObject);
    procedure SG_CheminSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure B_RechercheClick(Sender: TObject);
    procedure B_razClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_Carte: TF_Carte;

implementation
uses U_chemin, U_jeu;
{$R *.dfm}

procedure TF_Carte.B_QuitterClick(Sender: TObject);
begin
if MessageDlg('Quitter le programme ?',mtConfirmation, [mbYes, mbNo], 0) = mrYes
then application.Terminate;
end;
//----------------------------------------------------------------------------//
procedure TF_Carte.B_DepartClick(Sender: TObject);
begin
ajout_obstacle := false;
ajout_arrivee := false;
ajout_depart := true;
end;
//----------------------------------------------------------------------------//
procedure TF_Carte.B_ObstacleClick(Sender: TObject);
begin
ajout_obstacle := true;
ajout_arrivee := false;
ajout_depart := false;
end;
//----------------------------------------------------------------------------//
procedure TF_Carte.B_ArriveeClick(Sender: TObject);
begin
ajout_obstacle := false;
ajout_arrivee := true;
ajout_depart := false;
end;
//----------------------------------------------------------------------------//

procedure TF_Carte.SG_CheminSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
if ajout_depart = true
then SG_Chemin.Cells[ACol,ARow] := 'Depart'
else if ajout_obstacle = true
     then SG_Chemin.Cells[ACol,ARow] := 'Obstacle'
     else if ajout_arrivee = true
          then SG_Chemin.Cells[ACol,ARow] := 'Arrivee'; 
end;
//----------------------------------------------------------------------------//
procedure TF_Carte.B_RechercheClick(Sender: TObject);
var
line_dep,col_dep,line_fin,col_fin : integer;
t_line,t_col:integer;
begin
for t_line := 0 to SG_Chemin.RowCount do
begin
  for t_col := 0 to SG_Chemin.ColCount do
  begin
   if SG_Chemin.Cells[t_col,t_line] = 'Depart'
   then
    begin
    line_dep := t_line;
    col_dep := t_col;
    end
    else if SG_Chemin.Cells[t_col,t_line] = 'Arrivee'
         then
          begin
           line_fin := t_line;
           col_fin := t_col;
          end;
  end;
end;
CALCUL_CHEMIN(col_dep,line_dep,col_fin,line_fin,pdeb_chemin2);
AFFICHE_CHEMIN(pdeb_chemin2);
end;
//----------------------------------------------------------------------------//


procedure TF_Carte.B_razClick(Sender: TObject);
var
i,j : integer;
begin
for i := 0 to SG_Chemin.ColCount do
 begin
  for j := 0 to SG_Chemin.RowCount do
   begin
    SG_Chemin.Cells[i,j] := '';
   end;
 end;
end;
//----------------------------------------------------------------------------//
end.
