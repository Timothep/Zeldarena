unit U_fa_inaction;
//unite dans laquelle on declare la fa des entites inactives
//les enites inactives sont soit des joueurs soit des artefacts
//C est pourquoi on creera des VD a trois champs, un champ contenant
//un pointeur vers une instance de la classe TC_elt_non_permnt,
//un champ contenant l'heure de réactivation et un champ suiv


interface

uses U_crea_elt_non_permnt;

//----------------------------------------------------------------------------//
type

T_ptr_elt_inactif = ^elt_inactif;
elt_inactif = record
               heure_eveil     : integer;
               ptr_vers_entite : TC_elt_non_permnt;
               ptr_suiv        : T_ptr_elt_inactif;
               end;

var
pdeb_fa_inact,pfin_fa_inact,pcour_fa_inact : T_ptr_elt_inactif;
element_inact : TC_elt_non_permnt;
//----------------------------------------------------------------------------//
procedure AJOUT_ELEM_FA_INA(var  pdeb_fa_inact,pfin_fa_inact: T_ptr_elt_inactif; Delai:integer; element_inact : TC_elt_non_permnt);
procedure CREA_VD_INA(var pnouv_inact : T_ptr_elt_inactif);
procedure INIT_VD_INA(var pnouv_inact : T_ptr_elt_inactif; element_inact : TC_elt_non_permnt; horaire:integer);
procedure INIT_FA_INA(var pdeb_fa_inact,pfin_fa_inact,pcour_fa_inact : T_ptr_elt_inactif);
procedure AJOUT_FA_INA(var pdeb_fa_inact,pfin_fa_inact,pnouv_inact : T_ptr_elt_inactif);
procedure RETRAIT_FA_INA(var pdeb_fa_inact,pfin_fa_inact:T_ptr_elt_inactif; P_retirer:T_ptr_elt_inactif);
//----------------------------------------------------------------------------//

implementation
//----------------------------------------------------------------------------//
//Procedure d'ajout d'un élément dans la FA
//on passe les pointeurs en parametres, ainsi que l'instance de classe et le délai de réactivation
procedure AJOUT_ELEM_FA_INA(var  pdeb_fa_inact,pfin_fa_inact: T_ptr_elt_inactif; Delai:integer; element_inact : TC_elt_non_permnt);
Var
pnouv_inact:T_ptr_elt_inactif;
begin
//Création de la VD
CREA_VD_INA(pnouv_inact);
//Initialisation de la VD
INIT_VD_INA(pnouv_inact,element_inact,delai);
//Si c'est le premier élément on crée la FA
If pdeb_fa_inact=nil
        then INIT_FA_INA(pdeb_fa_inact,pfin_fa_inact,pcour_fa_inact);
//On ajoute la VD
AJOUT_FA_INA(pdeb_fa_inact,pfin_fa_inact,pnouv_inact);
end;
//----------------------------------------------------------------------------//
procedure CREA_VD_INA(var pnouv_inact : T_ptr_elt_inactif);
begin
New(pnouv_inact);
end;
//----------------------------------------------------------------------------//
procedure INIT_VD_INA(var pnouv_inact : T_ptr_elt_inactif; element_inact : TC_elt_non_permnt; horaire:integer);
begin
pnouv_inact.heure_eveil := horaire;
pnouv_inact.ptr_vers_entite := element_inact;
pnouv_inact^.ptr_suiv := nil;
end;
//----------------------------------------------------------------------------//
procedure INIT_FA_INA(var pdeb_fa_inact,pfin_fa_inact,pcour_fa_inact : T_ptr_elt_inactif);
begin
pdeb_fa_inact:=nil;
pfin_fa_inact:=nil;
pcour_fa_inact:=nil;
end;
//----------------------------------------------------------------------------//
procedure AJOUT_FA_INA(var pdeb_fa_inact,pfin_fa_inact,pnouv_inact : T_ptr_elt_inactif);
begin
 if Pdeb_fa_inact =nil
 then
        Pdeb_fa_inact := pnouv_inact
 else
        Pfin_fa_inact^.ptr_suiv := pnouv_inact;
 Pfin_fa_inact := pnouv_inact;
end;
//----------------------------------------------------------------------------//
procedure RETRAIT_FA_INA(var pdeb_fa_inact,pfin_fa_inact:T_ptr_elt_inactif; P_retirer:T_ptr_elt_inactif);
var
pprec, pcour, Paux: T_ptr_elt_inactif;
begin
//initialisations
pprec:=pdeb_fa_inact;
pcour:=pdeb_fa_inact;
//Si la FA n'est pas vide
  if pdeb_fa_inact <> nil
   then //alors on peut la parcourir
     //si l'élément a enlever est le premier élément
     if pdeb_fa_inact=P_retirer
       then //alors on chaine au suivant
         begin
         paux:=pdeb_fa_inact;
         pdeb_fa_inact:=pdeb_fa_inact^.ptr_suiv;
         Dispose(Paux);
         end
       else //sinon il faut rechercher le pointeur
         begin
         //Tant qu'on a pas trouvé la VD
         while pcour<>p_retirer do
                Begin //on boucle
                pprec:=pcour;
                pcour:=pcour^.ptr_suiv;
                end;
         //On supprime le chainage
         If pcour^.ptr_suiv<>nil
                then //ce n'est pas le dernier élément
                        pprec^.ptr_suiv:=pcour^.ptr_suiv
                else //c'est le dernier élément
                        begin
                        pprec^.ptr_suiv:=nil;
                        pfin_fa_inact:=pprec;
                        end;
         end;
end;
//----------------------------------------------------------------------------//
end.
