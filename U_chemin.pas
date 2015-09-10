unit U_chemin;
//Unite dans laquelle on declare la file d attente des cases du chemin suivies par un bot
//Lors du calcul du chemin a suivre, on execute les modules de cette unite
//Cette liste est construite lors du deroulement du module de pathfinding
//Dans cette unite sont declarées les listes nécessaires au deroulement de l Astar


interface
uses  Dialogs, Grids ,U_path, U_crea_joueur, U_types;

//----------------------------------------------------------------------------//

type

//Déplacé dans U_crea_joueur pour ref circulaire
{T_ptr_case_chemin = ^case_chemin;
case_chemin = record
                coord_colonne : integer;
                coord_ligne   : integer;
                fcost : integer;
                gcost : integer;
                hcost : integer;
                ptr_suivant   : T_ptr_case_chemin;
                ptr_parent : T_ptr_case_chemin;
                end;    }

T_ptr_case_invalide = ^case_invalide;
case_invalide = record
                   case1x : integer;
                   case1y : integer;
                   case2x : integer;
                   case2y : integer;
                   case3x : integer;
                   case3y : integer;
                   case4x : integer;
                   case4y : integer;
                   end;
var
pdeb_chemin1,pcour_chemin1,pdeb_chemin2,ptr_chgt_route,pcour_chemin2,pnouv_chemin,case_courante,ptr_arrivee  : T_ptr_case_chemin;
abscisse,ordonnee,but_x,but_y : integer;
ajout_depart,ajout_arrivee,ajout_obstacle : boolean;
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
procedure CALCUL_CHEMIN(depart_x,depart_y,but_x,but_y:integer;var pdeb_chemin2:T_ptr_case_chemin);
procedure SEARCH_LOW_FCOST(var case_courante:T_ptr_case_chemin);
procedure AJOUT_CASES_ADJACENTES(var a,b,but_x,but_y:integer;pdeb_chemin1,case_courante:T_ptr_case_chemin);
procedure TRANSFERT_CHEMIN(var case_courante:T_ptr_case_chemin);
procedure AJOUT_LIST_FERMEE(var case_courante:T_ptr_case_chemin);
procedure AJOUT_LIST_OUVERTE(var a,b,but_x,but_y:integer; var pdeb_chemin1,case_courante:T_ptr_case_chemin);
procedure COMPAROUTE(var ptr_chgt, case_cour:T_ptr_case_chemin;b,a:integer);
function GET_FCOST(a,b,but_x,but_y:integer):integer;
function GET_GCOST(a,b:integer;case_courante:T_ptr_case_chemin):integer;
function GET_HCOST(a,b,but_x,but_y:integer):integer;
function ALREXIST(a,b:integer):boolean;
function FOUND(b,a:integer;var ptr_chgt_route:T_ptr_case_chemin):boolean;
function ARRIVEE(but_y,but_x:integer;var ptr_arrivee:T_ptr_case_chemin):boolean;
procedure AFFICHE_CHEMIN(pdeb_chemin2:T_ptr_case_chemin);
procedure AJOUT_INVALIDE(var x1,y1:integer; var ptr_validite:T_ptr_case_invalide;case_cour:T_ptr_case_chemin);
procedure EPURATION(var ptr_validite:T_ptr_case_invalide;var pdeb_chemin1:T_ptr_case_chemin);
procedure REMISE_ORDRE(var pdeb,arrivee:T_ptr_case_chemin);
//----------------------------------------------------------------------------//

implementation
Uses U_jeu;
//----------------------------------------------------------------------------//
procedure CREA_VD_CHEMIN1(var pnouv_chemin : T_ptr_case_chemin);
begin
New(pnouv_chemin);
end;
//----------------------------------------------------------------------------//
function ALREXIST(a,b:integer):boolean;
var
paux: T_ptr_case_chemin;
begin
paux := pdeb_chemin2;
result := false;
while (paux <> nil) and (result = false) do
 begin
   if (paux^.coord_colonne = a) and (paux^.coord_ligne = b)
   then result := true
   else paux := paux^.ptr_suivant;
 end;
end;
//----------------------------------------------------------------------------//
procedure INIT_VD_CHEMIN1(var pnouv_chemin,ptr_parent,ptr_suivant : T_ptr_case_chemin; coutf,coutg,couth:integer;abscisse,ordonnee:integer);
begin
pnouv_chemin^.ptr_parent:=ptr_parent;
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
procedure AJOUT_fin_CHEMIN1(var pcour_chemin1, pnouv_chemin:T_ptr_case_chemin);
begin
//Condition de non calcul de chemin si Bot coincé
If pdeb_chemin1=Nil
then
  pdeb_chemin1 := pnouv_chemin
else
  Begin
  pcour_chemin1 := pdeb_chemin1;
   while pcour_chemin1^.ptr_suivant <> nil do
    begin
     pcour_chemin1 := pcour_chemin1^.ptr_suivant;
    end;
  pcour_chemin1^.ptr_suivant := pnouv_chemin;
  end;
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
procedure RETRAIT_fin_CHEMIN1(var pcour_chemin1:T_ptr_case_chemin);
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
procedure SEARCH_LOW_FCOST(var case_courante:T_ptr_case_chemin);
var
F : integer;
paux : T_ptr_case_chemin;
begin
 case_courante := pdeb_chemin1;
 paux := pdeb_chemin1;
 If paux<>Nil then F := pdeb_chemin1^.fcost;
 while paux <> nil do
 begin
   if paux^.fcost < F
   then
     begin
      if paux <> nil
      then
       begin
        case_courante := paux;
        F:= paux^.fcost;
       end;
     end;
   paux := paux^.ptr_suivant;
   end;
   //end;
end;

//----------------------------------------------------------------------------//
//----------------------------------------------------------------------------//
//----------------------------------------------------------------------------//
//----------------------------------------------------------------------------//
//----------------------------------------------------------------------------//

//Module principal de calcul du chemin (A*)
Procedure CALCUL_CHEMIN(depart_x,depart_y,but_x,but_y:integer;var pdeb_chemin2:T_ptr_case_chemin);
var
i,j: integer;//i et j sont les coordonnees de la case de depart, x et y celles de la case courante
trouve,existe : boolean;
begin
//Initialisation des bouléens
existe := true;
trouve := false;
//Initialisation de la liste ouverte
INIT_CHEMIN1(pdeb_chemin1);
//Initialisation de la liste fermée
INIT_CHEMIN2(pdeb_chemin2);
//Initialisation des pointeurs de début et d'arrivée
pdeb_chemin1 := nil;
case_courante := nil;
ptr_arrivee := nil;
//Ajout de la case de depart a la liste ouverte
AJOUT_LIST_OUVERTE(depart_x,depart_y,but_x,but_y,pdeb_chemin1,case_courante);
//Ajout des cases adjacentes a la liste ouverte
AJOUT_CASES_ADJACENTES(depart_x,depart_y,but_x,but_y,pdeb_chemin1,case_courante);
//Transfert de la case courante de la liste ouverte vers la liste fermée
TRANSFERT_CHEMIN(case_courante);
//Répéter ce qui suit jusqu'a ce qu'on ait trouvé ou que l'on ait pas de chemin possible vers l'entité
repeat
  begin
  //On recherche la case de plus bas cout parmi les cases adjacentes
  SEARCH_LOW_FCOST(case_courante);
  //Init des coord courantes
  i:= case_courante^.coord_ligne;
  j:= case_courante^.coord_colonne;
  //Transfert de la case courante
  TRANSFERT_CHEMIN(case_courante);
  AJOUT_CASES_ADJACENTES(j,i,but_x,but_y,pdeb_chemin1,case_courante);
  if pdeb_chemin1 = nil
  then existe := false;
  if ARRIVEE(but_y,but_x,ptr_arrivee) = true
  then trouve := true;
  end;
until (trouve = true) or (existe = false) ;
//Retournage du chemin
REMISE_ORDRE(pdeb_chemin2,ptr_arrivee);
end;
//----------------------------------------------------------------------------//
//Module de remise en ordre du chemin trouvé
procedure REMISE_ORDRE(var pdeb,arrivee:T_ptr_case_chemin);
var
paux : T_ptr_case_chemin;
begin
pdeb := nil;
paux := arrivee;
while paux <> nil do
  begin
   paux^.ptr_suivant := pdeb;
   pdeb := paux;
   paux := paux^.ptr_parent;
  end;
end;
//----------------------------------------------------------------------------//
procedure AJOUT_CASES_ADJACENTES(var a,b,but_x,but_y:integer;pdeb_chemin1,case_courante:T_ptr_case_chemin);
var
x1,y1,x2,y2:integer;
val_x,val_y:integer;
case_valide:boolean;
ptr_validite:T_ptr_case_invalide;
begin
{//Condition de non calcul de chemin en cas de blocage du BOT (houlala, s'il est bloqué, il va prendre cher!!!)
If pdeb_chemin1 <>Nil
then}
begin
New(ptr_validite);
//x1 := a;
//y1 := b;
 for  y1 := b-1 to b+1 do
 begin
   for x1 := a-1 to a+1 do
   begin
    if (x1 <> a) or (y1 <> b)
     then
      begin
        if (x1<= MAP_WIDTH-1) and (x1>=0) and  (y1<= MAP_HEIGHT-1) and (y1>=0)
        then
        begin
          if ((Matrice_structure[X1,Y1].Ptr_Terrain.GETMARCHABLE) and (Matrice_structure[X1,Y1].Ptr_Artefact.GETNOM='0') and (not ALREXIST(x1,y1))) or ((x1=But_x) and (y1=But_y))
          then
           begin
            val_x := x1;
            val_y := y1;
            if FOUND(y1,x1,ptr_chgt_route) = false
              then AJOUT_LIST_OUVERTE(val_x,val_y,but_x,but_y,pdeb_chemin1,case_courante)
              else COMPAROUTE(ptr_chgt_route,case_courante,val_y,val_x);
           end
          else
                begin
                x2:=x1;
                y2:=y1;
                AJOUT_INVALIDE(x2,y2,ptr_validite,case_courante);
                end;
        end;
      end;
   end;
 end;
if pdeb_chemin1<> nil then EPURATION(ptr_validite,pdeb_chemin1);
end;
end;
//----------------------------------------------------------------------------//
procedure EPURATION(var ptr_validite:T_ptr_case_invalide;var pdeb_chemin1:T_ptr_case_chemin);
var
paux : T_ptr_case_chemin;
trouve:boolean;
begin
paux := pdeb_chemin1;
//Rajout de la 2° condition pour que ça ne plante pas !!!
while (paux^.ptr_suivant <> nil) and (pdeb_chemin1<>nil) do
 begin
  trouve := false;
  if ((pdeb_chemin1^.coord_colonne = ptr_validite^.case1x) and (pdeb_chemin1^.coord_ligne = ptr_validite^.case1y) and (trouve=false))
         or ((pdeb_chemin1^.coord_colonne=ptr_validite^.case2x) and (pdeb_chemin1^.coord_ligne=ptr_validite^.case2y) and (trouve=false))
         or ((pdeb_chemin1^.coord_colonne=ptr_validite^.case3x) and (pdeb_chemin1^.coord_ligne=ptr_validite^.case3y) and (trouve=false))
         or ((pdeb_chemin1^.coord_colonne=ptr_validite^.case4x) and (pdeb_chemin1^.coord_ligne=ptr_validite^.case4y) and (trouve=false))
    then
    begin
      pdeb_chemin1 := pdeb_chemin1^.ptr_suivant;
      trouve := true;
    end;
  if ((paux^.ptr_suivant^.coord_colonne=ptr_validite^.case1x) and (paux^.ptr_suivant^.coord_ligne=ptr_validite^.case1y) and (trouve=false))
         or ((paux^.ptr_suivant^.coord_colonne=ptr_validite^.case2x) and (paux^.ptr_suivant^.coord_ligne=ptr_validite^.case2y) and (trouve=false))
         or ((paux^.ptr_suivant^.coord_colonne=ptr_validite^.case3x) and (paux^.ptr_suivant^.coord_ligne=ptr_validite^.case3y) and (trouve=false))
         or ((paux^.ptr_suivant^.coord_colonne=ptr_validite^.case4x) and (paux^.ptr_suivant^.coord_ligne=ptr_validite^.case4y) and (trouve=false))
    then
    begin
      paux^.ptr_suivant := paux^.ptr_suivant^.ptr_suivant;
      trouve := true;
    end ;
  if trouve = false
  then paux := paux^.ptr_suivant;
 end;
dispose(ptr_validite);
end;
//----------------------------------------------------------------------------//
procedure AJOUT_INVALIDE(var x1,y1:integer; var ptr_validite:T_ptr_case_invalide;case_cour:T_ptr_case_chemin);
begin
if (not Matrice_structure[X1,Y1].Ptr_Terrain.GETMARCHABLE) or (Matrice_structure[X1,Y1].Ptr_Artefact.GETNOM<>'0.bmp')
then
  begin
    if (x1 < case_courante^.coord_colonne) and (y1 = case_courante^.coord_ligne)
    then
    begin
    ptr_validite^.case1x := x1;
    ptr_validite^.case1y := y1-1;
    ptr_validite^.case3x := x1;
    ptr_validite^.case3y := y1+1;
    end;
    if (x1 > case_courante^.coord_colonne) and (y1 = case_courante^.coord_ligne)
    then
    begin
    ptr_validite^.case2x := x1;
    ptr_validite^.case2y := y1-1;
    ptr_validite^.case4x := x1;
    ptr_validite^.case4y := y1+1;
    end;
    if (x1 = case_courante^.coord_colonne) and (y1 < case_courante^.coord_ligne)
    then
    begin
    ptr_validite^.case1x := x1-1;
    ptr_validite^.case1y := y1;
    ptr_validite^.case2x := x1+1;
    ptr_validite^.case2y := y1;
    end;
    if (x1 = case_courante^.coord_colonne) and (y1 > case_courante^.coord_ligne)
    then
    begin
    ptr_validite^.case3x := x1-1;
    ptr_validite^.case3y := y1;
    ptr_validite^.case4x := x1+1;
    ptr_validite^.case4y := y1;
    end;
  end;
end;
//----------------------------------------------------------------------------//

//prend la case qui coute le moins cher de la liste ouverte et la met dans la liste fermée
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
  end
 else
  begin
   while (paux^.ptr_suivant <> nil) and (trouve = false) do
    begin
     if paux^.ptr_suivant = case_courante
      then
      begin
       trouve := true;
       paux^.ptr_suivant := case_courante^.ptr_suivant;
      end
      else paux := paux^.ptr_suivant;
    end;
  end;
case_courante^.ptr_suivant := nil;
AJOUT_LIST_FERMEE(case_courante);
end;
//----------------------------------------------------------------------------//
procedure AJOUT_LIST_FERMEE(var case_courante:T_ptr_case_chemin);
begin
  if pdeb_chemin2 = nil
  then pdeb_chemin2 := case_courante
  else AJOUT_fin_CHEMIN2(pcour_chemin2,case_courante);
end;
//----------------------------------------------------------------------------//
procedure AJOUT_LIST_OUVERTE(var a,b,but_x,but_y:integer; var pdeb_chemin1,case_courante:T_ptr_case_chemin);
var
GETF,GETG,GETH:integer;
parent,suivant : T_ptr_case_chemin;
begin
parent := nil;
suivant := nil;
if (pdeb_chemin1 = nil)  and (pdeb_chemin2 = nil)
 then//on ajoute le point de depart
  begin //i et j sont les coordonnees ligne et colonne de la case de depart
    GETH := GET_HCOST(a,b,but_x,but_y);
    GETF := GETH;
    CREA_VD_CHEMIN1(pnouv_chemin);
    INIT_VD_CHEMIN1(pnouv_chemin,parent,suivant,GETF,0,GETH,a,b);
    pdeb_chemin1 := pnouv_chemin;
    case_courante := pdeb_chemin1;
  end
 else//on ajoute les cases adjacentes
  begin //y et x sont les coordonnees ligne et colonne de la case en cours d examen
    GETH := GET_HCOST(a,b,but_x,but_y);
    GETG := GET_GCOST(a,b,case_courante);
    GETF := GETG + GETH;
    CREA_VD_CHEMIN1(pnouv_chemin);
    INIT_VD_CHEMIN1(pnouv_chemin,case_courante,suivant,GETF,GETG,GETH,a,b);
    AJOUT_fin_CHEMIN1(pcour_chemin1, pnouv_chemin);
  end;
end;
//----------------------------------------------------------------------------//
function GET_FCOST(a,b,but_x,but_y:integer):integer;
begin
result := GET_GCOST(a,b,case_courante) + GET_HCOST(a,b,but_x,but_y);
end;
//----------------------------------------------------------------------------//
function GET_GCOST(a,b:integer;case_courante:T_ptr_case_chemin):integer;
begin
if (b <> case_courante.coord_ligne) and (a <> case_courante.coord_colonne)
then result := case_courante.gcost + 14
else result := case_courante.gcost + 10;
end;
//----------------------------------------------------------------------------//
function GET_HCOST(a,b,but_x,but_y:integer):integer;
begin
 result := (abs(b-but_y) + abs(a-but_x))*10;
end;

//----------------------------------------------------------------------------//
function FOUND(b,a:integer;var ptr_chgt_route:T_ptr_case_chemin):boolean;
var
paux : T_ptr_case_chemin;
begin
paux := pdeb_chemin1;
result := false;
while (paux <> nil) and (result = false)do
 begin
   if (paux^.coord_colonne = a) and (paux^.coord_ligne = b)
   then
    begin
     result := true;
     ptr_chgt_route := paux;
    end
   else paux := paux^.ptr_suivant;
 end;
end;
//----------------------------------------------------------------------------//
function ARRIVEE(but_y,but_x:integer;var ptr_arrivee:T_ptr_case_chemin):boolean;
var
paux : T_ptr_case_chemin;
begin
paux := pdeb_chemin1;
result := false;
while (paux <> nil) and (result=false) do
 begin
   if (paux^.coord_colonne = but_x) and (paux^.coord_ligne = but_y)
   then
    begin
     result := true;
     ptr_arrivee := paux;
    end
   else paux := paux^.ptr_suivant;
 end;
end;
//----------------------------------------------------------------------------//
procedure COMPAROUTE(var ptr_chgt, case_cour:T_ptr_case_chemin;b,a:integer);
begin
 if GET_GCOST(a,b,case_cour) + case_cour^.gcost < ptr_chgt^.gcost
 then
  begin
    ptr_chgt^.ptr_parent := case_cour;
    ptr_chgt^.gcost := GET_GCOST(a,b,case_cour);
    ptr_chgt^.fcost := ptr_chgt^.gcost + ptr_chgt^.hcost;
  end;
end;
//----------------------------------------------------------------------------//
procedure AFFICHE_CHEMIN(pdeb_chemin2:T_ptr_case_chemin);
var
paux : T_ptr_case_chemin;
cx,cy :integer;
begin

(*paux := pdeb_chemin1;
while (paux <> nil) do
  begin
  cx := paux^.coord_colonne;
  cy := paux^.coord_ligne;
  F_carte.SG_Chemin.Cells[cx,cy] := 'OOOOOOOO' ;
  paux := paux^.ptr_suivant;
  end; *)
  
paux := ptr_arrivee;
while (paux <> nil) do
  begin
  cx := paux^.coord_colonne;
  cy := paux^.coord_ligne;
  F_carte.SG_Chemin.Cells[cx,cy] := '////////' ;
  paux := paux^.ptr_parent;
  end;

end;
//----------------------------------------------------------------------------//
end.
