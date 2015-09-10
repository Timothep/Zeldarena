unit U_avarie;
//Unite donnant la condition sur l avarie d un chemin
interface
//----------------------------------------------------------------------------//
function CHEMIN_AVARIE:boolean;
//----------------------------------------------------------------------------//
implementation
//----------------------------------------------------------------------------//
function CHEMIN_AVARIE;
var
paux: T_ptr_case_chemin;
x,y : integer;
begin
if pdeb_chemin2 = nil
then result := true
else
 begin
   paux := pdeb_chemin2;
   while paux^.ptr_suivant <> nil do
   begin
    paux := paux^.ptr_suivant;
   end;
   x := paux^.coord_colonne;
   y := paux^.coord_ligne;
   if (Matrice_structure[y,x].GETMARCHABLE = true) and (Matrice_structure[y,x].Ptr_joueur=nil) and (Matrice_structure[y,x].Ptr_artefact=nil)
   then result := true;
 end;
//----------------------------------------------------------------------------//
end.
