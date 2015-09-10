//Boussoumah
unit U_crea_joueur;
//sous classe de la classe TC_elt_non_permnt

interface
//----------------------------------------------------------------------------//
     uses U_crea_elt_non_permnt, Graphics;

     type
//----------------------------------------------------------------------------//
T_ptr_elt_3ch = ^elt_3ch ;

elt_3ch = record
           ligne : integer;
           colonne : integer;
           psuiv : T_ptr_elt_3ch;
          end;
//----------------------------------------------------------------------------//
        TC_joueur = class (TC_elt_non_permnt)
        private
           offset_X        : integer;
           offset_Y        : integer;
           vie             : integer;
           attaque         : integer;
           precision       : integer;
           endurance       : integer;
           armure          : integer;
           XP              : integer;
           bonus_vie       : integer;
           bonus_attaque   : integer;
           bonus_precision : integer;
           bonus_endurance : integer;
           bonus_armure    : integer;
           orientation     : char;
           chemin          : T_ptr_elt_3ch;
        public
           Sprites         : array [0..3,0..2] of Tbitmap;
           constructor INIT(newnom : string; newligne :integer; newcolonne :integer ;
                           newnumimage : string;newactif: boolean ;
                           newoffset_X,newoffset_Y,newvie,
                           newattaque,newprecision,newendurance,newarmure,newXP,
                           newbonus_vie,newbonus_attaque,newbonus_precision,
                           newbonus_endurance,newbonus_armure : integer ;
                           neworientation : char ; newchemin : T_ptr_elt_3ch);
           //-------------------//--------------------//
           function GETOFFSET_Y            : integer;
           function GETOFFSET_X            : integer;
           function GETVIE                 : integer;
           function GETATTAQUE             : integer;
           function GETPRECISION           : integer;
           function GETENDURANCE           : integer;
           function GETARMURE              : integer;
           function GETXP                  : integer;
           function GETBONUS_VIE           : integer;
           function GETBONUS_ATTAQUE       : integer;
           function GETBONUS_PRECISION     : integer;
           function GETBONUS_ENDURANCE     : integer;
           function GETBONUS_ARMURE        : integer;
           function GETORIENTATION         : char;
           function GETCHEMIN              : T_ptr_elt_3ch;
           //-------------------//--------------------//
           procedure PUTOFFSET_X (set_X : integer);
           procedure PUTOFFSET_Y (set_Y : integer);
           procedure PUTVIE (life : integer);
           procedure PUTATTAQUE (attack : integer);
           procedure PUTPRECISION (precise :integer);
           procedure PUTENDURANCE (stamina : integer);
           procedure PUTARMURE (armor : integer);
           procedure PUTXP (experience : integer);
           procedure PUTBONUS_VIE (bonvie : integer);
           procedure PUTBONUS_ATTAQUE (bonattaque : integer);
           procedure PUTBONUS_PRECISION (bonprecision : integer);
           procedure PUTBONUS_ENDURANCE (bonendurance : integer);
           procedure PUTBONUS_ARMURE (bonarmure : integer);
           procedure PUTORIENTATION (cardinal : char);
           procedure PUTCHEMIN (route : T_ptr_elt_3ch);
        end;



//----------------------------------------------------------------------------//
implementation
uses sysutils, U_Types;
//----------------------------------------------------------------------------//
constructor TC_joueur.INIT(newnom : string; newligne :integer; newcolonne :integer ;
                           newnumimage : string;newactif: boolean ;
                           newoffset_X,newoffset_Y,newvie,
                           newattaque,newprecision,newendurance,newarmure,newXP,
                           newbonus_vie,newbonus_attaque,newbonus_precision,
                           newbonus_endurance,newbonus_armure : integer ;
                           neworientation : char ; newchemin : T_ptr_elt_3ch);
Var                            //
x:byte;                        //
Dossier,FileToLoad:String;     //
//Pcour:T_ptr_VD_Joueur;         //
begin
     inherited INIT(newnom, newligne , newcolonne ,newnumimage, newactif);
     offset_X        := newoffset_X;
     offset_Y        := newoffset_Y;
     vie             := newvie;
     attaque         := newattaque;
     precision       := newprecision;
     endurance       := newendurance;
     armure          := newarmure;
     XP              := newXP;
     bonus_vie       := newbonus_vie;
     bonus_attaque   := newbonus_attaque;
     bonus_precision := newbonus_precision;
     bonus_endurance := newbonus_endurance;
     bonus_armure    := newbonus_armure;
     orientation     := neworientation;
     chemin          := newchemin;
     //**********************************//
        //Choix de la couleur et application du dossier correspondant.  {ble roug ver vio}
        If newnumimage=DOSSIER_SPRITES+SLASH+'1'+SLASH+SPRITE_DEFAUT+BMP_EXTENSION
                then dossier:=DOSSIER_1;
        If newnumimage=DOSSIER_SPRITES+SLASH+'2'+SLASH+SPRITE_DEFAUT+BMP_EXTENSION
                then dossier:=DOSSIER_2;
        If newnumimage=DOSSIER_SPRITES+SLASH+'3'+SLASH+SPRITE_DEFAUT+BMP_EXTENSION
                then dossier:=DOSSIER_3;
        If newnumimage=DOSSIER_SPRITES+SLASH+'4'+SLASH+SPRITE_DEFAUT+BMP_EXTENSION
                then dossier:=DOSSIER_4;
        //Tant qu'on a pas rempli toutes les cases du tableau
        For x:= 0 to 2 do
                Begin
                FileToLoad:=DOSSIER_SPRITES+SLASH+dossier+SLASH+DW_NOM+inttostr(x)+BMP_EXTENSION;
                Sprites[DIR_DW,x].LoadFromFile(FileToLoad);
                Sprites[DIR_DW,x].Transparent := True;
                Sprites[DIR_DW,x].TransParentColor := Sprites[DIR_DW,x].canvas.pixels[0,0];
                End;
        For x:= 0 to 2 do
                Begin
                FileToLoad:=DOSSIER_SPRITES+SLASH+dossier+SLASH+LE_NOM+inttostr(x)+BMP_EXTENSION;
                Sprites[DIR_LE,x].LoadFromFile(FileToLoad);
                Sprites[DIR_LE,x].Transparent := True;
                Sprites[DIR_LE,x].TransParentColor := Sprites[DIR_LE,x].canvas.pixels[0,0];
                End;
        For x:= 0 to 2 do
                Begin
                FileToLoad:=DOSSIER_SPRITES+SLASH+dossier+SLASH+UP_NOM+inttostr(x)+BMP_EXTENSION;
                Sprites[DIR_UP,x].LoadFromFile(FileToLoad);
                Sprites[DIR_UP,x].Transparent := True;
                Sprites[DIR_UP,x].TransParentColor := Sprites[DIR_UP,x].canvas.pixels[0,0];
                End;
        For x:= 0 to 2 do
                Begin
                FileToLoad:=DOSSIER_SPRITES+SLASH+dossier+SLASH+RI_NOM+inttostr(x)+BMP_EXTENSION;
                Sprites[DIR_RI,x].LoadFromFile(FileToLoad);
                Sprites[DIR_RI,x].Transparent := True;
                Sprites[DIR_RI,x].TransParentColor := Sprites[DIR_RI,x].canvas.pixels[0,0];
                End;
     //**********************************//
end;
//----------------------------------------------------------------------------//
{function GETSPRITES(i,j:integer): Tbitmap;
begin
Result:=Sprite[i,j];
end;
//----------------------------------------------------------------------------//
procedure PUTSPRITES(i,j:integer;image:string);
begin
Sprite[i,j]:=LoadFromFile(image);
end; }
//----------------------------------------------------------------------------//
function TC_joueur.GETOFFSET_X :integer;
begin
     GETOFFSET_X := offset_X;
end;
//----------------------------------------------------------------------------//
function TC_joueur.GETOFFSET_Y :integer;
begin
     GETOFFSET_Y := offset_Y;
end;
//----------------------------------------------------------------------------//
function TC_joueur.GETVIE :integer;
begin
     GETVIE := vie;
end;
//----------------------------------------------------------------------------//
function TC_joueur.GETATTAQUE :integer;
begin
     GETATTAQUE := attaque;
end;
//----------------------------------------------------------------------------//
function TC_joueur.GETPRECISION :integer;
begin
     GETPRECISION := precision;
end;
//----------------------------------------------------------------------------//
function TC_joueur.GETENDURANCE :integer;
begin
     GETENDURANCE := endurance;
end;
//----------------------------------------------------------------------------//
function TC_joueur.GETARMURE :integer;
begin
     GETARMURE := armure;
end;
//----------------------------------------------------------------------------//
function TC_joueur.GETXP :integer;
begin
     GETXP := XP;
end;
//----------------------------------------------------------------------------//
function TC_joueur.GETBONUS_VIE :integer;
begin
     GETBONUS_VIE := bonus_vie;
end;
//----------------------------------------------------------------------------//
function TC_joueur.GETBONUS_ATTAQUE :integer;
begin
     GETBONUS_ATTAQUE := bonus_attaque;
end;
//----------------------------------------------------------------------------//
function TC_joueur.GETBONUS_PRECISION :integer;
begin
     GETBONUS_PRECISION := bonus_precision;
end;
//----------------------------------------------------------------------------//
function TC_joueur.GETBONUS_ENDURANCE :integer;
begin
     GETBONUS_ENDURANCE := bonus_endurance;
end;
//----------------------------------------------------------------------------//
function TC_joueur.GETBONUS_ARMURE :integer;
begin
     GETBONUS_ARMURE := bonus_armure;
end;
//----------------------------------------------------------------------------//
function TC_joueur.GETORIENTATION :char;
begin
     GETORIENTATION := orientation;
end;
//----------------------------------------------------------------------------//
function TC_joueur.GETCHEMIN :T_ptr_elt_3ch;
begin
     GETCHEMIN := chemin;
end;
//----------------------------------------------------------------------------//

                //-------------------//--------------------//

//----------------------------------------------------------------------------//
procedure TC_joueur.PUTOFFSET_X (set_X:integer);
begin
     offset_X := set_X;
end;
//----------------------------------------------------------------------------//
procedure TC_joueur.PUTOFFSET_Y (set_Y:integer);
begin
     offset_Y := set_Y;
end;
//----------------------------------------------------------------------------//
procedure TC_joueur.PUTVIE (life:integer);
begin
     vie := life;
end;
//----------------------------------------------------------------------------//
procedure TC_joueur.PUTATTAQUE (attack:integer);
begin
     attaque := attack;
end;
//----------------------------------------------------------------------------//
procedure TC_joueur.PUTPRECISION (precise:integer);
begin
     precision := precise;
end;
//----------------------------------------------------------------------------//
procedure TC_joueur.PUTENDURANCE (stamina:integer);
begin
     endurance := stamina;
end;
//----------------------------------------------------------------------------//
procedure TC_joueur.PUTARMURE (armor:integer);
begin
     armure := armor;
end;
//----------------------------------------------------------------------------//
procedure TC_joueur.PUTXP (experience:integer);
begin
     XP := experience;
end;
//----------------------------------------------------------------------------//
procedure TC_joueur.PUTBONUS_VIE (bonvie:integer);
begin
     bonus_vie := bonvie;
end;
//----------------------------------------------------------------------------//
procedure TC_joueur.PUTBONUS_ATTAQUE (bonattaque : integer);
begin
     bonus_attaque := bonattaque;
end;
//----------------------------------------------------------------------------//
procedure TC_joueur.PUTBONUS_PRECISION (bonprecision:integer);
begin
     bonus_precision := bonprecision;
end;
//----------------------------------------------------------------------------//
procedure TC_joueur.PUTBONUS_ENDURANCE (bonendurance:integer);
begin
     bonus_endurance := bonendurance;
end;
//----------------------------------------------------------------------------//
procedure TC_joueur.PUTBONUS_ARMURE (bonarmure:integer);
begin
     bonus_armure := bonarmure;
end;
//----------------------------------------------------------------------------//
procedure TC_joueur.PUTORIENTATION (cardinal:char);
begin
     orientation := cardinal;
end;
//----------------------------------------------------------------------------//
procedure TC_joueur.PUTCHEMIN (route:T_ptr_elt_3ch);
begin
     chemin := route;
end;
//----------------------------------------------------------------------------//
end.
