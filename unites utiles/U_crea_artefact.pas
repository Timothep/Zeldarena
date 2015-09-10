//Boussoumah
unit U_crea_artefact;
//sous classe de la classe TC_elt_non_permnt

interface
//----------------------------------------------------------------------------//
     uses U_crea_elt_non_permnt  ;

     type
         TC_artefact = class (TC_elt_non_permnt)
         private
            bonus : integer;
         public
            constructor INIT(newnom : string; newligne :integer; newcolonne :integer ;
                             newnumimage : string;newactif: boolean;
                             newbonus :integer);
            function GETBONUS : integer;
            procedure PUTBONUS(bonification : integer);
            procedure AFFICHAGE();
         end;


//----------------------------------------------------------------------------//
implementation
uses Sysutils;
//----------------------------------------------------------------------------//
constructor TC_artefact.INIT(newnom : string; newligne :integer; newcolonne :integer ;
 newnumimage : string;newactif: boolean; newbonus :integer);
begin
        inherited  INIT(newnom, newligne , newcolonne ,newnumimage,newactif);
        bonus := newbonus;
end;
//----------------------------------------------------------------------------//
function TC_artefact.GETBONUS : integer;
begin
     GETBONUS := bonus;
end;
//----------------------------------------------------------------------------//
procedure  TC_artefact.PUTBONUS(bonification :integer );
begin
     bonus := bonification;
end;
//----------------------------------------------------------------------------//
procedure TC_artefact.AFFICHAGE();
begin
writeln('');
writeln(' Vous avez un(e) ' + GETNOM +'    Chemin d''acces :' +GETNUMIMAGE);
writeln(' Cet artefact se trouve sur la case de coordonnees  X=' +inttostr(GETCOLONNE)+ '; Y=' +inttostr(GETLIGNE));
if GETACTIF = true
 then
   writeln(' Cet element est actif')
 else
   writeln(' Cet element est inactif');
writeln(' Le present artefact apporte ' +inttostr(GETBONUS)+ ' points de ' +GETNOM);
end;
//----------------------------------------------------------------------------//
end.
