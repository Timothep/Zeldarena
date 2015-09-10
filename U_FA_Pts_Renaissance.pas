unit U_FA_Pts_Renaissance;

interface

type
//*****************************************************************************//
T_ptr_FA_Renaissance = ^elt_FA_Renaissance ;

elt_FA_Renaissance = record
                        CoordX : integer;
                        CoordY : integer;
                        psuiv : T_ptr_FA_Renaissance;
                     end;

//*****************************************************************************//
procedure CREA_VD(var pnouv : T_ptr_FA_Renaissance);
procedure INIT_VD(var pnouv : T_ptr_FA_Renaissance; CoordX,CoordY:integer);
Procedure AJOUT_VD_RENAISSANCE(Var Pfin_FA_Renaissance,Pdeb_FA_Renaissance,Pcour_FA_Renaissance,pnouv:T_ptr_FA_Renaissance);
Procedure COORD_INITIALES(Var CoordX,CoordY:integer; var Pcour_FA_Renaissance:T_ptr_FA_Renaissance);
Procedure CREA_PTS_RENAISSANCE(var PPremier_Renaiss:T_ptr_FA_Renaissance);
Procedure FA_RENAISSANCE_CREATION(Var Pcour_FA_Renaissance,Pdeb_FA_Renaissance,Pfin_FA_Renaissance:T_ptr_FA_Renaissance);
//*****************************************************************************//
implementation

Uses U_Jeu, U_types, SysUtils, Messages, Dialogs;

//*****************************************************************************//
//Module de création d'une nouvelle VD
procedure CREA_VD(var pnouv : T_ptr_FA_Renaissance);
Begin
New(pnouv);
end;
//*****************************************************************************//
//Module d'initlialisation d'un nouvelle VD
procedure INIT_VD(var pnouv : T_ptr_FA_Renaissance; CoordX,CoordY:integer);
Begin
Pnouv^.CoordX:=CoordX;
Pnouv^.CoordY:=CoordY;
Pnouv^.psuiv:=Nil;
End;
//*****************************************************************************//
//Module d'ajout d'une variable dynamique dans la FA
Procedure AJOUT_VD_RENAISSANCE(Var Pfin_FA_Renaissance,Pdeb_FA_Renaissance,Pcour_FA_Renaissance,pnouv:T_ptr_FA_Renaissance);
Begin
If Pfin_FA_Renaissance=nil //Alors c'est le premier élément
        then
                begin
                Pfin_FA_Renaissance:=pnouv;
                Pdeb_FA_Renaissance:=pnouv;
                end
        Else Pfin_FA_Renaissance^.psuiv:=pnouv;
Pfin_FA_Renaissance:=Pnouv;
Pcour_FA_Renaissance:=pnouv;
End;
//*****************************************************************************//
Procedure COORD_INITIALES(Var CoordX,CoordY:integer; var Pcour_FA_Renaissance:T_ptr_FA_Renaissance);
Begin
Pcour_FA_Renaissance:=Pcour_FA_Renaissance^.psuiv;
CoordX:=Pcour_FA_Renaissance^.CoordX;
CoordY:=Pcour_FA_Renaissance^.CoordY;
End;
//*****************************************************************************//
Procedure FA_RENAISSANCE_CREATION(Var Pcour_FA_Renaissance,Pdeb_FA_Renaissance,Pfin_FA_Renaissance:T_ptr_FA_Renaissance);
Begin
Pcour_FA_Renaissance:=Nil;
Pdeb_FA_Renaissance:=Nil;
Pfin_FA_Renaissance:=Nil;
End;
//*****************************************************************************//
//Module de création de la liste des points de renaissance
Procedure CREA_PTS_RENAISSANCE(var PPremier_Renaiss:T_ptr_FA_Renaissance);
Var
i,j:integer;
Pnouv:T_ptr_FA_Renaissance;
Begin
//On crée la FA mais elle est vide
FA_RENAISSANCE_CREATION(Pcour_FA_Renaissance,Pdeb_FA_Renaissance,Pfin_FA_Renaissance);
PPremier_Renaiss:=Pdeb_FA_Renaissance;
//Parcours de la matrice totale à la recherche des points de renaissance (code:83,84)
For i:=0 to High (Matrice_Structure[0]) do
        For j:=0 to High (Matrice_Structure) do
                Begin
                If (Matrice_Structure[j,i].Ptr_Artefact.GETNUMIMAGE=inttostr(RENAISS_1)+BMP_EXTENSION) or (Matrice_Structure[j,i].Ptr_Artefact.GETNUMIMAGE=inttostr(RENAISS_2)+BMP_EXTENSION)
                        then //c'est un point de renaissance donc il faut l'ajouter
                                begin
                                CREA_VD(pnouv);
                                //Initialisation de la nouvelle variable dynamique avec les coordonnées contenues dans le tableau
                                INIT_VD(pnouv,Matrice_Structure[j,i].Ptr_Artefact.GETCOLONNE,Matrice_Structure[j,i].Ptr_Artefact.GETLIGNE);
                                //Ajout de la VD dans la FA
                                AJOUT_VD_RENAISSANCE(Pfin_FA_Renaissance,Pdeb_FA_Renaissance,Pcour_FA_Renaissance,pnouv);
                                //Showmessage('Un point de renaissance trouvé aux coordonnées: '+inttostr(Pcour_FA_Renaissance^.CoordX)+', '+inttostr(Pcour_FA_Renaissance^.CoordY));
                                End;
                End;
End;
//*****************************************************************************//
end.
