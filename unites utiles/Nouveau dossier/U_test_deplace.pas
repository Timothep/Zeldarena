unit U_test_deplace;
//unite dans laquelle on declare les modules de test du deplacement
//et les modules de contact

interface

uses U_fa_joueur, U_types{,U_Chemin};

const
tile_size=32;

var
vitesse : integer;
trouve : boolean;
i,j,y,x : integer;
//----------------------------------------------------------------------------//
function GET_VITESSE(pcour_FA_joueur:T_ptr_VD_joueur):integer;
//fonction renvoyant un integer correspondant au nombre de pixels dont le joueur
//se deplacera s il envisage le deplacement
//----------------------------------------------------------------------------//
function DEPLACEMENT_POSSIBLE(var vitesse,a,b,x,y:integer;var trouve : boolean; pcour_fa_joueur:t_ptr_Vd_joueur):boolean;
//function renvoyant vrais si le deplacement est possible
//et la vitesse, car celle ci va s adapter a la distance a parcourir
//appelle la fonction GET_Distance
//----------------------------------------------------------------------------//
function GET_DISTANCE(i,j:integer;direction:char;pcour_FA_joueur:T_ptr_VD_joueur):integer;
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
//----------------------------------------------------------------------------//

implementation

Uses U_jeu;

//----------------------------------------------------------------------------//
function GET_VITESSE(pcour_FA_joueur:T_ptr_VD_joueur):integer;
var
temp:integer;
begin
 temp := pcour_FA_joueur.pt_visuel.GETVIE;
 result := round(temp/20);
end;
//----------------------------------------------------------------------------//
function GET_DISTANCE(i,j:integer;direction:char; pcour_FA_joueur:T_ptr_VD_joueur):integer;
var
x1,x2,y1,y2:integer;
begin
x1 := tile_size*pcour_fa_joueur^.pt_visuel.GETCOLONNE + pcour_fa_joueur^.pt_visuel.GETOFFSET_X;//abscisse absolue du joueur
y1 := tile_size*pcour_fa_joueur^.pt_visuel.GETLIGNE +  pcour_fa_joueur^.pt_visuel.GETOFFSET_Y;//ordonnee absolue du joueur
if Matrice_structure[i,j].Ptr_joueur<>nil//si l entite reperee est un joueur
 then                                   //alors on prend en compte ses offsets
  begin    //l entite est un joueur , on ajoute alors ses offsets a ses coordonnées
   x2 := tile_size*j +  Matrice_structure[i,j].Ptr_joueur.pt_visuel.GETOFFSET_X;//abscisse absolue de l entite
   y2 := tile_size*i +  Matrice_structure[i,j].Ptr_joueur.pt_visuel.GETOFFSET_Y;//ordonnee absolue de l entite
  end
 else
  begin
   x2 := tile_size*j;
   y2 := tile_size*i;
  end;
if direction ='l'
then result:= x1 - (x2+tile_size);
if direction ='r'                  //Calculs servant a determiner la largeur de l interstice 
then result:= x2 - (x1+tile_size);//entre les joueurs dans chacune des orientations
if direction ='u'
then result:= y1 - (y2+tile_size);
if direction ='d'
then result:= y2 - (y1+tile_size);
end;
//----------------------------------------------------------------------------//
function DEPLACEMENT_POSSIBLE(var vitesse,a,b,x,y:integer;var trouve : boolean; pcour_fa_joueur:t_ptr_Vd_joueur):boolean;
var
distance,i,j : integer;
direction : char;
begin
direction := pcour_fa_joueur^.pt_visuel.GETORIENTATION; //le caractere 'direction' prend la valeur de l orientation du joueur
distance := tile_size;//
if direction = 'L'
then //le joueur regarde vers la gauche
  begin//on examine les trois cases a sa gauche
    j := pcour_fa_joueur^.pt_visuel.GETCOLONNE-1; //la colonne examinée est celle situee a sa gauche, donc au rang -1
    for i:=(pcour_fa_joueur^.pt_visuel.GETLIGNE-1) to  pcour_fa_joueur^.pt_visuel.GETLIGNE+1 do
      begin//on parcourt les trois cases de la colonne de gauche qui sont autour de sa position
        if (Matrice_structure[i,j].Ptr_terrain.GETMARCHABLE = false) or (Matrice_structure[i,j].Ptr_joueur <> nil) or ((Matrice_structure[i,j].Ptr_artefact <> nil) and (Matrice_structure[i,j].Ptr_artefact.GETNOM<>'0'))
        then//Si la case est occupee soit par un element non marchable, soit par un joueur, soit par un artefact, alors il y a potentiellement contact
         begin
           trouve := true;//on a effectivement trouve qqchose autour du joueur
           if distance >= GET_DISTANCE(i,j,direction,pcour_fa_joueur)//on calcul la distance entre le joueur et l entite en presence
           then   //si l entite examinée est plus proche que la precedente alors c est elle que l on retient...
            begin
              distance := GET_DISTANCE(i,j,direction,pcour_fa_joueur);//...et c est la distance avec elle qui devient la nouvelle reference
              x:=j;//on retient la position de l objet trouve pour pouvoir
              y:=i;//atteindre sa structure plus tard
            end;
         end;
      end;
  end;

if direction = 'U'
then //le joueur regarde en haut
  begin//on examine les trois cases au dessus de lui
    i := pcour_fa_joueur^.pt_visuel.GETLIGNE-1;
    for j:= pcour_fa_joueur^.pt_visuel.GETCOLONNE-1 to  pcour_fa_joueur^.pt_visuel.GETCOLONNE+1 do
      begin
        if (Matrice_structure[i,j].Ptr_terrain.GETMARCHABLE = false) or (Matrice_structure[i,j].Ptr_joueur <> nil) or ((Matrice_structure[i,j].Ptr_artefact <> nil) and (Matrice_structure[i,j].Ptr_artefact.GETNOM<>'0'))
        then
         begin
           trouve := true;//on a effectivement trouve qqchose autour du joueur
           if distance >= GET_Distance(i,j,direction,pcour_fa_joueur)//on calcul la distance entre le joueur et l entite en presence
           then   //si l entite examinée est plus proche que la precedente alors c est elle que l on retient...
            begin
              distance := GET_Distance(i,j,direction,pcour_fa_joueur);//...et c est la distance avec elle qui devient la nouvelle reference
              x:=j;//on retient la position de l objet trouve pour pouvoir
              y:=i;//atteindre sa structure plus tard
            end;
         end;
      end;
  end;

if direction = 'R'
then //le joueur regarde vers la droite
  begin    //on examine les trois cases a se droite
    j := pcour_fa_joueur^.pt_visuel.GETCOLONNE+1;
    for i:= pcour_fa_joueur^.pt_visuel.GETLIGNE-1 to  pcour_fa_joueur^.pt_visuel.GETLIGNE+1 do
      begin
        if (Matrice_structure[i,j].Ptr_terrain.GETMARCHABLE = false) or (Matrice_structure[i,j].Ptr_joueur <> nil) or ((Matrice_structure[i,j].Ptr_artefact <> nil) and (Matrice_structure[i,j].Ptr_artefact.GETNOM<>'0'))
        then
           begin
           trouve := true;//on a effectivement trouve qqchose autour du joueur
           if distance >= GET_Distance(i,j,direction,pcour_fa_joueur)//on calcul la distance entre le joueur et l entite en presence
           then   //si l entite examinée est plus proche que la precedente alors c est elle que l on retient...
              begin
              distance := GET_Distance(i,j,direction,pcour_fa_joueur);//...et c est la distance avec elle qui devient la nouvelle reference
              x:=j;//on retient la position de l objet trouve pour pouvoir
              y:=i;//atteindre sa structure plus tard
              end;
           end;
      end;
  end;

if direction = 'D'
then //le joueur regarde en bas
  begin    //on examine les trois cases au dessous de lui
    i := pcour_fa_joueur^.pt_visuel.GETLIGNE+1;
    for j:= pcour_fa_joueur^.pt_visuel.GETCOLONNE-1 to  pcour_fa_joueur^.pt_visuel.GETCOLONNE+1 do
      begin
        if (Matrice_structure[i,j].Ptr_terrain.GETMARCHABLE = false) or (Matrice_structure[i,j].Ptr_joueur <> nil) or ((Matrice_structure[i,j].Ptr_artefact <> nil) and (Matrice_structure[i,j].Ptr_artefact.GETNOM<>'0'))
        then
         begin
           trouve := true;//on a effectivement trouve qqchose autour du joueur
           if distance >= GET_Distance(i,j,direction,pcour_fa_joueur)//on calcul la distance entre le joueur et l entite en presence
           then   //si l entite examinée est plus proche que la precedente alors c est elle que l on retient...
            begin
              distance := GET_Distance(i,j,direction,pcour_fa_joueur);//...et c est la distance avec elle qui devient la nouvelle reference
              x:=j;//on retient la position de l objet trouve pour pouvoir
              y:=i;//atteindre sa structure plus tard
            end;
         end;
      end;
  end;

if trouve = true
then
 begin
   vitesse := GET_Vitesse(pcour_FA_joueur);
   if distance > 0
   then
    begin
      if distance < GET_Vitesse(pcour_FA_joueur)
      then vitesse := distance;
      result := true;
    end
   else result := false;
 end
else
        begin
        result := true;
        vitesse:=Round(Pcour_FA_joueur.pt_visuel.GETVIE/20);
        end;
end;
//----------------------------------------------------------------------------//
function CONTACT_JOUEUR(i,j:integer ; var x,y:integer; var trouve:boolean; pcour_fa_joueur:t_ptr_Vd_joueur):boolean;
var //determine si le joueur est en contact avec une autre entite ou element de decor
possibilite : boolean;//on voit si il y a qqchose autour du joueur , puis si le joueur touche ce qqchose
begin
  possibilite := deplacement_possible(vitesse,i,j,x,y,trouve,pcour_fa_joueur);//appel de la fonction determinant si le
  if trouve = true and possibilite =false//joueur peut se deplacer dans la direction voulue et si il est
  then result := true;//au contact d une entite. La conjonction de l impossibilite du joueur de se deplacer
end;                  //liée a la presence d une entite donne le contact
//----------------------------------------------------------------------------//
function CONTACT_ENNEMI(i,j:integer; var trouve:boolean; pcour_fa_joueur:t_ptr_Vd_joueur):boolean;
var  //determine s il y a contact avec ennemi revient a determiner si le joueur est en contact
contact : boolean;//puis si l entite avec laquelle il est en contact est un joueur
begin
   contact := Contact_joueur(i,j,x,y,trouve,pcour_fa_joueur);//appel de la fonction determinant si le joueur est au contact
   if (contact = true) and  (matrice_structure[y,x].Ptr_joueur <> nil)//si le joueur est au contact
   then result := true;//et entite touchée = joueur, alors le joueur touche un ennemi
end;
//----------------------------------------------------------------------------//
function PRIORITE_IS_COMBAT(pcour_joueur:T_ptr_VD_joueur):boolean;
begin  //on lit le nom de l entite qui occupe la premiere place dans la liste des priorites
 //if (pcour_joueur.pt_visuel.GETCHEMIN.nom_entite = 'ennemi' )
 //then result := true;   //si l ennemi est la premiere priorite alors la fonction renvoie true
end;
//----------------------------------------------------------------------------//
end.

