unit U_chemin;
//Unite dans laquelle on declare la file d attente des cases du chemin suivies par un bot
//Lors du calcul du chemin a suivre, on execute les modules de cette unite
//Cette liste est construite lors du deroulement du module de pathfinding
//Dans cette unite sont declarées les listes nécessaires au deroulement de l Astar


interface

Uses U_Fa_joueur, U_types, U_crea_joueur;
//----------------------------------------------------------------------------//

var
pdeb_chemin1,pcour_chemin1,pdeb_chemin2,pcour_chemin2 : T_ptr_case_chemin;
abscisse,ordonnee : integer;
//----------------------------------------------------------------------------//
procedure CREA_VD_CHEMIN1(var pnouv_chemin : T_ptr_case_chemin);
procedure INIT_VD_CHEMIN1(var pnouv_chemin,ptr_parent,ptr_suivant : T_ptr_case_chemin; coutf,coutg,couth:integer;abscisse,ordonnee:integer);
procedure INIT_CHEMIN1(var pdeb_chemin1:T_ptr_case_chemin);
procedure AJOUT_CHEMIN1(var pcour_chemin1, pnouv_chemin:T_ptr_case_chemin);
procedure AJOUT_debut_CHEMIN1(var pdeb_chemin1, pnouv_chemin:T_ptr_case_chemin);
procedure AJOUT_fin_CHEMIN1(var pcour_chemin1, pnouv_chemin:T_ptr_case_chemin);
procedure RETRAIT_CHEMIN1(var pcour_chemin1:T_ptr_case_chemin);
procedure RETRAIT_debut_CHEMIN1(var pdeb_chemin1,pcour_chemin1:T_ptr_case_chemin);
procedure RETRAIT_fin_CHEMIN1(var pcour_chemin1:T_ptr_case_chemin);
          //****************************************//
procedure CREA_VD_CHEMIN2(var pnouv_chemin : T_ptr_case_chemin);
procedure INIT_VD_CHEMIN2(var pnouv_chemin,ptr_parent,ptr_suivant : T_ptr_case_chemin; coutf,coutg,couth:integer;abscisse,ordonnee:integer);
procedure INIT_CHEMIN2(var pdeb_chemin2:T_ptr_case_chemin);
procedure AJOUT_CHEMIN2(var pcour_chemin2, pnouv_chemin:T_ptr_case_chemin);
procedure AJOUT_debut_CHEMIN2(var pdeb_chemin2, pnouv_chemin:T_ptr_case_chemin);
procedure AJOUT_fin_CHEMIN2(var pcour_chemin2, pnouv_chemin:T_ptr_case_chemin);
procedure RETRAIT_CHEMIN2(var pcour_chemin2:T_ptr_case_chemin);
procedure RETRAIT_debut_CHEMIN2(var pdeb_chemin2,pcour_chemin2:T_ptr_case_chemin);
procedure RETRAIT_fin_CHEMIN2(var pcour_chemin2:T_ptr_case_chemin);
          //****************************************//
procedure CALCUL_CHEMIN(but_x,but_y:integer; pcour_fa_joueur:T_ptr_vd_joueur);
procedure SEARCH_LOW_FCOST(var case_courante:T_ptr_case_chemin);
procedure AJOUT_CASES_ADJACENTES(var i,j,x,y:integer);
procedure TRANSFERT_CHEMIN(var case_courante:T_ptr_case_chemin);
procedure AJOUT_LIST_FERMEE(case_courante:T_ptr_case_chemin);
procedure AJOUT_LIST_OUVERTE(i,j,x,y:integer; var pdeb_chemin1,case_courante:T_ptr_case_chemin);
procedure COMPAROUTE(var ptr_chgt_route, case_courante:T_ptr_case_chemin;y,x:integer);
function GET_FCOST(a,b:integer):integer;
function GET_GCOST(a,b:integer;case_courante:T_ptr_case_chemin):integer;
function GET_HCOST(a,b:integer):integer;
function ALREXIST(y,x:integer):boolean;
function FOUND(y,x:integer;var ptr_chgt_route:T_ptr_case_chemin):boolean;
function ARRIVEE(but_y,but_x:integer):boolean;
//----------------------------------------------------------------------------//

implementation

//----------------------------------------------------------------------------//
procedure CREA_VD_CHEMIN1(var pnouv_chemin : T_ptr_case_chemin);
begin
New(pnouv_chemin);
end;
//----------------------------------------------------------------------------//
procedure INIT_VD_CHEMIN1(var pnouv_chemin,ptr_parent,ptr_suivant : T_ptr_case_chemin; coutf,coutg,couth:integer;abscisse,ordonnee:integer);
begin
pnouv_chemin^.ptr_parent:=nil;
pnouv_chemin^.ptr_suivant:=nil;
pnouv_chemin.fcost :=coutf;
pnouv_chemin.gcost :=coutg;
pnouv_chemin.hcost :=couth;
pnouv_chemin.coord_colonne:=abscisse;
pnouv_chemin.coord_ligne:=ordonnee;
end;
//----------------------------------------------------------------------------//
procedure INIT_CHEMIN1(var pdeb_chemin1:T_ptr_case_chemin);
begin
pdeb_chemin1:=nil;
end;
//----------------------------------------------------------------------------//
procedure AJOUT_CHEMIN1(var pcour_chemin1, pnouv_chemin:T_ptr_case_chemin);
var
paux : T_ptr_case_chemin;
begin
   paux := pcour_chemin1;
   pcour_chemin1 := paux^.ptr_parent;
   pcour_chemin1^.ptr_suivant := pnouv_chemin;
   pnouv_chemin^.ptr_parent := pcour_chemin1;
   pnouv_chemin^.ptr_suivant := paux;
   paux^.ptr_parent := pnouv_chemin;
   pcour_chemin1 := paux;
end;
//----------------------------------------------------------------------------//
procedure AJOUT_debut_CHEMIN1(var pdeb_chemin1, pnouv_chemin:T_ptr_case_chemin);
begin
pnouv_chemin^.ptr_suivant := pdeb_chemin1;
pdeb_chemin1^.ptr_parent := pnouv_chemin;
pdeb_chemin1 := pnouv_chemin;
end;
//----------------------------------------------------------------------------//
procedure AJOUT_FIN_CHEMIN1(var pcour_chemin1, pnouv_chemin:T_ptr_case_chemin);
begin
pcour_chemin1 := pdeb_chemin1;
 while pcour_chemin1^.ptr_suivant <> nil do
  begin
   pcour_chemin1 := pcour_chemin1^.ptr_suivant;
  end;
pcour_chemin1^.ptr_suivant := pnouv_chemin;
end;
//----------------------------------------------------------------------------//
procedure RETRAIT_CHEMIN1(var pcour_chemin1:T_ptr_case_chemin);
var
paux,pauxi : T_ptr_case_chemin;
begin
paux := pcour_chemin1^.ptr_parent;
pauxi := pcour_chemin1^.ptr_suivant;
paux^.ptr_suivant := pcour_chemin1^.ptr_suivant;
pauxi^.ptr_parent := paux;
dispose(pcour_chemin1);
end;
//----------------------------------------------------------------------------//
procedure RETRAIT_debut_CHEMIN1(var pdeb_chemin1,pcour_chemin1:T_ptr_case_chemin);
begin
pdeb_chemin1 := pdeb_chemin1^.ptr_suivant;
pdeb_chemin1^.ptr_parent := nil;
dispose(pcour_chemin1);
end;
//----------------------------------------------------------------------------//
procedure RETRAIT_FIN_CHEMIN1(var pcour_chemin1:T_ptr_case_chemin);
var
paux : T_ptr_case_chemin;
begin
paux := pcour_chemin1^.ptr_parent;
paux^.ptr_suivant := nil;
dispose(pcour_chemin1);
end;
//----------------------------------------------------------------------------//

              //****************************************//

//----------------------------------------------------------------------------//
procedure CREA_VD_CHEMIN2(var pnouv_chemin : T_ptr_case_chemin);
begin
New(pnouv_chemin);
end;
//----------------------------------------------------------------------------//
procedure INIT_VD_CHEMIN2(var pnouv_chemin,ptr_parent,ptr_suivant : T_ptr_case_chemin; coutf,coutg,couth:integer;abscisse,ordonnee:integer);
begin
pnouv_chemin^.ptr_parent:=nil;
pnouv_chemin^.ptr_suivant:=nil;
pnouv_chemin.fcost :=coutf;
pnouv_chemin.gcost :=coutg;
pnouv_chemin.hcost :=couth;
pnouv_chemin.coord_colonne:=abscisse;
pnouv_chemin.coord_ligne:=ordonnee;
end;
//----------------------------------------------------------------------------//
procedure INIT_CHEMIN2(var pdeb_chemin2:T_ptr_case_chemin);
begin
pdeb_chemin2:=nil;
end;
//----------------------------------------------------------------------------//
procedure AJOUT_CHEMIN2(var pcour_chemin2, pnouv_chemin:T_ptr_case_chemin);
var
paux : T_ptr_case_chemin;
begin
   paux := pcour_chemin2;
   pcour_chemin2 := paux^.ptr_parent;
   pcour_chemin2^.ptr_suivant := pnouv_chemin;
   pnouv_chemin^.ptr_parent := pcour_chemin2;
   pnouv_chemin^.ptr_suivant := paux;
   paux^.ptr_parent := pnouv_chemin;
   pcour_chemin2 := paux;
end;
//----------------------------------------------------------------------------//
procedure AJOUT_debut_CHEMIN2(var pdeb_chemin2, pnouv_chemin:T_ptr_case_chemin);
begin
pnouv_chemin^.ptr_suivant := pdeb_chemin2;
pdeb_chemin2^.ptr_parent := pnouv_chemin;
pdeb_chemin2 := pnouv_chemin;
end;
//----------------------------------------------------------------------------//
procedure AJOUT_fin_CHEMIN2(var pcour_chemin2, pnouv_chemin:T_ptr_case_chemin);
begin
pcour_chemin2 := pdeb_chemin2;
 while pcour_chemin2^.ptr_suivant <> nil do
  begin
   pcour_chemin2 := pcour_chemin2^.ptr_suivant;
  end;
pcour_chemin2^.ptr_suivant := pnouv_chemin;
end;
//----------------------------------------------------------------------------//
procedure RETRAIT_CHEMIN2(var pcour_chemin2:T_ptr_case_chemin);
var
paux,pauxi : T_ptr_case_chemin;
begin
paux := pcour_chemin2^.ptr_parent;
pauxi := pcour_chemin2^.ptr_suivant;
paux^.ptr_suivant := pcour_chemin2^.ptr_suivant;
pauxi^.ptr_parent := paux;
dispose(pcour_chemin2);
end;
//----------------------------------------------------------------------------//
procedure RETRAIT_debut_CHEMIN2(var pdeb_chemin2,pcour_chemin2:T_ptr_case_chemin);
begin
pdeb_chemin2 := pdeb_chemin2^.ptr_suivant;
pdeb_chemin2^.ptr_parent := nil;
dispose(pcour_chemin2);
end;
//----------------------------------------------------------------------------//
procedure RETRAIT_fin_CHEMIN2(var pcour_chemin2:T_ptr_case_chemin);
var
paux : T_ptr_case_chemin;
begin
paux := pcour_chemin2^.ptr_parent;
paux^.ptr_suivant := nil;
dispose(pcour_chemin2);
end;
//----------------------------------------------------------------------------//
//----------------------------------------------------------------------------//
//----------------------------------------------------------------------------//
//----------------------------------------------------------------------------//
procedure CALCUL_CHEMIN(but_x,but_y:integer; pcour_fa_joueur:T_ptr_vd_joueur);
var
i,j,x,y : integer;//i et j sont les coordonnees de la case de depart, x et y celles de la case courante
trouve,existe : boolean;
P1,P2:T_ptr_case_chemin;
begin
existe := true;
trouve := false;
j := pcour_fa_joueur^.pt_visuel.GETCOLONNE;
i := pcour_fa_joueur^.pt_visuel.GETLIGNE;
INIT_CHEMIN1(pdeb_chemin1);
INIT_CHEMIN2(pdeb_chemin2);
P1:=nil;
P2:=nil;
AJOUT_LIST_OUVERTE(i,j,0,0,P1,P2);//Ajout de la case de depart a la liste ouverte
AJOUT_CASES_ADJACENTES(i,j,x,y);
TRANSFERT_CHEMIN(case_courante);
repeat
  SEARCH_LOW_FCOST(case_courante);
  i:= case_courante^.coord_ligne;
  j:= case_courante^.coord_colonne;
  TRANSFERT_CHEMIN(case_courante);
  AJOUT_CASES_ADJACENTES(i,j,x,y);
  if pdeb_chemin1 = nil
  then existe := false;
  if ARRIVEE(but_y,but_x) = true
  then trouve := true;
until trouve = true or existe = false ;
end;
//----------------------------------------------------------------------------//
procedure AJOUT_CASES_ADJACENTES(var i,j,x,y:integer);
begin
 for  y := i-1 to i+1 do
 begin
   for x := j-1 to j+1 do
   begin
    if x <> j and y <> i
     then
      begin
        if (Matrice_structure[y,x].GETMARCHABLE = true) and (Matrice_structure[y,x].Ptr_joueur=nil) and (Matrice_structure[y,x].Ptr_artefact=nil) and ALREXIST(y,x) = false
        then
         begin
          if FOUND(y,x,ptr_chgt_route) = false
          then AJOUT_LIST_OUVERTE(i,j,x,y,pdeb_chemin1,case_courante)
          else COMPAROUTE(ptr_chgt_route,case_courante,y,x);
         end;
      end;
   end;
 end;
end;
//----------------------------------------------------------------------------//
procedure SEARCH_LOW_FCOST(var case_courante:T_ptr_case_chemin);
F : integer;
paux : T_ptr_case_chemin;
begin
 paux := pdeb_chemin1;
 F := pdeb_chemin1^.fcost;
 while paux^.ptr_suivant <> nil do
  begin
   if paux^.fcost < F
   then case_courante := paux;
   paux := paux^.ptr_suivant;
  end;
end;
//----------------------------------------------------------------------------//
procedure TRANSFERT_CHEMIN(var case_courante:T_ptr_case_chemin);
var
paux : T_ptr_case_chemin;
trouve :boolean;
begin
 trouve := false;
 paux := pdeb_chemin1;
 if pdeb_chemin1 = case_courante
 then
  begin
   pdeb_chemin1 := case_courante^.ptr_suivant;
   case_courante^.ptr_suivant:=nil;
   AJOUT_LIST_FERMEE(case_courante);
  end
 else
  begin
   while paux^.ptr_suivant <> nil and trouve = false do
    begin
     if paux^.ptr_suivant = case_courante
      then trouve := true
      else paux := paux^.ptr_suivant;
    end;
    paux^.ptr_suivant := case_courante^.ptr_suivant;
    case_courante^.ptr_suivant := nil;
    AJOUT_LISTE_FERMEE(case_courante);
  end;
end;
//----------------------------------------------------------------------------//
procedure AJOUT_LIST_FERMEE(case_courante:T_ptr_case_chemin);
begin
  if pdeb_chemin2 = nil
  then pdeb_chemin2 := case_courante
  else AJOUT_fin_CHEMIN2(pcour_chemin2,case_courante);
end;
//----------------------------------------------------------------------------//
procedure AJOUT_LIST_OUVERTE(i,j,x,y:integer; var pdeb_chemin1,case_courante:T_ptr_case_chemin);
var
GETF,GETG,GETH:integer;
begin
if pdeb_chemin1 = nil  and pdeb_chemin2 = nil
 then//on ajoute le point de depart
  begin //i et j sont les coordonnees ligne et colonne de la case de depart
    GETH := GET_HCOST(i,j);
    GETF := GETH;
    CREA_VD_CHEMIN1(pnouv_chemin);
    INIT_VD_CHEMIN1(pnouv_chemin,nil,nil,GETF,0,GETH,j,i);
    pdeb_chemin1 := pnouv_chemin;
    case_courante := pdeb_chemin1;
  end
 else//on ajoute les cases adjacentes
  begin //y et x sont les coordonnees ligne et colonne de la case en cours d examen
    GETH := GET_HCOST(y,x);
    GETG := GET_GCOST(y,x);
    GETF := GETG + GETH;
    CREA_VD_CHEMIN1(pnouv_chemin);
    INIT_VD_CHEMIN1(pnouv_chemin,case_courante,nil,GETF,GETG,GETH,x,y);
    AJOUT_fin_CHEMIN1(pcour_chemin1, pnouv_chemin);
  end;
end;
//----------------------------------------------------------------------------//
function GET_FCOST(a,b:integer):integer;
begin
result := GET_GCOST(a,b,case_courante) + GET_HCOST(a,b);
end;
//----------------------------------------------------------------------------//
function GET_GCOST(a,b:integer;case_courante:T_ptr_case_chemin):integer;
begin
if a <> case_courante.coord_ligne and b <> case_courante.coord_colonne
then result := case_courante.gcost + 14
else result := case_courante.gcost + 10;
end;
//----------------------------------------------------------------------------//
function GET_HCOST(a,b:integer):integer;
begin
 result := abs(b-but_x) + abs(a-but_y);
end;
//----------------------------------------------------------------------------//
function ALREXIST(y,x:integer):boolean;
var
paux: T_ptr_case_chemin;
begin
paux := pdeb_chemin2;
while paux <> nil do
 begin
   if paux^.coord_colonne = x and paux^.coord_ligne = y
   then result := true
   else paux := paux^.ptr_suivant;
 end;
end;
//----------------------------------------------------------------------------//
function FOUND(y,x:integer;var ptr_chgt_route:T_ptr_case_chemin):boolean;
var
paux : T_ptr_case_chemin;
begin
paux := pdeb_chemin1;
while paux <> nil do
 begin
   if paux^.coord_colonne = x and paux^.coord_ligne = y
   then
    begin
     result := true;
     ptr_chgt_route := paux;
    end
   else paux := paux^.ptr_suivant;
 end;
end;
//----------------------------------------------------------------------------//
function ARRIVEE(but_y,but_x:integer):boolean;
var
paux : T_ptr_case_chemin;
begin
paux := pdeb_chemin1;
while paux <> nil do
 begin
   if paux^.coord_colonne = but_x and paux^.coord_ligne = but_y
   then result := true
   else paux := paux^.ptr_suivant;
 end;
end;
//----------------------------------------------------------------------------//
procedure COMPAROUTE(var ptr_chgt_route, case_courante:T_ptr_case_chemin;y,x:integer);
begin
 if GET_GCOST(y,x,case_courante) < ptr_chgt_route^.gcost
 then
  begin
    ptr_chgt_route^.ptr_parent := case_courante;
    ptr_chgt_route^.gcost := GET_GCOST(y,x,case_courante);
  end;
end;
//----------------------------------------------------------------------------//
end.
