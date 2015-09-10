unit U_test_deplace;
//unite dans laquelle on declare les modules de test du deplacement
//et les modules de contact

interface

uses U_fa_joueur, U_types, Dialogs;

var
vitesse : integer;
trouve : boolean;
i,j,y,x : integer;
//----------------------------------------------------------------------------//
function GET_VITESSE(pcour_FA_joueur:T_ptr_VD_joueur):integer;
//fonction renvoyant un integer correspondant au nombre de pixels dont le joueur
//se deplacera s il envisage le deplacement
//----------------------------------------------------------------------------//
function DEPLACEMENT_POSSIBLE(var vitesse,dist_mini,a,b,x,y:integer;var trouve : boolean; pcour_fa_joueur:t_ptr_Vd_joueur):boolean;
//function renvoyant vrais si le deplacement est possible
//et la vitesse, car celle ci va s adapter a la distance a parcourir
//appelle la fonction GET_Distance
//----------------------------------------------------------------------------//
//function GET_DISTANCE(i,j:integer;direction:char;pcour_FA_joueur:T_ptr_VD_joueur):integer;
//function renvoyant un entier represant la distance entre le joueur et l entite
//vers laquelle il se deplace
//----------------------------------------------------------------------------//
function CONTACT_JOUEUR(i,j:integer; var x,y:integer; var trouve:boolean; pcour_fa_joueur:t_ptr_Vd_joueur):boolean;
//function renvoyant true si le joueur est au contact d une entite
//appelle la fonction deplacement_possible
//----------------------------------------------------------------------------//
function CONTACT_ENNEMI(i,j:integer; var trouve:boolean; pcour_fa_joueur:t_ptr_Vd_joueur):boolean;
//renvoie true si le joueur est au contact d un ennemi
//appelle la fonction contact_joueur
//----------------------------------------------------------------------------//
function PRIORITE_IS_COMBAT(pcour_joueur:T_ptr_VD_Joueur):boolean;
//renvoie true si le premier element de la liste des priorites est l ennemi
function PRIORITE_IS_VIE(pcour_joueur:T_ptr_VD_joueur):boolean;
//----------------------------------------------------------------------------//

implementation

Uses U_jeu;

//----------------------------------------------------------------------------//
function GET_VITESSE(pcour_FA_joueur:T_ptr_VD_joueur):integer;
var
temp:integer;
begin
 temp := pcour_FA_joueur.pt_visuel.GETVIE;
 If pcour_FA_joueur.pt_visuel.bot=true
        then result := round(temp/20+1)
        else result := round(temp/10+1);
end;
//----------------------------------------------------------------------------//
function DEPLACEMENT_POSSIBLE(var vitesse,dist_mini,a,b,x,y:integer; var trouve : boolean; pcour_fa_joueur:t_ptr_Vd_joueur):boolean;
var
distance,i,j:integer;
direction:char;
CoordX_Elem,CoordY_Elem:integer; //Coordonnées de l'élément trouvé au contact
CoordX_joueur,CoordY_joueur:integer; //Coordonnées du joueur
begin
direction := pcour_fa_joueur^.pt_visuel.GETORIENTATION; //le caractere 'direction' prend la valeur de l orientation du joueur
dist_mini:=500;   //Distance minimale par défaut entre un joueur et un élément
//CoordX_Elem:=0;
//CoordY_Elem:=0;
CoordX_joueur:=pcour_fa_joueur.pt_visuel.GETCOLONNE*TILE_SIZE+pcour_fa_joueur.pt_visuel.GETOFFSET_X;
CoordY_joueur:=pcour_fa_joueur.pt_visuel.GETLIGNE*TILE_SIZE+pcour_fa_joueur.pt_visuel.GETOFFSET_Y;
Result:=false;
vitesse:=GET_VITESSE(pcour_fa_joueur);
//********GAUCHE********//

//si on souhaite se déplacer vers la Gauche
If Direction='L'
        then
        begin
        //On passe les 6 cases de gauche en revue
        For j:=pcour_fa_joueur^.pt_visuel.GETLIGNE-1 to pcour_fa_joueur^.pt_visuel.GETLIGNE+1 do
                For i:=pcour_fa_joueur^.pt_visuel.GETCOLONNE-2 to pcour_fa_joueur^.pt_visuel.GETCOLONNE-1 do
                        begin
                        CoordX_Elem:=900;
                        CoordY_Elem:=900;
                        distance:=500;
                        //On bloque les cas ou on sort de la matrice
                        If (i>=0) and (j>=0) and (i<MAP_WIDTH) and (j<MAP_HEIGHT)
                        then
                        begin
                        //Si la case est marchable
                        If Matrice_structure[i,j].Ptr_Terrain.GETMARCHABLE
                        then
                        begin
                        //S'il y a un artefact ou un joueur sur cette case
                        If Matrice_structure[i,j].Ptr_Artefact.GETNUMIMAGE<>'0.bmp'
                                then //il y a un artefact donc on choppe ses coordonnées
                                        begin
                                        CoordX_Elem:=Matrice_structure[i,j].Ptr_Artefact.GETCOLONNE*TILE_SIZE;
                                        CoordY_Elem:=Matrice_structure[i,j].Ptr_Artefact.GETLIGNE*TILE_SIZE;
                                        end;
                        If Matrice_structure[i,j].Ptr_Joueur<>Nil
                                then //il y a un joueur donc on choppe ses coordonnées
                                        begin
                                        CoordX_Elem:=Matrice_structure[i,j].Ptr_joueur.pt_visuel.GETCOLONNE*TILE_SIZE+Matrice_structure[i,j].Ptr_joueur.pt_visuel.GETOFFSET_X;
                                        CoordY_Elem:=Matrice_structure[i,j].Ptr_joueur.pt_visuel.GETLIGNE*TILE_SIZE+Matrice_structure[i,j].Ptr_joueur.pt_visuel.GETOFFSET_Y;
                                        end;
                        //S'il y a un élément dans la case
                        If CoordY_Elem<>900
                                then //Alors il faut tester s'il nous gêne ou pas
                                        begin
                                        //Si l'élément est sur le passage du joueur
                                        If (CoordY_Elem>CoordY_joueur-32) and (CoordY_Elem<CoordY_joueur+32)
                                                then //alors il nous gêne : on attrappe la distance entre le joueur et l'élément selon X
                                                        distance:=CoordX_joueur-(CoordX_Elem+32)
                                        end;
                        //Si on a trouve une distance entre un joueur et un élément (500 = val initiale)
                        If distance<>500
                                then //Sinon, on la compare à la distance précédemment trouvée, si c'est <
                                        if distance < dist_mini
                                                then    //C'est alors la nouvelle distance mini
                                                        begin
                                                        dist_mini:=distance;
                                                        x:=i;
                                                        y:=j;
                                                        end;
                        end;
                        end;
                        end;
        end;

//********DROITE********//

//si on souhaite se déplacer vers la DROITE
If Direction='R'
        then
        begin
        //On passe les 3 cases de droite en revue
        For j:=pcour_fa_joueur^.pt_visuel.GETLIGNE-1 to pcour_fa_joueur^.pt_visuel.GETLIGNE+1 do
                        begin
                        CoordX_Elem:=900;
                        CoordY_Elem:=900;
                        Distance:=500;
                        i:=pcour_fa_joueur^.pt_visuel.GETCOLONNE+1;
                        //On bloque les cas ou on sort de la matrice
                        If (i>=0) and (j>=0) and (i<MAP_WIDTH) and (j<MAP_HEIGHT)
                        then
                        begin
                        //Si la case est marchable
                        If Matrice_structure[i,j].Ptr_Terrain.GETMARCHABLE
                        then
                        begin
                        //S'il y a un artefact ou un joueur sur cette case
                        If Matrice_structure[i,j].Ptr_Artefact.GETNUMIMAGE<>'0.bmp'
                                then //il y a un artefact donc on choppe ses coordonnées
                                        begin
                                        CoordX_Elem:=Matrice_structure[i,j].Ptr_Artefact.GETCOLONNE*TILE_SIZE;
                                        CoordY_Elem:=Matrice_structure[i,j].Ptr_Artefact.GETLIGNE*TILE_SIZE;
                                        end;
                        If Matrice_structure[i,j].Ptr_Joueur<>Nil
                                then //il y a un joueur donc on choppe ses coordonnées
                                        begin
                                        CoordX_Elem:=Matrice_structure[i,j].Ptr_joueur.pt_visuel.GETCOLONNE*TILE_SIZE+Matrice_structure[i,j].Ptr_joueur.pt_visuel.GETOFFSET_X;
                                        CoordY_Elem:=Matrice_structure[i,j].Ptr_joueur.pt_visuel.GETLIGNE*TILE_SIZE+Matrice_structure[i,j].Ptr_joueur.pt_visuel.GETOFFSET_Y;
                                        end;
                        //S'il y a un élément dans la case
                        If CoordY_Elem<>900
                                then //Alors il faut tester s'il nous gêne ou pas
                                        begin
                                        //Si l'élément est sur le passage du joueur
                                        If (CoordY_Elem>CoordY_joueur-32) and (CoordY_Elem<CoordY_joueur+32)
                                                then //On attrappe la distance entre le joueur et l'élément selon X
                                                        distance:=CoordX_Elem-(CoordX_joueur+32);
                                        end;
                        //Si on a trouve une distance entre un joueur et un élément (500 = val initiale)
                        If distance<>500
                                then //Sinon, on la compare à la distance précédemment trouvée, si c'est <
                                                        if distance < dist_mini
                                                                then    //C'est alors la nouvelle distance mini
                                                                        begin
                                                                        dist_mini:=distance;
                                                                        x:=i;
                                                                        y:=j;
                                                                        end;
                        end;
                        end;
                        end;
        end;

//*********HAUT*********//

//si on souhaite se déplacer vers le Haut
If Direction='U'
        then
        begin
        //On passe les 6 cases du haut en revue
        For j:=pcour_fa_joueur^.pt_visuel.GETLIGNE-2 to pcour_fa_joueur^.pt_visuel.GETLIGNE-1 do
                For i:=pcour_fa_joueur^.pt_visuel.GETCOLONNE-1 to pcour_fa_joueur^.pt_visuel.GETCOLONNE+1 do
                        begin
                        CoordX_Elem:=900;
                        CoordY_Elem:=900;
                        Distance:=500;
                        //On bloque les cas ou on sort de la matrice
                        If (i>=0) and (j>=0) and (i<MAP_WIDTH) and (j<MAP_HEIGHT)
                        then
                        begin
                        //Si la case est marchable
                        If Matrice_structure[i,j].Ptr_Terrain.GETMARCHABLE
                        then
                        begin
                        //S'il y a un artefact ou un joueur sur cette case
                        If Matrice_structure[i,j].Ptr_Artefact.GETNUMIMAGE<>'0.bmp'
                                then //il y a un artefact donc on choppe ses coordonnées
                                        begin
                                        CoordX_Elem:=Matrice_structure[i,j].Ptr_Artefact.GETCOLONNE*TILE_SIZE;
                                        CoordY_Elem:=Matrice_structure[i,j].Ptr_Artefact.GETLIGNE*TILE_SIZE;
                                        end;
                        If Matrice_structure[i,j].Ptr_Joueur<>Nil
                                then //il y a un joueur donc on choppe ses coordonnées
                                        begin
                                        CoordX_Elem:=Matrice_structure[i,j].Ptr_joueur.pt_visuel.GETCOLONNE*TILE_SIZE+Matrice_structure[i,j].Ptr_joueur.pt_visuel.GETOFFSET_X;
                                        CoordY_Elem:=Matrice_structure[i,j].Ptr_joueur.pt_visuel.GETLIGNE*TILE_SIZE+Matrice_structure[i,j].Ptr_joueur.pt_visuel.GETOFFSET_Y;
                                        end;
                        //S'il y a un élément dans la case
                        If CoordY_Elem<>900
                                then //Alors il faut tester s'il nous gêne ou pas
                                        begin
                                        //Si l'élément est sur le passage du joueur
                                        If (CoordX_Elem>CoordX_joueur-32) and (CoordX_Elem<CoordX_joueur+32)
                                                then //On attrappe la distance entre le joueur et l'élément selon X
                                                        distance:=CoordY_joueur - (CoordY_Elem+32);
                                        end;
                        //Si on a trouve une distance entre un joueur et un élément (500 = val initiale)
                        If distance<>500
                                then //Sinon, on la compare à la distance précédemment trouvée, si c'est <
                                                        if distance < dist_mini
                                                                then    //C'est alors la nouvelle distance mini
                                                                        begin
                                                                        dist_mini:=distance;
                                                                        x:=i;
                                                                        y:=j;
                                                                        end;
                        end;
                        end;
                        end;
        end;

//**********BAS*********//

//si on souhaite se déplacer vers le bas
If Direction='D'
        then
        begin
        //On passe les 3 cases du bas en revue
        For i:=pcour_fa_joueur^.pt_visuel.GETCOLONNE-1 to pcour_fa_joueur^.pt_visuel.GETCOLONNE+1 do
                        begin
                        CoordX_Elem:=900;
                        CoordY_Elem:=900;
                        Distance:=500;
                        j:=pcour_fa_joueur^.pt_visuel.GETLIGNE+1;
                        //On bloque les cas ou on sort de la matrice
                        If (i>=0) and (j>=0) and (i<MAP_WIDTH) and (j<MAP_HEIGHT)
                        then
                        begin
                        //Si la case est marchable
                        If Matrice_structure[i,j].Ptr_Terrain.GETMARCHABLE
                        then
                        begin
                        //S'il y a un artefact ou un joueur sur cette case
                        If Matrice_structure[i,j].Ptr_Artefact.GETNUMIMAGE<>'0.bmp'
                                then //il y a un artefact donc on choppe ses coordonnées
                                        begin
                                        CoordX_Elem:=Matrice_structure[i,j].Ptr_Artefact.GETCOLONNE*TILE_SIZE;
                                        CoordY_Elem:=Matrice_structure[i,j].Ptr_Artefact.GETLIGNE*TILE_SIZE;
                                        end;
                        If Matrice_structure[i,j].Ptr_Joueur<>Nil
                                then //il y a un joueur donc on choppe ses coordonnées
                                        begin
                                        CoordX_Elem:=Matrice_structure[i,j].Ptr_joueur.pt_visuel.GETCOLONNE*TILE_SIZE+Matrice_structure[i,j].Ptr_joueur.pt_visuel.GETOFFSET_X;
                                        CoordY_Elem:=Matrice_structure[i,j].Ptr_joueur.pt_visuel.GETLIGNE*TILE_SIZE+Matrice_structure[i,j].Ptr_joueur.pt_visuel.GETOFFSET_Y;
                                        end;
                        //S'il y a un élément dans la case
                        If CoordY_Elem<>900
                                then //Alors il faut tester s'il nous gêne ou pas
                                        begin
                                        //Si l'élément est sur le passage du joueur
                                        If (CoordX_Elem>CoordX_joueur-32) and (CoordX_Elem<CoordX_joueur+32)
                                                then //On attrappe la distance entre le joueur et l'élément selon X
                                                        distance:=CoordY_Elem - (CoordY_joueur+32);
                                        end;
                        //Si on a trouve une distance entre un joueur et un élément (500 = val initiale)
                        If distance<>500
                                then //Sinon, on la compare à la distance précédemment trouvée, si c'est <
                                     if distance < dist_mini
                                           then    //C'est alors la nouvelle distance mini
                                                 begin
                                                 dist_mini:=distance;
                                                 x:=i;
                                                 y:=j;
                                                 end;
                        end;
                        end;
                        end;
        end;

//**********************//
//Si la distance mini a été modifiée
If (dist_mini<>500) and (dist_mini<>0)
        then
                begin
                Result:=True;
                If Dist_mini < GET_VITESSE(pcour_FA_joueur)
                        then
                        vitesse:=dist_mini
                        else
                        vitesse:=GET_VITESSE(pcour_FA_joueur);
                end;
//Si on a rien rencontré
If (dist_mini=500)
        then
                begin
                Result:=true;
                vitesse:=GET_VITESSE(pcour_FA_joueur);
                end;
//Si la distance mini de déplacement est 0 alors on est au contact d'une entité
If dist_mini=0
        then trouve:=true
        else trouve:=false;

End;
//----------------------------------------------------------------------------//
function CONTACT_JOUEUR(i,j:integer ; var x,y:integer; var trouve:boolean; pcour_fa_joueur:t_ptr_Vd_joueur):boolean;
var //determine si le joueur est en contact avec une autre entite ou element de decor
possibilite : boolean;//Variable contenant la possibilité de déplacement
//trouvé contient vrai si le joueur est au contact d'une entité
Dist:integer;
begin
  result:=false;
  possibilite := deplacement_possible(vitesse,dist,i,j,x,y,trouve,pcour_fa_joueur);//appel de la fonction determinant si le
  if (trouve = true) and (possibilite =false)//joueur peut se deplacer dans la direction voulue et si il est
  then result := true;//au contact d une entite. La conjonction de l impossibilite du joueur de se deplacer
end;                  //liée a la presence d une entite donne le contact
//----------------------------------------------------------------------------//
function CONTACT_ENNEMI(i,j:integer; var trouve:boolean;pcour_fa_joueur:t_ptr_Vd_joueur):boolean;
var  //determine s il y a contact avec ennemi revient a determiner si le joueur est en contact
contact : boolean;//puis si l entite avec laquelle il est en contact est un joueur
begin
   result:=false;
   contact := Contact_joueur(i,j,x,y,trouve,pcour_fa_joueur);//appel de la fonction determinant si le joueur est au contact
   If trouve then
        if (contact = true) and  (matrice_structure[x,y].Ptr_joueur <> nil)//si le joueur est au contact
                then result := true;//et entite touchée = joueur, alors le joueur touche un ennemi
end;
//----------------------------------------------------------------------------//
function PRIORITE_IS_COMBAT(pcour_joueur:T_ptr_VD_joueur):boolean;
begin  //on lit le nom de l entite qui occupe la premiere place dans la liste des priorites
if (pcour_joueur.pt_visuel.Liste_priorites.nom_entite ='ennemi')
 then result := true //si l ennemi est la premiere priorite alors la fonction renvoie true
 else result := false;
end;
//----------------------------------------------------------------------------//
function PRIORITE_IS_VIE(pcour_joueur:T_ptr_VD_joueur):boolean;
begin  //on lit le nom de l entite qui occupe la premiere place dans la liste des priorites
if (pcour_joueur.pt_visuel.Liste_priorites.nom_entite ='vie')
 then result := true //si la vie est la premiere priorite alors la fonction renvoie true
 else result := false;
end;
//----------------------------------------------------------------------------//

end.

