{JEU ZELDARENA - SAND
JOACHIM BOUSSOUMAH      GPBb
TIMOTHEE BOURGUIGNON    GPAa
EPF2}
unit U_tile_to_load;
//unite dans laquelle on declare la liste des images a afficher
//En plus précis, c'est la liste des éléments en attente d'affichage
//Les animations (3 frames par exemple pour un coup d'épée) nécessitent...
//...d'être affichées à 20 ms de décallage (exemple) d'ou un ajout dans cette FA...
//...qui sert de tampon d'impression
interface
uses Graphics;
//----------------------------------------------------------------------------//
type
T_ptr_toload=^tile_toload;

tile_toload=record
                pos_x:integer;
                pos_y:integer;
                h_eveil:integer;
                h_mort:integer;
                image:TBitmap;
                psuiv_toload:T_ptr_toload;
                end;
var
pdebl_toload,pcour_toload:T_ptr_toload;

//----------------------------------------------------------------------------//
procedure INIT_VD_TOLOAD(var pnouv_toload:T_ptr_toload;coordx,coordy,eveil,mort:integer;tile:TBitmap);
procedure INIT_LIST_TOLOAD(var pdebl_toload,pcour_toload : T_ptr_toload);
Procedure AJOUT_ELEM_STR_AFFICHAGE(var pdebl_toload:T_ptr_toload; var pcour_toload:T_ptr_toload; Coordx,CoordY:integer; eveil,mort:integer; Tile:Tbitmap);
Procedure RERTAIT_ELEM_STR_AFFICHAGE(var pdebl_toload:T_ptr_toload; pcour_toload:T_ptr_toload; P_a_retirer:T_ptr_toload);
//----------------------------------------------------------------------------//
implementation
//----------------------------------------------------------------------------//
//Module de retrait d'un element de la liste
Procedure RERTAIT_ELEM_STR_AFFICHAGE(var pdebl_toload:T_ptr_toload; pcour_toload:T_ptr_toload; P_a_retirer:T_ptr_toload);
var
pprec:T_ptr_toload;
trouve:boolean;
begin
trouve:=false;
pcour_toload:=pdebl_toload;
pprec:=pdebl_toload;
//Si c'est le premier élément
If pdebl_toload=P_a_retirer
        then    //on fait le chainage du pdeb
                pdebl_toload:=P_a_retirer^.psuiv_toload
        else    //sinon, on le cherche dans la structure
        While not trouve do
                begin
                if pcour_toload=P_a_retirer
                        then //on a trouve la bestiole à enlever
                                trouve:=true
                        else //c'est pas celle la
                                begin
                                pprec:=pcour_toload;
                                pcour_toload:=pcour_toload^.psuiv_toload;
                                end;
                If trouve then pprec^.psuiv_toload:=pcour_toload^.psuiv_toload;
                end;
end;
//----------------------------------------------------------------------------//
//Module d'ajout d'un élément dans la liste d'affichage des images
Procedure AJOUT_ELEM_STR_AFFICHAGE(var pdebl_toload:T_ptr_toload; var pcour_toload:T_ptr_toload; Coordx,CoordY:integer; eveil,mort:integer; Tile:Tbitmap);
var
Pnouv,pcour,pprec:T_ptr_toload;
trouve:boolean;
Begin
trouve:=false;
//Création de la nouvelle VD
INIT_VD_TOLOAD(pnouv,coordx,coordy,eveil,mort,tile);
//Si la structure est vide alors initialisation et ajout en tête
If pdebl_toload=nil
        then
                begin
                INIT_LIST_TOLOAD(pdebl_toload,pcour_toload);
                Pdebl_toload:=pnouv;
                Pcour_toload:=pnouv;
                end
        else //Sinon, on ajoute en fin
                begin
                pcour:=Pdebl_toload;
                pprec:=Pdebl_toload;
                //Tant que point d'insertion non trouvé
                While Pcour<>Nil do
                        begin
                        pprec:=pcour;
                        pcour:=pcour^.psuiv_toload;
                        end;
                //Chainage en fin de structure
                pprec^.psuiv_toload:=pnouv;
                end;
end;
//----------------------------------------------------------------------------//
//Crée une VD et la remplit comme se doit
procedure INIT_VD_TOLOAD(var pnouv_toload:T_ptr_toload;coordx,coordy,eveil,mort:integer;tile:TBitmap);
begin
New(pnouv_toload);
pnouv_toload.pos_x:=coordx;
pnouv_toload.pos_y:=coordy;
pnouv_toload.h_eveil:=eveil;
pnouv_toload.h_mort:=mort;
pnouv_toload.image:=Tbitmap.Create;
pnouv_toload.image:=tile;
pnouv_toload^.psuiv_toload:=nil;
end;
//----------------------------------------------------------------------------//
//Crée la liste mais elle est vide
procedure INIT_LIST_TOLOAD(var pdebl_toload, pcour_toload: T_ptr_toload);
begin
pdebl_toload:=Nil;
pcour_toload:=Nil;
end;
//----------------------------------------------------------------------------//
end.
