unit U_vision;
//unite dans laquelle on ecrit les modules des procedures relatives au traitement
//le champ de vision



interface
uses U_crea_joueur,u_types,U_priorite, U_jeu, Dialogs;

//----------------------------------------------------------------------------//
Procedure SCAN_VISION(pcour_fa_joueur : T_ptr_VD_joueur);
//Module de scan du champ de vision
Function GET_NOM_ENTITE(var i,j:integer;var trouve:boolean;pcour_joueur:t_ptr_vd_joueur):string;
//fonction renvoyant le nom de l entite trouve sur la case exploree et met le booleen
//trouve a vrai s il y a une entite sur la case
procedure AJOUT_ENTITE_PRIO(nom_trouve:string;pdebl_prio:T_ptr_prio;abscisse,ordonnee:integer;pcour_fa_joueur:t_ptr_Vd_joueur);
//module d insertion des coordonnees de l entite trouvee dans la liste des priorites
//----------------------------------------------------------------------------//

implementation

//----------------------------------------------------------------------------//
//----------------------------------------------------------------------------//

//Module qui va chercher (lycos :) le nom d'une entité située à des coordonnées précises
function GET_NOM_ENTITE(var i,j:integer;var trouve:boolean;pcour_joueur:t_ptr_vd_joueur):string;
begin
//Init de trouvé
trouve := false;
//Si aux coordonnées précises (i,j) ya un joueur (autre que lui)
if (Matrice_structure[i,j].Ptr_Joueur <> nil) and ((i<>pcour_joueur.pt_visuel.GETCOLONNE) or (j<>pcour_joueur.pt_visuel.GETLIGNE))
then //le dites a personne, mais je crois que c'est un ennemi... chuuut, on va le prendre par surprise
  begin
  //Bon, ben résultat = ennemi, logique
   result := 'ennemi';
  //Et puis on a trouvé (normal c'est lycos ;)
   trouve := true;
  end;
//Si aux coordonnées précises (i,j) ya un artefact
if (Matrice_structure[i,j].Ptr_Artefact.GETNOM <> '0') and (Matrice_structure[i,j].Ptr_Artefact.GETACTIF)
then
  begin
  //Idem, on choppe son nom et basta ou presque
  trouve := true ;
  //Si c'est une arme
   If   (Matrice_structure[i,j].Ptr_artefact.GETNOM='67')
     or (Matrice_structure[i,j].Ptr_artefact.GETNOM='68')
     or (Matrice_structure[i,j].Ptr_artefact.GETNOM='69')
     or (Matrice_structure[i,j].Ptr_artefact.GETNOM='70')
     or (Matrice_structure[i,j].Ptr_artefact.GETNOM='71')
     or (Matrice_structure[i,j].Ptr_artefact.GETNOM='72')
        then //alors c'est une arme (puisssssant non?)
        result:='arme';
  //Si c'est une armure
   If   (Matrice_structure[i,j].Ptr_artefact.GETNOM='73')
     or (Matrice_structure[i,j].Ptr_artefact.GETNOM='74')
     or (Matrice_structure[i,j].Ptr_artefact.GETNOM='75')
     or (Matrice_structure[i,j].Ptr_artefact.GETNOM='76')
     or (Matrice_structure[i,j].Ptr_artefact.GETNOM='77')
     or (Matrice_structure[i,j].Ptr_artefact.GETNOM='78')
        then //alors c'est une armure (puisssssant non?)
        result:='armure';
  //Si c'est de la vie
   If   (Matrice_structure[i,j].Ptr_artefact.GETNOM='79')
     or (Matrice_structure[i,j].Ptr_artefact.GETNOM='80')
        then //alors c'est de la vie (puisssssant non?)
        result:='vie';
  //Si c'est de l'XP
   If   (Matrice_structure[i,j].Ptr_artefact.GETNOM='85')
     or (Matrice_structure[i,j].Ptr_artefact.GETNOM='86')
     or (Matrice_structure[i,j].Ptr_artefact.GETNOM='87')
     or (Matrice_structure[i,j].Ptr_artefact.GETNOM='88')
        then //alors c'est de l'XP (puisssssant non?)
        result:='xp';
  //Si c'est un point de renaissance
   If   (Matrice_structure[i,j].Ptr_artefact.GETNOM='83')
     or (Matrice_structure[i,j].Ptr_artefact.GETNOM='84')
        then
                begin
                trouve := false ;
                result:='';
                end;
   //Si c'est un point de passage
   If   (Matrice_structure[i,j].Ptr_artefact.GETNOM='81')
     or (Matrice_structure[i,j].Ptr_artefact.GETNOM='82')
        then
        //result:='wp';
                begin
                trouve := false ;
                result:='';
                //i:=-1;
                //j:=-1;
                end;
  end;
end;

//----------------------------------------------------------------------------//
//----------------------------------------------------------------------------//

//Module d'ajout des coordonnées d'une entité dans la liste des priorités
procedure AJOUT_ENTITE_PRIO(nom_trouve:string;pdebl_prio:T_ptr_prio;abscisse,ordonnee:integer;pcour_fa_joueur:t_ptr_Vd_joueur);
var
found : boolean;
ptr_prio : T_ptr_prio;
x,y : integer;
begin
//On initialise les coordonnées du joueur
 y := pcour_fa_joueur^.pt_visuel.GETLIGNE;
 x := pcour_fa_joueur^.pt_visuel.GETCOLONNE;
//On a pas encore trouvé... hé non, lycos n'est pas loin pourtant
 found := false;
//Et on se place au début de la liste (c'est mieux n'est-ce pas?)
 ptr_prio := pcour_fa_joueur.pt_visuel.Liste_priorites;
//Tant qu'on a pas parcouru toute la liste, ou qu'on a pas trouvé
 while (ptr_prio <> nil) and (found = false) do
   begin
   //Si le nom qu'on a passé en parametre, et bien croyez moi ou non, c'est le nom du bidule courant dans la liste des priorités...
     if nom_trouve = ptr_prio.nom_entite
     then  //C'est magique on a trouvé alors
       begin
       //Si ses coordonnées ne sont pô vides
        if (ptr_prio.coordonnees_x <> -1) and (ptr_prio.coordonnees_y <> -1)
        then
          begin
          //C'est ce que je disais, on a trouvé
            found := true;
          //Si la distance entre le joueur et l'objet est plus proche qu'avant
            if (abs(ordonnee-y) < abs(ptr_prio.coordonnees_y-y)) and (abs(abscisse-x) < abs(ptr_prio.coordonnees_x-x))
            then //Alors, il faut mettre a jour les coord
              begin
              //Mise a jour des coord
                ptr_prio.coordonnees_y := ordonnee;
                ptr_prio.coordonnees_x := abscisse;
              end;
          end
        else //Sinon, les coord sont vides donc on remplit
         begin
          found:=true;
          ptr_prio.coordonnees_y := ordonnee;
          ptr_prio.coordonnees_x := abscisse;
         end;
       end;
     //else //On passe au copain suivant
        ptr_prio := ptr_prio^.psuiv_prio;
   end;
end;

//----------------------------------------------------------------------------//
//----------------------------------------------------------------------------//

//Module de scan de la vision
procedure SCAN_VISION(pcour_fa_joueur : T_ptr_VD_joueur);
var
direction :char;
i,j,a,b,c,d : integer;
nom_entite_trouve :string;
trouve : boolean;
Paux_prio:t_ptr_prio;
Begin
//Init de la direction
direction := pcour_fa_joueur^.pt_visuel.GETORIENTATION;
//Init des coordonnées du joueur
c:= pcour_fa_joueur^.pt_visuel.GETLIGNE;
d := pcour_fa_joueur^.pt_visuel.GETCOLONNE;
//si direction Up
if direction  = 'U'
then //Alors
  Begin
  //Pour i variant de la longuer de vue jusqu'au joueur
    For j := c - L_vision to c do
     begin
     //Pour j variant de la largeur de vue à gauche jusqu'a la largeur de vue a droite
       For i := d - round(L_vision/2) to d + round(L_vision/2) do
         Begin
         //On bloque les moments ou i et j sortent de la matrice
         a:=i;
         b:=j;
         If (a>=0) and (b>=0) and (a<MAP_WIDTH) and (b<MAP_HEIGHT)
                then
                begin
         //On choppe le nom de l'entité qu'on a trouvé
           nom_entite_trouve := GET_NOM_ENTITE(a,b,trouve,pcour_fa_joueur);
         //Si ya un artefact ou un joueur
           if trouve = true
           then //alors on regarde si ça vaut le coup d'ajouter l'entité dans la liste des priorités
                AJOUT_ENTITE_PRIO(nom_entite_trouve,pdebl_prio,a,b,pcour_fa_joueur);
                end;
         end;
     end;
  end;

if direction  = 'D'
then
  Begin
    For j := c to c + L_vision do
     begin
       For i := d - round(L_vision/2) to d + round(L_vision/2) do
         Begin
           //On bloque les moments ou i et j sortent de la matrice
         a:=i;
         b:=j;
         If (a>=0) and (b>=0) and (a<MAP_WIDTH) and (b<MAP_HEIGHT)
                then
                begin
         //On choppe le nom de l'entité qu'on a trouvé
           nom_entite_trouve := GET_NOM_ENTITE(a,b,trouve,pcour_fa_joueur);
         //Si ya un artefact ou un joueur
           if trouve = true
           then //alors on regarde si ça vaut le coup d'ajouter l'entité dans la liste des priorités
                AJOUT_ENTITE_PRIO(nom_entite_trouve,pdebl_prio,a,b,pcour_fa_joueur);
                end;
         end;
     end;
  end;

if direction  = 'L'
then
  Begin
    For j := c - round(L_vision/2) to c + round(L_vision/2) do
     begin
       For i := d - L_vision to d do
         Begin
           //On bloque les moments ou i et j sortent de la matrice
         a:=i;
         b:=j;
         If (a>=0) and (b>=0) and (a<MAP_WIDTH) and (b<MAP_HEIGHT)
                then
                begin
                //On choppe le nom de l'entité qu'on a trouvé
                nom_entite_trouve := GET_NOM_ENTITE(a,b,trouve,pcour_fa_joueur);
                //Si ya un artefact ou un joueur
                if trouve = true
                then //alors on regarde si ça vaut le coup d'ajouter l'entité dans la liste des priorités
                        AJOUT_ENTITE_PRIO(nom_entite_trouve,pdebl_prio,a,b,pcour_fa_joueur);
                end;
         end;
     end;
  end;


if direction  = 'R'
then
  Begin
    For j := c - round(L_vision/2) to c + round(L_vision/2) do
     begin
       For i := d to d + L_vision do
         Begin
           //On bloque les moments ou i et j sortent de la matrice
         a:=i;
         b:=j;
         If (a>=0) and (b>=0) and (a<MAP_WIDTH) and (b<MAP_HEIGHT)
                then
                begin
         //On choppe le nom de l'entité qu'on a trouvé
           nom_entite_trouve := GET_NOM_ENTITE(a,b,trouve,pcour_fa_joueur);
         //Si ya un artefact ou un joueur
           if trouve = true
           then //alors on regarde si ça vaut le coup d'ajouter l'entité dans la liste des priorités
                AJOUT_ENTITE_PRIO(nom_entite_trouve,pdebl_prio,a,b,pcour_fa_joueur);
                end;
         end;
     end;
  end;

//Epuration de la liste des priorités
Paux_prio:=pcour_fa_joueur.pt_visuel.Liste_priorites;
//Tant qu'on a pas vérifié toute la FA
While paux_prio<>nil do
        begin
        If (paux_prio.coordonnees_x<>-1) and (paux_prio.coordonnees_y<>-1) and (paux_prio.nom_entite='ennemi')
                then
                begin
                If matrice_structure[paux_prio.coordonnees_x,paux_prio.coordonnees_y].Ptr_Joueur=nil
                        then
                                begin
                                paux_prio.coordonnees_x:=-1;
                                paux_prio.coordonnees_y:=-1;
                                end;
                end
                else
                If (paux_prio.coordonnees_x<>-1) and (paux_prio.coordonnees_y<>-1) and (matrice_structure[paux_prio.coordonnees_x,paux_prio.coordonnees_y].Ptr_Artefact.GETNOM='0')
                                then
                                        begin
                                        paux_prio.coordonnees_x:=-1;
                                        paux_prio.coordonnees_y:=-1;
                                        end;
        paux_prio:=paux_prio.psuiv_prio;
        end;
end;

//----------------------------------------------------------------------------//
//----------------------------------------------------------------------------//

end.
