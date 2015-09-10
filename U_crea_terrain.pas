//Boussoumah
unit U_crea_terrain;
//sous classe de la classe TC_elt_visuel

interface
//----------------------------------------------------------------------------//
        uses U_crea_elt_visuel ;
        type
            TC_terrain = class (TC_elt_visuel)
            private
                marchable : boolean ;
            public
                constructor INIT (newnom : string; newligne :integer;newcolonne :integer; newmarchable : boolean; newnumimage : string);
                function GETMARCHABLE : boolean;
            end;
//----------------------------------------------------------------------------//
implementation
//----------------------------------------------------------------------------//
constructor TC_terrain.INIT(newnom : string; newligne :integer; newcolonne :integer; newmarchable : boolean; newnumimage : string) ;
begin
   inherited INIT(newnom,newligne,newcolonne,newnumimage);
   marchable := newmarchable;
end;
//----------------------------------------------------------------------------//
function TC_terrain.GETMARCHABLE : boolean;
begin
   GETMARCHABLE := marchable;
end;
//----------------------------------------------------------------------------//
end.
