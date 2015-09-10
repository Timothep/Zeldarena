{JEU ZELDARENA - SAND
JOACHIM BOUSSOUMAH      GPBb
TIMOTHEE BOURGUIGNON    GPAa
EPF2}
{Unité de création de la File d'attente des joueurs
---la file d'attente qui contient les 4 joueurs chainés/bouclés---}
unit U_fa_joueur;

interface

uses U_crea_joueur, U_types;
//----------------------------------------------------------------------------//

var
autrelement, n , y : string;
autre_elt :boolean;
//----------------------------------------------------------------------------//
procedure INIT_FA_JOUEUR(var Pdeb_FA_Joueur :T_ptr_VD_Joueur; var Pfin_FA_Joueur : T_ptr_VD_Joueur);overload;
procedure AJOUT_JOUEUR(var Pdeb_FA_Joueur,Pfin_FA_Joueur : T_ptr_VD_Joueur; pnouv :T_ptr_VD_Joueur);
procedure CREA_VD_JOUEUR(var pnouv:T_ptr_VD_Joueur);
procedure INIT_VD_JOUEUR(var pnouv : T_ptr_VD_Joueur; nx_joueur : TC_joueur);
//----------------------------------------------------------------------------//

implementation

//----------------------------------------------------------------------------//
procedure CREA_VD_JOUEUR(var pnouv:T_ptr_VD_Joueur);
begin
New (pnouv);
end;
//----------------------------------------------------------------------------//
procedure INIT_VD_JOUEUR(var pnouv : T_ptr_VD_Joueur; nx_joueur : TC_joueur);
begin
pnouv.pt_visuel:=nx_joueur;
pnouv^.psuiv:=nil
end;
//----------------------------------------------------------------------------//
procedure INIT_FA_JOUEUR(var Pdeb_FA_Joueur :T_ptr_VD_Joueur; var Pfin_FA_Joueur : T_ptr_VD_Joueur);
begin
Pdeb_FA_Joueur := nil;
Pfin_FA_Joueur := nil;
end;
//----------------------------------------------------------------------------//
//Ajout d'une nouvelle VD en fin de File d'attente
procedure AJOUT_JOUEUR(var Pdeb_FA_Joueur,Pfin_FA_Joueur : T_ptr_VD_Joueur; pnouv :T_ptr_VD_Joueur);
begin
//Si la FA est vide
 if Pdeb_FA_Joueur =nil
        then //alors on ajoute en tête
                Pdeb_FA_Joueur := pnouv
        else //sinon on ajoute en fin
                Pfin_FA_Joueur^.psuiv := pnouv;
 //Mise a jour du pointeur Pfin_Fa_Joueur
 Pfin_FA_Joueur := pnouv;
 // Bouclage du cycle
 Pfin_Fa_Joueur^.psuiv:=Pdeb_Fa_Joueur;
end;
//----------------------------------------------------------------------------//
end.
