unit U_avarie;
//Unite donnant la condition sur l avarie d un chemin
interface
Uses U_Crea_joueur, U_types;
//----------------------------------------------------------------------------//
function CHEMIN_AVARIE(pdeb_chemin2:T_ptr_case_chemin; pcour_joueur:T_ptr_VD_joueur):boolean;
//----------------------------------------------------------------------------//
implementation
Uses U_Jeu;

//----------------------------------------------------------------------------//
//----------------------------------------------------------------------------//

//Module testant la validit� du chemin que le bot a en m�moire
Function CHEMIN_AVARIE(pdeb_chemin2:T_ptr_case_chemin; pcour_joueur:T_ptr_VD_joueur):boolean;
var
paux: T_ptr_case_chemin;
paux_prio:T_ptr_prio;
x,y : integer;
begin
result:=false;
//Si la premi�re case du chemin est nil
if pdeb_chemin2 = nil
        then //Alors le chemin est vide .... donc avari�
                result := true
        else //Sinon, il faut regarder la derni�re case du chemin avant de se prononcer
                begin
                //Initialisation de Paux vers la premi�re cse de la matrice
                paux := pdeb_chemin2;
                //Tant qu'on a pas atteint la fin du chemin
                while paux^.ptr_suivant <> nil do paux := paux^.ptr_suivant;
                //On retient les coordonn�es du dernier �l�ment
                x := paux^.coord_colonne;
                y := paux^.coord_ligne;
                //Si la case correspondante dans la matrice n'est pas marchable ou qu'il n'y a rien dessus
                if (Matrice_structure[x,y].Ptr_Terrain.GETMARCHABLE = true) and (Matrice_structure[x,y].Ptr_joueur=nil) and (Matrice_structure[x,y].Ptr_artefact=nil)
                        then
                begin
                result := true;
                //Recherche des coordonn�es de l'�l�ment but du chemin dans la liste des priorit�s
                paux_prio:=pcour_joueur.pt_visuel.Liste_priorites;
                while paux_prio<>Nil do
                        begin
                        If (paux_prio.coordonnees_x=x) and (paux_prio.coordonnees_y=y)
                                then
                                        begin
                                        paux_prio.coordonnees_x:=-1;
                                        paux_prio.coordonnees_y:=-1;
                                        end;
                        end;
                pcour_joueur.pt_visuel.PUTCHEMIN(Nil);
                end;
                end;


End;

//----------------------------------------------------------------------------//
//----------------------------------------------------------------------------//

end.
