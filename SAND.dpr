{JEU ZELDARENA - SAND
JOACHIM BOUSSOUMAH      GPBb
TIMOTHEE BOURGUIGNON    GPAa
EPF2}
program SAND;

uses
  Forms,
  U_Accueil in 'U_Accueil.pas' {F_Accueil},
  U_Credits in 'U_Credits.pas' {F_Credits},
  U_Options in 'U_Options.pas' {F_Options},
  U_creation_player in 'U_creation_player.pas' {F_Crea_Perso},
  U_Creation_Cartes in 'U_Creation_Cartes.pas' {F_Crea_Carte},
  U_Param_Nouv_Carte in 'U_Param_Nouv_Carte.pas' {F_Param_Carte},
  U_Regles_crea_cartes in 'U_Regles_crea_cartes.pas' {F_Regles_crea_cartes},
  U_Banque_Images in 'U_Banque_Images.pas' {F_Banque_Images},
  U_Description_carte in 'U_Description_carte.pas' {F_Description_Carte},
  U_Jeu in 'U_Jeu.pas' {F_Jeu},
  U_Load in 'U_Load.pas' {F_Load},
  U_Types in 'U_Types.pas',
  U_Splash in 'U_Splash.pas' {F_Splash},
  U_crea_terrain in 'U_crea_terrain.pas',
  U_crea_artefact in 'U_crea_artefact.pas',
  U_crea_elt_non_permnt in 'U_crea_elt_non_permnt.pas',
  U_crea_elt_visuel in 'U_crea_elt_visuel.pas',
  U_crea_joueur in 'U_crea_joueur.pas',
  U_fa_joueur in 'U_fa_joueur.pas',
  U_FA_Pts_Renaissance in 'U_FA_Pts_Renaissance.pas',
  U_traitement in 'U_traitement.pas',
  U_priorite in 'U_priorite.pas',
  U_tile_to_load in 'U_tile_to_load.pas',
  U_test_deplace in 'U_test_deplace.pas',
  U_fa_inaction in 'U_fa_inaction.pas',
  U_vision in 'U_vision.pas',
  U_FA_Pts_pass in 'U_FA_Pts_pass.pas',
  U_avarie in 'U_avarie.pas',
  U_chemin in 'U_chemin.pas',
  U_abr_scores in 'U_abr_scores.pas',
  U_NB_joueurs in 'U_NB_joueurs.pas' {F_Nb_J};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Zeldarena';
  Application.CreateForm(TF_Accueil, F_Accueil);
  Application.CreateForm(TF_Credits, F_Credits);
  Application.CreateForm(TF_Options, F_Options);
  Application.CreateForm(TF_Crea_Perso, F_Crea_Perso);
  Application.CreateForm(TF_Crea_Carte, F_Crea_Carte);
  Application.CreateForm(TF_Param_Carte, F_Param_Carte);
  Application.CreateForm(TF_Regles_crea_cartes, F_Regles_crea_cartes);
  Application.CreateForm(TF_Banque_Images, F_Banque_Images);
  Application.CreateForm(TF_Description_Carte, F_Description_Carte);
  Application.CreateForm(TF_Jeu, F_Jeu);
  Application.CreateForm(TF_Load, F_Load);
  Application.CreateForm(TF_Splash, F_Splash);
  Application.CreateForm(TF_Nb_J, F_Nb_J);
  Application.Run;
end.
