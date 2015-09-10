{JEU ZELDARENA - SAND
JOACHIM BOUSSOUMAH      GPBb
TIMOTHEE BOURGUIGNON    GPAa
EPF2}
unit U_crea_elt_non_permnt;
//sous classe de la classe TC_elt_visuel

interface
//----------------------------------------------------------------------------//
   uses U_crea_elt_visuel ;

   type
        TC_elt_non_permnt = class (TC_elt_visuel)
        private
           actif : boolean;
        public
           constructor INIT(newnom : string; newligne :integer; newcolonne :integer ;
                             numimage : string;newactif: boolean);
           function GETACTIF : boolean;
           procedure PUTACTIF(activite : boolean);
        end;

   var
       activite : boolean ;
//----------------------------------------------------------------------------//
implementation
//----------------------------------------------------------------------------//
constructor TC_elt_non_permnt.INIT(newnom : string; newligne :integer; newcolonne :integer ;
                                   numimage : string;newactif: boolean );
begin
        inherited INIT(newnom,newligne,newcolonne, numimage);
        actif := newactif ;
end;
//----------------------------------------------------------------------------//
function TC_elt_non_permnt.GETACTIF : boolean;
begin
   GETACTIF := actif;
end;
//----------------------------------------------------------------------------//
procedure TC_elt_non_permnt.PUTACTIF(activite : boolean);
begin
     actif := activite;
end;
//----------------------------------------------------------------------------//
end.
