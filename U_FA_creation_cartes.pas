unit U_FA_creation_cartes;

interface

//============================================================================//
//Déclaration des types de l'unité
type
T_Ptr_Cell=^T_Cell;
T_Cell  =  record
        Col:integer;
        Row:integer;
        Num_Img:integer;
        Suiv:T_Ptr_Cell;
        end;

Var
Pdebut,Pfin,Pnouv:T_Ptr_Cell;

//============================================================================//
//Déclaration des procédures de l'unité
Procedure INIT_FA(var Pdebut:T_Ptr_Cell; var Pfin:T_Ptr_Cell);
Procedure AJOUT_FA(var Pdebut:T_Ptr_Cell; var Pfin:T_Ptr_Cell; p_VD:T_Ptr_Cell);
Procedure VIDAGE_FA(var Pdebut:T_Ptr_Cell);
Procedure CREATE_VD_VAL(var pnouv:T_Ptr_Cell; Col,Row,Num:integer);
//============================================================================//
implementation
//============================================================================//
//Crée la FA mais elle est vide
Procedure INIT_FA(var Pdebut:T_Ptr_Cell; var Pfin:T_Ptr_Cell);
Begin
Pdebut:=Nil;
Pfin:=Nil;
end;
//============================================================================//
//Ajout d'un élément dans la FA
Procedure AJOUT_FA(var Pdebut:T_Ptr_Cell; var Pfin:T_Ptr_Cell; p_VD:T_Ptr_Cell);
Begin
If Pdebut=Nil
        then
                begin
                Pdebut:=p_VD;
                Pfin:=p_VD;
                end
        Else
                Begin
                Pfin.Suiv:=p_VD;
                Pfin:=p_VD;
                end;
end;
//============================================================================//
//Libère l'emplacement en mémoire centrale de chaque élément de la FA
Procedure VIDAGE_FA(var Pdebut:T_Ptr_Cell);
Var
Pcour:T_Ptr_Cell;
Begin
Pcour:=pdebut;
While pcour<>nil do
        begin
        Dispose(Pcour);
        pcour:=pcour^.Suiv;
        end;
end;

//============================================================================//
//Module de création d'une nouvelle variable dynamique
Procedure CREATE_VD_VAL(var pnouv:T_Ptr_Cell; Col,Row,Num:integer);
Begin
New(pnouv);
Pnouv.Col:=Col;
Pnouv.Row:=Row;
Pnouv.Num_Img:=Num;
Pnouv.suiv:=Nil;
End;
//============================================================================//
end.
