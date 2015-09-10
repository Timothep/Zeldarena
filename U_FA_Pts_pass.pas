unit U_FA_Pts_pass;

interface

type
//*****************************************************************************//
T_ptr_FA_pass = ^elt_FA_pass ;

elt_FA_pass = record
                        CoordX : integer;
                        CoordY : integer;
                        psuiv : T_ptr_FA_pass;
                     end;
Var
pcour_Fa_Pass,Pdeb_FA_PASS,Pfin_FA_PASS:T_ptr_FA_PASS;

//*****************************************************************************//
procedure CREA_VD(var pnouv : T_ptr_FA_pass);
procedure INIT_VD(var pnouv : T_ptr_FA_pass; CoordY,CoordX:integer);
Procedure AJOUT_VD_PASS(Var Pfin_FA_pass,Pcour_FA_pass,pnouv,pdeb_fa_pass:T_ptr_FA_pass);
Procedure COORD_INITIALES(Var CoordX,CoordY:integer; var Pcour_FA_pass:T_ptr_FA_pass);
Procedure CREA_PTS_PASSAGE(var pcour_Fa_Pass,Pdeb_FA_PASS,Pfin_FA_PASS:T_ptr_FA_PASS);
Procedure FA_PASS_CREATION(Var Pcour_FA_pass,Pdeb_FA_pass,Pfin_FA_pass:T_ptr_FA_pass);
//*****************************************************************************//
implementation

Uses U_Jeu, U_types, SysUtils;

//*****************************************************************************//
//Module de création d'une nouvelle VD
procedure CREA_VD(var pnouv : T_ptr_FA_pass);
Begin
New(pnouv);
end;
//*****************************************************************************//
//Module d'initlialisation d'un nouvelle VD
procedure INIT_VD(var pnouv : T_ptr_FA_pass; CoordY,CoordX:integer);
Begin
Pnouv^.CoordX:=CoordX;
Pnouv^.CoordY:=CoordY;
Pnouv^.psuiv:=Nil;
End;
//*****************************************************************************//
//Module d'ajout d'une variable dynamique dans la FA
Procedure AJOUT_VD_PASS(Var Pfin_FA_PASS,Pcour_FA_PASS,pnouv,pdeb_fa_pass:T_ptr_FA_pass);
Begin
Pcour_FA_Pass:=pdeb_fa_pass;
//Si c'est le premier élément
If pdeb_FA_PASS=nil
        then //Alors on chaine en tête
                begin
                pdeb_fa_pass:=pnouv;
                Pfin_FA_PASS:=pnouv;
                Pcour_FA_PASS:=pnouv;
                end
        else //SInon, on chaine en queue
        begin
        //Tant qu'on est pas arrivé en queue
        While pcour_FA_PASS^.psuiv<>Nil do
                pcour_FA_PASS:=pcour_FA_PASS^.psuiv;
        pcour_FA_PASS^.psuiv:=pnouv;
        Pfin_FA_PASS:=pnouv;
        end;
End;
//*****************************************************************************//
Procedure COORD_INITIALES(Var CoordX,CoordY:integer; var Pcour_FA_PASS:T_ptr_FA_pass);
Begin
Pcour_FA_PASS:=Pcour_FA_PASS^.psuiv;
CoordX:=Pcour_FA_PASS^.CoordX;
CoordY:=Pcour_FA_PASS^.CoordY;
End;
//*****************************************************************************//
Procedure FA_PASS_CREATION(Var Pcour_FA_PASS,Pdeb_FA_PASS,Pfin_FA_PASS:T_ptr_FA_pass);
Begin
Pcour_FA_PASS:=Nil;
Pdeb_FA_PASS:=Nil;
Pfin_FA_PASS:=Nil;
End;
//*****************************************************************************//
//Module de création de la liste des points de renaissance
Procedure CREA_PTS_PASSAGE(var pcour_Fa_Pass,Pdeb_FA_PASS,Pfin_FA_PASS:T_ptr_FA_PASS);
Var
i,j:integer;
Pnouv:T_ptr_FA_PASS;
Begin
//On crée la FA mais elle est vide
FA_PASS_CREATION(Pcour_FA_pass,Pdeb_FA_PASS,Pfin_FA_PASS);
//Parcours de la matrice totale à la recherche des points de renaissance (code:83,84)
For i:=0 to High (Matrice_Structure[0]) do
        For j:=0 to High (Matrice_Structure) do
                Begin
                If (Matrice_Structure[j,i].Ptr_Artefact.GETNUMIMAGE=inttostr(PASSAGE_1)+BMP_EXTENSION) or (Matrice_Structure[j,i].Ptr_Artefact.GETNUMIMAGE=inttostr(PASSAGE_2)+BMP_EXTENSION)
                        then //c'est un point de renaissance donc il faut l'ajouter
                                begin
                                CREA_VD(pnouv);
                                //Initialisation de la nouvelle variable dynamique avec les coordonnées contenues dans le tableau
                                INIT_VD(pnouv,Matrice_Structure[j,i].Ptr_Artefact.GETLIGNE,Matrice_Structure[j,i].Ptr_Artefact.GETCOLONNE);
                                //Ajout de la VD dans la FA
                                AJOUT_VD_PASS(Pfin_FA_PASS,Pcour_FA_PASS,pnouv,pdeb_Fa_Pass);
                                End;
                End;
End;
//*****************************************************************************//
end.
