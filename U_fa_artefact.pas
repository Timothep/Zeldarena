unit U_fa_artefact;

interface
uses U_crea_artefact;
//----------------------------------------------------------------------------//
type
T_ptr_VD_Artefact = ^VD_Artefact ;
nx_artefact = TC_artefact;

VD_Artefact = record
           ptr_visuel : TC_artefact;
           psui : T_ptr_VD_Artefact;
          end;
pcour_FA_arte,pdebf_FA_arte,pfinf_FA_arte = T_ptr_VD_Artefact;

//----------------------------------------------------------------------------//
procedure INIT_FA_ARTE(var Pdebf_FA_Arte :T_ptr_VD_Artefact; var Pfinf_FA_Arte : T_ptr_VD_Artefact; var Pcour_fa_Arte : T_ptr_VD_Artefact);overload;
procedure AJOUT_ARTE(var Pdeb_FA_Arte,Pfin_FA_Arte, pnou :T_ptr_VD_Artefact);
procedure CREA_VD_ARTE(var pnou:T_ptr_VD_Artefact);
procedure INIT_VD_ARTE(var pnou : T_ptr_VD_Artefact; nx_artefact : TC_artefact);
//----------------------------------------------------------------------------//

implementation

//----------------------------------------------------------------------------//
procedure CREA_VD_ARTE(var pnou:T_ptr_VD_Artefact);
begin
New (pnou);
end;
//----------------------------------------------------------------------------//
procedure INIT_VD_ARTE(var pnou : T_ptr_VD_Artefact; nx_artefact : TC_artefact);
begin
pnou.ptr_visuel := nx_artefact;
pnou^.psui:=nil
end;
//----------------------------------------------------------------------------//
procedure INIT_FA_ARTE(var Pdeb_FA_Arte :T_ptr_VD_Artefact; var Pfin_FA_Arte : T_ptr_VD_Artefact; var Pcour_fa_Arte : T_ptr_VD_Artefact);
begin
Pdeb_FA_Arte := nil;
Pcou_FA_Arte := nil;
Pfin_FA_Arte := nil;
end;
//----------------------------------------------------------------------------//
procedure AJOUT_ARTE(var Pdeb_FA_Arte,Pfin_FA_Arte: T_ptr_VD_Artefact; pnou :T_ptr_VD_Artefact);
begin
 if Pdeb_FA_Arte =nil
 then
        Pdeb_FA_Arte := pnou
 else
        Pfin_FA_Arte^.psuiv := pnou;
 Pfin_FA_Arte := pnou;
end;
//----------------------------------------------------------------------------//
end.
