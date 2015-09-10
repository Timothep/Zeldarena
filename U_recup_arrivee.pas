unit U_recup_arrivee;
//Unite dans laquelle on declare le module de recuperation des coordonn�es
//du point d arrivee dans la liste des priorites..

interface

implementation
//----------------------------------------------------------------------------//

//Module dans lequel on recupere les coordonn�es du point d'arrivee dans la liste des priorites
procedure RECUP_COORD(pdebl_prio:T_ptr_prio;var but_x,but_y:integer;pdeb_FA_waypoint:T_ptr_FA_waypoint);
var
paux: T_ptr_prio;
paux2: T_ptr_FA_waypoint;
trouve : boolean;
x,y:integer;
begin
//Initialisation de Paux (debut de la liste des priorit�s
paux := pdebl_prio;
trouve := false;
//Tant que l'on a pas parcouru toute la liste des priorit�s
while (paux <> nil) and (trouve = false) do
  begin
  //Si l'�l�ment courant poss�de des coordonn�es valides
    if (paux^.coordonnees_x <> -1) and (paux^.coordonnees_y <> -1)
    then
      begin
      //On retient les coordonn�es
        but_x := paux^.coordonnees_x;
        but_y := paux^.coordonnees_y;
        trouve := true;
      end
    else //sinon, on boucle
        paux := paux^.psuiv_prio;
  end;
//Si on est arriv� � la fin de la liste et qu'on a rien trouv�
if (paux = nil) and (trouve = false)
then //C'est que la liste �tait vide et donc on cherche le point de passage le plus �loign�
  begin
  //Initialisation de paux au d�but de la FA des points de passage
   paux2:= pdeb_FA_waypoint;
   //On retient les coordonn�es du joueur
   x := pcour_fa_joueur^.pt_visuel^.GETCOLONNE;
   y := pcour_fa_joueur^.pt_visuel^.GETLIGNE;
   //Initialisation de la distance
   distx:=0;
   disty:=0;
   //Tant que l'on a pas parcouru toute la liste des points de passage
   while paux2 <> nil do
    begin
      //Si la distance s�parant le PP et le joueur est plus grande que la pr�c�dente
      if (abs(paux2^.CoordX - x) > distx) and (abs(paux2^.CoordY - y) > disty)
      then //alors c'est la nouvelle cible
        begin
        //On retient la distance
          distx := abs(paux2^.CoordX - x);
          disty := abs(paux2^.CoordY - y);
        //On retient les coordonn�es
          but_x := paux2^.CoordX;
          but_y := paux2^.CoordY;
        end
      else //Sinon, on passe a l'�l�ment suivant
        paux2 := paux2^.psuiv;
    end;
  end;
end;
//----------------------------------------------------------------------------//
end.
