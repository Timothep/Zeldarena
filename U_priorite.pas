{JEU ZELDARENA - SAND
JOACHIM BOUSSOUMAH      GPBb
TIMOTHEE BOURGUIGNON    GPAa
EPF2}
unit U_priorite;
//unite dans laquelle on declare la liste des priorites ainsi que les algorithmes relatifs

interface
Uses U_Types, U_crea_joueur;
//----------------------------------------------------------------------------//

var
pdebl_prio,pcour_prio:T_ptr_prio;
//----------------------------------------------------------------------------//
procedure INIT_VD_PRIO(var pnouv_prio:T_ptr_prio;coordx,coordy:integer;nom_entite:string);
procedure INIT_LIST_PRIO(var pdebl_prio : T_ptr_prio);
{procedure AJOUT_LIST_PRIO(var pcour_prio,pnouv_prio : T_ptr_prio);
procedure AJOUT_DEBUT_PRIO(var pdebl_prio, pnouv_prio:T_ptr_prio);
procedure AJOUT_FIN_PRIO(var pcour_prio, pnouv_prio:T_ptr_prio);
procedure RETRAIT_PRIO(var pcour_prio:T_ptr_prio);
procedure RETRAIT_DEBUT_PRIO(var pdebl_prio,pcour_prio:T_ptr_prio);
procedure RETRAIT_FIN_PRIO(var pcour_prio:T_ptr_prio);   }
procedure MOV_FOND(pdebl_prio:T_ptr_prio; nom_bonus:string;pcour_joueur:t_ptr_vd_joueur);
procedure MOV_FRONT(priorite:string ;pcour_joueur:t_ptr_vd_joueur);
//procedure INSER_PRIO_FOND(var pcour_prio,pdebl_prio:T_ptr_prio);
function ANALYSE_BESOIN(pcour_fa_joueur:T_ptr_VD_joueur):string;
procedure AJOUT_PRIO(var pdebl_prio,pnouv_prio:T_ptr_prio);
procedure INIT_FA_PRIORITES(var pdebl_prio: T_ptr_prio);
//----------------------------------------------------------------------------//
implementation

//----------------------------------------------------------------------------//
procedure INIT_VD_PRIO(var pnouv_prio:T_ptr_prio;coordx,coordy:integer;nom_entite:string);
begin
New(pnouv_prio);
pnouv_prio^.psuiv_prio:=nil;
pnouv_prio.coordonnees_x:=coordx;
pnouv_prio.coordonnees_y:=coordy;
pnouv_prio.nom_entite:=nom_entite;
end;
//----------------------------------------------------------------------------//
procedure INIT_LIST_prio(var pdebl_prio : T_ptr_prio);
begin
pdebl_prio:=nil;
end;
//----------------------------------------------------------------------------//
{procedure AJOUT_LIST_prio(var pcour_prio,pnouv_prio : T_ptr_prio);
var
paux : T_ptr_prio;
begin
   paux := pcour_prio^.psuiv_prio;
   pcour_prio^.psuiv_prio := pnouv_prio;
   pnouv_prio^.psuiv_prio := paux;
end;
//----------------------------------------------------------------------------//
procedure AJOUT_debut_prio(var pdebl_prio, pnouv_prio:T_ptr_prio);
begin
pnouv_prio^.psuiv_prio := pdebl_prio;
pdebl_prio := pnouv_prio;
end;
//----------------------------------------------------------------------------//
procedure AJOUT_fin_prio(var pcour_prio, pnouv_prio:T_ptr_prio);
begin
pcour_prio^.psuiv_prio := pnouv_prio;
end;
//----------------------------------------------------------------------------//
procedure RETRAIT_prio(var pcour_prio:T_ptr_prio);
var
paux:T_ptr_prio;
begin
paux := pcour_prio^.psuiv_prio;
pcour_prio^.psuiv_prio:=paux^.psuiv_prio;
dispose(paux);
end;
//----------------------------------------------------------------------------//
procedure RETRAIT_debut_prio(var pdebl_prio,pcour_prio:T_ptr_prio);
begin
pcour_prio:=pdebl_prio;
pdebl_prio:=pdebl_prio^.psuiv_prio;
dispose(pcour_prio);
end;
//----------------------------------------------------------------------------//
procedure RETRAIT_fin_prio(var pcour_prio:T_ptr_prio);
var
paux : T_ptr_prio;
begin
paux := pcour_prio^.psuiv_prio;
pcour_prio^.psuiv_prio := nil;
dispose(paux);
end;
//----------------------------------------------------------------------------//
procedure INSER_PRIO_FOND(var pcour_prio,pdebl_prio:T_ptr_prio);
var
paux:T_ptr_prio;
begin
 pcour_prio:=pdebl_prio;
 while pcour_prio^.psuiv_prio <>nil do
  begin
   pcour_prio:=pcour_prio^.psuiv_prio;
  end;
 paux:=pcour_prio;
 pcour_prio:=pdebl_prio;
 while pcour_prio^.psuiv_prio <> paux do
  begin
   pcour_prio:=pcour_prio^.psuiv_prio;
  end;
end; }
//----------------------------------------------------------------------------//
procedure MOV_FOND(pdebl_prio:T_ptr_prio; nom_bonus:string;pcour_joueur:t_ptr_vd_joueur);
var
pcour,pcour2,pprec,pprec2,paux:T_ptr_prio;
trouve:boolean;
begin
//pour le bouger en avant dernier:
pcour:=pcour_joueur.pt_visuel.Liste_priorites;  //pointeur qui est destiné a retenir la position de l'élément a déplacer
trouve:=false;      //variable bouléenne nécessaire a la recherche
pprec:=pcour_joueur.pt_visuel.Liste_priorites;  //pointeur qui est destiné a retenir la position de l'élément a déplacer pour casser les liens
        {
//TEST//
Paux:=pcour_joueur.pt_visuel.Liste_priorites;
While Paux<>nil do
paux:=paux.psuiv_prio;
//TEST//}

//On le recherche
While (pcour<>Nil) and (not trouve) do
        If pcour^.nom_entite=nom_bonus
                then trouve:=true
                else
                        begin
                        pprec:=pcour;
                        pcour:=pcour^.psuiv_prio;
                        end;
//On met ses coordonnées à (-1,-1)
pcour.coordonnees_x:=-1;
pcour.coordonnees_y:=-1;
//Si c'est le premier élément
If pcour=pcour_joueur.pt_visuel.Liste_priorites
        then //alors on coupe pcour
                begin
                pcour_joueur.pt_visuel.Liste_priorites:=pcour.psuiv_prio;
                pcour.psuiv_prio:=nil;
                end
        else
                begin
                //On coupe pcour (on chaine le précedent au suivant)
                pprec.psuiv_prio:=pcour.psuiv_prio;
                pcour.psuiv_prio:=nil;
                end;

pcour2:=pcour_joueur.pt_visuel.Liste_priorites; //pointeur qui est destiné a retenir la position d'insertion pour le chainage
pprec2:=pcour_joueur.pt_visuel.Liste_priorites; //pointeur qui est destiné a retenir la position d'insertion pour le chainage
//On recherche l'avant dernière place
While (pcour2.psuiv_prio<>Nil) do
        begin //on garde l'ancienne position et on passe à la suivante
        pprec2:=pcour2;
        pcour2:=pcour2^.psuiv_prio;
        end;
        //Insertion
pcour^.psuiv_prio:=pcour2;
pprec2^.psuiv_prio:=pcour;

//TEST//{
Paux:=pcour_joueur.pt_visuel.Liste_priorites;
While Paux<>nil do
paux:=paux.psuiv_prio;
//TEST//}
end;
//----------------------------------------------------------------------------//
procedure MOV_FRONT(priorite:string ;pcour_joueur:t_ptr_vd_joueur);
//deplacement de la variable dynamique en premier
var
paux,pcour,pprec:T_ptr_prio;
trouve:boolean;
begin
trouve:=false;
//Si la string <>''
If priorite<>'' then
        begin
        //Recherche la string passée en paramètre
        Paux:=pcour_joueur.pt_visuel.Liste_priorites;
        pprec:=paux;
        While (paux<>nil) and (not trouve) do
                if priorite=Paux.nom_entite
                        then trouve:=true
                        else
                                begin
                                pprec:=paux;
                                Paux:=Paux.psuiv_prio;
                                end;
        //On l'extrait
        If (trouve=true) and (pcour_joueur.pt_visuel.Liste_priorites.nom_entite<>priorite) then
                begin
                pprec.psuiv_prio:=paux.psuiv_prio;
                pcour:=pcour_joueur.pt_visuel.Liste_priorites;
                //On la place en avant
                pcour_joueur.pt_visuel.Liste_priorites:=paux;
                paux.psuiv_prio:=pcour;
                end;
        end;
        
{  AVANT MODIFS BETA 7
//pour le bouger en avant dernier:
pcour:=pdebl_prio;  //pointeur qui est destiné à retenir la position de l'élément à déplacer
trouve:=false;      //variable bouléenne nécessaire à la recherche
pprec:=pdebl_prio;  //pointeur qui est destiné à retenir la position de l'élément à déplacer pour casser les liens
//On le recherche
While (pcour<>Nil) and (not trouve) do
        If pcour^.nom_entite=nom_cherche
                then trouve:=true
                else
                        begin
                        pprec:=pcour;
                        pcour:=pcour^.psuiv_prio;
                        end;
//Chainage dans le bon sens
Pprec^.psuiv_prio:=pcour^.psuiv_prio;
Pcour^.psuiv_prio:=Pdebl_prio;
pdebl_prio:=pcour;    }
end;
//----------------------------------------------------------------------------//

//Module analysant les besoins d'un joueur
function ANALYSE_BESOIN(pcour_fa_joueur:T_ptr_VD_joueur):string;
begin
result:='';
//Si la vie du Bot est inférieure a la vie mini
if pcour_fa_joueur^.pt_visuel.GETVIE < MIN_VIE
 then //Alors il va en urgence se rechercher de la vie
        result := 'vie'
 else //Sinon
   Begin
   //Si son bonus d'attaques est inférieur au bonus d'armure
     if pcour_fa_joueur^.pt_visuel.GETBONUS_ATTAQUE < pcour_fa_joueur^.pt_visuel.GETBONUS_ARMURE
     then //alors il va chercher de l'attaque
        result := 'attaque';
     //Si son bonus d'armure est inférieur au bonus d'attaques
     if pcour_fa_joueur^.pt_visuel.GETBONUS_ARMURE < pcour_fa_joueur^.pt_visuel.GETBONUS_ATTAQUE
     then //alors il va chercher de l'armure
        result := 'armure';
     //S'il a autant d'attaque que d'armure
     if pcour_fa_joueur^.pt_visuel.GETBONUS_ARMURE = pcour_fa_joueur^.pt_visuel.GETBONUS_ATTAQUE
     then //alors il cherche a se battre
        result := 'ennemi';
   end;
end;
//----------------------------------------------------------------------------//
procedure INIT_FA_PRIORITES(var pdebl_prio: T_ptr_prio);
var
pnouv_prio : T_ptr_prio;
begin
//Initialisation de la première VD de la liste des priorités
INIT_VD_PRIO(pnouv_prio,-1,-1,'arme');
//Ajout de cette VD dans la liste
AJOUT_PRIO(pdebl_prio,pnouv_prio);
INIT_VD_PRIO(pnouv_prio,-1,-1,'armure');
AJOUT_PRIO(pdebl_prio,pnouv_prio);
INIT_VD_PRIO(pnouv_prio,-1,-1,'ennemi');
AJOUT_PRIO(pdebl_prio,pnouv_prio);
INIT_VD_PRIO(pnouv_prio,-1,-1,'vie');
AJOUT_PRIO(pdebl_prio,pnouv_prio);
INIT_VD_PRIO(pnouv_prio,-1,-1,'xp');
AJOUT_PRIO(pdebl_prio,pnouv_prio);
INIT_VD_PRIO(pnouv_prio,-1,-1,'wp');
AJOUT_PRIO(pdebl_prio,pnouv_prio);
end;
//----------------------------------------------------------------------------//

//Module d'ajout d'une VD dans la FA des priorités
procedure AJOUT_PRIO(var pdebl_prio,pnouv_prio:T_ptr_prio);
var
paux : T_ptr_prio;
begin
//Si la FA est vide
if pdebl_prio = nil
        then //Alors on ajoute en tête
        pdebl_prio := pnouv_prio
        else //Sinon, il faut parcourir la liste
                begin
                //Init de Paux
                paux := pdebl_prio;
                //Tant qu'on est pas arrivé à la fin de la FA
                while paux^.psuiv_prio <> nil do
                        //On boucle
                        paux := paux^.psuiv_prio;
                //On chaine en fin
                paux^.psuiv_prio := pnouv_prio;
                end;
end;
//----------------------------------------------------------------------------//
end.
