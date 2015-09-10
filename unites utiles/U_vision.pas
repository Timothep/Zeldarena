unit U_vision;
//unite dans laquelle on ecrit les modules des procedures relatives au traitement
//le champ de vision



interface
uses U_crea_joueur,u_types,U_priorite;

//----------------------------------------------------------------------------//
procedure SCAN_VISION(pcour_fa_joueur : T_ptr_VD_joueur;
//Module de scan du champ de vision
function GET_NOM_ENTITE(var i,j:integer;var trouve:boolean):string;
//fonction renvoyant le nom de l entite trouve sur la case exploree et met le booleen
//trouve a vrai s il y a une entite sur la case
procedure AJOUT_ENTITE_PRIO(nom_trouve:string;pdebl_prio:T_ptr_prio;ordonnee,abscisse:integer);
//module d insertion des coordonnees de l entite trouvee dans la liste des priorites
//----------------------------------------------------------------------------//



implementation
//----------------------------------------------------------------------------//
procedure SCAN_VISION(pcour_fa_joueur : T_ptr_VD_joueur;
var
direction :char;
i,j,c,d : integer;
nom_entite_trouve :string;
trouve : boolean;
begin
direction := pcour_fa_joueur^.pt_visuel.GETORIENTATION;
c:= pcour_fa_joueur^.pt_visuel.GETLIGNE;
d := pcour_fa_joueur^.pt_visuel.GETCOLONNE;

if direction  = 'u'
then
  Begin
    For i := c - L_vision to c do
     begin
       For j := d - round(L_vision/2) to d + round(L_vision/2) do
         Begin
           nom_entite_trouve := GET_NOM_ENTITE(i,j,trouve)
           if trouve = true
           then AJOUT_ENTITE_PRIO(nom_entite_trouve,pdebl_prio,i,j);
         end;
     end;
  end;

if direction  = 'd'
then
  Begin
    For i := c to c + L_vision do
     begin
       For j := d - round(L_vision/2) to d + round(L_vision/2) do
         Begin
           nom_entite_trouve := GET_NOM_ENTITE(i,j,trouve)
           if trouve = true
           then AJOUT_ENTITE_PRIO(nom_entite_trouve,pdebl_prio,i,j);
         end;
     end;
  end;

if direction  = 'l'
then
  Begin
    For i := d to d + L_vision do
     begin
       For j := c - round(L_vision/2) to c + round(L_vision/2) do
         Begin
           nom_entite_trouve := GET_NOM_ENTITE(i,j,trouve)
           if trouve = true
           then AJOUT_ENTITE_PRIO(nom_entite_trouve,pdebl_prio,i,j);
         end;
     end;
  end;


if direction  = 'r'
then
  Begin
    For i := d + L_vision to d do
     begin
       For j := c - round(L_vision/2) to c + round(L_vision/2) do
         Begin
           nom_entite_trouve := GET_NOM_ENTITE(i,j,trouve)
           if trouve = true
           then AJOUT_ENTITE_PRIO(nom_entite_trouve,pdebl_prio,i,j);
         end;
     end;
  end;

end;
//----------------------------------------------------------------------------//
function GET_NOM_ENTITE(var i,j:integer;var trouve:boolean):string;
begin
trouve := false;
if Matrice_structure[i,j].Ptr_joueur <> nil
then
  begin
   result := 'ennemi';
   trouve := true;
  end;
if Matrice_structure[i,j].Ptr_Artefact <> nil
then
  begin
   result := Matrice_structure[i,j].Ptr_artefact.GETNOM;
   trouve := true ;
  end;
end;
//----------------------------------------------------------------------------//
procedure AJOUT_ENTITE_PRIO(nom_trouve:string;pdebl_prio:T_ptr_prio;ordonnee,abscisse:integer);
var
found : boolean;
ptr_prio : T_ptr_prio;
x,y : integer;
begin
 y := pcour_fa_joueur^.pt_visuel.GETLIGNE;
 x := pcour_fa_joueur^.pt_visuel.GETCOLONNE;
 found := false;
 ptr_prio := pdebl_prio;
 while ptr_prio <> nil and found = false do
   begin
     if nom_trouve = ptr_prio.nom_entite
     then
       begin
         found := true;
         if ((ordonnee-y)*(ordonnee-y) < (ptr_prio.coordonnees_y-y)*(ptr_prio.coordonnees_y-y)) and (abscisse-x)*(abscisse-x) < (ptr_prio.coordonnes_x-x)*(ptr_prio.coordonnes_x-x))
         then
           begin
             ptr_prio.coordonnees_y := ordonnee;
             ptr_prio.coordonnes_x := abscisse;
           end;
       end
     else ptr_prio := ptr_prio^.psuiv_prio;
   end;
end;
//----------------------------------------------------------------------------//
end.
