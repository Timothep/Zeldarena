//Boussoumah
unit U_fa_joueur;

interface

uses U_crea_joueur;
//----------------------------------------------------------------------------//
type
T_ptr_VD_Joueur = ^VD_Joueur ;
nx_joueur = TC_joueur;

VD_Joueur = record
           pt_visuel : TC_joueur;
           psuiv : T_ptr_VD_Joueur;
          end;
pcou_FA_joueur,pdeb_FA_joueur,pfin_FA_joueur = T_ptr_VD_joueur;

//----------------------------------------------------------------------------//
procedure INIT_FA_JOUEUR(var Pdeb_FA_Joueur :T_ptr_VD_Joueur; var Pfin_FA_Joueur : T_ptr_VD_Joueur; var Pcour_fa_joueur : T_ptr_VD_joueur);overload;
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
pnouv.pt_visuel := nx_joueur;
pnouv^.psuiv:=nil
end;
//----------------------------------------------------------------------------//
procedure INIT_FA_JOUEUR(var Pdeb_FA_Joueur :T_ptr_VD_Joueur; var Pfin_FA_Joueur : T_ptr_VD_Joueur; var Pcour_fa_joueur : T_ptr_VD_joueur);
begin
Pdeb_FA_Joueur := nil;
Pcou_FA_joueur := nil;
Pfin_FA_Joueur := nil;
end;
//----------------------------------------------------------------------------//
procedure AJOUT_JOUEUR(var Pdeb_FA_Joueur,Pfin_FA_Joueur : T_ptr_VD_Joueur; pnouv :T_ptr_VD_Joueur);
begin
 if Pdeb_FA_Joueur =nil
 then
        Pdeb_FA_Joueur := pnouv
 else
        Pfin_FA_Joueur^.psuiv := pnouv;
 Pfin_FA_Joueur := pnouv;
end;
//----------------------------------------------------------------------------//
end.
