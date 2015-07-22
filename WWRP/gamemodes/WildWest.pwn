//--------------------------------------------------------//
//							Wild West Roleplay                       //
//							Coded by Radma            							//
//							http://www.github.com/Radmanovic 	     //
//----------------------------------------------------//

//-----------//
// INCLUDES //
//---------//
#include <a_samp>
#include <YSI\y_ini>
#include <sscanf2>
#include <YSI\y_commands>



//-----------//
// DEFINES  //
//---------//
#define DIALOG_REGISTER 1
#define DIALOG_LOGIN 2
#define DIALOG_SUCCESS_1 3
#define DIALOG_SUCCESS_2 4
#define SCM SendClientMessage
#define SCMA SendClientMessageToAll
//-----------//
// PATHS    //
//---------//
#define PATH "/Korisnici/%s.ini"


//-----------//
// BOJE     //
//---------//
#define COL_BELA "{FFFFFF}"
#define COL_CRVENA "{F81414}"
#define COL_ZELENA "{00FF22}"
#define COL_SVPLAVA "{00CED1}"
#define COLOR_GRAD6 0xF0F0F0FF
#define COLOR_BROWN 0x993300AA
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_WHITE 0xFFFFFFFF
#define COL_WHITE 		"{FFFFFF}"
#define COL_RED 		"{B33C3C}"
#define COL_LIGHTRED    "{F041F0}"
#define COL_GREEN 		"{165316}"
#define COL_LIGHTBLUE 	"{00CED1}"
#define COLORYELLOW 	"{9DBD1E}"
#define COLORORANGE 	"{E68C0E}"
#define COLORBLUE   	"{39AACC}"
#define COLORGREEN 		"{6FA828}"
#define COLORWHITE  	"{FFFFFF}"
#define COLORRED    	"{FF0000}"
#define COLORGREY   	"{7D8584}"
#define COL_BROWN       "{6B3F34}"
#define COL_PROPERTIES  "{4364FF}"
#define COL_HOUSES      "{6200FF}"
#define COL_SILVER      "{C0C0C0}"
#define COL_BRONZE      "{CD7F32}"
#define COL_GOLD        "{D4A017}"
#define COL_ADMIN       "{027807}"
#define COLOR_FACTIONCHAT 0x01FCFFC8
#define COLOR_GROVE 0x51A505FF
#define COLOR_SEVILLE 0xBCFB84FF
#define COLOR_AZTECAS 0x00BBBBFF
#define COLOR_VAGOS 0xFFFF24FF
#define COLOR_BALLAS 0xB000B0FF
#define COLOR_SJPD 0x5846FFFF
#define COLOR_ADMIN 0xFD7E00FF
#define COLOR_DARKRED 0xCD000000
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_LIGHTGREEN 0x9ACD32AA
#define COLOR_LIGHTRED 0xFF6347AA
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_LIGHTBLUE2 0x0080FFAA
#define COLOR_LIGHTGREEN 0x9ACD32AA
#define COLOR_LIGHTORANGE 0xFF8000FF
#define COLOR_DARKBROWN 0xB36C42FF
#define COLOR_MEDIUMBLUE 0x1ED5C7FF
#define COLOR_LIGHTYELLOW 0xE0E377AA
#define COLOR_LIGHTYELLOW2 0xE0EA64AA
#define COLOR_LIGHTYELLOW3 0xFF6347AA
#define COLOR_DARKPURPLE 0x5F56F8AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_YELLOW2 0xF5DEB3AA
#define COLOR_FADE1 0xE6E6E6E6
#define COLOR_FADE2 0xC8C8C8C8
#define COLOR_FADE3 0xAAAAAAAA
#define COLOR_FADE4 0x8C8C8C8C
#define COLOR_FADE5 0x6E6E6E6E
#define COLOR_PURPLE 0xC2A2DAAA
#define COLOR_OOC 0xE0FFFFAA
#define COLOR_LOCALMSG 0xEC5413AA

//-------------//
// IGRAC INFO //
//-----------//
enum iInfo
{
    iLozinka,
    iNovac,
    iAdmin,
		iVip,
    iUbistava,
    iSmrti
}


//-----------//
// Variable //
//---------//
new IgracInfo[MAX_PLAYERS][iInfo];

//--------------------//
// FORWARDS && STOCKS//
//------------------//
forward UcitajKorisnika_data(playerid,name[],value[]);
public 	UcitajKorisnika_data(playerid,name[],value[])
{
    INI_Int("Lozinka",IgracInfo[playerid][iLozinka]);
    INI_Int("Novac",IgracInfo[playerid][iNovac]);
    INI_Int("Admin",IgracInfo[playerid][iAdmin]);
    INI_Int("Vip",IgracInfo[playerid][iAdmin]);
		INI_Int("Ubistava",IgracInfo[playerid][iUbistava]);
    INI_Int("Smrti",IgracInfo[playerid][iSmrti]);
    return 1;
}

stock UserPath(playerid)
{
    new string[128],playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid,playername,sizeof(playername));
    format(string,sizeof(string),PATH,playername);
    return string;
}

/*Credits to Dracoblue*/
stock udb_hash(buf[]) {
    new length=strlen(buf);
    new s1 = 1;
    new s2 = 0;
    new n;
    for (n=0; n<length; n++)
    {
       s1 = (s1 + buf[n]) % 65521;
       s2 = (s2 + s1)     % 65521;
    }
    return (s2 << 16) + s1;
}

stock GetName(playerid)
{
	new
	    pName[MAX_PLAYER_NAME];

	GetPlayerName(playerid, pName, MAX_PLAYER_NAME);
	return pName;
}
forward APoruka(color,const string[],alevel);
public APoruka(color,const string[],alevel)
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if (IgracInfo[i][iAdmin] >= alevel)
			{
				SendClientMessage(i, color, string);
			}
		}
	}
	return 1;
}
main()
{
	print("\n----------------------------------");
	print(" 				Wild West Roleplay				 ");
	print("							By Radma							 ");
	print("							 © 2015								 ");
	print("----------------------------------\n");
}


public OnGameModeInit()
{
	SetGameModeText("WWRP v0.0.1");
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}

public OnPlayerConnect(playerid)
{
	if(fexist(UserPath(playerid)))
	{
		INI_ParseFile(UserPath(playerid), "UcitajKorisnika_%s", .bExtra = true, .extra = playerid);
  		ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_INPUT,""COL_BELA"Login",""COL_BELA"Unesite vasu lozinku da se ulogujete.","Login","Izlaz");
	}
	else
	{
 		ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT,""COL_BELA"Registrovanje...",""COL_BELA"Unesite vasu lozinku ispod da napravite novi nalog.","Register","Izlaz");
	}
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	new INI:File = INI_Open(UserPath(playerid));
	INI_SetTag(File,"data");
	INI_WriteInt(File,"Novac",GetPlayerMoney(playerid));
	INI_WriteInt(File,"Admin",IgracInfo[playerid][iAdmin]);
	INI_WriteInt(File,"Vip",IgracInfo[playerid][iVip]);
	INI_WriteInt(File,"Ubistava",IgracInfo[playerid][iUbistava]);
	INI_WriteInt(File,"Smrti",IgracInfo[playerid][iSmrti]);
	INI_Close(File);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	IgracInfo[killerid][iUbistava]++;
	IgracInfo[playerid][iSmrti]++;
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/mycommand", cmdtext, true, 10) == 0)
	{
		// Do something here
		return 1;
	}
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch( dialogid )
    {
        case DIALOG_REGISTER:
        {
            if (!response) return Kick(playerid);
            if(response)
            {
                if(!strlen(inputtext)) return ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT, ""COL_BELA"Registrovanje...",""COL_CRVENA"Uneli ste pogresnu lozinku.\n"COL_BELA"Unesite lozinku ispod da napravite novi nalog.","Register","Izlaz");
                new INI:File = INI_Open(UserPath(playerid));
                INI_SetTag(File,"data");
                INI_WriteInt(File,"Lozinka",udb_hash(inputtext));
                INI_WriteInt(File,"Novac",0);
                INI_WriteInt(File,"Admin",0);
                INI_WriteInt(File,"Vip",0);
								INI_WriteInt(File,"Ubistava",0);
								INI_WriteInt(File,"Smrti",0);
                INI_Close(File);

                SetSpawnInfo(playerid, 0, 0, 1958.33, 1343.12, 15.36, 269.15, 0, 0, 0, 0, 0, 0);
                SpawnPlayer(playerid);
                ShowPlayerDialog(playerid, DIALOG_SUCCESS_1, DIALOG_STYLE_MSGBOX,""COL_BELA"Uspesno!",""COL_ZELENA"Great! Your Y_INI system works perfectly. Relog to save your stats!","Ok","");
			}
        }

        case DIALOG_LOGIN:
        {
            if ( !response ) return Kick ( playerid );
            if( response )
            {
                if(udb_hash(inputtext) == IgracInfo[playerid][iLozinka]){
                    INI_ParseFile(UserPath(playerid), "LoadUser_%s", .bExtra = true, .extra = playerid);
                    GivePlayerMoney(playerid, IgracInfo[playerid][iNovac]);
					ShowPlayerDialog(playerid, DIALOG_SUCCESS_2, DIALOG_STYLE_MSGBOX,""COL_BELA"Uspesno!",""COL_ZELENA"Uspesno ste se ulogovali!","Ok","");
                }
                else
                {
                    ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_INPUT,""COL_BELA"Login",""COL_CRVENA"Uneli ste pogresnu lozinku.\n"COL_BELA"Unesite lozinku ispod da se ulogujete.","Login","Quit");
                }
                return 1;
            }
        }
    }
    return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
CMD:makeadmin(playerid, params[])
{
    new
	pID, value, string[124];

    if(IgracInfo[playerid][iAdmin] < 5 && !IsPlayerAdmin(playerid)) return SCM( playerid, COLOR_GREY, "Nemate dozvolu za upotrebu ove komande.");
    else if (sscanf(params, "ui", pID, value)) return SCM(playerid, COLOR_GREY, "[Koristi:] /makeadmin [playerid/DeoImena] [level 1-6].");
    else if (value < 0 || value > 6) return SCM(playerid, COLOR_LIGHTRED, "Invalid administrator level, 0-6.");
    else if(!IsPlayerConnected(pID)) return SCM(playerid, COLOR_LIGHTRED, "Taj igrac nije konektovan.");

 	format(string, sizeof(string), "WWRP: %s je postavio igracu %s administrator level %d.", GetName(playerid), GetName(pID), value);
 	SendClientMessageToAll(COLOR_LIGHTRED,string);
	IgracInfo[pID][iAdmin] = value;
    return 1;
}
CMD:makevip(playerid, params[])
{
    new
	pID, value, string[124];

    if(IgracInfo[playerid][iAdmin] < 6 && !IsPlayerAdmin(playerid)) return SCM( playerid, COLOR_GREY, "Nemate dozvolu za upotrebu ove komande.");
    else if (sscanf(params, "ui", pID, value)) return SCM(playerid, COLOR_GREY, "[Koristi:] /makevip [playerid/DeoImena] [level 1-3].");
    else if (value < 0 || value > 3) return SCM(playerid, COLOR_LIGHTRED, "Invalid vip level, 0-3.");
    else if(!IsPlayerConnected(pID)) return SCM(playerid, COLOR_LIGHTRED, "Taj igrac nije konektovan.");

 	format(string, sizeof(string), "VIP: %s je postavio %s vip level %d.", GetName(playerid), GetName(pID), value);
 	APoruka(COLOR_LIGHTRED,string);
	IgracInfo[pID][iVip] = value;
    return 1;
}
