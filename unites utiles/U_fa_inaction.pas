unit U_fa_inaction;
//unite dans laquelle on declare la fa des entites inactives
//les enites inactives sont soit des joueurs soit des artefacts
//C est pourquoi on creera des VD a trois champs, un champ contenant
//un pointeur vers une instance de la classe TC_elt_non_permnt,
//un champ contenant l'heure de réactivation et un champ suiv


interface


//----------------------------------------------------------------------------//
type

T_ptr_elt_inactif = ^.elt_inactif;
elt_inactif = record
               heure_eveil     : integer;
               ptr_vers_entite : TC_elt_non_permnt;
               ptr_suiv        : T_ptr_elt_inactif;
               end;

var
pdeb_fa_inact,pfin_fa_inact,pcour_fa_inact : T_ptr_elt_inactif;
element_inact : TC_elt_non_permnt;
//----------------------------------------------------------------------------//
procedure CREA_VD_INA(var pnouv_inact : T_ptr_elt_inactif);
procedure INIT_VD_INA(var pnouv_inact : T_ptr_elt_inactif; element_inact : TC_elt_non_permnt; horaire:integer);
procedure INIT_FA_INA(var pdeb_fa_inact,pfin_fa_inact,pcour_fa_inact : T_ptr_elt_inactif);
procedure AJOUT_FA_INA(var pdeb_fa_inact,pfin_fa_inact,pnouv_inact : T_ptr_elt_inactif);
procedure RETRAIT_FA_INA(var pdeb_fa_inact:T_ptr_elt_inactif);
//----------------------------------------------------------------------------//

implementation


//----------------------------------------------------------------------------//
procedure CREA_VD_INA(var pnouv_inact : T_ptr_elt_inactif);
begin
New(pnouv_inact);
end;
//----------------------------------------------------------------------------//
procedure INIT_VD_INA(var pnouv_inact : T_ptr_elt_inactif; element_inact : TC_elt_non_permnt; horaire;integer);
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
        Pfin_fa_inact^.ptr_psuiv := pnouv_inact;
 Pfin_fa_inact := pnouv_inact;
end;
//----------------------------------------------------------------------------//
procedure RETRAIT_FA_INA(var pdeb_fa_inact:T_ptr_elt_inactif);
var
paux : T_ptr_elt_inactif;
begin
  if pdeb_fa_inact <> nil
   then
   paux := pdeb_fa_inact^.ptr_suiv;
   dispose(pdeb_fa_inact);
   pdeb_fa_inact:= paux;
end;
//----------------------------------------------------------------------------//
end.
