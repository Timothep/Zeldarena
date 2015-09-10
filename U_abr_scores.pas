unit U_abr_scores;
//Unite dans laquelle on declare l arbre des scores et les modules associes

interface

Uses U_Types, SysUtils;

type

T_score=record
        score:integer;
        nom_joueur:string[100];
        end;

T_file_score=file of T_score;

T_ptr_score=^T_abr_score;

T_abr_score=record
                score:T_score;
                f_score_g:T_ptr_score;
                f_score_d:T_ptr_score;
                end;
var

score,courant_score:T_score;
pnouv_score,score_courant,pnd_score:T_ptr_score;
ptr_racine_score:T_ptr_score;
path_scores:string;
//----------------------------------------------------------------------------//
procedure ECRIT_ABR_SCORE(var pnd_score:T_Ptr_Score);
procedure ECRIT_FIC(path:string);
procedure AJOUT_ABR_SCORE(var pnd_score :T_Ptr_score;var courant_score:T_score);
procedure CREATION_VD(var pnouv_score :T_Ptr_score;var courant_score:t_score);
procedure CHARGE(path : string;var ptr_racine_score:T_Ptr_score);
procedure MODIF_XP(var prescore:T_score;var paux:T_ptr_VD_joueur);
PROCEDURE EXISTENCE (VAR path:string);
PROCEDURE CREATION (path :string);
function JOUEUR_ACTIF(prescore:T_score;var paux:T_ptr_VD_joueur):boolean;
//----------------------------------------------------------------------------//
implementation
//----------------------------------------------------------------------------//
procedure ECRIT_ABR_SCORE(var pnd_score:T_Ptr_Score);
//ce module sert en outre de module de parcours integrale de l arbre
Var
fdon:T_file_score;
begin
if pnd_score <> nil
then
//test d'arrêt de la récursivité
        begin
        ECRIT_ABR_SCORE(pnd_score^.f_score_g);//descente dans le fils gauche
        write(fdon,pnd_score^.score);
        ECRIT_ABR_SCORE(pnd_score^.f_score_d);//descente dans le fils droit

        end;
end;
//----------------------------------------------------------------------------//
procedure ECRIT_FIC(path:string);
var
path_scores:string;
fdon:T_file_score;
begin
  path_scores:=path;
  Assignfile(fdon,path_scores);
  rewrite(fdon);
  ECRIT_ABR_SCORE(pnd_score);
end;
//----------------------------------------------------------------------------//
procedure AJOUT_ABR_SCORE(var pnd_score :T_Ptr_score;var courant_score:T_score);

begin
if pnd_score= nil //test d'arrêt de la recursivité
then
         Begin
         //le noeud n existe pas alors on le creer
         CREATION_VD (pnd_score,courant_score);
         End
else
//le noeud existe .comparaison possible avec la valeur du noeud
        begin
        If courant_score.score<= pnd_score^.score.score
        then
                  Begin
                  //descente dans le sous-arbre gauche
                  AJOUT_ABR_SCORE(pnd_score^.f_score_g,courant_score);
                  End
        else
        //descente dans le sous arbre droit
                  Begin
                  AJOUT_ABR_SCORE(pnd_score^.f_score_d,courant_score);
                  End;



         end;
end;
//----------------------------------------------------------------------------//
procedure  CREATION_VD(var pnouv_score :T_Ptr_score;var courant_score:t_score);
//permet la création d'ne nouvelle variable dynamique à insérer dans l'arbre

begin
//creation d'une nouvelle variable dynamique

new(pnouv_score);
pnouv_score^.score:=courant_score;//le champ 'score' de pnouv_score prend la valeur de courant score
pnouv_score^.f_score_g:=nil;//initialise les fils gauche et droit de la vd en cours
pnouv_score^.f_score_d:=nil;//initialise les fils gauche et droit de la vd en cours
score_courant:=pnouv_score;//la variable qui vient d etre cree devient la variable sur
                         //laquelle pointe le pointeur courant

end;
//----------------------------------------------------------------------------//

procedure CHARGE(path : string;var ptr_racine_score:T_Ptr_score);
var      //module d ouverture du fichier avec verification prealable de son existence
path_scores:string;      //afin de ne pas effacer un module existant
fdon:T_file_score;
prescore:T_score;
paux:T_ptr_VD_joueur;
begin
  path_scores:=path;
  Assignfile(fdon,path_scores);
  reset(fdon);
  while (not eof(fdon)) do //tant qu on a pas atteint la fin du fichier type
   begin
      read(fdon,prescore); //on lit l article en cours
      if JOUEUR_ACTIF(prescore,paux) = false
      then AJOUT_ABR_SCORE(ptr_racine_score,prescore) //on initialise une vd que l on ajoute a l abr
      else MODIF_XP(prescore,paux);
   end;                                 //des scores
  closefile(fdon);  //fermeture du fichier typé
end;
//----------------------------------------------------------------------------//
procedure MODIF_XP(var prescore:T_score;var paux:T_ptr_VD_joueur);
begin
prescore.score := prescore.score+ paux^.pt_visuel.GETXP;
AJOUT_ABR_SCORE(ptr_racine_score,prescore);
end;
//----------------------------------------------------------------------------//
function JOUEUR_ACTIF(prescore:T_score;var paux:T_ptr_VD_joueur):boolean;
//var
//paux:T_ptr_VD_joueur;
begin
paux := PPremier_joueur;
while paux <> nil do
if paux^.pt_visuel.GETNOM = prescore.nom_joueur
then result := true
else paux:=paux^.psuiv;
end;
//----------------------------------------------------------------------------//
PROCEDURE EXISTENCE (VAR path:string);
// Verification de l'existence du fichier d'agences ou création puis chargement des données

Begin
If not (fileexists(path))
Then // Le fichier n'existe pas, on doit le créer ou chercher ailleurs
        Creation(path);//appel du module de creation
CHARGE(path,ptr_racine_score);
End;
//----------------------------------------------------------------------------//
PROCEDURE CREATION (path :string);
// Création du fichier d'agences
//en entree le chemin d acces du fichier dont on souhaite confirmer l existence
Var
fdon: T_File_score;

Begin
Assignfile(fdon,path);
Rewrite(fdon);
Closefile(fdon);
End;
//----------------------------------------------------------------------------//
end.
