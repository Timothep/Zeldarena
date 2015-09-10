{JEU ZELDARENA - SAND
JOACHIM BOUSSOUMAH      GPBb
TIMOTHEE BOURGUIGNON    GPAa
EPF2}
{Unité rattachée à la boucle principale du Timer,
cette unité rassemble les modules de test, de comparaison etc. utiles au module principal}
unit U_traitement;

interface
Uses U_types, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg, U_jeu, U_Fa_Joueur, U_priorite, U_fa_inaction, U_accueil,
  U_tile_to_load, U_Test_Deplace, U_FA_Pts_Renaissance,MMSystem, MPlayer, U_crea_joueur, U_FA_Pts_pass;


//****************************************************************************//
//Ensemble des fonctions déclarées ci dessous
Function COMBAT_DESIRE(Pcour_joueur:t_ptr_vd_joueur):Boolean;
Function DEPLACEMENT_DESIRE(var Direction:char;Pcour_joueur:t_ptr_vd_joueur):Boolean;
Procedure INTERACTION_ARTEFACT(pcour_joueur:T_ptr_VD_Joueur; ligne,colonne:integer);
Procedure VERIF_XP(pcour:T_ptr_VD_joueur);
Procedure DEPLACEMENT_JOUEUR(pcour_joueur:T_ptr_VD_joueur;Direction:char;deplacement:integer);
Function GET_POINTEUR_ENNEMI(p_joueur_courant:T_ptr_VD_joueur):T_ptr_VD_joueur;
Procedure COMBAT(pcour_joueur,p_ennemi:T_ptr_VD_joueur);
Procedure AFFICHE_COMBAT(pcour_joueur:T_ptr_VD_joueur);
Procedure REACTIVATION(var pdeb_fa_inact:T_ptr_elt_inactif);
Procedure MAJ_DONNEES_ECRAN(Pcour_joueur,Phumain:T_ptr_vd_joueur);
Procedure MORT(pcour_joueur:T_ptr_VD_joueur; var PPremier_Renaiss:T_ptr_FA_Renaissance);
function CASE_SUIVANTE_OCCUPEE(pcour_fa_joueur:T_ptr_VD_joueur):boolean;
procedure RECUP_COORD(pdebl_prio:T_ptr_prio;var but_x,but_y:integer;pdeb_FA_waypoint:T_ptr_FA_pass;pcour_fa_joueur:T_ptr_VD_joueur);
procedure RECUP_COORD_PARTIELLES(pdebl_prio:T_ptr_prio;var but_x,but_y:integer;pdeb_FA_waypoint:T_ptr_FA_pass;pcour_fa_joueur:T_ptr_VD_joueur);
Procedure DEPLACEMENT_BOT(pcour_joueur:t_ptr_vd_joueur);
Procedure MAJ_DEST_BOT(Destination_X,Destination_Y:integer;pcour_joueur:t_ptr_vd_joueur;var Difx,DifY:integer; Var orient1,orient2:char);
//****************************************************************************//
implementation

//****************************************************************************//
//****************************************************************************//

//Module bouléen de vérification d'entrée dans le combat
Function COMBAT_DESIRE(Pcour_joueur:t_ptr_vd_joueur):Boolean;
Var
Keys:TKeyboardState;
Begin
GetKeyboardState(Keys);
//Joueur 1
If pcour_joueur=Phumain then
//I la touches espace est enfoncée
If Keys[VK_RETURN] and $80<>0
        then //alors le combat est enclenché
                COMBAT_DESIRE:=true
        else //le joueur ne souhaite pas tapper
                COMBAT_DESIRE:=false;
//Joueur 2
If pcour_joueur=Phumain2 then
If Keys[VK_NUMPAD0] and $80<>0
        then //alors le combat est enclenché
                COMBAT_DESIRE:=true
        else //le joueur ne souhaite pas tapper
                COMBAT_DESIRE:=false;
//Joueur 3
If pcour_joueur=Phumain3 then
If Keys[VK_F8] and $80<>0
        then //alors le combat est enclenché
                COMBAT_DESIRE:=true
        else //le joueur ne souhaite pas tapper
                COMBAT_DESIRE:=false;
//Joueur 4
If pcour_joueur=Phumain4 then
If Keys[VK_SUBTRACT] and $80<>0
        then //alors le combat est enclenché
                COMBAT_DESIRE:=true
        else //le joueur ne souhaite pas tapper
                COMBAT_DESIRE:=false;
End;

//****************************************************************************//
//****************************************************************************//

//Module bouléen de vérification de mouvement
Function DEPLACEMENT_DESIRE(var Direction:char;Pcour_joueur:t_ptr_vd_joueur):Boolean;
Var
Keys:TKeyboardState;
Key:word;
Begin
//Capture de la touche enfoncée en cours
GetKeyboardState(Keys);
result:=false;

////////Joueur1///////////

If pcour_joueur=Phumain then
begin
//Si c'est la touche gauche qui est enfoncée
If Keys[VK_Left] and $80<>0 then
        begin // Si la touche "gauche" est enfoncée...
        result:=true;
        Direction:='L';
        end;
//...
If Keys[VK_Right] and $80<>0 then
        begin // Si la touche "droite" est enfoncée...
        result:=true;
        Direction:='R';
        end;
//...
If Keys[VK_Down] and $80<>0 then
        begin // Si la touche "bas" est enfoncée...
        result:=true;
        Direction:='D';
        end;
//...
If Keys[VK_Up] and $80<>0 then
        begin // Si la touche "haut" est enfoncée...
        result:=true;
        Direction:='U';
        end;
end;

////////Joueur3///////////

If Pcour_joueur=Phumain3
then
begin
If Keys[VK_F9] and $80<>0 then
        begin // Si la touche "gauche" est enfoncée...
        result:=true;
        Direction:='L';
        end;
//...
If Keys[VK_F11] and $80<>0 then
        begin // Si la touche "droite" est enfoncée...
        result:=true;
        Direction:='R';
        end;
//...
If Keys[VK_INSERT] and $80<>0 then
        begin // Si la touche "bas" est enfoncée...
        result:=true;
        Direction:='D';
        end;
//...
If Keys[VK_F10] and $80<>0 then
        begin // Si la touche "haut" est enfoncée...
        result:=true;
        Direction:='U';
        end;
end;
////////Joueur2///////////

If Pcour_joueur=Phumain4
then
begin
If Keys[VK_NUMPAD7] and $80<>0 then
        begin // Si la touche "gauche" est enfoncée...
        result:=true;
        Direction:='L';
        end;
//...
If Keys[VK_NUMPAD9] and $80<>0 then
        begin // Si la touche "droite" est enfoncée...
        result:=true;
        Direction:='R';
        end;
//...
If Keys[VK_NUMPAD8] and $80<>0 then
        begin // Si la touche "bas" est enfoncée...
        result:=true;
        Direction:='D';
        end;
//...
If Keys[VK_DIVIDE] and $80<>0 then
        begin // Si la touche "haut" est enfoncée...
        result:=true;
        Direction:='U';
        end;
end;
/////////Joueur4//////////

If Pcour_joueur=Phumain2
then
begin
If Keys[VK_NUMPAD1] and $80<>0 then
        begin // Si la touche "gauche" est enfoncée...
        result:=true;
        Direction:='L';
        end;
//...
If Keys[VK_NUMPAD3] and $80<>0 then
        begin // Si la touche "droite" est enfoncée...
        result:=true;
        Direction:='R';
        end;
//...
If Keys[VK_NUMPAD2] and $80<>0 then
        begin // Si la touche "bas" est enfoncée...
        result:=true;
        Direction:='D';
        end;
//...
If Keys[VK_NUMPAD5] and $80<>0 then
        begin // Si la touche "haut" est enfoncée...
        result:=true;
        Direction:='U';
        end;
end;

//////////////////////////

End;

//****************************************************************************//
//****************************************************************************//

//Module de gestion du contact avec un artefact
Procedure INTERACTION_ARTEFACT(pcour_joueur:T_ptr_VD_Joueur; ligne,colonne:integer);
Var
Num,bonus,i,j:integer; //Num de référence de l'artefact, et son bonus
Paux_prio:t_ptr_prio;
Paux_chemin:T_ptr_case_chemin;
Begin
//on passe en revue les 8 cases qui entourent le joueur
for j:=pcour_joueur.pt_visuel.GETLIGNE-1 to pcour_joueur.pt_visuel.GETLIGNE+1 do
        for i:=pcour_joueur.pt_visuel.GETCOLONNE-1 to pcour_joueur.pt_visuel.GETCOLONNE+1 do
        begin
        //Si la case en cours n'est pas la case centrale (celle ou on se trouve)
        if ((i<>pcour_joueur.pt_visuel.GETCOLONNE) or (j<>pcour_joueur.pt_visuel.GETLIGNE)) and (i>=0) and (j>=0) and (i<=MAP_WIDTH-1) and (j<=MAP_HEIGHT-1)
                then
                begin
                ligne:=j;
                colonne:=i;

//On va chercher les noms et bonus
Num:=strtoint(Matrice_Structure[colonne,ligne]^.Ptr_Artefact.GETNOM);
Bonus:=Matrice_Structure[colonne,ligne]^.Ptr_Artefact.GETBONUS;
//Affectation
if (((num=67) or (num=68)) {and (bonus>pcour_joueur.pt_visuel.GETBONUS_ATTAQUE)} and (Matrice_Structure[colonne,ligne]^.Ptr_Artefact.GETACTIF=true)) //si c'est une epée de niv 1 et que le bonus existant est moins élevé que le bonus a ajouter
        then //il faut appliquer le nouveau bonus dans la SDD, demander l'affichage, et commander la désactivation
                begin
                pcour_joueur.pt_visuel.PUTBONUS_ATTAQUE(Bonus); //On applique le bonus
                Matrice_Structure[colonne,ligne].Ptr_Artefact.PUTACTIF(False);//Désactivation
                If pcour_joueur.pt_visuel.bot=true //Si c'est un bot
                        then MOV_FOND(pdebl_prio,'arme',pcour_joueur);//Alors mise en fin dans le liste des priorités
                //Mise en réactivation dans la FA des réactivations (Ajout dans la FA des réactivations)
                AJOUT_ELEM_FA_INA(pdeb_fa_inact,pfin_fa_inact,GetTickCount+DELAI_ART,Matrice_Structure[colonne,ligne]^.Ptr_Artefact);
                //Affichage du bonus
                If pcour_joueur=Phumain then
                        begin
                        F_Jeu.ImageList2.GetBitmap(0,F_jeu.I_arme_J1.Picture.Bitmap);
                        F_jeu.I_arme_J1.Repaint;
                        F_jeu.L_arme_J1.Caption:='1';
                        end;
                If (pcour_joueur=Phumain2) or (pcour_joueur=P_bot1) then
                        begin
                        F_Jeu.ImageList2.GetBitmap(0,F_jeu.I_arme_J2.Picture.Bitmap);
                        F_jeu.I_arme_J2.Repaint;
                        F_jeu.L_arme_J2.Caption:='1';
                        end;
                If (pcour_joueur=Phumain3) or (pcour_joueur=P_bot2) then
                        begin
                        F_Jeu.ImageList2.GetBitmap(0,F_jeu.I_arme_J3.Picture.Bitmap);
                        F_jeu.I_arme_J3.Repaint;
                        F_jeu.L_arme_J3.Caption:='1';
                        end;
                If (pcour_joueur=Phumain4) or (pcour_joueur=P_bot3) then
                        begin
                        F_Jeu.ImageList2.GetBitmap(0,F_jeu.I_arme_J4.Picture.Bitmap);
                        F_jeu.I_arme_J4.Repaint;
                        F_jeu.L_arme_J4.Caption:='1';
                        end;
                //Suppression du chemin
                pcour_joueur.pt_visuel.PUTCHEMIN(Nil);
                end;
if (((num=69) or (num=70)) {and (bonus>pcour_joueur.pt_visuel.GETBONUS_ATTAQUE)} and (Matrice_Structure[colonne,ligne]^.Ptr_Artefact.GETACTIF=true)) //si c'est une epée de niv 2 et que le bonus existant est moins élevé que le bonus a ajouter
        then //il faut appliquer le nouveau bonus dans la SDD, demander l'affichage, et commander la désactivation
                begin
                pcour_joueur.pt_visuel.PUTBONUS_ATTAQUE(Bonus); //On applique le bonus
                Matrice_Structure[colonne,ligne]^.Ptr_Artefact.PUTACTIF(False);//Désactivation
                If pcour_joueur.pt_visuel.bot=true //Si c'est un bot
                        then MOV_FOND(pdebl_prio,'arme',pcour_joueur);//Alors mise en fin dans le liste des priorités
                //Mise en réactivation dans la FA des réactivations (Ajout dans la FA des réactivations)
                AJOUT_ELEM_FA_INA(pdeb_fa_inact,pfin_fa_inact,GetTickCount+DELAI_ART,Matrice_Structure[colonne,ligne]^.Ptr_Artefact);
                //
                If pcour_joueur=Phumain then
                        begin
                        F_Jeu.ImageList2.GetBitmap(1,F_jeu.I_arme_J1.Picture.Bitmap);
                        F_jeu.I_arme_J1.Repaint;
                        F_jeu.L_arme_J1.Caption:='2';
                        end;
                If (pcour_joueur=Phumain2) or (pcour_joueur=P_bot1) then
                        begin
                        F_Jeu.ImageList2.GetBitmap(1,F_jeu.I_arme_J2.Picture.Bitmap);
                        F_jeu.I_arme_J2.Repaint;
                        F_jeu.L_arme_J2.Caption:='2';
                        end;
                If (pcour_joueur=Phumain3) or (pcour_joueur=P_bot2) then
                        begin
                        F_Jeu.ImageList2.GetBitmap(1,F_jeu.I_arme_J3.Picture.Bitmap);
                        F_jeu.I_arme_J3.Repaint;
                        F_jeu.L_arme_J3.Caption:='2';
                        end;
                If (pcour_joueur=Phumain4) or (pcour_joueur=P_bot3) then
                        begin
                        F_Jeu.ImageList2.GetBitmap(1,F_jeu.I_arme_J4.Picture.Bitmap);
                        F_jeu.I_arme_J4.Repaint;
                        F_jeu.L_arme_J4.Caption:='2';
                        end;
                //
                //Suppression du chemin
                pcour_joueur.pt_visuel.PUTCHEMIN(Nil);

                end;
if (((num=71) or (num=72)) {and (bonus>pcour_joueur.pt_visuel.GETBONUS_ATTAQUE)}and (Matrice_Structure[colonne,ligne]^.Ptr_Artefact.GETACTIF=true)) //si c'est une epée de niv 3 et que le bonus existant est moins élevé que le bonus a ajouter
        then //il faut appliquer le nouveau bonus dans la SDD, demander l'affichage, et commander la désactivation
                begin
                pcour_joueur.pt_visuel.PUTBONUS_ATTAQUE(Bonus); //On applique le bonus
                Matrice_Structure[colonne,ligne]^.Ptr_Artefact.PUTACTIF(False);//Désactivation
                If pcour_joueur.pt_visuel.bot=true //Si c'est un bot
                        then MOV_FOND(pdebl_prio,'arme',pcour_joueur);//Alors mise en fin dans le liste des priorités
                //Mise en réactivation dans la FA des réactivations (Ajout dans la FA des réactivations)
                AJOUT_ELEM_FA_INA(pdeb_fa_inact,pfin_fa_inact,GetTickCount+DELAI_ART,Matrice_Structure[colonne,ligne]^.Ptr_Artefact);
                //
                If pcour_joueur=Phumain then
                        begin
                        F_Jeu.ImageList2.GetBitmap(2,F_jeu.I_arme_J1.Picture.Bitmap);
                        F_jeu.I_arme_J1.Repaint;
                        F_jeu.L_arme_J1.Caption:='3';
                        end;
                If (pcour_joueur=Phumain2) or (pcour_joueur=P_bot1) then
                        begin
                        F_Jeu.ImageList2.GetBitmap(2,F_jeu.I_arme_J2.Picture.Bitmap);
                        F_jeu.I_arme_J2.Repaint;
                        F_jeu.L_arme_J2.Caption:='3';
                        end;
                If (pcour_joueur=Phumain3) or (pcour_joueur=P_bot2) then
                        begin
                        F_Jeu.ImageList2.GetBitmap(2,F_jeu.I_arme_J3.Picture.Bitmap);
                        F_jeu.I_arme_J3.Repaint;
                        F_jeu.L_arme_J3.Caption:='3';
                        end;
                If (pcour_joueur=Phumain4) or (pcour_joueur=P_bot3) then
                        begin
                        F_Jeu.ImageList2.GetBitmap(2,F_jeu.I_arme_J4.Picture.Bitmap);
                        F_jeu.I_arme_J4.Repaint;
                        F_jeu.L_arme_J4.Caption:='3';
                        end;
                //
                //Suppression du chemin
                pcour_joueur.pt_visuel.PUTCHEMIN(Nil);

                end;
if (((num=73) or (num=74)) {and (bonus>pcour_joueur.pt_visuel.GETBONUS_ARMURE)}and (Matrice_Structure[colonne,ligne]^.Ptr_Artefact.GETACTIF=true)) //si c'est une armure de niv 1 et que le bonus existant est moins élevé que le bonus a ajouter
        then //il faut appliquer le nouveau bonus dans la SDD, demander l'affichage, et commander la désactivation
                begin
                pcour_joueur.pt_visuel.PUTBONUS_ARMURE(Bonus); //On applique le bonus
                Matrice_Structure[colonne,ligne]^.Ptr_Artefact.PUTACTIF(False);//Désactivation
                If pcour_joueur.pt_visuel.bot=true //Si c'est un bot
                        then MOV_FOND(pdebl_prio,'armure',pcour_joueur);//Alors mise en fin dans le liste des priorités
                //Mise en réactivation dans la FA des réactivations (Ajout dans la FA des réactivations)
                AJOUT_ELEM_FA_INA(pdeb_fa_inact,pfin_fa_inact,GetTickCount+DELAI_ART,Matrice_Structure[colonne,ligne]^.Ptr_Artefact);
                //
                If pcour_joueur=Phumain then
                        begin
                        F_Jeu.ImageList2.GetBitmap(3,F_jeu.I_armure_J1.Picture.Bitmap);
                        F_jeu.I_armure_J1.Repaint;
                        F_jeu.L_armure_J1.Caption:='1';
                        end;
                If (pcour_joueur=Phumain2) or (pcour_joueur=P_bot1) then
                        begin
                        F_Jeu.ImageList2.GetBitmap(3,F_jeu.I_armure_J2.Picture.Bitmap);
                        F_jeu.I_armure_J2.Repaint;
                        F_jeu.L_armure_J2.Caption:='1';
                        end;
                If (pcour_joueur=Phumain3) or (pcour_joueur=P_bot2) then
                        begin
                        F_Jeu.ImageList2.GetBitmap(3,F_jeu.I_armure_J3.Picture.Bitmap);
                        F_jeu.I_armure_J3.Repaint;
                        F_jeu.L_armure_J3.Caption:='1';
                        end;
                If (pcour_joueur=Phumain4) or (pcour_joueur=P_bot3) then
                        begin
                        F_Jeu.ImageList2.GetBitmap(3,F_jeu.I_armure_J4.Picture.Bitmap);
                        F_jeu.I_armure_J4.Repaint;
                        F_jeu.L_armure_J4.Caption:='1';
                        end;
                //
                //Suppression du chemin
                pcour_joueur.pt_visuel.PUTCHEMIN(Nil);
                end;
if (((num=75) or (num=76)) {and (bonus>pcour_joueur.pt_visuel.GETBONUS_ARMURE)}and (Matrice_Structure[colonne,ligne]^.Ptr_Artefact.GETACTIF=true)) //si c'est une armure de niv 2 et que le bonus existant est moins élevé que le bonus a ajouter
        then //il faut appliquer le nouveau bonus dans la SDD, demander l'affichage, et commander la désactivation
                begin
                pcour_joueur.pt_visuel.PUTBONUS_ARMURE(Bonus); //On applique le bonus
                Matrice_Structure[colonne,ligne]^.Ptr_Artefact.PUTACTIF(False);//Désactivation
                If pcour_joueur.pt_visuel.bot=true //Si c'est un bot
                        then MOV_FOND(pdebl_prio,'armure',pcour_joueur);//Alors mise en fin dans le liste des priorités
                //Mise en réactivation dans la FA des réactivations (Ajout dans la FA des réactivations)
                AJOUT_ELEM_FA_INA(pdeb_fa_inact,pfin_fa_inact,GetTickCount+DELAI_ART,Matrice_Structure[colonne,ligne]^.Ptr_Artefact);
                //
                If pcour_joueur=Phumain then
                        begin
                        F_Jeu.ImageList2.GetBitmap(4,F_jeu.I_armure_J1.Picture.Bitmap);
                        F_jeu.I_armure_J1.Repaint;
                        F_jeu.L_armure_J1.Caption:='2';
                        end;
                If (pcour_joueur=Phumain2) or (pcour_joueur=P_bot1) then
                        begin
                        F_Jeu.ImageList2.GetBitmap(4,F_jeu.I_armure_J2.Picture.Bitmap);
                        F_jeu.I_armure_J2.Repaint;
                        F_jeu.L_armure_J2.Caption:='2';
                        end;
                If (pcour_joueur=Phumain3) or (pcour_joueur=P_bot2) then
                        begin
                        F_Jeu.ImageList2.GetBitmap(4,F_jeu.I_armure_J3.Picture.Bitmap);
                        F_jeu.I_armure_J3.Repaint;
                        F_jeu.L_armure_J3.Caption:='2';
                        end;
                If (pcour_joueur=Phumain4) or (pcour_joueur=P_bot3) then
                        begin
                        F_Jeu.ImageList2.GetBitmap(4,F_jeu.I_armure_J4.Picture.Bitmap);
                        F_jeu.I_armure_J4.Repaint;
                        F_jeu.L_armure_J4.Caption:='2';
                        end;
                //
                //Suppression du chemin
                pcour_joueur.pt_visuel.PUTCHEMIN(Nil);
                end;
if (((num=77) or (num=78)) {and (bonus>pcour_joueur.pt_visuel.GETBONUS_ARMURE)}and (Matrice_Structure[colonne,ligne]^.Ptr_Artefact.GETACTIF=true)) //si c'est une armure de niv 3 et que le bonus existant est moins élevé que le bonus a ajouter
        then //il faut appliquer le nouveau bonus dans la SDD, demander l'affichage, et commander la désactivation
                begin
                pcour_joueur.pt_visuel.PUTBONUS_ARMURE(Bonus); //On applique le bonus
                Matrice_Structure[colonne,ligne]^.Ptr_Artefact.PUTACTIF(False);//Désactivation
                If pcour_joueur.pt_visuel.bot=true //Si c'est un bot
                        then MOV_FOND(pdebl_prio,'armure',pcour_joueur);//Alors mise en fin dans le liste des priorités
                //Mise en réactivation dans la FA des réactivations (Ajout dans la FA des réactivations)
                AJOUT_ELEM_FA_INA(pdeb_fa_inact,pfin_fa_inact,GetTickCount+DELAI_ART,Matrice_Structure[colonne,ligne]^.Ptr_Artefact);
                //
                If pcour_joueur=Phumain then
                        begin
                        F_Jeu.ImageList2.GetBitmap(5,F_jeu.I_armure_J1.Picture.Bitmap);
                        F_jeu.I_armure_J1.Repaint;
                        F_jeu.L_armure_J1.Caption:='3';
                        end;
                If (pcour_joueur=Phumain2) or (pcour_joueur=P_bot1) then
                        begin
                        F_Jeu.ImageList2.GetBitmap(5,F_jeu.I_armure_J2.Picture.Bitmap);
                        F_jeu.I_armure_J2.Repaint;
                        F_jeu.L_armure_J2.Caption:='3';
                        end;
                If (pcour_joueur=Phumain3) or (pcour_joueur=P_bot2) then
                        begin
                        F_Jeu.ImageList2.GetBitmap(5,F_jeu.I_armure_J3.Picture.Bitmap);
                        F_jeu.I_armure_J3.Repaint;
                        F_jeu.L_armure_J3.Caption:='3';
                        end;
                If (pcour_joueur=Phumain4) or (pcour_joueur=P_bot3) then
                        begin
                        F_Jeu.ImageList2.GetBitmap(5,F_jeu.I_armure_J4.Picture.Bitmap);
                        F_jeu.I_armure_J4.Repaint;
                        F_jeu.L_armure_J4.Caption:='3';
                        end;
                //
                //Suppression du chemin
                pcour_joueur.pt_visuel.PUTCHEMIN(Nil);
                end;
if (((num=79) or (num=80)) and (Matrice_Structure[colonne,ligne]^.Ptr_Artefact.GETACTIF=true)) //si c'est une vie
        then //il faut appliquer le nouveau bonus dans la SDD, demander l'affichage, et commander la désactivation
                begin
                Pcour_joueur.pt_visuel.PUTVIE(INIT_POINTS_VIE); //On applique le bonus
                Matrice_Structure[colonne,ligne].Ptr_Artefact.PUTACTIF(False);//Désactivation
                If pcour_joueur.pt_visuel.bot=true //Si c'est un bot
                        then MOV_FOND(pdebl_prio,'vie',pcour_joueur);//Alors mise en fin dans le liste des priorités
                //Mise en réactivation dans la FA des réactivations (Ajout dans la FA des réactivations)
                AJOUT_ELEM_FA_INA(pdeb_fa_inact,pfin_fa_inact,GetTickCount+DELAI_ART,Matrice_Structure[colonne,ligne]^.Ptr_Artefact);
                //Suppression du chemin
                pcour_joueur.pt_visuel.PUTCHEMIN(Nil);
                end;
if (((num=85) or (num=86)) and (Matrice_Structure[colonne,ligne]^.Ptr_Artefact.GETACTIF=true)) //si c'est un rubis
        then //il faut appliquer le nouveau bonus dans la SDD, demander l'affichage, et commander la désactivation
                begin
                Pcour_joueur.pt_visuel.PUTXP(XP_RUBIS); //On applique le bonus
                Matrice_Structure[colonne,ligne].Ptr_Artefact.PUTACTIF(False);//Désactivation
                If pcour_joueur.pt_visuel.bot=true //Si c'est un bot
                        then MOV_FOND(pdebl_prio,'xp',pcour_joueur);//Alors mise en fin dans le liste des priorités
                //Mise en réactivation dans la FA des réactivations (Ajout dans la FA des réactivations)
                AJOUT_ELEM_FA_INA(pdeb_fa_inact,pfin_fa_inact,GetTickCount+DELAI_ART,Matrice_Structure[colonne,ligne]^.Ptr_Artefact);
                //Suppression du chemin
                pcour_joueur.pt_visuel.PUTCHEMIN(Nil);
                end;
if (((num=87) or (num=88)) and (Matrice_Structure[colonne,ligne]^.Ptr_Artefact.GETACTIF=true)) //si c'est une emmeraude
        then //il faut appliquer le nouveau bonus dans la SDD, demander l'affichage, et commander la désactivation
                begin
                Pcour_joueur.pt_visuel.PUTXP(XP_EMMERAUDES); //On applique le bonus
                Matrice_Structure[colonne,ligne].Ptr_Artefact.PUTACTIF(False);//Désactivation
                If pcour_joueur.pt_visuel.bot=true //Si c'est un bot
                        then MOV_FOND(pdebl_prio,'xp',pcour_joueur);//Alors mise en fin dans le liste des priorités
                //Mise en réactivation dans la FA des réactivations (Ajout dans la FA des réactivations)
                AJOUT_ELEM_FA_INA(pdeb_fa_inact,pfin_fa_inact,GetTickCount+DELAI_ART,Matrice_Structure[colonne,ligne]^.Ptr_Artefact);
                //Suppression du chemin
                pcour_joueur.pt_visuel.PUTCHEMIN(Nil);
                end;
if (num=81) or (num=82) //si c'est un point de passage
        then
                begin
                //Tant qu'on a pas parcouru toute la liste des priorités
                Paux_prio:=pcour_joueur.pt_visuel.Liste_priorites;
                While Paux_prio.psuiv_prio<>Nil do Paux_prio:=Paux_prio.psuiv_prio;
                Paux_prio.coordonnees_x:=-1;
                Paux_prio.coordonnees_y:=-1;
                pcour_joueur.pt_visuel.PUTCHEMIN(Nil);
                end;

//Si le joueur est au contact du point d'arrivée
If (Pcour_joueur.pt_visuel.GETCHEMIN<>Nil) then
        begin
        Paux_chemin:=Pcour_joueur.pt_visuel.GETCHEMIN;
        While Paux_chemin.ptr_suivant<>Nil do
                Paux_chemin:=Paux_chemin.ptr_suivant;
        If (Paux_chemin.coord_ligne=j) and (Paux_chemin.coord_colonne=i)
                then pcour_joueur.pt_visuel.PUTCHEMIN(Nil);
        end;
        end;

{       TOURNE BIEN MAIS DESACTIVE POUR TESTS
//Si le joueur est au contact du point d'arrivée
If (Pcour_joueur.pt_visuel.GETCHEMIN<>Nil) and (pcour_joueur.pt_visuel.GETCHEMIN.coord_ligne=j) and (pcour_joueur.pt_visuel.GETCHEMIN.coord_colonne=i)
        then pcour_joueur.pt_visuel.PUTCHEMIN(Nil);
        end;                                  }

        {//Suppression des coordonnées de l'élément avec lequel on a agit
        Paux_prio:=pcour_joueur.pt_visuel.Liste_priorites;
        While paux_prio<>nil do
                begin
                if (paux_prio.coordonnees_x=colonne) and (paux_prio.coordonnees_y=ligne)
                        then    begin
                                paux_prio.coordonnees_x:=-1;
                                paux_prio.coordonnees_y:=-1;
                                end;
                paux_prio:=paux_prio.psuiv_prio;
                end;   }
                
        end;
End;
//****************************************************************************//
//****************************************************************************//

//Module de vérification du niveau de l'XP, et module de sortie du jeu si l'XP est suffisant
Procedure VERIF_XP(pcour:T_ptr_VD_joueur);
Begin
If pcour.pt_visuel.GETXP>XP_GAGNANT
        then // nous avons un gaaaagnnnaaaaaaaaannnnnnnnnnnt ...Nelson, "Wevvvvvgotaawinnneeurrrrrrr"!
                begin
                F_jeu.Timer1.Enabled:=False;
                Showmessage('La partie est terminée:'
                +#13+pcour.pt_visuel.GETNOM+': '+inttostr(pcour.pt_visuel.GETXP                                          )
                +#13+pcour^.psuiv.pt_visuel.GETNOM+': '+inttostr(pcour^.psuiv.pt_visuel.GETXP                            )
                +#13+pcour^.psuiv^.psuiv.pt_visuel.GETNOM+': '+inttostr(pcour^.psuiv^.psuiv.pt_visuel.GETXP              )
                +#13+pcour^.psuiv^.psuiv^.psuiv.pt_visuel.GETNOM+': '+inttostr(pcour^.psuiv^.psuiv^.psuiv.pt_visuel.GETXP));
                //Chargement de l'arbre

                //Ecriture dans l'arbre
                //Sauvegarde de l'arbre dans un fichier type
                //Destruction de l'arbre
                //Fin du jeu
                F_Jeu.Hide;
                F_Accueil.Show;
                end;
End;

//****************************************************************************//
//****************************************************************************//

//Ce module effectue le déplacement d'un joueur
//Il met a jour les structures pour que le déplacement soit effectif
//Insere l'image du déplacement dans la liste Tile_to_load
Procedure DEPLACEMENT_JOUEUR(pcour_joueur:T_ptr_VD_joueur; Direction:char; deplacement:integer);
Var
OffsetX,OffsetY,ligne,colonne,j,i:integer;
Begin
//Initialisations
OffsetX:=pcour_joueur.pt_visuel.GETOFFSET_X;
OffsetY:=pcour_joueur.pt_visuel.GETOFFSET_Y;
ligne  :=pcour_joueur.pt_visuel.GETLIGNE;
colonne:=pcour_joueur.pt_visuel.GETCOLONNE;
Case Direction of
'U' :
        begin
        If OffsetY >= deplacement //si l'offset courant est supérieur ou = à la possibilité de déplacement
                then //on ne change pas de case, on se déplace dans la case courante dc on ne met a jour que les offsets
                        begin
                        pcour_joueur.pt_visuel.PUTOFFSET_Y(OffsetY-deplacement);
                        If pcour_joueur.pt_visuel.numimage<>2
                                then pcour_joueur.pt_visuel.numimage:=pcour_joueur.pt_visuel.numimage+1
                                else pcour_joueur.pt_visuel.numimage:=0;
                        end
                else //on change de case alors il faut réagir
                        begin
                        If (ligne-1)>=0 then
                                pcour_joueur.pt_visuel.PUTLIGNE(ligne-1);//la ligne prend -1 (on se déplace vers le haut)
                        deplacement:=deplacement-OffsetY;//on supprime tous les pixels sur la case courante
                        pcour_joueur.pt_visuel.PUTOFFSET_Y(TILE_SIZE-deplacement); //on met a jour l'offset sur la case suivante
                        If pcour_joueur.pt_visuel.numimage<>2
                                then pcour_joueur.pt_visuel.numimage:=pcour_joueur.pt_visuel.numimage+1
                                else pcour_joueur.pt_visuel.numimage:=0;
                        //Changement de repère dans la matrice
                        {if pcour_joueur.pt_visuel.GETCOLONNE > 19
                        then showmessage('tu sors!..a cause de ta colonne');
                        if pcour_joueur.pt_visuel.GETLIGNE > 14
                        then showmessage('tu sors!..a cause de ta ligne'); }
                        Matrice_Structure[colonne,ligne].Ptr_Joueur:=Nil;
                        Matrice_Structure[pcour_joueur.pt_visuel.GETCOLONNE,pcour_joueur.pt_visuel.GETLIGNE].Ptr_Joueur:=pcour_joueur;
                        end;
        end;
'D' :
        begin
        If OffsetY+Deplacement < TILE_SIZE //si l'offset courant après déplacement est inférieur à la largeur de la case
                then //on ne change pas de case, on se déplace dans la case courante dc on ne met a jour que les offsets
                        begin
                        pcour_joueur.pt_visuel.PUTOFFSET_Y(OffsetY+deplacement);
                        If pcour_joueur.pt_visuel.numimage<>2
                                then pcour_joueur.pt_visuel.numimage:=pcour_joueur.pt_visuel.numimage+1
                                else pcour_joueur.pt_visuel.numimage:=0;
                        end
                else //on change de case alors il faut réagir
                        begin
                        //Si on est sur la dernière ligne
                        If pcour_joueur.pt_visuel.GETLIGNE=MAP_HEIGHT-2
                                then
                                        begin
                                        //Pcour_joueur.pt_visuel.PUTORIENTATION('R');
                                        pcour_joueur.pt_visuel.PUTOFFSET_Y(0);
                                        pcour_joueur.pt_visuel.PUTLIGNE(MAP_HEIGHT-1);
                                        If pcour_joueur.pt_visuel.numimage<>2
                                                then pcour_joueur.pt_visuel.numimage:=pcour_joueur.pt_visuel.numimage+1
                                                else pcour_joueur.pt_visuel.numimage:=0;
                                        //Changement de repère dans la matrice
                                        Matrice_Structure[colonne,ligne].Ptr_Joueur:=Nil;
                                        Matrice_Structure[pcour_joueur.pt_visuel.GETCOLONNE,pcour_joueur.pt_visuel.GETLIGNE].Ptr_Joueur:=pcour_joueur;
                                        end
                                else
                                        begin
                                        //Si on est pas sur la dernière ligne
                                        If (ligne+1)<(MAP_HEIGHT-1) then
                                                pcour_joueur.pt_visuel.PUTLIGNE(ligne+1);//la ligne prend +1 (on se déplace vers le bas)
                                        pcour_joueur.pt_visuel.PUTOFFSET_Y(OffsetY+deplacement-TILE_SIZE); //on met à jour l'offset sur la case suivante
                                        If pcour_joueur.pt_visuel.numimage<>2
                                                then pcour_joueur.pt_visuel.numimage:=pcour_joueur.pt_visuel.numimage+1
                                                else pcour_joueur.pt_visuel.numimage:=0;
                                        //Changement de repère dans la matrice
                                        Matrice_Structure[colonne,ligne].Ptr_Joueur:=Nil;
                                        Matrice_Structure[pcour_joueur.pt_visuel.GETCOLONNE,pcour_joueur.pt_visuel.GETLIGNE].Ptr_Joueur:=pcour_joueur;
                                        End;
                        end;
        end;
'R' :
        begin
        If OffsetX+Deplacement < TILE_SIZE //si l'offset courant après déplacement est inférieur à la largeur de la case
                then //on ne change pas de case, on se déplace dans la case courante dc on ne met a jour que les offsets
                        begin
                        pcour_joueur.pt_visuel.PUTOFFSET_X(OffsetX+deplacement);
                        If pcour_joueur.pt_visuel.numimage<>2
                                then pcour_joueur.pt_visuel.numimage:=pcour_joueur.pt_visuel.numimage+1
                                else pcour_joueur.pt_visuel.numimage:=0;
                        end
                else //on change de case alors il faut réagir
                        begin
                        //Si on est sur la dernière colonne
                        If pcour_joueur.pt_visuel.GETCOLONNE=MAP_WIDTH-2
                                then
                                        begin
                                        pcour_joueur.pt_visuel.PUTOFFSET_X(0);
                                        pcour_joueur.pt_visuel.PUTCOLONNE(MAP_WIDTH-1);
                                        If pcour_joueur.pt_visuel.numimage<>2
                                                then pcour_joueur.pt_visuel.numimage:=pcour_joueur.pt_visuel.numimage+1
                                                else pcour_joueur.pt_visuel.numimage:=0;
                                        //Changement de repère dans la matrice
                                        Matrice_Structure[colonne,ligne].Ptr_Joueur:=Nil;
                                        Matrice_Structure[pcour_joueur.pt_visuel.GETCOLONNE,pcour_joueur.pt_visuel.GETLIGNE].Ptr_Joueur:=pcour_joueur;
                                        end
                                else
                                        begin
                                        //Si on est pas sur la dernière ligne
                                        If (colonne+1)<(MAP_WIDTH-1) then
                                                pcour_joueur.pt_visuel.PUTCOLONNE(colonne+1);//la colonne prend +1 (on se déplace vers la droite)
                                        pcour_joueur.pt_visuel.PUTOFFSET_X(OffsetX+deplacement-TILE_SIZE); //on met a jour l'offset sur la case suivante
                                        If pcour_joueur.pt_visuel.numimage<>2
                                                then pcour_joueur.pt_visuel.numimage:=pcour_joueur.pt_visuel.numimage+1
                                                else pcour_joueur.pt_visuel.numimage:=0;
                                        //Changement de repère dans la matrice
                                        Matrice_Structure[colonne,ligne].Ptr_Joueur:=Nil;
                                        Matrice_Structure[pcour_joueur.pt_visuel.GETCOLONNE,pcour_joueur.pt_visuel.GETLIGNE].Ptr_Joueur:=pcour_joueur;
                                        end;
                        End;
        end;
'L' :
        begin
        If OffsetX-deplacement >= 0 //si l'offset courant est supérieur ou = à la possibilité de déplacement
                then //on ne change pas de case, on se déplace dans la case courante dc on ne met à jour que les offsets
                        begin
                        pcour_joueur.pt_visuel.PUTOFFSET_X(OffsetX-deplacement);
                        If pcour_joueur.pt_visuel.numimage<>2
                                then pcour_joueur.pt_visuel.numimage:=pcour_joueur.pt_visuel.numimage+1
                                else pcour_joueur.pt_visuel.numimage:=0;
                        end
                else //on change de case alors il faut réagir
                        begin
                        If (colonne-1)>=0 then
                                pcour_joueur.pt_visuel.PUTCOLONNE(colonne-1);//la colonne prend -1 (on se déplace vers la gauche)
                        deplacement:=deplacement-OffsetX;       //on supprime tous les pixels sur la case courante
                        pcour_joueur.pt_visuel.PUTOFFSET_X(TILE_SIZE-deplacement); //on met a jour l'offset sur la case suivante
                        If pcour_joueur.pt_visuel.numimage<>2
                                then pcour_joueur.pt_visuel.numimage:=pcour_joueur.pt_visuel.numimage+1
                                else pcour_joueur.pt_visuel.numimage:=0;
                        //Changement de repère dans la matrice
                        Matrice_Structure[colonne,ligne].Ptr_Joueur:=Nil;
                        Matrice_Structure[pcour_joueur.pt_visuel.GETCOLONNE,pcour_joueur.pt_visuel.GETLIGNE].Ptr_Joueur:=pcour_joueur;
                        end;
        end;
End;
End;

//****************************************************************************//
//****************************************************************************//

//Module retournant le pointeur vers l'ennemi considéré
Function GET_POINTEUR_ENNEMI(p_joueur_courant:T_ptr_VD_joueur):T_ptr_VD_joueur;
Var
ligne,colonne,i:integer;
pcour:T_ptr_VD_joueur;
Begin
//On choppe les lignes et colonnes du joueur courant pour savoir quel est l'ennemi qu'il touche
ligne:=p_joueur_courant.pt_visuel.GETLIGNE;
colonne:=p_joueur_courant.pt_visuel.GETCOLONNE;
//initialisation de pcour
pcour:=p_joueur_courant^.psuiv;
For i:=1 to 3 do
begin
Case p_joueur_courant.pt_visuel.GETORIENTATION of
'U':    begin
        If (pcour.pt_visuel.GETLIGNE=(ligne-1)) and ((pcour.pt_visuel.GETCOLONNE=(colonne-1))or (pcour.pt_visuel.GETCOLONNE=(colonne)) or (pcour.pt_visuel.GETCOLONNE=(colonne+1)) )
                then // alors le joueur est sur une des 3 cases du dessus donc on le touche en le frappant
                GET_POINTEUR_ENNEMI:=pcour;
        end;
'D':    begin
        If (pcour.pt_visuel.GETLIGNE=(ligne+1)) and ((pcour.pt_visuel.GETCOLONNE=(colonne-1))or (pcour.pt_visuel.GETCOLONNE=(colonne)) or (pcour.pt_visuel.GETCOLONNE=(colonne+1)) )
                then // alors le joueur est sur une des 3 cases du dessous donc on le touche en le frappant
                GET_POINTEUR_ENNEMI:=pcour;
        end;
'L':    begin
        If (pcour.pt_visuel.GETCOLONNE=(colonne-1)) and ((pcour.pt_visuel.GETLIGNE=(ligne-1))or (pcour.pt_visuel.GETLIGNE=(ligne)) or (pcour.pt_visuel.GETLIGNE=(ligne+1)) )
                then // alors le joueur est sur une des 3 cases de gauche donc on le touche en le frappant
                GET_POINTEUR_ENNEMI:=pcour;
        end;
'R':    begin
        If (pcour.pt_visuel.GETCOLONNE=(colonne+1)) and ((pcour.pt_visuel.GETLIGNE=(ligne-1))or (pcour.pt_visuel.GETLIGNE=(ligne)) or (pcour.pt_visuel.GETLIGNE=(ligne+1)) )
                then // alors le joueur est sur une des 3 cases de droite donc on le touche en le frappant
                GET_POINTEUR_ENNEMI:=pcour;
        end;
End; //end du case Of
pcour:=pcour^.psuiv;
End;
end;

//****************************************************************************//
//****************************************************************************//

//Module de calcul du décallage a appliquer au Blessé
Procedure CALCUL_DECALLAGE(var DecalX:integer; var DecalY:integer;pcour_joueur,p_ennemi:T_ptr_VD_joueur);
Var
DistanceX,DistanceY:integer;
Begin
DistanceX:=Abs((pcour_joueur.pt_visuel.GETCOLONNE*32+pcour_joueur.pt_visuel.GETOFFSET_X)-(P_ennemi.pt_visuel.GETCOLONNE*32+P_ennemi.pt_visuel.GETOFFSET_X));
DistanceY:=Abs((pcour_joueur.pt_visuel.GETLIGNE*32+pcour_joueur.pt_visuel.GETOFFSET_Y)-(P_ennemi.pt_visuel.GETLIGNE*32+P_ennemi.pt_visuel.GETOFFSET_Y));
End;

//****************************************************************************//
//****************************************************************************//

//Module effectuant le calcul des dégats infligés,
//Désctivation de la personne touchée
//Mise a jour des priorités de la personne touchée
Procedure COMBAT(pcour_joueur,p_ennemi:T_ptr_VD_joueur);
Var
Attaque, Defense, degats, DecalX, DecalY, Vitesse, dist:integer;
tile:TBitmap;
OldDirection,Dir:char;
Begin
//p_ennemi:=Matrice_Structure[ligne,colonne].Ptr_Joueur;
//Calcul des dégats infligés
Attaque:=Round((pcour_joueur.pt_visuel.GETFORCE+pcour_joueur.pt_visuel.GETATTAQUE+pcour_joueur.pt_visuel.GETPRECISION+pcour_joueur.pt_visuel.GETBONUS_ATTAQUE)/2);
Defense:=Round((p_ennemi.pt_visuel.GETARMURE+p_ennemi.pt_visuel.GETENDURANCE+pcour_joueur.pt_visuel.GETBONUS_ARMURE)/3);
Degats:=Attaque-defense;
//Au cas ou un naze en attaque frappe un grosbill en défense
//(n'arrivera pas tous les jours tout de même mais bon on est jamais trop prudent ;o) 
If degats < 0 then degats := 0;
//Application des dégats
p_ennemi.pt_visuel.PUTVIE(p_ennemi.pt_visuel.GETVIE-degats);
//Showmessage(inttostr(Pcour_joueur.pt_visuel.GETXP)+' '+inttostr(degats));
If pcour_joueur.pt_visuel.bot
        then
        Pcour_joueur.pt_visuel.PUTXP(round(degats/2))
        else
        Pcour_joueur.pt_visuel.PUTXP(degats);
//Désactivation du blessé
//p_ennemi.pt_visuel.PUTACTIF(false);
//pcour_joueur.pt_visuel.PUTACTIF(False);
//Ajout du Blessé à la liste des réactivations

AJOUT_ELEM_FA_INA(pdeb_fa_inact,pfin_fa_inact,GetTickCount+DELAI_JOU_BLES,p_ennemi.pt_visuel);

//Mise a jour des priorités du blessé (si sa vie est trop basse)
//Calcul du décallage (géographique) du blessé
//CALCUL_DECALLAGE(DecalX,DecalY,pcour_joueur,p_ennemi);

        //***************Décallage directionnel***************

//Tourner le perso qui se fait frapper dans la direction du mouvement
OldDirection:=p_ennemi.pt_visuel.GETORIENTATION;
p_ennemi.pt_visuel.PUTORIENTATION(pcour_joueur.pt_visuel.GETORIENTATION);
//Cas des 4 directions
Dir:=p_ennemi.pt_visuel.GETORIENTATION;
dist:=0;
Case Dir Of
'D':
        Begin
        //Si déplacement possible et déplacement d'au moins 32 pixels possible
        If DEPLACEMENT_POSSIBLE(vitesse,dist,i,j,x,y,trouve,p_ennemi) then
                begin
                If dist>=TILE_SIZE //Si on peut bouger d'une case complête
                        then //déplacement sans réflechir
                                Begin
                                //Si on reste dans le cadre
                                If (p_ennemi.pt_visuel.GETLIGNE*TILE_SIZE+1)<=((MAP_HEIGHT-1)*TILE_SIZE)
                                        then
                                        begin
                                        matrice_structure[p_ennemi.pt_visuel.GETCOLONNE,p_ennemi.pt_visuel.GETLIGNE].Ptr_Joueur:=Nil;
                                        p_ennemi.pt_visuel.PUTLIGNE(p_ennemi.pt_visuel.GETLIGNE+1);
                                        matrice_structure[p_ennemi.pt_visuel.GETCOLONNE,p_ennemi.pt_visuel.GETLIGNE].Ptr_Joueur:=P_ennemi;
                                        end;
                                end
                        else //il faut le déplacer pour l'envoyer au contact
                                begin
                                If (p_ennemi.pt_visuel.GETOFFSET_Y+dist<TILE_SIZE)
                                        then //on reste sur la meme case
                                        p_ennemi.pt_visuel.PUTOFFSET_Y(p_ennemi.pt_visuel.GETOFFSET_Y+Vitesse)
                                        else
                                                begin
                                                matrice_structure[p_ennemi.pt_visuel.GETCOLONNE,p_ennemi.pt_visuel.GETLIGNE].Ptr_Joueur:=Nil;
                                                //On se déplace au max sur la case courante
                                                //Vitesse:=Vitesse-TILE_SIZE;
                                                p_ennemi.pt_visuel.PUTLIGNE(p_ennemi.pt_visuel.GETLIGNE+1);
                                                p_ennemi.pt_visuel.PUTOFFSET_Y(dist);
                                                matrice_structure[p_ennemi.pt_visuel.GETCOLONNE,p_ennemi.pt_visuel.GETLIGNE].Ptr_Joueur:=P_ennemi;
                                                end;
                                end;
                end;
        End;
'U':
        Begin
        //Si déplacement possible
        If DEPLACEMENT_POSSIBLE(vitesse,dist,i,j,x,y,trouve,p_ennemi) then
                begin
                If dist>=TILE_SIZE //Si on peut bouger d'une case complête
                        then //déplacement sans réflechir
                                begin
                                //Si on reste dans le cadre
                                If (p_ennemi.pt_visuel.GETLIGNE*TILE_SIZE-1)>=0
                                        then
                                        begin
                                        matrice_structure[p_ennemi.pt_visuel.GETCOLONNE,p_ennemi.pt_visuel.GETLIGNE].Ptr_Joueur:=Nil;
                                        p_ennemi.pt_visuel.PUTLIGNE(p_ennemi.pt_visuel.GETLIGNE-1);
                                        matrice_structure[p_ennemi.pt_visuel.GETCOLONNE,p_ennemi.pt_visuel.GETLIGNE].Ptr_Joueur:=P_ennemi;
                                        end;
                                end
                        else //il faut le déplacer pour l'envoyer au contact
                                begin
                                If (p_ennemi.pt_visuel.GETOFFSET_Y-dist>=0)
                                        then //on reste sur la meme case
                                        p_ennemi.pt_visuel.PUTOFFSET_Y(p_ennemi.pt_visuel.GETOFFSET_Y-dist)
                                        else
                                                begin
                                                matrice_structure[p_ennemi.pt_visuel.GETCOLONNE,p_ennemi.pt_visuel.GETLIGNE].Ptr_Joueur:=Nil;
                                                //On se déplace au max sur la case courante
                                                //Vitesse:=TILE_SIZE-Vitesse+p_ennemi.pt_visuel.GETOFFSET_Y;
                                                p_ennemi.pt_visuel.PUTLIGNE(p_ennemi.pt_visuel.GETLIGNE-1);
                                                p_ennemi.pt_visuel.PUTOFFSET_Y(dist);
                                                matrice_structure[p_ennemi.pt_visuel.GETCOLONNE,p_ennemi.pt_visuel.GETLIGNE].Ptr_Joueur:=P_ennemi;
                                                end;
                                end;
                end;
        End;
'L':
        Begin
        //Si déplacement possible et déplacement d'au moins 32 pixels possible
        If DEPLACEMENT_POSSIBLE(vitesse,dist,i,j,x,y,trouve,p_ennemi) then
                begin
                If dist>=TILE_SIZE //Si on peut bouger d'une case complête
                        then //déplacement sans réflechir
                                begin
                                //Si on reste dans le cadre
                                If (p_ennemi.pt_visuel.GETCOLONNE*TILE_SIZE-1)>=0
                                        then
                                        begin
                                        matrice_structure[p_ennemi.pt_visuel.GETCOLONNE,p_ennemi.pt_visuel.GETLIGNE].Ptr_Joueur:=Nil;
                                        p_ennemi.pt_visuel.PUTCOLONNE(p_ennemi.pt_visuel.GETCOLONNE-1);
                                        matrice_structure[p_ennemi.pt_visuel.GETCOLONNE,p_ennemi.pt_visuel.GETLIGNE].Ptr_Joueur:=P_ennemi;
                                        end;
                                end
                        else //il faut le déplacer pour l'envoyer au contact
                                begin
                                If (p_ennemi.pt_visuel.GETOFFSET_X-dist>=0)
                                        then //on reste sur la meme case
                                        p_ennemi.pt_visuel.PUTOFFSET_X(p_ennemi.pt_visuel.GETOFFSET_X-dist)
                                        else
                                                begin
                                                matrice_structure[p_ennemi.pt_visuel.GETCOLONNE,p_ennemi.pt_visuel.GETLIGNE].Ptr_Joueur:=Nil;
                                                //On se déplace au max sur la case courante
                                                //Vitesse:=TILE_SIZE-Vitesse+p_ennemi.pt_visuel.GETOFFSET_X;
                                                p_ennemi.pt_visuel.PUTCOLONNE(p_ennemi.pt_visuel.GETCOLONNE-1);
                                                p_ennemi.pt_visuel.PUTOFFSET_X(dist);
                                                matrice_structure[p_ennemi.pt_visuel.GETCOLONNE,p_ennemi.pt_visuel.GETLIGNE].Ptr_Joueur:=P_ennemi;
                                                end;
                                end;
                end;
        End;
'R':
        Begin
                //Si déplacement possible et déplacement d'au moins 32 pixels possible
        If DEPLACEMENT_POSSIBLE(vitesse,dist,i,j,x,y,trouve,p_ennemi) then
                begin
                If dist>=TILE_SIZE //Si on peut bouger d'une case complête
                        then //déplacement sans réflechir
                                Begin
                                //Si on reste dans le cadre
                                If (p_ennemi.pt_visuel.GETCOLONNE*TILE_SIZE+1)<=((MAP_WIDTH-1)*TILE_SIZE)
                                        then
                                        begin
                                        matrice_structure[p_ennemi.pt_visuel.GETCOLONNE,p_ennemi.pt_visuel.GETLIGNE].Ptr_Joueur:=Nil;
                                        p_ennemi.pt_visuel.PUTCOLONNE(p_ennemi.pt_visuel.GETCOLONNE+1);
                                        matrice_structure[p_ennemi.pt_visuel.GETCOLONNE,p_ennemi.pt_visuel.GETLIGNE].Ptr_Joueur:=P_ennemi;
                                        end;
                                end
                        else //il faut le déplacer pour l'envoyer au contact
                                begin
                                If (p_ennemi.pt_visuel.GETOFFSET_X+dist<TILE_SIZE)
                                        then //on reste sur la meme case
                                        p_ennemi.pt_visuel.PUTOFFSET_X(p_ennemi.pt_visuel.GETOFFSET_X+dist)
                                        else
                                                begin
                                                matrice_structure[p_ennemi.pt_visuel.GETCOLONNE,p_ennemi.pt_visuel.GETLIGNE].Ptr_Joueur:=Nil;
                                                //On se déplace au max sur la case courante
                                                //Vitesse:=Vitesse-TILE_SIZE;
                                                p_ennemi.pt_visuel.PUTCOLONNE(p_ennemi.pt_visuel.GETCOLONNE+1);
                                                p_ennemi.pt_visuel.PUTOFFSET_X(dist);
                                                matrice_structure[p_ennemi.pt_visuel.GETCOLONNE,p_ennemi.pt_visuel.GETLIGNE].Ptr_Joueur:=P_ennemi;
                                                end;
                                end;
                end;
        End;
end;
//Tourner le perso qui s'est fait frapper dans la direction d'origine
p_ennemi.pt_visuel.PUTORIENTATION(OldDirection);
//Ajout des images du blessé dans la FA des images
Case p_ennemi.pt_visuel.GETORIENTATION of
        'D' : Tile:=p_ennemi.pt_visuel.Sprites[0,0];
        'L' : Tile:=p_ennemi.pt_visuel.Sprites[1,0];
        'U' : Tile:=p_ennemi.pt_visuel.Sprites[2,0];
        'R' : Tile:=p_ennemi.pt_visuel.Sprites[3,0];
        End;
AJOUT_ELEM_STR_AFFICHAGE(pdebl_toload,pcour_toload,p_ennemi.pt_visuel.GETLIGNE*TILE_SIZE+p_ennemi.pt_visuel.GETOFFSET_Y,p_ennemi.pt_visuel.GETCOLONNE*TILE_SIZE+p_ennemi.pt_visuel.GETOFFSET_X,Gettickcount+DELAI_JOU_BLES,Gettickcount+DELAI_JOU_BLES,tile);
End;

//****************************************************************************//
//****************************************************************************//

//Module d'ajout des images du personnage qui vient de frapper
//Désativation du frappeur
Procedure AFFICHE_COMBAT(pcour_joueur:T_ptr_VD_joueur);
Var
CoordX_jou,CoordY_jou,CoordX_arm,CoordY_arm,now:integer;
Tile1,Tile2,Tile3:Tbitmap;
Begin
//Jouer son attaque
playsound(Pchar(SON_ATTAQUE),F_jeu.Handle,snd_sync or snd_async);
//Désactivation du frappeur
pcour_joueur.pt_visuel.PUTACTIF(false);
//Ajout du personnage dans la FA des désactivations
AJOUT_ELEM_FA_INA(pdeb_fa_inact,pfin_fa_inact,GetTickCount+DELAI_JOU_FRAP*3,pcour_joueur.pt_visuel);
//Initialisation des coordonnées des images
CoordX_jou:=Pcour_joueur.pt_visuel.GETCOLONNE*TILE_SIZE+Pcour_joueur.pt_visuel.GETOFFSET_X;
CoordY_jou:=Pcour_joueur.pt_visuel.GETLIGNE*TILE_SIZE+Pcour_joueur.pt_visuel.GETOFFSET_Y;
CoordX_arm:=Pcour_joueur.pt_visuel.GETCOLONNE*TILE_SIZE+Pcour_joueur.pt_visuel.GETOFFSET_X;
CoordY_arm:=Pcour_joueur.pt_visuel.GETLIGNE*TILE_SIZE+Pcour_joueur.pt_visuel.GETOFFSET_Y;
//Choix des images
Tile1:=Tbitmap.Create;
Tile2:=Tbitmap.Create;
Tile3:=Tbitmap.Create;
Now:=GetTickCount;
//Cas des Frappages intempestifs
Case Pcour_joueur.pt_visuel.GETORIENTATION of
        'D': begin
                //Ajout des armes dans la direction down
                Tile1:=Armes[0,0];
                Tile2:=Armes[0,1];
                Tile3:=Armes[0,2];
                //Image 1
                //Ajout des images du frappeur dans la FA d'affichage des images
                //AJOUT_ELEM_STR_AFFICHAGE(pdebl_toload,pcour_toload,CoordX_jou,CoordY_jou,now,now+DELAI_JOU_FRAP*3,pcour_joueur.pt_visuel.Sprites[0,0]);
                //Coordonnées d'affichage de l'arme
                CoordX_arm:=Pcour_joueur.pt_visuel.GETCOLONNE*TILE_SIZE+Pcour_joueur.pt_visuel.GETOFFSET_X-6;
                CoordY_arm:=Pcour_joueur.pt_visuel.GETLIGNE*TILE_SIZE+Pcour_joueur.pt_visuel.GETOFFSET_Y+14;
                //Ajout de l'arme dans la FA d'affichage
                AJOUT_ELEM_STR_AFFICHAGE(pdebl_toload,pcour_toload,CoordX_arm,CoordY_arm,now,now+DELAI_JOU_FRAP,Tile1);
                //Image 2
                //Ajout des images du frappeur dans la FA d'affichage des images
        //AJOUT_ELEM_STR_AFFICHAGE(pdebl_toload,pcour_toload,CoordX_jou,CoordY_jou,now+DELAI_JOU_FRAP*2,pcour_joueur.pt_visuel.Sprites[0,0]);
                //Coordonnées d'affichage de l'arme
                CoordX_arm:=Pcour_joueur.pt_visuel.GETCOLONNE*TILE_SIZE+Pcour_joueur.pt_visuel.GETOFFSET_X+10;
                CoordY_arm:=Pcour_joueur.pt_visuel.GETLIGNE*TILE_SIZE+Pcour_joueur.pt_visuel.GETOFFSET_Y+20;
                //Ajout de l'arme dans la FA d'affichage
                AJOUT_ELEM_STR_AFFICHAGE(pdebl_toload,pcour_toload,CoordX_arm,CoordY_arm,now+DELAI_JOU_FRAP,now+DELAI_JOU_FRAP*2,Tile2);
                //Image 3
                //Ajout des images du frappeur dans la FA d'affichage des images
        //AJOUT_ELEM_STR_AFFICHAGE(pdebl_toload,pcour_toload,CoordX_jou,CoordY_jou,now+DELAI_JOU_FRAP*3,pcour_joueur.pt_visuel.Sprites[0,0]);
                //Coordonnées d'affichage de l'arme
                CoordX_arm:=Pcour_joueur.pt_visuel.GETCOLONNE*TILE_SIZE+Pcour_joueur.pt_visuel.GETOFFSET_X+28;
                CoordY_arm:=Pcour_joueur.pt_visuel.GETLIGNE*TILE_SIZE+Pcour_joueur.pt_visuel.GETOFFSET_Y+20;
                //Ajout de l'arme dans la FA d'affichage
                AJOUT_ELEM_STR_AFFICHAGE(pdebl_toload,pcour_toload,CoordX_arm,CoordY_arm,now+DELAI_JOU_FRAP*2,now+DELAI_JOU_FRAP*3,Tile3);
             End;
        'L': begin
                Tile1:=Armes[1,0];
                Tile2:=Armes[1,1];
                Tile3:=Armes[1,2];
                //Image 1
                //AJOUT_ELEM_STR_AFFICHAGE(pdebl_toload,pcour_toload,CoordX_jou,CoordY_jou,now,now+DELAI_JOU_FRAP*3,pcour_joueur.pt_visuel.Sprites[1,0]);

                CoordX_arm:=Pcour_joueur.pt_visuel.GETCOLONNE*TILE_SIZE+Pcour_joueur.pt_visuel.GETOFFSET_X-17;
                CoordY_arm:=Pcour_joueur.pt_visuel.GETLIGNE*TILE_SIZE+Pcour_joueur.pt_visuel.GETOFFSET_Y-17;
                AJOUT_ELEM_STR_AFFICHAGE(pdebl_toload,pcour_toload,CoordX_arm,CoordY_arm,now,now+DELAI_JOU_FRAP,Tile1);
                //Image 2
        //AJOUT_ELEM_STR_AFFICHAGE(pdebl_toload,pcour_toload,CoordX_jou,CoordY_jou,now+DELAI_JOU_FRAP,pcour_joueur.pt_visuel.Sprites[1,0]);
                CoordX_arm:=Pcour_joueur.pt_visuel.GETCOLONNE*TILE_SIZE+Pcour_joueur.pt_visuel.GETOFFSET_X-25;
                CoordY_arm:=Pcour_joueur.pt_visuel.GETLIGNE*TILE_SIZE+Pcour_joueur.pt_visuel.GETOFFSET_Y+7;
                AJOUT_ELEM_STR_AFFICHAGE(pdebl_toload,pcour_toload,CoordX_arm,CoordY_arm,now+DELAI_JOU_FRAP,now+DELAI_JOU_FRAP*2,Tile2);
                //Image 3
        //AJOUT_ELEM_STR_AFFICHAGE(pdebl_toload,pcour_toload,CoordX_jou,CoordY_jou,now+DELAI_JOU_FRAP*2,pcour_joueur.pt_visuel.Sprites[1,0]);
                CoordX_arm:=Pcour_joueur.pt_visuel.GETCOLONNE*TILE_SIZE+Pcour_joueur.pt_visuel.GETOFFSET_X-14;
                CoordY_arm:=Pcour_joueur.pt_visuel.GETLIGNE*TILE_SIZE+Pcour_joueur.pt_visuel.GETOFFSET_Y+25;
                AJOUT_ELEM_STR_AFFICHAGE(pdebl_toload,pcour_toload,CoordX_arm,CoordY_arm,now+DELAI_JOU_FRAP*2,now+DELAI_JOU_FRAP*3,Tile3);
             End;
        'U': begin
                Tile1:=Armes[2,0];
                Tile2:=Armes[2,1];
                Tile3:=Armes[2,2];
                //Image 1
                //AJOUT_ELEM_STR_AFFICHAGE(pdebl_toload,pcour_toload,CoordX_jou,CoordY_jou,now,now+DELAI_JOU_FRAP*3,pcour_joueur.pt_visuel.Sprites[2,0]);

                CoordX_arm:=Pcour_joueur.pt_visuel.GETCOLONNE*TILE_SIZE+Pcour_joueur.pt_visuel.GETOFFSET_X-20;
                CoordY_arm:=Pcour_joueur.pt_visuel.GETLIGNE*TILE_SIZE+Pcour_joueur.pt_visuel.GETOFFSET_Y-19;
                AJOUT_ELEM_STR_AFFICHAGE(pdebl_toload,pcour_toload,CoordX_arm,CoordY_arm,now,now+DELAI_JOU_FRAP,Tile1);
                //Image 2
        //AJOUT_ELEM_STR_AFFICHAGE(pdebl_toload,pcour_toload,CoordX_jou,CoordY_jou,now+DELAI_JOU_FRAP,pcour_joueur.pt_visuel.Sprites[2,0]);
                CoordX_arm:=Pcour_joueur.pt_visuel.GETCOLONNE*TILE_SIZE+Pcour_joueur.pt_visuel.GETOFFSET_X-0;
                CoordY_arm:=Pcour_joueur.pt_visuel.GETLIGNE*TILE_SIZE+Pcour_joueur.pt_visuel.GETOFFSET_Y-22;
                AJOUT_ELEM_STR_AFFICHAGE(pdebl_toload,pcour_toload,CoordX_arm,CoordY_arm,now+DELAI_JOU_FRAP,now+DELAI_JOU_FRAP*2,Tile2);
                //Image 3
        //AJOUT_ELEM_STR_AFFICHAGE(pdebl_toload,pcour_toload,CoordX_jou,CoordY_jou,now+DELAI_JOU_FRAP*2,pcour_joueur.pt_visuel.Sprites[2,0]);
                CoordX_arm:=Pcour_joueur.pt_visuel.GETCOLONNE*TILE_SIZE+Pcour_joueur.pt_visuel.GETOFFSET_X+18;
                CoordY_arm:=Pcour_joueur.pt_visuel.GETLIGNE*TILE_SIZE+Pcour_joueur.pt_visuel.GETOFFSET_Y-15;
                AJOUT_ELEM_STR_AFFICHAGE(pdebl_toload,pcour_toload,CoordX_arm,CoordY_arm,now+DELAI_JOU_FRAP*2,now+DELAI_JOU_FRAP*3,Tile3);
             End;
        'R': begin
                Tile1:=Armes[3,0];
                Tile2:=Armes[3,1];
                Tile3:=Armes[3,2];
                //Image 1
                //AJOUT_ELEM_STR_AFFICHAGE(pdebl_toload,pcour_toload,CoordX_jou,CoordY_jou,now,now+DELAI_JOU_FRAP*3,pcour_joueur.pt_visuel.Sprites[3,0]);

                CoordX_arm:=Pcour_joueur.pt_visuel.GETCOLONNE*TILE_SIZE+Pcour_joueur.pt_visuel.GETOFFSET_X+12;
                CoordY_arm:=Pcour_joueur.pt_visuel.GETLIGNE*TILE_SIZE+Pcour_joueur.pt_visuel.GETOFFSET_Y-18;
                AJOUT_ELEM_STR_AFFICHAGE(pdebl_toload,pcour_toload,CoordX_arm,CoordY_arm,now,now+DELAI_JOU_FRAP,Tile1);
                //Image 2
        //AJOUT_ELEM_STR_AFFICHAGE(pdebl_toload,pcour_toload,CoordX_jou,CoordY_jou,now+DELAI_JOU_FRAP,pcour_joueur.pt_visuel.Sprites[3,0]);
                CoordX_arm:=Pcour_joueur.pt_visuel.GETCOLONNE*TILE_SIZE+Pcour_joueur.pt_visuel.GETOFFSET_X+20;
                CoordY_arm:=Pcour_joueur.pt_visuel.GETLIGNE*TILE_SIZE+Pcour_joueur.pt_visuel.GETOFFSET_Y+5;
                AJOUT_ELEM_STR_AFFICHAGE(pdebl_toload,pcour_toload,CoordX_arm,CoordY_arm,now+DELAI_JOU_FRAP,now+DELAI_JOU_FRAP*2,Tile2);
                //Image 3
        //AJOUT_ELEM_STR_AFFICHAGE(pdebl_toload,pcour_toload,CoordX_jou,CoordY_jou,now+DELAI_JOU_FRAP*2,pcour_joueur.pt_visuel.Sprites[3,0]);
                CoordX_arm:=Pcour_joueur.pt_visuel.GETCOLONNE*TILE_SIZE+Pcour_joueur.pt_visuel.GETOFFSET_X+20;
                CoordY_arm:=Pcour_joueur.pt_visuel.GETLIGNE*TILE_SIZE+Pcour_joueur.pt_visuel.GETOFFSET_Y+20;
                AJOUT_ELEM_STR_AFFICHAGE(pdebl_toload,pcour_toload,CoordX_arm,CoordY_arm,now+DELAI_JOU_FRAP*2,now+DELAI_JOU_FRAP*3,Tile3);
             End;
        End;
End;

//****************************************************************************//
//****************************************************************************//

//Module de réactivation de tous les éléments qui doivent être réactivés
Procedure REACTIVATION(var pdeb_fa_inact:T_ptr_elt_inactif);
Var
now:integer;
pcour,pcour2:T_ptr_elt_inactif;
Begin
Now:=GetTickCount;
Pcour:=pdeb_fa_inact;
//Passer en revue toute la FA des éléments inactifs et réactiver ceux qui doivent l'être
If Pcour<>Nil
        then
        begin
                Repeat
                If pcour^.heure_eveil < GetTickCount
                        then //l'heure est passée donc il faut réactiver
                                begin
                                pcour^.ptr_vers_entite.PUTACTIF(true);
                                //On sauve l'@ du prochain element
                                pcour2:=pcour^.ptr_suiv;
                                //On enlève l'élem courant
                                RETRAIT_FA_INA(pdeb_fa_inact,pfin_fa_inact,pcour);
                                //On restaure l'@ sauvée
                                pcour:=pcour2;
                                end
                        else
                        pcour:=pcour^.ptr_suiv;
                Until Pcour=nil;
        end;
End;

//****************************************************************************//
//****************************************************************************//

//Mise a jour de toutes les données concernant les joueurs
Procedure MAJ_DONNEES_ECRAN(Pcour_joueur,Phumain:T_ptr_vd_joueur);
Var
i:integer;
Pcour:T_ptr_vd_joueur;
Begin
//MAJ de l'XP
pcour:=phumain;
For i:=0 to 3 do
        begin
        //Les 3 zones d'XP
        If pcour_joueur.pt_visuel.GETNOM=F_jeu.L_Nom_J1.Caption
                then
                F_Jeu.L_XP1.Caption:=inttostr(pcour_joueur.pt_visuel.GETXP);
        If pcour_joueur.pt_visuel.GETNOM=F_jeu.L_Nom_J2.Caption
                then
                F_Jeu.L_XP2.Caption:=inttostr(pcour_joueur.pt_visuel.GETXP);
        If pcour_joueur.pt_visuel.GETNOM=F_jeu.L_Nom_J3.Caption
                then
                F_Jeu.L_XP3.Caption:=inttostr(pcour_joueur.pt_visuel.GETXP);
        If pcour_joueur.pt_visuel.GETNOM=F_jeu.L_Nom_J4.Caption
                then
                F_Jeu.L_XP4.Caption:=inttostr(pcour_joueur.pt_visuel.GETXP);
        Pcour:=pcour^.psuiv;
        end;
//Vies
For i:=0 to 3 do
        Begin
        //Les 4 zones de vie
        If pcour_joueur.pt_visuel.GETNOM=F_jeu.L_Nom_J1.Caption
                then
                F_Jeu.GaugeJ1.Progress:=pcour_joueur.pt_visuel.GETVIE;
        If pcour_joueur.pt_visuel.GETNOM=F_jeu.L_Nom_J2.Caption
                then
                F_Jeu.GaugeJ2.Progress:=pcour_joueur.pt_visuel.GETVIE;
        If pcour_joueur.pt_visuel.GETNOM=F_jeu.L_Nom_J3.Caption
                then
                F_Jeu.GaugeJ3.Progress:=pcour_joueur.pt_visuel.GETVIE;
        If pcour_joueur.pt_visuel.GETNOM=F_jeu.L_Nom_J4.Caption
                then
                F_Jeu.GaugeJ4.Progress:=pcour_joueur.pt_visuel.GETVIE;
        Pcour_joueur:=pcour_joueur^.psuiv;
        End;
//Humain
//F_Jeu.J_Vie1.Progress:=Phumain.pt_visuel.GETVIE;
End;

//****************************************************************************//
//****************************************************************************//

//Vérifie si le joueur est mort, si oui, le réaffiche autre part
Procedure MORT(pcour_joueur:T_ptr_VD_joueur; var PPremier_Renaiss:T_ptr_FA_Renaissance);
Var
i:integer;
Done:boolean;
pcour:T_ptr_FA_Renaissance;
Nouv_pdeb_prio:T_ptr_prio;
Begin
Done:=false;
pcour:=PPremier_Renaiss;
//On passe en revue tous les joueurs
For i:=0 to 4 do
        Begin
        If pcour_joueur.pt_visuel.GETVIE<=0 then
                Begin
                //Jouer le son d'attaque
                playsound(Pchar(SON_MORT),F_jeu.Handle,snd_sync or snd_async);
                //Coupage du pointeur
                Matrice_structure[pcour_joueur.pt_visuel.GETCOLONNE,pcour_joueur.pt_visuel.GETLIGNE].Ptr_Joueur:=Nil;
                //Si réinitialisation possible
                While (pcour<>nil) and (not done) do
                        begin
                        If Matrice_structure[pcour.CoordX,pcour.CoordY].ptr_joueur=nil
                                then
                                        begin
                                        //Réinitialisation
                                        pcour_joueur.pt_visuel.PUTLIGNE(pcour.CoordY);
                                        pcour_joueur.pt_visuel.PUTCOLONNE(pcour.CoordX);
                                        pcour_joueur.pt_visuel.PUTOFFSET_X(0);
                                        pcour_joueur.pt_visuel.PUTOFFSET_Y(0);
                                        Matrice_structure[pcour_joueur.pt_visuel.GETCOLONNE,pcour_joueur.pt_visuel.GETLIGNE].Ptr_Joueur:=Pcour_joueur;
                                        pcour_joueur.pt_visuel.PUTVIE(INIT_POINTS_VIE);
                                        Done:=true;
                                        pcour_joueur.pt_visuel.PUTBONUS_ATTAQUE(0);
                                        pcour_joueur.pt_visuel.PUTBONUS_ARMURE(0);
                                        If pcour_joueur=phumain then
                                                begin
                                                F_Jeu.ImageList2.GetBitmap(6,F_jeu.I_arme_J1.Picture.Bitmap);
                                                F_Jeu.ImageList2.GetBitmap(6,F_jeu.I_armure_J1.Picture.Bitmap);
                                                F_jeu.I_arme_J1.Repaint;
        F_jeu.                                  I_armure_J1.Repaint;
                                                end;
                                        If (pcour_joueur=phumain2) or (pcour_joueur=P_bot1) then
                                                begin
                                                F_Jeu.ImageList2.GetBitmap(6,F_jeu.I_arme_J2.Picture.Bitmap);
                                                F_Jeu.ImageList2.GetBitmap(6,F_jeu.I_armure_J2.Picture.Bitmap);
                                                F_jeu.I_arme_J2.Repaint;
        F_jeu.                                  I_armure_J2.Repaint;
                                                end;
                                        If (pcour_joueur=phumain3) or (pcour_joueur=P_bot2) then
                                                begin
                                                F_Jeu.ImageList2.GetBitmap(6,F_jeu.I_arme_J3.Picture.Bitmap);
                                                F_Jeu.ImageList2.GetBitmap(6,F_jeu.I_armure_J3.Picture.Bitmap);
                                                F_jeu.I_arme_J3.Repaint;
        F_jeu.                                  I_armure_J3.Repaint;
                                                end;
                                        If (pcour_joueur=phumain4) or (pcour_joueur=P_bot3) then
                                                begin
                                                F_Jeu.ImageList2.GetBitmap(6,F_jeu.I_arme_J4.Picture.Bitmap);
                                                F_Jeu.ImageList2.GetBitmap(6,F_jeu.I_armure_J4.Picture.Bitmap);
                                                F_jeu.I_arme_J4.Repaint;
        F_jeu.                                  I_armure_J4.Repaint;
                                                end;
                                        end;
                        pcour:=pcour^.psuiv;
                        end;
                //Remise a zéro de la liste des priorités
                INIT_FA_PRIORITES(Nouv_pdeb_prio);
                Pcour_joueur.pt_visuel.Liste_priorites:=Nouv_pdeb_prio;
                //Mise a nil du chemin
                Pcour_joueur.pt_visuel.PUTCHEMIN(Nil);
                end;
        pcour_joueur:=pcour_joueur^.psuiv;
        End;
If PPremier_Renaiss= nil
        then PPremier_Renaiss:=Pdeb_FA_Renaissance
        else PPremier_Renaiss:=PPremier_Renaiss^.psuiv;
end;

//****************************************************************************//
//****************************************************************************//

function CASE_SUIVANTE_OCCUPEE(pcour_fa_joueur:T_ptr_VD_joueur):boolean;
var
x,y : integer;
begin
//Si le joueur n'a pas de chemin
If pcour_Fa_joueur.pt_visuel.GETCHEMIN=nil
        then
                result:=false
        else
                begin
                //Initialisation des coordonnées de la case suivante du chemin
                x := pcour_fa_joueur.pt_visuel.GETCHEMIN.coord_colonne;
                y := pcour_fa_joueur.pt_visuel.GETCHEMIN.coord_ligne;
                //pcour_fa_joueur.pt_visuel.   chemin.coord_colonne;
                //pcour_fa_joueur.pt_visuel   chemin.coord_ligne;
                //Si la case est marchable et qu'il n'y a rien dessus.... alors la case n'est pas occupée (normal)...
                if (Matrice_structure[x,y].Ptr_Terrain.GETMARCHABLE = true) and ((Matrice_structure[x,y].Ptr_joueur=nil) or (Matrice_structure[x,y].Ptr_joueur.pt_visuel.GETNOM=pcour_fa_joueur.pt_visuel.GETNOM)) and (Matrice_structure[x,y].Ptr_artefact.GETNOM='0')
                then result := false
                else result := true;
                end;
end;
//****************************************************************************//
//****************************************************************************//

//Module dans lequel on recupere les coordonnées du point d'arrivee dans la liste des priorites
procedure RECUP_COORD(pdebl_prio:T_ptr_prio;var but_x,but_y:integer;pdeb_FA_waypoint:T_ptr_FA_pass;pcour_fa_joueur:T_ptr_VD_joueur);
var
paux: T_ptr_prio;
paux2: T_ptr_FA_pass;
trouve : boolean;
x,y,Distx,Disty:integer;
begin
//Initialisation de Paux (debut de la liste des priorités
paux := pdebl_prio;
trouve := false;
//Tant que l'on a pas parcouru toute la liste des priorités
while (paux <> nil) and (trouve = false) do
  begin
  //Si l'élément courant possède des coordonnées valides
    if (paux^.coordonnees_x <> -1) and (paux^.coordonnees_y <> -1)
    then
      begin
      //On retient les coordonnées
        but_x := paux^.coordonnees_x;
        but_y := paux^.coordonnees_y;
        trouve := true;
      end
    else //sinon, on boucle
        paux := paux^.psuiv_prio;
  end;
//Si on est arrivé à la fin de la liste et qu'on a rien trouvé
if (paux = nil) and (trouve = false)
then //C'est que la liste était vide et donc on cherche le point de passage le plus éloigné
  begin
  //Initialisation de paux au début de la FA des points de passage
   paux2:= pdeb_FA_waypoint;
   //On retient les coordonnées du joueur
   x := pcour_fa_joueur.pt_visuel.GETCOLONNE;
   y := pcour_fa_joueur.pt_visuel.GETLIGNE;
   //Initialisation de la distance
   distx:=0;
   disty:=0;
   //Tant que l'on a pas parcouru toute la liste des points de passage
   while paux2 <> nil do
    begin
      //Si la distance séparant le PP et le joueur est plus grande que la précédente
      if (abs(paux2^.CoordX - x) + abs(paux2^.CoordY - y)) > (distx+distY)
      then //alors c'est la nouvelle cible
        begin
        //On retient la distance
          distx := abs(paux2^.CoordX - x);
          disty := abs(paux2^.CoordY - y);
        //On retient les coordonnées
          but_x := paux2^.CoordX;
          but_y := paux2^.CoordY;
          paux2 := paux2^.psuiv;
          //On recherche le dernier élément de la FA des priorités
          paux:=pcour_fa_joueur.pt_visuel.Liste_priorites;
          while paux.psuiv_prio<>Nil do
                paux:=paux.psuiv_prio;
          //et on met a jour ses coordonnées
          paux.coordonnees_x:=but_x;
          paux.coordonnees_y:=but_y;
        end
      else //Sinon, on passe a l'élément suivant
        paux2 := paux2^.psuiv;
    end;
  end;
end;

//****************************************************************************//
//****************************************************************************//

//****************************************************************************//
//****************************************************************************//

//Module dans lequel on recupere les coordonnées du point d'arrivee dans la liste des priorites
procedure RECUP_COORD_PARTIELLES(pdebl_prio:T_ptr_prio;var but_x,but_y:integer;pdeb_FA_waypoint:T_ptr_FA_pass;pcour_fa_joueur:T_ptr_VD_joueur);
var
paux: T_ptr_prio;
paux2: T_ptr_FA_pass;
trouve : boolean;
x,y,Distx,Disty:integer;
begin
But_x:=-1;
But_y:=-1;
//Initialisation de Paux (debut de la liste des priorités
paux := pdebl_prio;
trouve := false;
//Tant que l'on a pas parcouru toute la liste des priorités
while (paux.psuiv_prio <> nil) and (trouve = false) do
  begin
  //Si l'élément courant possède des coordonnées valides
    if (paux^.coordonnees_x <> -1) and (paux^.coordonnees_y <> -1)
    then
      begin
      //On retient les coordonnées
        but_x := paux^.coordonnees_x;
        but_y := paux^.coordonnees_y;
        trouve := true;
      end
    else //sinon, on boucle
        paux := paux^.psuiv_prio;
  end;
end;

//****************************************************************************//
//****************************************************************************//

//Module mettant a jour l'orientation du bot
Procedure MAJ_DEST_BOT(Destination_X,Destination_Y:integer;pcour_joueur:t_ptr_vd_joueur;var Difx,DifY:integer; Var orient1,orient2:char);
Begin
//Calcul de la différence de coordonnées
Difx:=Destination_X-(pcour_joueur.pt_visuel.GETCOLONNE*TILE_SIZE+pcour_joueur.pt_visuel.GETOFFSET_X);
DifY:=Destination_Y-(pcour_joueur.pt_visuel.GETLIGNE*TILE_SIZE+pcour_joueur.pt_visuel.GETOFFSET_Y);
//Si l'un des deux est nul
If (difx=0) or (dify=0)
        Then //alors
                begin
                If DifX=0//Si DifX=0
                        then //Alors Si DifY<0
                        If DifY<0
                                then//alors
                                pcour_joueur.pt_visuel.PUTORIENTATION('U')
                                Else//Sinon
                                pcour_joueur.pt_visuel.PUTORIENTATION('D');
                If DifY=0//Si DifY=0
                        then//Alors Si DifX<0
                        If DifX<0
                                then//alors
                                pcour_joueur.pt_visuel.PUTORIENTATION('L')
                                Else//Sinon
                                pcour_joueur.pt_visuel.PUTORIENTATION('R');
                end
        Else//Sinon
                begin
                If DifX<0//Si DifX<0
                        then//Alors si DifY<0
                        If DifY<0
                                then//Alors on est dans le quart nord-ouest
                                        If abs(difx)<=abs(dify)
                                                then //Alors on se déplace suivant Y
                                                begin
                                                pcour_joueur.pt_visuel.PUTORIENTATION('U');
                                                Orient1:='U';
                                                Orient2:='L';
                                                end
                                                else //Sinon on se déplace suivant X
                                                begin
                                                pcour_joueur.pt_visuel.PUTORIENTATION('L');
                                                Orient1:='L';
                                                Orient2:='U';
                                                end
                                Else//Sinon on est dans le quart sud-ouest
                                        If abs(difx)<=abs(dify)
                                                then //Alors on se déplace suivant Y
                                                begin
                                                pcour_joueur.pt_visuel.PUTORIENTATION('D');
                                                Orient1:='D';
                                                Orient2:='L';
                                                end
                                                else //Sinon on se déplace suivant X
                                                begin
                                                pcour_joueur.pt_visuel.PUTORIENTATION('L');
                                                Orient1:='L';
                                                Orient2:='D';
                                                end;
                If DifX>0//Si DifX>0
                        then//Alors si DifY<0
                        If DifY<0
                                then//Alors on est dans le quart nord-est
                                        If abs(difx)<=abs(dify)
                                                then //Alors on se déplace suivant Y
                                                begin
                                                pcour_joueur.pt_visuel.PUTORIENTATION('U');
                                                Orient1:='U';
                                                Orient2:='R';
                                                end
                                                else //Sinon on se déplace suivant X
                                                begin
                                                pcour_joueur.pt_visuel.PUTORIENTATION('R');
                                                Orient1:='R';
                                                Orient2:='U';
                                                end
                                Else//Sinon on est dans le quart sud-est
                                        If abs(difx)<=abs(dify)
                                                then //Alors on se déplace suivant Y
                                                begin
                                                pcour_joueur.pt_visuel.PUTORIENTATION('D');
                                                Orient1:='D';
                                                Orient2:='R';
                                                end
                                                else //Sinon on se déplace suivant X
                                                begin
                                                pcour_joueur.pt_visuel.PUTORIENTATION('R');
                                                Orient1:='R';
                                                Orient2:='D';
                                                end;
                end;
End;

//****************************************************************************//
//****************************************************************************//

//Module de déplacement des Bots
Procedure DEPLACEMENT_BOT(pcour_joueur:t_ptr_vd_joueur);
Var
Dest_X,Dest_Y,Difx,DifY:integer;
Vitesse,dist_mini:integer;   //nombre de pixels dont le joueur peut se déplacer dans une direction donnée
                             //Distance minimale entre le joueur et le prochain objet (si objet sur la case suivante (sinon =500))
trouve:boolean;              //bouléen indiquant qu'on est au contact
orient1,orient2:char;
i,j,x,y:integer;             //x,y: en entrée=rien, en sortie les coordonnées de la case contenant l'obstacle
paux_chemin:t_ptr_case_chemin;
Begin
//Initialisation
i:=0;
j:=0;
x:=0;
y:=0;
trouve:=false;
//Si le joueur est centré sur sa case
{If (pcour_joueur.pt_visuel.GETOFFSET_X=0) and (pcour_joueur.pt_visuel.GETOFFSET_Y=0)
        then //On le recentre sur la case suivante
                begin}
                //Initialisation des variables de destination
Dest_X:=pcour_joueur.pt_visuel.GETCHEMIN.coord_colonne*TILE_SIZE;
Dest_Y:=pcour_joueur.pt_visuel.GETCHEMIN.coord_ligne*TILE_SIZE;
                {end
        else //On le recentre sur sa case en cours
                begin
                //Initialisation des variables de destination
                Dest_X:=pcour_joueur.pt_visuel.GETCOLONNE*TILE_SIZE;
                Dest_Y:=pcour_joueur.pt_visuel.GETLIGNE*TILE_SIZE;
                end;}
//Recentrage
MAJ_DEST_BOT(Dest_X,Dest_Y,pcour_joueur,difX,DifY,orient1,orient2);
//On chercha la case d'arrivée
paux_chemin:=pcour_joueur.pt_visuel.GETCHEMIN;
While paux_chemin.ptr_suivant<>nil do
        paux_chemin:=paux_chemin.ptr_suivant;

//Si les coord d'arrivées sont contenues dans les 8 cases adjacentes
If     ((pcour_joueur.pt_visuel.GETLIGNE=paux_chemin.coord_ligne+1)
      or(pcour_joueur.pt_visuel.GETLIGNE=paux_chemin.coord_ligne-1))
    and((pcour_joueur.pt_visuel.GETCOLONNE=paux_chemin.coord_colonne+1)
      or(pcour_joueur.pt_visuel.GETCOLONNE=paux_chemin.coord_colonne-1))
        then //Alors on se déplace normalement
        begin
                If DEPLACEMENT_POSSIBLE(vitesse,dist_mini,i,j,x,y,trouve,pcour_joueur)
                        then //Alors on peut déplacer le joueur
                        begin
                                Case pcour_joueur.pt_visuel.GETORIENTATION of
                                'U': If abs(difY)<Vitesse
                                        then
                                                vitesse:=abs(difY);
                                'D': If abs(difY)<Vitesse
                                        then
                                                vitesse:=abs(difY);
                                'L': If abs(difX)<Vitesse
                                        then
                                                vitesse:=abs(difX);
                                'R': If abs(difX)<Vitesse
                                        then
                                                vitesse:=abs(difX);
                                End;
                        DEPLACEMENT_JOUEUR(pcour_joueur,pcour_joueur.pt_visuel.GETORIENTATION,vitesse);
                        //Si on est arrivé a destination sur la nouvelle case
                        If (pcour_joueur.pt_visuel.GETCOLONNE*TILE_SIZE+pcour_joueur.pt_visuel.GETOFFSET_X=Dest_X) and (pcour_joueur.pt_visuel.GETLIGNE*TILE_SIZE+pcour_joueur.pt_visuel.GETOFFSET_Y=Dest_Y)
                                then //on est arrive en (0,0) donc on supprime la première case du chemin
                                        pcour_joueur.pt_visuel.PUTCHEMIN(pcour_joueur.pt_visuel.GETCHEMIN.ptr_suivant);
                        End;
        end
        else  //Alors on se déplace anormalement cad il faut parfois contourner la case
        begin
        //Alors ce module n'est valable que si on n'est pas a coté de la case d'arrivée
        //Si le déplacement est possible dans la direction modifiée par recentrage
        If DEPLACEMENT_POSSIBLE(vitesse,dist_mini,i,j,x,y,trouve,pcour_joueur)
                then //Alors on peut déplacer le joueur
                begin
                Case pcour_joueur.pt_visuel.GETORIENTATION of
                'U': If abs(difY)<Vitesse
                                then
                                vitesse:=abs(difY);
                'D': If abs(difY)<Vitesse
                                then
                                vitesse:=abs(difY);
                'L': If abs(difX)<Vitesse
                                then
                                vitesse:=abs(difX);
                'R': If abs(difX)<Vitesse
                                then
                                vitesse:=abs(difX);
                End;
                DEPLACEMENT_JOUEUR(pcour_joueur,pcour_joueur.pt_visuel.GETORIENTATION,vitesse);
                //Si on est arrivé a destination sur la nouvelle case
                If (pcour_joueur.pt_visuel.GETCOLONNE*TILE_SIZE+pcour_joueur.pt_visuel.GETOFFSET_X=Dest_X) and (pcour_joueur.pt_visuel.GETLIGNE*TILE_SIZE+pcour_joueur.pt_visuel.GETOFFSET_Y=Dest_Y)
                        then //on est arrive en (0,0) donc on supprime la première case du chemin
                        pcour_joueur.pt_visuel.PUTCHEMIN(pcour_joueur.pt_visuel.GETCHEMIN.ptr_suivant);
                End
                else //Si jamais ct pas possible alors c'est qu'il faut le contourner (donc on choisit l'autre direction)
                        begin
                        pcour_joueur.pt_visuel.PUTORIENTATION(Orient2);
                        Case pcour_joueur.pt_visuel.GETORIENTATION of
                'U': If abs(difY)<Vitesse
                                 then
                                 vitesse:=abs(difY);
                'D': If abs(difY)<Vitesse
                                 then
                                 vitesse:=abs(difY);
                'L': If abs(difX)<Vitesse
                                 then
                                 vitesse:=abs(difX);
                'R': If abs(difX)<Vitesse
                                 then
                                 vitesse:=abs(difX);
                        End;
                DEPLACEMENT_JOUEUR(pcour_joueur,pcour_joueur.pt_visuel.GETORIENTATION,vitesse);
                //Si on est arrivé a destination sur la nouvelle case
                If (pcour_joueur.pt_visuel.GETCOLONNE*TILE_SIZE+pcour_joueur.pt_visuel.GETOFFSET_X=Dest_X) and (pcour_joueur.pt_visuel.GETLIGNE*TILE_SIZE+pcour_joueur.pt_visuel.GETOFFSET_Y=Dest_Y)
                        then //on est arrive en (0,0) donc on supprime la première case du chemin
                        pcour_joueur.pt_visuel.PUTCHEMIN(pcour_joueur.pt_visuel.GETCHEMIN.ptr_suivant);
                        end;
                end;
End;

//****************************************************************************//
//****************************************************************************//

end.
