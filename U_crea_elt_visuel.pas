//Boussoumah
unit U_crea_elt_visuel;
//classe mere
interface
type
//----------------------------------------------------------------------------//
TC_elt_visuel = class (Tobject)//
             private
                nom :string;
                ligne : integer;
                colonne : integer;
                numimage : string;
             public
                function GETNOM : string;
                function GETLIGNE : integer;
                function GETCOLONNE : integer;
                function GETNUMIMAGE : string;
                constructor INIT(newnom : string; newligne :integer; newcolonne :integer; newnumimage : string);
                procedure AFFICHAGE; virtual;abstract;
                Procedure PUTLIGNE(newligne:integer);
                Procedure PUTCOLONNE(newcolonne:integer);
             end;
//----------------------------------------------------------------------------//
implementation
//----------------------------------------------------------------------------//
constructor TC_elt_visuel.INIT(newnom : string; newligne :integer; newcolonne :integer; newnumimage : string);
begin
  nom := newnom;
  ligne := newligne;
  colonne := newcolonne;
  numimage := newnumimage;
end;
//----------------------------------------------------------------------------//
Procedure TC_elt_visuel.PUTLIGNE(newligne:integer);
begin
        ligne:=newligne;
end;
//----------------------------------------------------------------------------//
Procedure TC_elt_visuel.PUTCOLONNE(newcolonne:integer);
begin
        colonne:=newcolonne;
end;
//----------------------------------------------------------------------------//
function TC_elt_visuel.GETNOM : string;
begin
  GETNOM := nom;
end;
//----------------------------------------------------------------------------//
function TC_elt_visuel.GETLIGNE : integer;
begin
  GETLIGNE := ligne;
end;
//----------------------------------------------------------------------------//
function TC_elt_visuel.GETCOLONNE : integer;
begin
  GETCOLONNE := colonne;
end;
//----------------------------------------------------------------------------//
function TC_elt_visuel.GETNUMIMAGE : string;
begin
  Result := numimage;
end;
//----------------------------------------------------------------------------//
end.
