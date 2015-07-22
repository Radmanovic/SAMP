/*
    * ## LEASE ATENTAMENTE PARA NO CONVERTIRSE EN LAMMER!!.: :D ##
    *
    * Estè Simple FILTERSCRIPT esta hecho especialmente para www.forum.sa-mp.com
    * NO Publicar estè FILTERSCRIPT en Otros foros de SA-MP y hacerse pasar por el creador del CODE.
    *
    * Codigo Creado Por OTACON
    *
    * CREDITOS:
    *     OTACON: Realizacion y Idea de creacion del code.
    *     TÙ: Modificacion libremente respetando lo mencionado ;).
    *
    *    NOTA: Menos Creditos para los que me los critican.. JO'PUTAS! :D xD ;)
    *
    *                Prohibido TOTALMENTE el Robo de Créditos o la
    *                  Publicación de este FILTERSCRIPT sin Mi Permiso.
*/
/*
    * ## READ CAREFULLY TO AVOID BECOMING LAMMER!.: :D ##
    *
    * This simple FILTERSCRIPT is made especially for www.forum.sa-mp.com
    * DO NOT Post the FILTERSCRIPT in Other SAMP forums and impersonating the creator of the CODE.
    *
    * Code Created By OTACON
    *
    * CREDITS:
    *     OTACON: Idea Making and code creation.
    *     YOUR: Modification freely respecting the above ;).
    *
    *    NOTE: Less Credits for those who criticize me.. JO'PUTAS! :D xD ;)
    *
    *                        FULLY spaces Theft Credit or
    *                 Publication of this FILTERSCRIPT without my permission.
*/

/*
[img]http://i.imgur.com/cQBWMoq.png[/img]
[img]http://i.imgur.com/5GLYPtd.png[/img]
[img]http://i.imgur.com/T5G5420.png[/img]
[img]http://i.imgur.com/0Pw63AP.png[/img]
*/

#include <a_samp>
#include <zcmd>
#include <sscanf2>

#define DIALOG_ACTORS (17)
enum e_actor{
	objeto_select,
	color_actor,
    a_name[25],
	a_skin,
	c_actor,
	bool:i_actor,
	Float:h_actor,
	a_animlib[32],
	a_animname[32],
	Text3D:label };
new InfoActorEdicion[MAX_ACTORS][e_actor],
cantidad_actores=0,
cantidad_archivos=0,
id_seleccionado=0,
Float:vida_id=0.0,
seleccion_skis=0,
bool:actor_Invulnerable,
bool:seleccionando_skins[MAX_PLAYERS][2],
bool:creando_actors[MAX_PLAYERS],
bool:tipo_archivo_a[MAX_PLAYERS],
bool:seleccioando_actor[MAX_PLAYERS][2];
static Float:old_actors[4], virtualword_actors;

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys){

	new
		Float:pos[4],
		data[144];

	GetPlayerPos(playerid, pos[0],pos[1],pos[2]);
	GetPlayerFacingAngle(playerid, pos[3]);

	if(newkeys & KEY_YES){
		if(creando_actors[playerid]){
			if(IsPlayerInAnyVehicle(playerid))
				return SendClientMessage(playerid,-1,"{919BA4}INFO: You can not use the editor of actors from a vehicle!.");
			if(cantidad_actores>=MAX_ACTORS)
				return SendClientMessage(playerid,-1,"{919BA4}INFO: There are too many actors created so far!.");

			ShowPlayerDialog(playerid, DIALOG_ACTORS+1, DIALOG_STYLE_MSGBOX, "{FF6800}Editing system actors:", "\
			{FFFFFF}¿That vulnerability want to apply the actor?", "vulnerable", "invulnerable");
		}
	}

	if(newkeys & KEY_NO){
		if(creando_actors[playerid]){
			if(IsPlayerInAnyVehicle(playerid))
				return SendClientMessage(playerid,-1,"{919BA4}INFO: You can not use the editor of actors from a vehicle!.");
			if(cantidad_actores<=0)
				return SendClientMessage(playerid,-1,"{919BA4}INFO: there is not actor created so far!.");

			if(!IsValidActor(InfoActorEdicion[cantidad_actores][c_actor]))
				return false;
			DestroyActor(InfoActorEdicion[cantidad_actores][c_actor]);
			Delete3DTextLabel(InfoActorEdicion[cantidad_actores][label]);
			InfoActorEdicion[cantidad_actores][a_skin] = 0;
			InfoActorEdicion[cantidad_actores][c_actor] = 0;
			InfoActorEdicion[cantidad_actores][i_actor] = false;
			InfoActorEdicion[cantidad_actores][h_actor] = 0.0;
			InfoActorEdicion[cantidad_actores][color_actor] = -1;
		    format(InfoActorEdicion[cantidad_actores][a_animlib],32,"%s","null");
		    format(InfoActorEdicion[cantidad_actores][a_animname],32,"%s","null");
		    format(InfoActorEdicion[cantidad_actores][a_name],24,"%s","Actor");
		    DestroyObject(InfoActorEdicion[cantidad_actores][objeto_select]);
			cantidad_actores--;
			format(data,sizeof(data),"{EEE019}INFO: You have successfully removed an actor!. actors created in total: [%d/%d].",cantidad_actores,MAX_ACTORS);
			SendClientMessage(playerid,-1,data);
		}
	}

	if(newkeys & KEY_CROUCH && newkeys & KEY_SECONDARY_ATTACK){
		if(creando_actors[playerid]){
			if(IsPlayerInAnyVehicle(playerid))
				return SendClientMessage(playerid,-1,"{919BA4}INFO: You can not use the editor of actors from a vehicle!.");
			if(cantidad_actores<=0)
				return SendClientMessage(playerid,-1,"{919BA4}INFO: there is not actor created so far!.");

			for(new xx=0; xx<cantidad_actores+1; xx++){
				if(!IsValidActor(InfoActorEdicion[xx][c_actor]))
					continue;
				DestroyActor(InfoActorEdicion[xx][c_actor]);
				Delete3DTextLabel(InfoActorEdicion[xx][label]);
				InfoActorEdicion[xx][a_skin] = 0;
				InfoActorEdicion[xx][c_actor] = 0;
				InfoActorEdicion[xx][i_actor] = false;
				InfoActorEdicion[xx][h_actor] = 0.0;
				InfoActorEdicion[xx][color_actor] = -1;
			    format(InfoActorEdicion[xx][a_animlib],32,"%s","null");
			    format(InfoActorEdicion[xx][a_animname],32,"%s","null");
			    format(InfoActorEdicion[xx][a_name],24,"%s","Actor");
			    DestroyObject(InfoActorEdicion[xx][objeto_select]);
			}
			cantidad_actores=0;
			format(data,sizeof(data),"{EEE019}INFO: They have eliminated all the actors properly!. actors created in total: [%d/%d].",cantidad_actores,MAX_ACTORS);
			SendClientMessage(playerid,-1,data);
		}
	}

	if(newkeys & KEY_CROUCH && newkeys & KEY_SPRINT){
		if(creando_actors[playerid]){
			if(IsPlayerInAnyVehicle(playerid))
				return SendClientMessage(playerid,-1,"{919BA4}INFO: You can not use the editor of actors from a vehicle!.");
			if(cantidad_actores<=0)
				return SendClientMessage(playerid,-1,"{919BA4}INFO: there is not actor created so far!.");

			ShowPlayerDialog(playerid, DIALOG_ACTORS+16, DIALOG_STYLE_MSGBOX, "{FF6800}Editing system actors:", "\
			{FFFFFF}choose the file type you want to save the actors:", "normal", "filterscript");
		}
	}

	if(newkeys & KEY_CROUCH && newkeys & KEY_CTRL_BACK)
		CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorhelp");

	return true;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]){

	new
		animlib[32],
    	animname[32],
		Float:pos[4],
		data[300],
		datos[144],
		File:archivos,
		Float:health,
		virtualword;

	GetPlayerPos(playerid, pos[0],pos[1],pos[2]);
	GetPlayerFacingAngle(playerid, pos[3]);
	virtualword = GetPlayerVirtualWorld(playerid);

    switch(dialogid){

        case DIALOG_ACTORS+0:{
	        if(!response)
				CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
        }
        case DIALOG_ACTORS+1:{
	        if(response){
				actor_Invulnerable = false;
				ShowPlayerDialog(playerid, DIALOG_ACTORS+2, DIALOG_STYLE_MSGBOX, "{FF6800}Editing system actors:", "\
				{FFFFFF}¿Choice of life that you want to apply to the actor?", "personalize", "by default");
	        }else{
				actor_Invulnerable = true;
				ShowPlayerDialog(playerid, DIALOG_ACTORS+2, DIALOG_STYLE_MSGBOX, "{FF6800}Editing system actors:", "\
				{FFFFFF}¿Choice of life that you want to apply to the actor?", "personalize", "by default");
	        }
        }

        case DIALOG_ACTORS+2:{
	        if(response){
				ShowPlayerDialog(playerid, DIALOG_ACTORS+3, DIALOG_STYLE_INPUT, "{FF6800}Editing system actors:", "\
				{FFFFFF}enter the amount of life that has the actor, must be greater than 0 and less than or equal to 100.\n\
				{A50000}NOTE: You can use the 'default' to be applied automatically 100. ", "accept", "by default");
	        }else{
				vida_id = 100.0;
				ShowPlayerDialog(playerid, DIALOG_ACTORS+7, DIALOG_STYLE_MSGBOX, "{FF6800}Editing system actors:", "\
				{FFFFFF}¿Choice of skin that you want to apply to the actor?", "personalize", "by default");
	        }
	    }

        case DIALOG_ACTORS+3:{
	        if(response){
				new Float:valor;
				if(!sscanf(inputtext, "f", valor)){
					if(valor>=0 && valor<=100){
						vida_id = valor;
						ShowPlayerDialog(playerid, DIALOG_ACTORS+7, DIALOG_STYLE_MSGBOX, "{FF6800}Editing system actors:", "\
						{FFFFFF}¿Choice of skin that you want to apply to the actor?", "personalize", "by default");
					}else{
						ShowPlayerDialog(playerid, DIALOG_ACTORS+3, DIALOG_STYLE_INPUT, "{FF6800}Editing system actors:", "\
						{FFFFFF}enter the amount of life that has the actor, must be greater than 0 and less than or equal to 100.\n\
						{A50000}NOTE: You can use the 'default' to be applied automatically 100. ", "accept", "by default");
					}
				}else{
					ShowPlayerDialog(playerid, DIALOG_ACTORS+3, DIALOG_STYLE_INPUT, "{FF6800}Editing system actors:", "\
					{FFFFFF}enter the amount of life that has the actor, must be greater than 0 and less than or equal to 100.\n\
					{A50000}NOTE: You can use the 'default' to be applied automatically 100. ", "accept", "by default");
				}
	        }else{
				vida_id = 100.0;
				ShowPlayerDialog(playerid, DIALOG_ACTORS+7, DIALOG_STYLE_MSGBOX, "{FF6800}Editing system actors:", "\
				{FFFFFF}¿Choice of skin that you want to apply to the actor?", "personalize", "by default");
	        }
	    }

        case DIALOG_ACTORS+4:{
	        if(response){
				new opcion[100];

				if(!sscanf(inputtext, "s[100]", opcion)){
					format(data,sizeof(data),"%s.%s",opcion, (tipo_archivo_a[playerid])?("txt"):("pwn") );
					if(fexist(data))fremove(data);
					archivos=fopen(data, io_readwrite);
					if(archivos){

						if(tipo_archivo_a[playerid]){
							fwrite(archivos, "\r\n/**** Editing system actors - By OTACON ****/\r\n");
							format(datos,sizeof(datos),"	new actorid[%d];\r\n", cantidad_actores+1);
							fwrite(archivos, datos);
							format(datos,sizeof(datos),"	new Text3D:text_actor[%d];\r\n\r\n\r\n", cantidad_actores+1);
							fwrite(archivos, datos);
							for(new xx=1; xx<cantidad_actores+1; xx++){
								if(!IsValidActor(InfoActorEdicion[xx][c_actor]))
									continue;
								GetActorPos(InfoActorEdicion[xx][c_actor], pos[0],pos[1],pos[2]);
								GetActorFacingAngle(InfoActorEdicion[xx][c_actor], pos[3]);
								format(datos,sizeof(datos),"	actorid[%d] = CreateActor(%d, %f,%f,%f,%f);\r\n\r\n", xx,InfoActorEdicion[xx][a_skin],pos[0],pos[1],pos[2],pos[3]);
								fwrite(archivos, datos);
							}
							fwrite(archivos, "\r\n	new data[144];\r\n");
							for(new xx=1; xx<cantidad_actores+1; xx++){
								if(!IsValidActor(InfoActorEdicion[xx][c_actor]))
									continue;
								GetActorPos(InfoActorEdicion[xx][c_actor], pos[0],pos[1],pos[2]);
								virtualword = GetActorVirtualWorld(playerid);
								format(datos,sizeof(datos),"	text_actor[%d] = Create3DTextLabel(\"_\",-1,%f,%f,%f,10,%d,0);\r\n",xx,pos[1],pos[2],pos[3]+1,virtualword);
								fwrite(archivos, datos);
								format(datos,sizeof(datos),"	format(data,sizeof(data),\"%s:%s\",actorid[%d]);\r\n",InfoActorEdicion[xx][a_name],"(id:%d)",xx);
								fwrite(archivos, datos);
								format(datos,sizeof(datos),"	Update3DTextLabelText(text_actor[%d],0x%08x,data);\r\n\r\n",xx,InfoActorEdicion[xx][color_actor]);
								fwrite(archivos, datos);
							}
							for(new xx=1; xx<cantidad_actores+1; xx++){
								if(!IsValidActor(InfoActorEdicion[xx][c_actor]))
									continue;
								GetActorFacingAngle(InfoActorEdicion[xx][c_actor], pos[3]);
								virtualword = GetActorVirtualWorld(playerid);
								GetActorHealth(InfoActorEdicion[xx][c_actor], health);
								format(datos,sizeof(datos),"	SetActorFacingAngle(actorid[%d], %f);\r\n", xx,pos[3]);
								fwrite(archivos, datos);
								format(datos,sizeof(datos),"	SetActorVirtualWorld(actorid[%d], %d);\r\n", xx,virtualword);
								fwrite(archivos, datos);
								format(datos,sizeof(datos),"	SetActorInvulnerable(actorid[%d], %s);\r\n", xx, (!InfoActorEdicion[xx][i_actor])?("false"):("true") );
								fwrite(archivos, datos);
								format(datos,sizeof(datos),"	SetActorHealth(actorid[%d], %f);\r\n", xx,InfoActorEdicion[xx][h_actor]);
								fwrite(archivos, datos);
								format(datos,sizeof(datos),"	ApplyActorAnimation(actorid[%d], \"%s\", \"%s\", 4.1, 1, 1, 1, 1, 1);\r\n", xx, InfoActorEdicion[xx][a_animlib],InfoActorEdicion[xx][a_animname]);
								fwrite(archivos, datos);
								fwrite(archivos, "	// NOTE: changing the settings: (Float:fDelta, loop, lockx, locky, freeze, time) \r\n");
								fwrite(archivos, "	// https://wiki.sa-mp.com/wiki/ApplyActorAnimation \r\n\r\n");
							}
							fwrite(archivos, "\r\n/*  * MORE FEATURES...: \r\n\r\n");
							fwrite(archivos, "	    GetActorPos                 => https://wiki.sa-mp.com/wiki/GetActorPos \r\n");
							fwrite(archivos, "	    GetActorVirtualWorld        => https://wiki.sa-mp.com/wiki/GetActorVirtualWorld \r\n");
							fwrite(archivos, "	    GetPlayerTargetActor        => https://wiki.sa-mp.com/wiki/GetPlayerTargetActor \r\n");
							fwrite(archivos, "	    IsActorInvulnerable         => https://wiki.sa-mp.com/wiki/IsActorInvulnerable \r\n");
							fwrite(archivos, "	    IsActorStreamedIn           => https://wiki.sa-mp.com/wiki/IsActorStreamedIn \r\n");
							fwrite(archivos, "	    IsValidActor                => https://wiki.sa-mp.com/wiki/IsValidActor \r\n");
							fwrite(archivos, "	    OnActorStreamIn             => https://wiki.sa-mp.com/wiki/OnActorStreamIn \r\n");
							fwrite(archivos, "	    OnActorStreamOut            => https://wiki.sa-mp.com/wiki/OnActorStreamOut \r\n");
							fwrite(archivos, "	    OnPlayerGiveDamageActor     => https://wiki.sa-mp.com/wiki/OnPlayerGiveDamageActor \r\n");
							fwrite(archivos, "	    SetActorFacingAngle         => https://wiki.sa-mp.com/wiki/SetActorFacingAngle \r\n");
							fwrite(archivos, "	    SetActorHealth              => https://wiki.sa-mp.com/wiki/SetActorHealth \r\n");
							fwrite(archivos, "	    SetActorInvulnerable        => https://wiki.sa-mp.com/wiki/SetActorInvulnerable \r\n");
							fwrite(archivos, "	    SetActorPos                 => https://wiki.sa-mp.com/wiki/SetActorPos \r\n");
							fwrite(archivos, "	    SetActorVirtualWorld        => https://wiki.sa-mp.com/wiki/SetActorVirtualWorld \r\n");
							fwrite(archivos, "	    ApplyActorAnimation         => https://wiki.sa-mp.com/wiki/ApplyActorAnimation \r\n");
							fwrite(archivos, "	    ClearActorAnimations        => https://wiki.sa-mp.com/wiki/ClearActorAnimations \r\n");
							fwrite(archivos, "	    CreateActor                 => https://wiki.sa-mp.com/wiki/CreateActor \r\n");
							fwrite(archivos, "	    DestroyActor                => https://wiki.sa-mp.com/wiki/DestroyActor \r\n");
							fwrite(archivos, "	    GetActorFacingAngle         => https://wiki.sa-mp.com/wiki/GetActorFacingAngle \r\n");
							fwrite(archivos, "	    GetActorHealth              => https://wiki.sa-mp.com/wiki/GetActorHealth \r\n");
							fwrite(archivos, "	    GetActorPoolSize            => https://wiki.sa-mp.com/wiki/GetActorPoolSize \r\n\r\n");
							fwrite(archivos, "*/ \r\n\r\n");
							fwrite(archivos, "/**** Editing system actors - By OTACON ****/\r\n\r\n");
							fclose(archivos);
						}else{
							fwrite(archivos, "\r\n/**** Editing system actors - By OTACON ****/\r\n");
							fwrite(archivos, "#include <a_samp>\r\n\r\n");
							format(datos,sizeof(datos),"new actorid[%d];\r\n", cantidad_actores+1);
							fwrite(archivos, datos);
							format(datos,sizeof(datos),"new Text3D:text_actor[%d];\r\n\r\n", cantidad_actores+1);
							fwrite(archivos, datos);
							fwrite(archivos, "public OnFilterScriptInit(){\r\n\r\n");
							for(new xx=1; xx<cantidad_actores+1; xx++){
								if(!IsValidActor(InfoActorEdicion[xx][c_actor]))
									continue;
								GetActorPos(InfoActorEdicion[xx][c_actor], pos[0],pos[1],pos[2]);
								GetActorFacingAngle(InfoActorEdicion[xx][c_actor], pos[3]);
								format(datos,sizeof(datos),"	actorid[%d] = CreateActor(%d, %f,%f,%f,%f);\r\n", xx,InfoActorEdicion[xx][a_skin],pos[0],pos[1],pos[2],pos[3]);
								fwrite(archivos, datos);
							}
							fwrite(archivos, "\r\n	new data[144];\r\n");
							for(new xx=1; xx<cantidad_actores+1; xx++){
								if(!IsValidActor(InfoActorEdicion[xx][c_actor]))
									continue;
								GetActorPos(InfoActorEdicion[xx][c_actor], pos[0],pos[1],pos[2]);
								virtualword = GetActorVirtualWorld(playerid);
								format(datos,sizeof(datos),"	text_actor[%d] = Create3DTextLabel(\"_\",-1,%f,%f,%f,10,%d,0);\r\n",xx,pos[1],pos[2],pos[3]+1,virtualword);
								fwrite(archivos, datos);
								format(datos,sizeof(datos),"	format(data,sizeof(data),\"%s:%s\",actorid[%d]);\r\n",InfoActorEdicion[xx][a_name],"(id:%d)",xx);
								fwrite(archivos, datos);
								format(datos,sizeof(datos),"	Update3DTextLabelText(text_actor[%d],0x%08x,data);\r\n\r\n",xx,InfoActorEdicion[xx][color_actor]);
								fwrite(archivos, datos);
							}
							for(new xx=1; xx<cantidad_actores+1; xx++){
								if(!IsValidActor(InfoActorEdicion[xx][c_actor]))
									continue;
								GetActorFacingAngle(InfoActorEdicion[xx][c_actor], pos[3]);
								virtualword = GetActorVirtualWorld(playerid);
								GetActorHealth(InfoActorEdicion[xx][c_actor], health);
								format(datos,sizeof(datos),"	SetActorFacingAngle(actorid[%d], %f);\r\n", xx,pos[3]);
								fwrite(archivos, datos);
								format(datos,sizeof(datos),"	SetActorVirtualWorld(actorid[%d], %d);\r\n", xx,virtualword);
								fwrite(archivos, datos);
								format(datos,sizeof(datos),"	SetActorInvulnerable(actorid[%d], %s);\r\n", xx, (!InfoActorEdicion[xx][i_actor])?("false"):("true") );
								fwrite(archivos, datos);
								format(datos,sizeof(datos),"	SetActorHealth(actorid[%d], %f);\r\n", xx,InfoActorEdicion[xx][h_actor]);
								fwrite(archivos, datos);
								format(datos,sizeof(datos),"	ApplyActorAnimation(actorid[%d], \"%s\", \"%s\", 4.1, 1, 1, 1, 1, 1);\r\n", xx, InfoActorEdicion[xx][a_animlib],InfoActorEdicion[xx][a_animname]);
								fwrite(archivos, datos);
								fwrite(archivos, "	// NOTE: changing the settings: (Float:fDelta, loop, lockx, locky, freeze, time) \r\n");
								fwrite(archivos, "	// https://wiki.sa-mp.com/wiki/ApplyActorAnimation \r\n\r\n");
							}
							fwrite(archivos, "	return true;\r\n");
							fwrite(archivos, "}\r\n\r\n");
							fwrite(archivos, "public OnPlayerGiveDamageActor(playerid, damaged_actorid, Float: amount, weaponid, bodypart){\r\n\r\n");
							fwrite(archivos, "    new\r\n");
							fwrite(archivos, "		Float:health;\r\n");
							fwrite(archivos, "    GetActorHealth(actorid[damaged_actorid], health);\r\n");
							fwrite(archivos, "	if(IsValidActor(actorid[damaged_actorid])){\r\n");
							fwrite(archivos, "		if(!IsActorInvulnerable(actorid[damaged_actorid])){\r\n");
							fwrite(archivos, "			SetActorHealth(actorid[damaged_actorid], (health-amount));\r\n");
							fwrite(archivos, "			if(health<=0.0){\r\n");
							fwrite(archivos, "				SetActorHealth(actorid[damaged_actorid], 100.0);\r\n");
							fwrite(archivos, "			}\r\n");
							fwrite(archivos, "		}\r\n");
							fwrite(archivos, "	}\r\n\r\n");
							fwrite(archivos, "	return true;\r\n");
							fwrite(archivos, "}\r\n\r\n");
							fwrite(archivos, "/*  * MORE FEATURES...: \r\n\r\n");
							fwrite(archivos, "	    GetActorPos                 => https://wiki.sa-mp.com/wiki/GetActorPos \r\n");
							fwrite(archivos, "	    GetActorVirtualWorld        => https://wiki.sa-mp.com/wiki/GetActorVirtualWorld \r\n");
							fwrite(archivos, "	    GetPlayerTargetActor        => https://wiki.sa-mp.com/wiki/GetPlayerTargetActor \r\n");
							fwrite(archivos, "	    IsActorInvulnerable         => https://wiki.sa-mp.com/wiki/IsActorInvulnerable \r\n");
							fwrite(archivos, "	    IsActorStreamedIn           => https://wiki.sa-mp.com/wiki/IsActorStreamedIn \r\n");
							fwrite(archivos, "	    IsValidActor                => https://wiki.sa-mp.com/wiki/IsValidActor \r\n");
							fwrite(archivos, "	    OnActorStreamIn             => https://wiki.sa-mp.com/wiki/OnActorStreamIn \r\n");
							fwrite(archivos, "	    OnActorStreamOut            => https://wiki.sa-mp.com/wiki/OnActorStreamOut \r\n");
							fwrite(archivos, "	    OnPlayerGiveDamageActor     => https://wiki.sa-mp.com/wiki/OnPlayerGiveDamageActor \r\n");
							fwrite(archivos, "	    SetActorFacingAngle         => https://wiki.sa-mp.com/wiki/SetActorFacingAngle \r\n");
							fwrite(archivos, "	    SetActorHealth              => https://wiki.sa-mp.com/wiki/SetActorHealth \r\n");
							fwrite(archivos, "	    SetActorInvulnerable        => https://wiki.sa-mp.com/wiki/SetActorInvulnerable \r\n");
							fwrite(archivos, "	    SetActorPos                 => https://wiki.sa-mp.com/wiki/SetActorPos \r\n");
							fwrite(archivos, "	    SetActorVirtualWorld        => https://wiki.sa-mp.com/wiki/SetActorVirtualWorld \r\n");
							fwrite(archivos, "	    ApplyActorAnimation         => https://wiki.sa-mp.com/wiki/ApplyActorAnimation \r\n");
							fwrite(archivos, "	    ClearActorAnimations        => https://wiki.sa-mp.com/wiki/ClearActorAnimations \r\n");
							fwrite(archivos, "	    CreateActor                 => https://wiki.sa-mp.com/wiki/CreateActor \r\n");
							fwrite(archivos, "	    DestroyActor                => https://wiki.sa-mp.com/wiki/DestroyActor \r\n");
							fwrite(archivos, "	    GetActorFacingAngle         => https://wiki.sa-mp.com/wiki/GetActorFacingAngle \r\n");
							fwrite(archivos, "	    GetActorHealth              => https://wiki.sa-mp.com/wiki/GetActorHealth \r\n");
							fwrite(archivos, "	    GetActorPoolSize            => https://wiki.sa-mp.com/wiki/GetActorPoolSize \r\n\r\n");
							fwrite(archivos, "*/ \r\n\r\n");
							fwrite(archivos, "/**** Editing system actors - By OTACON ****/\r\n\r\n");
							fclose(archivos);
						}

						format(data,sizeof(data),"{005BA1}INFO: haz guardado todos los actores correctamente!. actors created in total: [%d/%d].",cantidad_actores,MAX_ACTORS);
						SendClientMessage(playerid,-1,data);
						format(data,sizeof(data),"{005BA1}INFO: all players have been saved in the file: '%s.txt', en 'scriptfiles'.",opcion);
						SendClientMessage(playerid,-1,data);
						SendClientMessage(playerid,-1,"{EEE019}INFO: the editor is restarted, all the players have been eliminated!.");
						for(new xx=1; xx<cantidad_actores+1; xx++){
							if(!IsValidActor(InfoActorEdicion[xx][c_actor]))
								continue;
							DestroyActor(InfoActorEdicion[xx][c_actor]);
							Delete3DTextLabel(InfoActorEdicion[xx][label]);
							InfoActorEdicion[xx][a_skin] = 0;
							InfoActorEdicion[xx][c_actor] = 0;
							InfoActorEdicion[xx][i_actor] = false;
							InfoActorEdicion[xx][h_actor] = 0.0;
							InfoActorEdicion[xx][color_actor] = -1;
						    format(InfoActorEdicion[xx][a_animlib],32,"%s","null");
						    format(InfoActorEdicion[xx][a_animname],32,"%s","null");
						    format(InfoActorEdicion[xx][a_name],24,"%s","Actor");
						    DestroyObject(InfoActorEdicion[xx][objeto_select]);
						}
						cantidad_actores=0;
					}
				}else{
					ShowPlayerDialog(playerid, DIALOG_ACTORS+4, DIALOG_STYLE_INPUT, "{FF6800}Editing system actors:", "\
					{FFFFFF}type a name for the file that stores the actors created.\n\
					{A50000}NOTE: You can use the 'default' to be applied\n\
					the name {FFFFFF}'actors.0001' {A50000}(by counting the number will file created). ", "accept", "by default");
				}
	        }else{
				format(data,sizeof(data),"actors.%04d.%s",cantidad_archivos, (tipo_archivo_a[playerid])?("txt"):("pwn") );
				if(fexist(data))fremove(data);
				archivos=fopen(data, io_readwrite);
				if(archivos){

					if(tipo_archivo_a[playerid]){
						fwrite(archivos, "\r\n/**** Editing system actors - By OTACON ****/\r\n");
						format(datos,sizeof(datos),"	new actorid[%d];\r\n", cantidad_actores+1);
						fwrite(archivos, datos);
						format(datos,sizeof(datos),"	new Text3D:text_actor[%d];\r\n\r\n", cantidad_actores+1);
						fwrite(archivos, datos);
						for(new xx=1; xx<cantidad_actores+1; xx++){
							if(!IsValidActor(InfoActorEdicion[xx][c_actor]))
								continue;
							GetActorPos(InfoActorEdicion[xx][c_actor], pos[0],pos[1],pos[2]);
							GetActorFacingAngle(InfoActorEdicion[xx][c_actor], pos[3]);
							format(datos,sizeof(datos),"	actorid[%d] = CreateActor(%d, %f,%f,%f,%f);\r\n", xx,InfoActorEdicion[xx][a_skin],pos[0],pos[1],pos[2],pos[3]);
							fwrite(archivos, datos);
						}
						fwrite(archivos, "\r\n	new data[144];\r\n");
						for(new xx=1; xx<cantidad_actores+1; xx++){
							if(!IsValidActor(InfoActorEdicion[xx][c_actor]))
								continue;
							GetActorPos(InfoActorEdicion[xx][c_actor], pos[0],pos[1],pos[2]);
							virtualword = GetActorVirtualWorld(playerid);
							format(datos,sizeof(datos),"	text_actor[%d] = Create3DTextLabel(\"_\",-1,%f,%f,%f,10,%d,0);\r\n",xx,pos[1],pos[2],pos[3]+1,virtualword);
							fwrite(archivos, datos);
							format(datos,sizeof(datos),"	format(data,sizeof(data),\"%s:%s\",actorid[%d]);\r\n",InfoActorEdicion[xx][a_name],"(id:%d)",xx);
							fwrite(archivos, datos);
							format(datos,sizeof(datos),"	Update3DTextLabelText(text_actor[%d],0x%08x,data);\r\n\r\n",xx,InfoActorEdicion[xx][color_actor]);
							fwrite(archivos, datos);
						}
						for(new xx=1; xx<cantidad_actores+1; xx++){
							if(!IsValidActor(InfoActorEdicion[xx][c_actor]))
								continue;
							GetActorFacingAngle(InfoActorEdicion[xx][c_actor], pos[3]);
							virtualword = GetActorVirtualWorld(playerid);
							GetActorHealth(InfoActorEdicion[xx][c_actor], health);
							format(datos,sizeof(datos),"	SetActorFacingAngle(actorid[%d], %f);\r\n", xx,pos[3]);
							fwrite(archivos, datos);
							format(datos,sizeof(datos),"	SetActorVirtualWorld(actorid[%d], %d);\r\n", xx,virtualword);
							fwrite(archivos, datos);
							format(datos,sizeof(datos),"	SetActorInvulnerable(actorid[%d], %s);\r\n", xx, (!InfoActorEdicion[xx][i_actor])?("false"):("true") );
							fwrite(archivos, datos);
							format(datos,sizeof(datos),"	SetActorHealth(actorid[%d], %f);\r\n", xx,InfoActorEdicion[xx][h_actor]);
							fwrite(archivos, datos);
							format(datos,sizeof(datos),"	ApplyActorAnimation(actorid[%d], \"%s\", \"%s\" 4.1, 1, 1, 1, 1, 1);\r\n", xx, InfoActorEdicion[xx][a_animlib],InfoActorEdicion[xx][a_animname]);
							fwrite(archivos, datos);
							fwrite(archivos, "	// NOTE: changing the settings: (Float:fDelta, loop, lockx, locky, freeze, time) \r\n");
							fwrite(archivos, "	// https://wiki.sa-mp.com/wiki/ApplyActorAnimation \r\n\r\n");
						}
						fwrite(archivos, "\r\n/*  * MORE FEATURES...: \r\n\r\n");
						fwrite(archivos, "	    GetActorPos                 => https://wiki.sa-mp.com/wiki/GetActorPos \r\n");
						fwrite(archivos, "	    GetActorVirtualWorld        => https://wiki.sa-mp.com/wiki/GetActorVirtualWorld \r\n");
						fwrite(archivos, "	    GetPlayerTargetActor        => https://wiki.sa-mp.com/wiki/GetPlayerTargetActor \r\n");
						fwrite(archivos, "	    IsActorInvulnerable         => https://wiki.sa-mp.com/wiki/IsActorInvulnerable \r\n");
						fwrite(archivos, "	    IsActorStreamedIn           => https://wiki.sa-mp.com/wiki/IsActorStreamedIn \r\n");
						fwrite(archivos, "	    IsValidActor                => https://wiki.sa-mp.com/wiki/IsValidActor \r\n");
						fwrite(archivos, "	    OnActorStreamIn             => https://wiki.sa-mp.com/wiki/OnActorStreamIn \r\n");
						fwrite(archivos, "	    OnActorStreamOut            => https://wiki.sa-mp.com/wiki/OnActorStreamOut \r\n");
						fwrite(archivos, "	    OnPlayerGiveDamageActor     => https://wiki.sa-mp.com/wiki/OnPlayerGiveDamageActor \r\n");
						fwrite(archivos, "	    SetActorFacingAngle         => https://wiki.sa-mp.com/wiki/SetActorFacingAngle \r\n");
						fwrite(archivos, "	    SetActorHealth              => https://wiki.sa-mp.com/wiki/SetActorHealth \r\n");
						fwrite(archivos, "	    SetActorInvulnerable        => https://wiki.sa-mp.com/wiki/SetActorInvulnerable \r\n");
						fwrite(archivos, "	    SetActorPos                 => https://wiki.sa-mp.com/wiki/SetActorPos \r\n");
						fwrite(archivos, "	    SetActorVirtualWorld        => https://wiki.sa-mp.com/wiki/SetActorVirtualWorld \r\n");
						fwrite(archivos, "	    ApplyActorAnimation         => https://wiki.sa-mp.com/wiki/ApplyActorAnimation \r\n");
						fwrite(archivos, "	    ClearActorAnimations        => https://wiki.sa-mp.com/wiki/ClearActorAnimations \r\n");
						fwrite(archivos, "	    CreateActor                 => https://wiki.sa-mp.com/wiki/CreateActor \r\n");
						fwrite(archivos, "	    DestroyActor                => https://wiki.sa-mp.com/wiki/DestroyActor \r\n");
						fwrite(archivos, "	    GetActorFacingAngle         => https://wiki.sa-mp.com/wiki/GetActorFacingAngle \r\n");
						fwrite(archivos, "	    GetActorHealth              => https://wiki.sa-mp.com/wiki/GetActorHealth \r\n");
						fwrite(archivos, "	    GetActorPoolSize            => https://wiki.sa-mp.com/wiki/GetActorPoolSize \r\n\r\n");
						fwrite(archivos, "*/ \r\n\r\n");
						fwrite(archivos, "/**** Editing system actors - By OTACON ****/\r\n\r\n");
						fclose(archivos);
					}else{
						fwrite(archivos, "\r\n/**** Editing system actors - By OTACON ****/\r\n");
						fwrite(archivos, "#include <a_samp>\r\n\r\n");
						format(datos,sizeof(datos),"new actorid[%d];\r\n", cantidad_actores+1);
						fwrite(archivos, datos);
						format(datos,sizeof(datos),"new Text3D:text_actor[%d];\r\n\r\n", cantidad_actores+1);
						fwrite(archivos, datos);
						fwrite(archivos, "public OnFilterScriptInit(){\r\n\r\n");
						for(new xx=1; xx<cantidad_actores+1; xx++){
							if(!IsValidActor(InfoActorEdicion[xx][c_actor]))
								continue;
							GetActorPos(InfoActorEdicion[xx][c_actor], pos[0],pos[1],pos[2]);
							GetActorFacingAngle(InfoActorEdicion[xx][c_actor], pos[3]);
							format(datos,sizeof(datos),"	actorid[%d] = CreateActor(%d, %f,%f,%f,%f);\r\n", xx,InfoActorEdicion[xx][a_skin],pos[0],pos[1],pos[2],pos[3]);
							fwrite(archivos, datos);
						}
						fwrite(archivos, "\r\n	new data[144];\r\n");
						for(new xx=1; xx<cantidad_actores+1; xx++){
							if(!IsValidActor(InfoActorEdicion[xx][c_actor]))
								continue;
							GetActorPos(InfoActorEdicion[xx][c_actor], pos[0],pos[1],pos[2]);
							virtualword = GetActorVirtualWorld(playerid);
							format(datos,sizeof(datos),"	text_actor[%d] = Create3DTextLabel(\"_\",-1,%f,%f,%f,10,%d,0);\r\n",xx,pos[1],pos[2],pos[3]+1,virtualword);
							fwrite(archivos, datos);
							format(datos,sizeof(datos),"	format(data,sizeof(data),\"%s:%s\",actorid[%d]);\r\n",InfoActorEdicion[xx][a_name],"(id:%d)",xx);
							fwrite(archivos, datos);
							format(datos,sizeof(datos),"	Update3DTextLabelText(text_actor[%d],0x%08x,data);\r\n\r\n",xx,InfoActorEdicion[xx][color_actor]);
							fwrite(archivos, datos);
						}
						for(new xx=1; xx<cantidad_actores+1; xx++){
							if(!IsValidActor(InfoActorEdicion[xx][c_actor]))
								continue;
							GetActorFacingAngle(InfoActorEdicion[xx][c_actor], pos[3]);
							virtualword = GetActorVirtualWorld(playerid);
							GetActorHealth(InfoActorEdicion[xx][c_actor], health);
							format(datos,sizeof(datos),"	SetActorFacingAngle(actorid[%d], %f);\r\n", xx,pos[3]);
							fwrite(archivos, datos);
							format(datos,sizeof(datos),"	SetActorVirtualWorld(actorid[%d], %d);\r\n", xx,virtualword);
							fwrite(archivos, datos);
							format(datos,sizeof(datos),"	SetActorInvulnerable(actorid[%d], %s);\r\n", xx, (!InfoActorEdicion[xx][i_actor])?("false"):("true") );
							fwrite(archivos, datos);
							format(datos,sizeof(datos),"	SetActorHealth(actorid[%d], %f);\r\n", xx,InfoActorEdicion[xx][h_actor]);
							fwrite(archivos, datos);
							format(datos,sizeof(datos),"	ApplyActorAnimation(actorid[%d], \"%s\", \"%s\", 4.1, 1, 1, 1, 1, 1);\r\n", xx, InfoActorEdicion[xx][a_animlib],InfoActorEdicion[xx][a_animname]);
							fwrite(archivos, datos);
							fwrite(archivos, "	// NOTE: changing the settings: (Float:fDelta, loop, lockx, locky, freeze, time) \r\n");
							fwrite(archivos, "	// https://wiki.sa-mp.com/wiki/ApplyActorAnimation \r\n\r\n");
						}
						fwrite(archivos, "	return true;\r\n");
						fwrite(archivos, "}\r\n\r\n");
						fwrite(archivos, "public OnPlayerGiveDamageActor(playerid, damaged_actorid, Float: amount, weaponid, bodypart){\r\n\r\n");
						fwrite(archivos, "    new\r\n");
						fwrite(archivos, "		Float:health;\r\n");
						fwrite(archivos, "    GetActorHealth(actorid[damaged_actorid], health);\r\n");
						fwrite(archivos, "	if(IsValidActor(actorid[damaged_actorid])){\r\n");
						fwrite(archivos, "		if(!IsActorInvulnerable(actorid[damaged_actorid])){\r\n");
						fwrite(archivos, "			SetActorHealth(actorid[damaged_actorid], (health-amount));\r\n");
						fwrite(archivos, "			if(health<=0.0){\r\n");
						fwrite(archivos, "				SetActorHealth(actorid[damaged_actorid], 100.0);\r\n");
						fwrite(archivos, "			}\r\n");
						fwrite(archivos, "		}\r\n");
						fwrite(archivos, "	}\r\n\r\n");
						fwrite(archivos, "	return true;\r\n");
						fwrite(archivos, "}\r\n\r\n");
						fwrite(archivos, "/*  * MORE FEATURES...: \r\n\r\n");
						fwrite(archivos, "	    GetActorPos                 => https://wiki.sa-mp.com/wiki/GetActorPos \r\n");
						fwrite(archivos, "	    GetActorVirtualWorld        => https://wiki.sa-mp.com/wiki/GetActorVirtualWorld \r\n");
						fwrite(archivos, "	    GetPlayerTargetActor        => https://wiki.sa-mp.com/wiki/GetPlayerTargetActor \r\n");
						fwrite(archivos, "	    IsActorInvulnerable         => https://wiki.sa-mp.com/wiki/IsActorInvulnerable \r\n");
						fwrite(archivos, "	    IsActorStreamedIn           => https://wiki.sa-mp.com/wiki/IsActorStreamedIn \r\n");
						fwrite(archivos, "	    IsValidActor                => https://wiki.sa-mp.com/wiki/IsValidActor \r\n");
						fwrite(archivos, "	    OnActorStreamIn             => https://wiki.sa-mp.com/wiki/OnActorStreamIn \r\n");
						fwrite(archivos, "	    OnActorStreamOut            => https://wiki.sa-mp.com/wiki/OnActorStreamOut \r\n");
						fwrite(archivos, "	    OnPlayerGiveDamageActor     => https://wiki.sa-mp.com/wiki/OnPlayerGiveDamageActor \r\n");
						fwrite(archivos, "	    SetActorFacingAngle         => https://wiki.sa-mp.com/wiki/SetActorFacingAngle \r\n");
						fwrite(archivos, "	    SetActorHealth              => https://wiki.sa-mp.com/wiki/SetActorHealth \r\n");
						fwrite(archivos, "	    SetActorInvulnerable        => https://wiki.sa-mp.com/wiki/SetActorInvulnerable \r\n");
						fwrite(archivos, "	    SetActorPos                 => https://wiki.sa-mp.com/wiki/SetActorPos \r\n");
						fwrite(archivos, "	    SetActorVirtualWorld        => https://wiki.sa-mp.com/wiki/SetActorVirtualWorld \r\n");
						fwrite(archivos, "	    ApplyActorAnimation         => https://wiki.sa-mp.com/wiki/ApplyActorAnimation \r\n");
						fwrite(archivos, "	    ClearActorAnimations        => https://wiki.sa-mp.com/wiki/ClearActorAnimations \r\n");
						fwrite(archivos, "	    CreateActor                 => https://wiki.sa-mp.com/wiki/CreateActor \r\n");
						fwrite(archivos, "	    DestroyActor                => https://wiki.sa-mp.com/wiki/DestroyActor \r\n");
						fwrite(archivos, "	    GetActorFacingAngle         => https://wiki.sa-mp.com/wiki/GetActorFacingAngle \r\n");
						fwrite(archivos, "	    GetActorHealth              => https://wiki.sa-mp.com/wiki/GetActorHealth \r\n");
						fwrite(archivos, "	    GetActorPoolSize            => https://wiki.sa-mp.com/wiki/GetActorPoolSize \r\n\r\n");
						fwrite(archivos, "*/ \r\n\r\n");
						fwrite(archivos, "/**** Editing system actors - By OTACON ****/\r\n\r\n");
						fclose(archivos);
					}

					format(data,sizeof(data),"{005BA1}INFO: haz guardado todos los actores correctamente!. actors created in total: [%d/%d].",cantidad_actores,MAX_ACTORS);
					SendClientMessage(playerid,-1,data);
					format(data,sizeof(data),"{005BA1}INFO: all players have been saved in the file: 'actors.%d04.txt', en 'scriptfiles'.",cantidad_archivos);
					SendClientMessage(playerid,-1,data);
					SendClientMessage(playerid,-1,"{EEE019}INFO: the editor is restarted, all the players have been eliminated!.");
					cantidad_archivos++;
					for(new xx=1; xx<cantidad_actores+1; xx++){
						if(!IsValidActor(InfoActorEdicion[xx][c_actor]))
							continue;
						DestroyActor(InfoActorEdicion[xx][c_actor]);
						Delete3DTextLabel(InfoActorEdicion[xx][label]);
						InfoActorEdicion[xx][a_skin] = 0;
						InfoActorEdicion[xx][c_actor] = 0;
						InfoActorEdicion[xx][i_actor] = false;
						InfoActorEdicion[xx][h_actor] = 0.0;
						InfoActorEdicion[xx][color_actor] = -1;
			    		format(InfoActorEdicion[xx][a_animlib],32,"%s","null");
					    format(InfoActorEdicion[xx][a_animname],32,"%s","null");
					    format(InfoActorEdicion[xx][a_name],24,"%s","Actor");
					    DestroyObject(InfoActorEdicion[xx][objeto_select]);
					}
					cantidad_actores=0;
				}
	        }
	    }

        case DIALOG_ACTORS+5:{
	        if(response){
				ShowPlayerDialog(playerid, DIALOG_ACTORS+6, DIALOG_STYLE_INPUT, "{FF6800}Editing system actors:", "\
				{FFFFFF}id type of actor who want to establish:. ", "accept", "cancel");
	        }else CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
	    }

        case DIALOG_ACTORS+6:{
	        if(response){
				new opcion;
				if(!sscanf(inputtext, "d", opcion)){
					if( IsValidActor(InfoActorEdicion[opcion][c_actor]) ){
						id_seleccionado = opcion;
						format(data,sizeof(data),"{FFFFFF}INFO: the actor id is established: id:%d", id_seleccionado);
						SendClientMessage(playerid,-1,data);
						CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
					}else{
						ShowPlayerDialog(playerid, DIALOG_ACTORS+6, DIALOG_STYLE_INPUT, "{FF6800}Editing system actors:", "\
						{FFFFFF}id type of actor who want to establish: \n\
						{A50000}NOTE: You have not written anything, try again. ", "accept", "cancel");
					}
				}else{
					ShowPlayerDialog(playerid, DIALOG_ACTORS+6, DIALOG_STYLE_INPUT, "{FF6800}Editing system actors:", "\
					{FFFFFF}id type of actor who want to establish: \n\
					{A50000}NOTE: You have not written anything, try again. ", "accept", "cancel");
				}
	        }else CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
		}

        case DIALOG_ACTORS+7:{
	        if(response){
				ShowPlayerDialog(playerid, DIALOG_ACTORS+8, DIALOG_STYLE_INPUT, "{FF6800}Editing system actors:", "\
				{FFFFFF}id type that has the actor, must be greater or equal to 0 and less than or equal to 311.\n\
				{A50000}NOTE: You can use the 'default' that will apply a random id from 0 to 311. ", "accept", "by default");
	        }else{
	        	cantidad_actores++;
				InfoActorEdicion[cantidad_actores][a_skin] = 0;
				InfoActorEdicion[cantidad_actores][i_actor] = false;
				InfoActorEdicion[cantidad_actores][h_actor] = 0.0;
				InfoActorEdicion[cantidad_actores][color_actor] = -1;
			    format(InfoActorEdicion[cantidad_actores][a_animlib],32,"%s","null");
			    format(InfoActorEdicion[cantidad_actores][a_animname],32,"%s","null");
			    format(InfoActorEdicion[cantidad_actores][a_name],24,"%s","Actor");

				InfoActorEdicion[cantidad_actores][a_skin] = random(311);
				InfoActorEdicion[cantidad_actores][c_actor] = CreateActor(InfoActorEdicion[cantidad_actores][a_skin], pos[0],pos[1],pos[2], pos[3]);
				SetActorPos(InfoActorEdicion[cantidad_actores][c_actor], pos[0],pos[1],pos[2]);
				SetActorFacingAngle(InfoActorEdicion[cantidad_actores][c_actor], pos[3]);
				SetActorVirtualWorld(InfoActorEdicion[cantidad_actores][c_actor], virtualword);
				InfoActorEdicion[cantidad_actores][h_actor] = vida_id;
				SetActorHealth(InfoActorEdicion[cantidad_actores][c_actor], InfoActorEdicion[cantidad_actores][h_actor]);
				InfoActorEdicion[cantidad_actores][i_actor] = actor_Invulnerable;
				SetActorInvulnerable(InfoActorEdicion[cantidad_actores][c_actor], InfoActorEdicion[cantidad_actores][i_actor]);
				InfoActorEdicion[cantidad_actores][objeto_select] = CreateObject(18631, pos[0],pos[1],pos[2], 0,0,0);

				InfoActorEdicion[cantidad_actores][label] = Create3DTextLabel("_",-1,pos[0],pos[1],pos[2]+1,10,virtualword,0);
				format(InfoActorEdicion[cantidad_actores][a_name],25,"%s","Actor");
				format(data,sizeof(data),"%s:(id:%d)",InfoActorEdicion[cantidad_actores][a_name],cantidad_actores);
				Update3DTextLabelText(InfoActorEdicion[cantidad_actores][label],InfoActorEdicion[cantidad_actores][color_actor],data);
				pos[0]=pos[0]-(1*floatsin(-pos[3],degrees));
				pos[1]=pos[1]-(1*floatcos(-pos[3],degrees));
				SetPlayerPos(playerid, pos[0],pos[1],pos[2]);

				format(data,sizeof(data),"{EEE019}INFO: beam created an actor correctly!. actors created in total: [%d/%d].",cantidad_actores,MAX_ACTORS);
				SendClientMessage(playerid,-1,data);
	        }
	    }

        case DIALOG_ACTORS+8:{
	        if(response){
				new ropa;
				if(!sscanf(inputtext, "d", ropa)){
					if(ropa>=0 && ropa<=311){
			        	cantidad_actores++;
						InfoActorEdicion[cantidad_actores][a_skin] = 0;
						InfoActorEdicion[cantidad_actores][i_actor] = false;
						InfoActorEdicion[cantidad_actores][h_actor] = 0.0;
						InfoActorEdicion[cantidad_actores][color_actor] = -1;
					    format(InfoActorEdicion[cantidad_actores][a_animlib],32,"%s","null");
					    format(InfoActorEdicion[cantidad_actores][a_animname],32,"%s","null");
					    format(InfoActorEdicion[cantidad_actores][a_name],24,"%s","Actor");

						InfoActorEdicion[cantidad_actores][a_skin] = ropa;
						InfoActorEdicion[cantidad_actores][c_actor] = CreateActor(InfoActorEdicion[cantidad_actores][a_skin], pos[0],pos[1],pos[2], pos[3]);
						SetActorPos(InfoActorEdicion[cantidad_actores][c_actor], pos[0],pos[1],pos[2]);
						SetActorFacingAngle(InfoActorEdicion[cantidad_actores][c_actor], pos[3]);
						SetActorVirtualWorld(InfoActorEdicion[cantidad_actores][c_actor], virtualword);
						InfoActorEdicion[cantidad_actores][h_actor] = vida_id;
						SetActorHealth(InfoActorEdicion[cantidad_actores][c_actor], InfoActorEdicion[cantidad_actores][h_actor]);
						InfoActorEdicion[cantidad_actores][i_actor] = actor_Invulnerable;
						SetActorInvulnerable(InfoActorEdicion[cantidad_actores][c_actor], InfoActorEdicion[cantidad_actores][i_actor]);
						InfoActorEdicion[cantidad_actores][objeto_select] = CreateObject(18631, pos[0],pos[1],pos[2], 0,0,0);

						InfoActorEdicion[cantidad_actores][label] = Create3DTextLabel("_",-1,pos[0],pos[1],pos[2]+1,10,virtualword,0);
						format(InfoActorEdicion[cantidad_actores][a_name],25,"%s","Actor");
						format(data,sizeof(data),"%s:(id:%d)",InfoActorEdicion[cantidad_actores][a_name],cantidad_actores);
						Update3DTextLabelText(InfoActorEdicion[cantidad_actores][label],InfoActorEdicion[cantidad_actores][color_actor],data);
						pos[0]=pos[0]-(1*floatsin(-pos[3],degrees));
						pos[1]=pos[1]-(1*floatcos(-pos[3],degrees));
						SetPlayerPos(playerid, pos[0],pos[1],pos[2]);

						format(data,sizeof(data),"{EEE019}INFO: beam created an actor correctly!. actors created in total: [%d/%d].",cantidad_actores,MAX_ACTORS);
						SendClientMessage(playerid,-1,data);
					}else{
						ShowPlayerDialog(playerid, DIALOG_ACTORS+8, DIALOG_STYLE_INPUT, "{FF6800}Editing system actors:", "\
						{FFFFFF}id type that has the actor, must be greater or equal to 0 and less than or equal to 311.\n\
						{A50000}NOTE: You can use the 'default' that will apply a random id from 0 to 311. ", "accept", "by default");
					}
				}else{
					ShowPlayerDialog(playerid, DIALOG_ACTORS+8, DIALOG_STYLE_INPUT, "{FF6800}Editing system actors:", "\
					{FFFFFF}id type that has the actor, must be greater or equal to 0 and less than or equal to 311.\n\
					{A50000}NOTE: You can use the 'default' that will apply a random id from 0 to 311. ", "accept", "by default");
				}
	        }else{
	        	cantidad_actores++;
				InfoActorEdicion[cantidad_actores][a_skin] = 0;
				InfoActorEdicion[cantidad_actores][i_actor] = false;
				InfoActorEdicion[cantidad_actores][h_actor] = 0.0;
				InfoActorEdicion[cantidad_actores][color_actor] = -1;
			    format(InfoActorEdicion[cantidad_actores][a_animlib],32,"%s","null");
			    format(InfoActorEdicion[cantidad_actores][a_animname],32,"%s","null");
			    format(InfoActorEdicion[cantidad_actores][a_name],24,"%s","Actor");

				InfoActorEdicion[cantidad_actores][a_skin] = random(311);
				InfoActorEdicion[cantidad_actores][c_actor] = CreateActor(InfoActorEdicion[cantidad_actores][a_skin], pos[0],pos[1],pos[2], pos[3]);
				SetActorPos(InfoActorEdicion[cantidad_actores][c_actor], pos[0],pos[1],pos[2]);
				SetActorFacingAngle(InfoActorEdicion[cantidad_actores][c_actor], pos[3]);
				SetActorVirtualWorld(InfoActorEdicion[cantidad_actores][c_actor], virtualword);
				InfoActorEdicion[cantidad_actores][h_actor] = vida_id;
				SetActorHealth(InfoActorEdicion[cantidad_actores][c_actor], InfoActorEdicion[cantidad_actores][h_actor]);
				InfoActorEdicion[cantidad_actores][i_actor] = actor_Invulnerable;
				SetActorInvulnerable(InfoActorEdicion[cantidad_actores][c_actor], InfoActorEdicion[cantidad_actores][i_actor]);
				InfoActorEdicion[cantidad_actores][objeto_select] = CreateObject(18631, pos[0],pos[1],pos[2], 0,0,0);

				InfoActorEdicion[cantidad_actores][label] = Create3DTextLabel("_",-1,pos[0],pos[1],pos[2]+1,10,virtualword,0);
				format(InfoActorEdicion[cantidad_actores][a_name],25,"%s","Actor");
				format(data,sizeof(data),"%s:(id:%d)",InfoActorEdicion[cantidad_actores][a_name],cantidad_actores);
				Update3DTextLabelText(InfoActorEdicion[cantidad_actores][label],InfoActorEdicion[cantidad_actores][color_actor],data);
				pos[0]=pos[0]-(1*floatsin(-pos[3],degrees));
				pos[1]=pos[1]-(1*floatcos(-pos[3],degrees));
				SetPlayerPos(playerid, pos[0],pos[1],pos[2]);

				format(data,sizeof(data),"{EEE019}INFO: beam created an actor correctly!. actors created in total: [%d/%d].",cantidad_actores,MAX_ACTORS);
				SendClientMessage(playerid,-1,data);
	        }
	    }

        case DIALOG_ACTORS+9:{
	        if(response){
				new name_a[25];
				if(!sscanf(inputtext, "s[25]", name_a)){
					if(strlen(name_a)>=4 && strlen(name_a)<=24){
						format(InfoActorEdicion[id_seleccionado][a_name],25,"%s",name_a);
						format(data,sizeof(data),"%s:(id:%d)",InfoActorEdicion[id_seleccionado][a_name],id_seleccionado);
						Update3DTextLabelText(InfoActorEdicion[id_seleccionado][label],InfoActorEdicion[id_seleccionado][color_actor],data);

						format(data,sizeof(data),"{FFFFFF}INFO: do you renamed the actor id:%d, correctamente!.", id_seleccionado);
						SendClientMessage(playerid,-1,data);
						format(data,sizeof(data),"{EEE019}NOTA: Now the actor id:%d It is named after :%s.", id_seleccionado,InfoActorEdicion[id_seleccionado][a_name]);
						SendClientMessage(playerid,-1,data);
						CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
					}else{
						format(data,sizeof(data),"{FFFFFF}¿Place you want to name the actor id:%d?: \n\
						{A50000}(NOTE: Enter the name you want to have the actor id:%d,  \n\
						It must be greater or equal to 4 and less than or equal to 24).", id_seleccionado,id_seleccionado);
						ShowPlayerDialog(playerid, DIALOG_ACTORS+9, DIALOG_STYLE_INPUT, "{FF6800}Editing system actors:", data, "accept", "cancel");
					}
				}else{
					format(data,sizeof(data),"{FFFFFF}¿Place you want to name the actor id:%d?: \n\
					{A50000}(NOTE: Enter the name you want to have the actor id:%d,  \n\
					It must be greater or equal to 4 and less than or equal to 24).", id_seleccionado,id_seleccionado);
					ShowPlayerDialog(playerid, DIALOG_ACTORS+9, DIALOG_STYLE_INPUT, "{FF6800}Editing system actors:", data, "accept", "cancel");
				}
	        }else CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
	    }

        case DIALOG_ACTORS+10:{
	        if(response){
				new name_a[25];
				if(!sscanf(inputtext, "s[25]", name_a)){
					if(strlen(name_a)>=4 && strlen(name_a)<=24){
						for(new xx=0; xx<cantidad_actores+1; xx++){
							if(!IsValidActor(InfoActorEdicion[xx][c_actor]))
								continue;
							format(InfoActorEdicion[xx][a_name],25,"%s",name_a);
							format(data,sizeof(data),"%s:(id:%d)",InfoActorEdicion[xx][a_name],xx);
							Update3DTextLabelText(InfoActorEdicion[xx][label],InfoActorEdicion[xx][color_actor],data);
						}
						format(data,sizeof(data),"{FFFFFF}INFO: do you renamed the %d actors created correctly!.", cantidad_actores);
						SendClientMessage(playerid,-1,data);
						format(data,sizeof(data),"{EEE019}NOTA: now the %d actors are named :%s.", cantidad_actores,name_a);
						SendClientMessage(playerid,-1,data);
						CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
					}else{
						format(data,sizeof(data),"{FFFFFF}¿You want to place them to name %d actors created?: \n\
						{A50000}(NOTE: Enter the name you want to have the% d player created,  \n\
						It must be greater or equal to 4 and less than or equal to 24).", cantidad_actores,cantidad_actores);
						ShowPlayerDialog(playerid, DIALOG_ACTORS+10, DIALOG_STYLE_INPUT, "{FF6800}Editing system actors:", data, "accept", "cancel");
					}
				}else{
					format(data,sizeof(data),"{FFFFFF}¿You want to place them to name %d actors created?: \n\
					{A50000}(NOTE: Enter the name you want to have the% d player created,  \n\
					It must be greater or equal to 4 and less than or equal to 24).", cantidad_actores,cantidad_actores);
					ShowPlayerDialog(playerid, DIALOG_ACTORS+10, DIALOG_STYLE_INPUT, "{FF6800}Editing system actors:", data, "accept", "cancel");
				}
	        }else CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
	    }

        case DIALOG_ACTORS+11:{
	        if(response){
			    switch(listitem){
			        case 0:{
						if(IsPlayerInAnyVehicle(playerid)){
							CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
							return SendClientMessage(playerid,-1,"{919BA4}INFO: You can not use the editor of actors from a vehicle!."); }
						if(!creando_actors[playerid]){
							CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
							return SendClientMessage(playerid,-1,"{919BA4}INFO: you are not the editor of actors on!."); }
						if(cantidad_actores<=0){
							CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
							return SendClientMessage(playerid,-1,"{919BA4}INFO: there is not actor created so far!."); }

						ShowPlayerDialog(playerid, DIALOG_ACTORS+5, DIALOG_STYLE_MSGBOX, "{FF6800}Editing system actors:", "\
						{FFFFFF}¿You want to select a specific id of an actor created?:", "accept", "cancel");
					}
			        case 1:{
						if(IsPlayerInAnyVehicle(playerid)){
							CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
							return SendClientMessage(playerid,-1,"{919BA4}INFO: You can not use the editor of actors from a vehicle!."); }
						if(!creando_actors[playerid]){
							CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
							return SendClientMessage(playerid,-1,"{919BA4}INFO: you are not the editor of actors on!."); }
						if(cantidad_actores<=0){
							CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
							return SendClientMessage(playerid,-1,"{919BA4}INFO: there is not actor created so far!."); }
						if(id_seleccionado<=0){
							CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
							return SendClientMessage(playerid,-1,"{919BA4}INFO: you have not selected any id for editing!."); }

					    GetAnimationName(GetPlayerAnimationIndex(playerid),animlib,32,animname,32);

					    format(InfoActorEdicion[id_seleccionado][a_animlib],32,"%s",animlib);
					    format(InfoActorEdicion[id_seleccionado][a_animname],32,"%s",animname);
					    ClearActorAnimations(InfoActorEdicion[id_seleccionado][c_actor]);
					    ApplyActorAnimation(InfoActorEdicion[id_seleccionado][c_actor], InfoActorEdicion[id_seleccionado][a_animlib], InfoActorEdicion[id_seleccionado][a_animname], 4.1, 0, 0, 0, 0, 0);
					    ApplyActorAnimation(InfoActorEdicion[id_seleccionado][c_actor], InfoActorEdicion[id_seleccionado][a_animlib], InfoActorEdicion[id_seleccionado][a_animname], 4.1, 0, 0, 0, 0, 0);

					    format(data,sizeof(data),"{EEE019}INFO: you have an animation applied to the actor id:%d, correctly!.",id_seleccionado);
					    SendClientMessage(playerid,-1,data);
					    CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
					}
			        case 2:{
						if(IsPlayerInAnyVehicle(playerid)){
							CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
							return SendClientMessage(playerid,-1,"{919BA4}INFO: You can not use the editor of actors from a vehicle!."); }
						if(!creando_actors[playerid]){
							CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
							return SendClientMessage(playerid,-1,"{919BA4}INFO: you are not the editor of actors on!."); }
						if(cantidad_actores<=0){
							CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
							return SendClientMessage(playerid,-1,"{919BA4}INFO: there is not actor created so far!."); }

					    GetAnimationName(GetPlayerAnimationIndex(playerid),animlib,32,animname,32);

						for(new xx=0; xx<cantidad_actores+1; xx++){
							if(!IsValidActor(InfoActorEdicion[xx][c_actor]))
								continue;

						    format(InfoActorEdicion[xx][a_animlib],32,"%s",animlib);
						    format(InfoActorEdicion[xx][a_animname],32,"%s",animname);
						    ClearActorAnimations(InfoActorEdicion[xx][c_actor]);
						    ApplyActorAnimation(InfoActorEdicion[xx][c_actor], InfoActorEdicion[xx][a_animlib], InfoActorEdicion[xx][a_animname], 4.1, 0, 0, 0, 0, 0);
						    ApplyActorAnimation(InfoActorEdicion[xx][c_actor], InfoActorEdicion[xx][a_animlib], InfoActorEdicion[xx][a_animname], 4.1, 0, 0, 0, 0, 0);
						}
					    SendClientMessage(playerid,-1,"{EEE019}INFO: you have an animation applied to all players created, correctly!.");
					    CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
					}
			        case 3:{
						if(IsPlayerInAnyVehicle(playerid)){
							CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
							return SendClientMessage(playerid,-1,"{919BA4}INFO: You can not use the editor of actors from a vehicle!."); }
						if(!creando_actors[playerid]){
							CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
							return SendClientMessage(playerid,-1,"{919BA4}INFO: you are not the editor of actors on!."); }
						if(cantidad_actores<=0){
							CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
							return SendClientMessage(playerid,-1,"{919BA4}INFO: there is not actor created so far!."); }
						if(id_seleccionado<=0){
							CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
							return SendClientMessage(playerid,-1,"{919BA4}INFO: you have not selected any id for editing!."); }

						format(data,sizeof(data),"{FFFFFF}¿Place you want to name the actor id:%d?:",id_seleccionado);
						ShowPlayerDialog(playerid, DIALOG_ACTORS+9, DIALOG_STYLE_INPUT, "{FF6800}Editing system actors:", data, "accept", "cancel");
					}
			        case 4:{
						if(IsPlayerInAnyVehicle(playerid)){
							CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
							return SendClientMessage(playerid,-1,"{919BA4}INFO: You can not use the editor of actors from a vehicle!."); }
						if(!creando_actors[playerid]){
							CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
							return SendClientMessage(playerid,-1,"{919BA4}INFO: you are not the editor of actors on!."); }
						if(cantidad_actores<=0){
							CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
							return SendClientMessage(playerid,-1,"{919BA4}INFO: there is not actor created so far!."); }

						format(data,sizeof(data),"{FFFFFF}¿You want to place them to name %d actors created?:",cantidad_actores);
						ShowPlayerDialog(playerid, DIALOG_ACTORS+10, DIALOG_STYLE_INPUT, "{FF6800}Editing system actors:", data, "accept", "cancel");
					}
					case 5:{
						if(IsPlayerInAnyVehicle(playerid)){
							CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
							return SendClientMessage(playerid,-1,"{919BA4}INFO: You can not use the editor of actors from a vehicle!."); }
						if(!creando_actors[playerid]){
							CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
							return SendClientMessage(playerid,-1,"{919BA4}INFO: you are not the editor of actors on!."); }
						if(cantidad_actores<=0){
							CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
							return SendClientMessage(playerid,-1,"{919BA4}INFO: there is not actor created so far!."); }
						if(id_seleccionado<=0){
							CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
							return SendClientMessage(playerid,-1,"{919BA4}INFO: you have not selected any id for editing!."); }

						seleccionando_skins[playerid][0] = true;
						format(data,sizeof(data),"{FFFFFF}\n\t\t * displaying skin: [ %d / 311 ] \n\n\
						\t\t{FF6800}>>: select your preferred option: \n\
						option - skin'>>' \n\
					  	option - skin'<<' \n\
						option - skin'random'  \n",seleccion_skis);
						ShowPlayerDialog(playerid, DIALOG_ACTORS+12, DIALOG_STYLE_LIST, "{FF6800}Editing system actors:", data, "select", "finish");
					}
					case 6:{
						if(IsPlayerInAnyVehicle(playerid)){
							CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
							return SendClientMessage(playerid,-1,"{919BA4}INFO: You can not use the editor of actors from a vehicle!."); }
						if(!creando_actors[playerid]){
							CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
							return SendClientMessage(playerid,-1,"{919BA4}INFO: you are not the editor of actors on!."); }
						if(cantidad_actores<=0){
							CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
							return SendClientMessage(playerid,-1,"{919BA4}INFO: there is not actor created so far!."); }

						seleccionando_skins[playerid][1] = true;
						format(data,sizeof(data),"{FFFFFF}\n\t\t * displaying skin: [ %d / 311 ] \n\n\
						\t\t{FF6800}>>: select your preferred option: \n\
						option - skin'>>' \n\
					  	option - skin'<<' \n\
						option - skin'random'  \n",seleccion_skis);
						ShowPlayerDialog(playerid, DIALOG_ACTORS+13, DIALOG_STYLE_LIST, "{FF6800}Editing system actors:", data, "select", "finish");
					}
					case 7:{
						if(IsPlayerInAnyVehicle(playerid)){
							CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
							return SendClientMessage(playerid,-1,"{919BA4}INFO: You can not use the editor of actors from a vehicle!."); }
						if(!creando_actors[playerid]){
							CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
							return SendClientMessage(playerid,-1,"{919BA4}INFO: you are not the editor of actors on!."); }
						if(cantidad_actores<=0){
							CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
							return SendClientMessage(playerid,-1,"{919BA4}INFO: there is not actor created so far!."); }
						if(id_seleccionado<=0){
							CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
							return SendClientMessage(playerid,-1,"{919BA4}INFO: you have not selected any id for editing!."); }

						ShowPlayerDialog(playerid, DIALOG_ACTORS+14, DIALOG_STYLE_INPUT, "{FF6800}Editing system actors:", "\
						{FFFFFF}put the color you want to place the name of all players: \n\
						{A50000}(NOTE: The color format must be in 'hex' example: 0xFFFFFFFF \n\
						", "accept", "cancel");
					}
					case 8:{
						if(IsPlayerInAnyVehicle(playerid)){
							CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
							return SendClientMessage(playerid,-1,"{919BA4}INFO: You can not use the editor of actors from a vehicle!."); }
						if(!creando_actors[playerid]){
							CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
							return SendClientMessage(playerid,-1,"{919BA4}INFO: you are not the editor of actors on!."); }
						if(cantidad_actores<=0){
							CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
							return SendClientMessage(playerid,-1,"{919BA4}INFO: there is not actor created so far!."); }

						ShowPlayerDialog(playerid, DIALOG_ACTORS+15, DIALOG_STYLE_INPUT, "{FF6800}Editing system actors:", "\
						{FFFFFF}put the color you want to place the name of all players: \n\
						{A50000}(NOTE: The color format must be in 'hex' example: 0xFFFFFFFF \n\
						", "accept", "cancel");
					}
					case 9:{
						if(IsPlayerInAnyVehicle(playerid)){
							CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
							return SendClientMessage(playerid,-1,"{919BA4}INFO: You can not use the editor of actors from a vehicle!."); }
						if(!creando_actors[playerid]){
							CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
							return SendClientMessage(playerid,-1,"{919BA4}INFO: you are not the editor of actors on!."); }
						if(cantidad_actores<=0){
							CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
							return SendClientMessage(playerid,-1,"{919BA4}INFO: there is not actor created so far!."); }

						seleccioando_actor[playerid][0]=true;
						SelectObject(playerid);
						SendClientMessage(playerid,-1,"{EEE019}INFO: Now select an actor to establish its id!.");
			    		SendClientMessage(playerid,-1,"{FFFFFF}INFO: to change the camera when you're in edit mode,");
			    		SendClientMessage(playerid,-1,"{FFFFFF}Keep the 'TAB' key and moving the 'mouse' to change!.");
					}
					case 10:{
						if(IsPlayerInAnyVehicle(playerid)){
							CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
							return SendClientMessage(playerid,-1,"{919BA4}INFO: You can not use the editor of actors from a vehicle!."); }
						if(!creando_actors[playerid]){
							CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
							return SendClientMessage(playerid,-1,"{919BA4}INFO: you are not the editor of actors on!."); }
						if(cantidad_actores<=0){
							CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
							return SendClientMessage(playerid,-1,"{919BA4}INFO: there is not actor created so far!."); }

						seleccioando_actor[playerid][1]=true;
						SelectObject(playerid);
						SendClientMessage(playerid,-1,"{EEE019}INFO: Now select an actor to begin to move!.");
			    		SendClientMessage(playerid,-1,"{FFFFFF}INFO: to change the camera when you're in edit mode,");
			    		SendClientMessage(playerid,-1,"{FFFFFF}Keep the 'TAB' key and moving the 'mouse' to change!.");
					}
			    }
	        }
	    }

        case DIALOG_ACTORS+12:{
	        if(response){
			    switch(listitem){
			        case 3:{
				        if(!seleccionando_skins[playerid][0]){
							CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
							return SendClientMessage(playerid,-1,"{919BA4}INFO: you have not selected any id for editing!.");}

						if(seleccion_skis>=311) seleccion_skis=311;
				        else seleccion_skis++;
						format(data,sizeof(data),"{FFFFFF}\n\t\t * displaying skin: [ %d / 311 ] \n\n\
						\t\t{FF6800}>>: select your preferred option: \n\
						option - skin'>>' \n\
					  	option - skin'<<' \n\
						option - skin'random'  \n",seleccion_skis);
						ShowPlayerDialog(playerid, DIALOG_ACTORS+12, DIALOG_STYLE_LIST, "{FF6800}Editing system actors:", data, "select", "finish");

						GetActorPos(InfoActorEdicion[id_seleccionado][c_actor], pos[0],pos[1],pos[2]);
						GetActorFacingAngle(InfoActorEdicion[id_seleccionado][c_actor], pos[3]);
						DestroyActor(InfoActorEdicion[id_seleccionado][c_actor]);
						InfoActorEdicion[id_seleccionado][a_skin] = seleccion_skis;
						InfoActorEdicion[id_seleccionado][c_actor] = CreateActor(InfoActorEdicion[id_seleccionado][a_skin], pos[0],pos[1],pos[2], pos[3]);
			        }
			        case 4:{
				        if(!seleccionando_skins[playerid][0]){
							CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
							return SendClientMessage(playerid,-1,"{919BA4}INFO: you have not selected any id for editing!."); }

						if(seleccion_skis<=0) seleccion_skis=0;
				        else seleccion_skis--;
						format(data,sizeof(data),"{FFFFFF}\n\t\t * displaying skin: [ %d / 311 ] \n\n\
						\t\t{FF6800}>>: select your preferred option: \n\
						option - skin'>>' \n\
					  	option - skin'<<' \n\
						option - skin'random'  \n",seleccion_skis);
						ShowPlayerDialog(playerid, DIALOG_ACTORS+12, DIALOG_STYLE_LIST, "{FF6800}Editing system actors:", data, "select", "finish");

						GetActorPos(InfoActorEdicion[id_seleccionado][c_actor], pos[0],pos[1],pos[2]);
						GetActorFacingAngle(InfoActorEdicion[id_seleccionado][c_actor], pos[3]);
						DestroyActor(InfoActorEdicion[id_seleccionado][c_actor]);
						InfoActorEdicion[id_seleccionado][a_skin] = seleccion_skis;
						InfoActorEdicion[id_seleccionado][c_actor] = CreateActor(InfoActorEdicion[id_seleccionado][a_skin], pos[0],pos[1],pos[2], pos[3]);
			        }
			        case 5:{
				        if(!seleccionando_skins[playerid][0]){
							CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
							return SendClientMessage(playerid,-1,"{919BA4}INFO: you have not selected any id for editing!."); }

				        seleccion_skis=random(311);
						format(data,sizeof(data),"{FFFFFF}\n\t\t * displaying skin: [ %d / 311 ] \n\n\
						\t\t{FF6800}>>: select your preferred option: \n\
						option - skin'>>' \n\
					  	option - skin'<<' \n\
						option - skin'random'  \n",seleccion_skis);
						ShowPlayerDialog(playerid, DIALOG_ACTORS+12, DIALOG_STYLE_LIST, "{FF6800}Editing system actors:", data, "select", "finish");

						GetActorPos(InfoActorEdicion[id_seleccionado][c_actor], pos[0],pos[1],pos[2]);
						GetActorFacingAngle(InfoActorEdicion[id_seleccionado][c_actor], pos[3]);
						DestroyActor(InfoActorEdicion[id_seleccionado][c_actor]);
						InfoActorEdicion[id_seleccionado][a_skin] = seleccion_skis;
						InfoActorEdicion[id_seleccionado][c_actor] = CreateActor(InfoActorEdicion[id_seleccionado][a_skin], pos[0],pos[1],pos[2], pos[3]);
			        }
			        default:{
						format(data,sizeof(data),"{FFFFFF}\n\t\t * displaying skin: [ %d / 311 ] \n\n\
						\t\t{FF6800}>>: select your preferred option: \n\
						option - skin'>>' \n\
					  	option - skin'<<' \n\
						option - skin'random'  \n",seleccion_skis);
						ShowPlayerDialog(playerid, DIALOG_ACTORS+12, DIALOG_STYLE_LIST, "{FF6800}Editing system actors:", data, "select", "finish");
			        }
			    }
	        }else{seleccionando_skins[playerid][0] = false;CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");}
	    }

        case DIALOG_ACTORS+13:{
	        if(response){
			    switch(listitem){
			        case 3:{
				        if(!seleccionando_skins[playerid][1]){
							CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
							return SendClientMessage(playerid,-1,"{919BA4}INFO: you have not selected any id for editing!."); }

						if(seleccion_skis>=311) seleccion_skis=311;
				        else seleccion_skis++;
						format(data,sizeof(data),"{FFFFFF}\n\t\t * displaying skin: [ %d / 311 ] \n\n\
						\t\t{FF6800}>>: select your preferred option: \n\
						option - skin'>>' \n\
					  	option - skin'<<' \n\
						option - skin'random'  \n",seleccion_skis);
						ShowPlayerDialog(playerid, DIALOG_ACTORS+13, DIALOG_STYLE_LIST, "{FF6800}Editing system actors:", data, "select", "finish");

						for(new xx=1; xx<cantidad_actores+1; xx++){
							if(!IsValidActor(InfoActorEdicion[xx][c_actor]))
								continue;
							GetActorPos(InfoActorEdicion[xx][c_actor], pos[0],pos[1],pos[2]);
							GetActorFacingAngle(InfoActorEdicion[xx][c_actor], pos[3]);
							DestroyActor(InfoActorEdicion[xx][c_actor]);
							InfoActorEdicion[xx][a_skin] = seleccion_skis;
							InfoActorEdicion[xx][c_actor] = CreateActor(InfoActorEdicion[xx][a_skin], pos[0],pos[1],pos[2], pos[3]);
						}
			        }
			        case 4:{
				        if(!seleccionando_skins[playerid][1]){
							CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
							return SendClientMessage(playerid,-1,"{919BA4}INFO: you have not selected any id for editing!."); }

						if(seleccion_skis<=0) seleccion_skis=0;
				        else seleccion_skis--;
						format(data,sizeof(data),"{FFFFFF}\n\t\t * displaying skin: [ %d / 311 ] \n\n\
						\t\t{FF6800}>>: select your preferred option: \n\
						option - skin'>>' \n\
					  	option - skin'<<' \n\
						option - skin'random'  \n",seleccion_skis);
						ShowPlayerDialog(playerid, DIALOG_ACTORS+13, DIALOG_STYLE_LIST, "{FF6800}Editing system actors:", data, "select", "finish");

						for(new xx=1; xx<cantidad_actores+1; xx++){
							if(!IsValidActor(InfoActorEdicion[xx][c_actor]))
								continue;
							GetActorPos(InfoActorEdicion[xx][c_actor], pos[0],pos[1],pos[2]);
							GetActorFacingAngle(InfoActorEdicion[xx][c_actor], pos[3]);
							DestroyActor(InfoActorEdicion[xx][c_actor]);
							InfoActorEdicion[xx][a_skin] = seleccion_skis;
							InfoActorEdicion[xx][c_actor] = CreateActor(InfoActorEdicion[xx][a_skin], pos[0],pos[1],pos[2], pos[3]);
						}
			        }
			        case 5:{
				        if(!seleccionando_skins[playerid][1]){
							CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
							return SendClientMessage(playerid,-1,"{919BA4}INFO: you have not selected any id for editing!."); }

				        seleccion_skis=random(311);
						format(data,sizeof(data),"{FFFFFF}\n\t\t * displaying skin: [ %d / 311 ] \n\n\
						\t\t{FF6800}>>: select your preferred option: \n\
						option - skin'>>' \n\
					  	option - skin'<<' \n\
						option - skin'random'  \n",seleccion_skis);
						ShowPlayerDialog(playerid, DIALOG_ACTORS+13, DIALOG_STYLE_LIST, "{FF6800}Editing system actors:", data, "select", "finish");

						for(new xx=1; xx<cantidad_actores+1; xx++){
							if(!IsValidActor(InfoActorEdicion[xx][c_actor]))
								continue;
							GetActorPos(InfoActorEdicion[xx][c_actor], pos[0],pos[1],pos[2]);
							GetActorFacingAngle(InfoActorEdicion[xx][c_actor], pos[3]);
							DestroyActor(InfoActorEdicion[xx][c_actor]);
							InfoActorEdicion[xx][a_skin] = seleccion_skis;
							InfoActorEdicion[xx][c_actor] = CreateActor(InfoActorEdicion[xx][a_skin], pos[0],pos[1],pos[2], pos[3]);
						}
			        }
			        default:{
						format(data,sizeof(data),"{FFFFFF}\n\t\t * displaying skin: [ %d / 311 ] \n\n\
						\t\t{FF6800}>>: select your preferred option: \n\
						option - skin'>>' \n\
					  	option - skin'<<' \n\
						option - skin'random'  \n",seleccion_skis);
						ShowPlayerDialog(playerid, DIALOG_ACTORS+13, DIALOG_STYLE_LIST, "{FF6800}Editing system actors:", data, "select", "finish");
			        }
			    }
	        }else{seleccionando_skins[playerid][1] = false;CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");}
	    }

        case DIALOG_ACTORS+14:{
	        if(response){
		        if(strlen(inputtext)==10){
			        if(inputtext[0]=='0' && inputtext[1]=='x'){
			        	InfoActorEdicion[id_seleccionado][color_actor] = HexToInt(inputtext);
			        	format(data,sizeof(data),"%s:(id:%d)",InfoActorEdicion[id_seleccionado][a_name],id_seleccionado);
			        	Update3DTextLabelText(InfoActorEdicion[id_seleccionado][label],InfoActorEdicion[id_seleccionado][color_actor],data);

			        	format(data,sizeof(data),"{FFFFFF}INFO: do you changed the color of the name of the actor id:%d, correctamente!.", id_seleccionado);
						SendClientMessage(playerid,-1,data);
						format(data,sizeof(data),"{A50000}INFO: color is changed:: {%06x} 0x%08x", HexToInt(InfoActorEdicion[id_seleccionado][color_actor])>>>8, InfoActorEdicion[id_seleccionado][color_actor]);
						SendClientMessage(playerid,-1,data);
			        	CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
			        }else{
						ShowPlayerDialog(playerid, DIALOG_ACTORS+14, DIALOG_STYLE_INPUT, "{FF6800}Editing system actors:", "\
						{FFFFFF}put the color you want to place the name of the actor: \n\
						{A50000}(NOTE: The color format must be in 'hex' example: 0xFFFFFFFF \n\
						", "accept", "cancel");
			        }
		        }else{
					ShowPlayerDialog(playerid, DIALOG_ACTORS+14, DIALOG_STYLE_INPUT, "{FF6800}Editing system actors:", "\
					{FFFFFF}put the color you want to place the name of the actor: \n\
					{A50000}(NOTE: The color format must be in 'hex' example: 0xFFFFFFFF \n\
					", "accept", "cancel");
		        }
	        }else CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
	    }

        case DIALOG_ACTORS+15:{
	        if(response){
		        if(strlen(inputtext)==10){
			        if(inputtext[0]=='0' && inputtext[1]=='x'){
						for(new xx=1; xx<cantidad_actores+1; xx++){
							if(!IsValidActor(InfoActorEdicion[xx][c_actor]))
								continue;
							InfoActorEdicion[xx][color_actor] = HexToInt(inputtext);
				        	format(data,sizeof(data),"%s:(id:%d)",InfoActorEdicion[xx][a_name],xx);
				        	Update3DTextLabelText(InfoActorEdicion[xx][label],InfoActorEdicion[xx][color_actor],data);
						}
						SendClientMessage(playerid,-1,"{FFFFFF}INFO: do you name changed color all actors created correctly!.");
						format(data,sizeof(data),"{A50000}INFO: color is changed: {%06x} 0x%08x", HexToInt(inputtext)>>>8, HexToInt(inputtext));
						SendClientMessage(playerid,-1,data);
			        	CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
			        }else{
						ShowPlayerDialog(playerid, DIALOG_ACTORS+15, DIALOG_STYLE_INPUT, "{FF6800}Editing system actors:", "\
						{FFFFFF}put the color you want to place the name of all players: \n\
						{A50000}(NOTE: The color format must be in 'hex' example: 0xFFFFFFFF \n\
						", "accept", "cancel");
			        }
		        }else{
					ShowPlayerDialog(playerid, DIALOG_ACTORS+15, DIALOG_STYLE_INPUT, "{FF6800}Editing system actors:", "\
					{FFFFFF}put the color you want to place the name of all players: \n\
					{A50000}(NOTE: The color format must be in 'hex' example: 0xFFFFFFFF \n\
					", "accept", "cancel");
		        }
	        }else CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
	    }

        case DIALOG_ACTORS+16:{
	        if(response){
	        	tipo_archivo_a[playerid] = true;
				ShowPlayerDialog(playerid, DIALOG_ACTORS+4, DIALOG_STYLE_INPUT, "{FF6800}Editing system actors:", "\
				{FFFFFF}type an name for the file you saved actors created.\n\
				{A50000}NOTE: You can use the 'default' to be applied\n\
				the name {FFFFFF}'actors.0001' {A50000}(by counting the number will file created). ", "accept", "by default");
	        }else{
	        	tipo_archivo_a[playerid] = false;
				ShowPlayerDialog(playerid, DIALOG_ACTORS+4, DIALOG_STYLE_INPUT, "{FF6800}Editing system actors:", "\
				{FFFFFF}type an name for the file you saved actors created.\n\
				{A50000}NOTE: You can use the 'default' to be applied\n\
				the name {FFFFFF}'actors.0001' {A50000}(by counting the number will file created). ", "accept", "by default");
	        }
	    }

    }
	return false;
}

public OnPlayerSelectObject(playerid, type, objectid, modelid, Float:fX, Float:fY, Float:fZ){
	new data[100];
    if(type == SELECT_OBJECT_GLOBAL_OBJECT){
    	if(seleccioando_actor[playerid][0]){
			id_seleccionado = objectid;
			format(data,sizeof(data),"{FFFFFF}INFO: the actor id is established: id:%d", id_seleccionado);
			SendClientMessage(playerid,-1,data);
			CancelEdit(playerid);
			seleccioando_actor[playerid][0]=false;
			CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
    	}
    	else if(seleccioando_actor[playerid][1]){
    		id_seleccionado = objectid;
			format(data,sizeof(data),"{FFFFFF}INFO: the id of the selected actor is the: id:%d", id_seleccionado);
			SendClientMessage(playerid,-1,data);
    		EditObject(playerid, InfoActorEdicion[id_seleccionado][objeto_select]);
    		SendClientMessage(playerid,-1,"{EEE019}INFO: now moves to position the actor editing mode!.");
    		SendClientMessage(playerid,-1,"{FFFFFF}INFO: to change the camera when you're in edit mode,");
    		SendClientMessage(playerid,-1,"{FFFFFF}Keep the 'TAB' key and moving the 'mouse' to change!.");
			virtualword_actors = GetActorVirtualWorld(InfoActorEdicion[objectid][c_actor]);
			GetActorPos(InfoActorEdicion[objectid][c_actor], old_actors[0], old_actors[1], old_actors[2]);
			GetActorFacingAngle(InfoActorEdicion[objectid][c_actor], old_actors[3]);
    	}
    }
    return true;
}

public OnPlayerEditObject(playerid, playerobject, objectid, response, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ){
	new data[50];
	if(seleccioando_actor[playerid][1]){
	    switch(response){
	    	// player moved the object (edition did not stop at all)
	        case EDIT_RESPONSE_UPDATE:{
		        if(!playerobject){
					SetObjectPos(InfoActorEdicion[objectid][objeto_select], fX, fY, fZ);
					SetObjectRot(InfoActorEdicion[objectid][objeto_select], 0, 0, fRotZ);
					DestroyActor(InfoActorEdicion[objectid][c_actor]);
					InfoActorEdicion[objectid][c_actor] = CreateActor(InfoActorEdicion[objectid][a_skin], fX, fY, fZ, fRotZ);
					Delete3DTextLabel(InfoActorEdicion[objectid][label]);
					InfoActorEdicion[objectid][label] = Create3DTextLabel("_",-1,fX, fY, fZ+1,10,virtualword_actors,0);
					format(data,sizeof(data),"%s:(id:%d)",InfoActorEdicion[objectid][a_name],objectid);
					Update3DTextLabelText(InfoActorEdicion[objectid][label],InfoActorEdicion[objectid][color_actor],data);
		        }
			}
			// player clicked on save
	        case EDIT_RESPONSE_FINAL:{
	        	seleccioando_actor[playerid][1]=false;
	        	SetObjectPos(InfoActorEdicion[objectid][objeto_select], fX, fY, fZ);
	        	SetObjectRot(InfoActorEdicion[objectid][objeto_select], 0, 0, fRotZ);
				DestroyActor(InfoActorEdicion[objectid][c_actor]);
				InfoActorEdicion[objectid][c_actor] = CreateActor(InfoActorEdicion[objectid][a_skin], fX, fY, fZ, fRotZ);
				Delete3DTextLabel(InfoActorEdicion[objectid][label]);
				InfoActorEdicion[objectid][label] = Create3DTextLabel("_",-1,fX, fY, fZ+1,10,virtualword_actors,0);
				format(data,sizeof(data),"%s:(id:%d)",InfoActorEdicion[objectid][a_name],objectid);
				Update3DTextLabelText(InfoActorEdicion[objectid][label],InfoActorEdicion[objectid][color_actor],data);

	        	SendClientMessage(playerid,-1,"{EEE019}INFO:beam finished editing the actor,");
	        	SendClientMessage(playerid,-1,"{EEE019}it has established the new position actor!.");
	        	CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
			}
			// player cancelled (ESC)
	        case EDIT_RESPONSE_CANCEL:{
		        if(!playerobject){
		        	seleccioando_actor[playerid][1]=false;
					SetObjectPos(InfoActorEdicion[objectid][objeto_select], old_actors[0], old_actors[1], old_actors[2]);
					SetObjectRot(InfoActorEdicion[objectid][objeto_select], 0, 0, old_actors[3]);
					DestroyActor(InfoActorEdicion[objectid][c_actor]);
					InfoActorEdicion[objectid][c_actor] = CreateActor(InfoActorEdicion[objectid][a_skin], old_actors[0], old_actors[1], old_actors[2], old_actors[3]);
					Delete3DTextLabel(InfoActorEdicion[objectid][label]);
					InfoActorEdicion[objectid][label] = Create3DTextLabel("_",-1,old_actors[0], old_actors[1], old_actors[2]+1,10,virtualword_actors,0);
					format(data,sizeof(data),"%s:(id:%d)",InfoActorEdicion[objectid][a_name],objectid);
					Update3DTextLabelText(InfoActorEdicion[objectid][label],InfoActorEdicion[objectid][color_actor],data);

		        	SendClientMessage(playerid,-1,"{EEE019}INFO: You've canceled editing Actor,");
		        	SendClientMessage(playerid,-1,"{EEE019}It has established her former position of the actor!.");
		        	CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorfunction");
		        }
			}
		}
	}
}

COMMAND:actorhelp(playerid, params[]){
	new
		data[2024];
	strcat(data,"{FFFFFF}INFO: use the following keys for editing actors: \n\n");
	strcat(data,"{FF6800}>>: key 'Y' to create an player in your position. \n");
	strcat(data,"{FF6800}>>: key 'N' to remove the actor created earlier. \n");
	strcat(data,"{FF6800}>>: key 'C' y 'ENTER' (both) to remove all creative players so far. \n");
	strcat(data,"{FF6800}>>: key 'C' y 'BAR' (both) to save all creative players so far. \n");
	strcat(data,"{FF6800}>>: key 'C' y 'H' (both) to start the dialog help. \n\n");
	strcat(data,"{FFFFFF}INFO: use the following commands for editing actors: \n\n");
	strcat(data,"{FF6800}>>: use the command '/actorfunction' to use the functions available \n");
	strcat(data,"{FF6800}>>: use the command '/actor' to turn on / off Editing system actors. \n");
	ShowPlayerDialog(playerid, DIALOG_ACTORS+0, DIALOG_STYLE_MSGBOX, "{FF6800}Editing system actors:", data, "close", "more...");
	return true;
}

COMMAND:actorfunction(playerid, params[]){
	if(IsPlayerInAnyVehicle(playerid))
		return SendClientMessage(playerid,-1,"{919BA4}INFO: You can not use the editor of actors from a vehicle!.");

	new
		data[2024];
	strcat(data,"OPTION \t comment \n");
	// NOTE: change the comment to your preference.
	strcat(data,"{FF6800}>>: {FFFFFF}establish an specific id.. \t{2C2E2E} created by OTACON.\n");
	strcat(data,"{FF6800}>>: {FFFFFF}animation to establish an specific id. \t{2C2E2E} created by OTACON.\n");
	strcat(data,"{FF6800}>>: {FFFFFF}establish an animation all actors. \t{2C2E2E} created by OTACON.\n");
	strcat(data,"{FF6800}>>: {FFFFFF}change the name to an specific actor. \t{2C2E2E} created by OTACON.\n");
	strcat(data,"{FF6800}>>: {FFFFFF}change the name to all actors. \t{2C2E2E} created by OTACON.\n");
	strcat(data,"{FF6800}>>: {FFFFFF}coach skins for the specific id. \t{2C2E2E} created by OTACON.\n");
	strcat(data,"{FF6800}>>: {FFFFFF}coach skins for all actors. \t{2C2E2E} created by OTACON.\n");
	strcat(data,"{FF6800}>>: {FFFFFF}change the color of the name for the specified id. \t{2C2E2E} created by OTACON.\n");
	strcat(data,"{FF6800}>>: {FFFFFF}change the color of the name for all actors. \t{2C2E2E} created by OTACON.\n");
	strcat(data,"{FF6800}>>: {FFFFFF}select an specific id. \t{2C2E2E} created by OTACON.\n");
	strcat(data,"{FF6800}>>: {FFFFFF}move to position an actor, selecting it. \t{2C2E2E} created by OTACON.\n");
	ShowPlayerDialog(playerid, DIALOG_ACTORS+11, DIALOG_STYLE_TABLIST_HEADERS,\
	 "{FF6800}Editing system actors:", data, "select", "cancel");
	return true;
}

COMMAND:actor(playerid, params[]){
	if(IsPlayerInAnyVehicle(playerid))
		return SendClientMessage(playerid,-1,"{919BA4}INFO: You can not use the editor of actors from a vehicle!.");

	if(!creando_actors[playerid]){
		creando_actors[playerid]=true;
		SendClientMessage(playerid,-1,"{447900}INFO: actors creation system, on.");
		CallLocalFunction("OnPlayerCommandText", "is", playerid, "/actorhelp");
	}else{
		creando_actors[playerid]=false;
		SendClientMessage(playerid,-1,"{A50000}INFO: actors creation system, off.");
	}
	return true;
}

public OnFilterScriptInit(){
	AddPlayerClass(random(311),2074.5679,1208.1819,10.6719,2.4021,37,999999,38,999999,35,999999); //
	CreateVehicle(535, 2074.5679,1208.1819,10.6719,2.4021, random(200),random(200), 9999);
	return true;
}

stock HexToInt(string[]){
  if (string[0]==0) return 0;
  new i;
  new cur=1;
  new res=0;
  for (i=strlen(string);i>0;i--) {
    if (string[i-1]<58) res=res+cur*(string[i-1]-48); else res=res+cur*(string[i-1]-65+10);
    cur=cur*16;
  }return res;
}
