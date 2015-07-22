//-----------------------------
//      INCLUDES
//-----------------------------

#include <a_samp>
#include <YSI\y_ini>
#include <zcmd>
#include <sscanf2>
#include <foreach>
#include <streamer>
#include <ELC_AC_CONNECTOR>

main()
{
	print(">>Wild West<<");
	print("   by ");
	print(" |Radma|");
	return 1;
}
//-----------------------------
//      DEFINES
//-----------------------------

#define DIALOG_REGISTER 1
#define DIALOG_LOGIN 2
#define DIALOG_SUCCESS_1 3
#define DIALOG_SUCCESS_2 4
#undef MAX_PLAYERS
#define MAX_PLAYERS 100
#define SCM SendClientMessage
#define SCMA SendClientMessageToAll
#undef MAX_PLAYERS
#define MAX_PLAYERS 100 // Change to you're servers max player count.

#define MAX_SLOTS 100
// Logs
#define ADM_CHAT_LOG        true
// Stats Dialog
#define STA_Dialog 20003

// PATHS
#define PATH "/Users/%s.ini"
#define banPATH "Users/Logs/BanLog.txt"

#define COL_WHITE "{FFFFFF}"
#define COL_RED "{F81414}"
#define COL_GREEN "{00FF22}"
#define COL_LIGHTBLUE "{00CED1}"
#define COL_YELLOW "{00FF22}"
#define Narandzasta "{FF6600}"
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_RED 0xAA3333AA
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_PINK 0xFF66FFAA
#define COLOR_BLUE 0x0000BBAAf
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_DARKRED 0x660000AA
#define COLOR_ORANGE 0xFF9900AA
#define COLOR_BRIGHTRED 0xFF0000AA
#define COLOR_INDIGO 0x4B00B0AA
#define COLOR_VIOLET 0x9955DEEE
#define COLOR_LIGHTRED 0xFF99AADD
#define COLOR_SEAGREEN 0x00EEADDF
#define COLOR_GRAYWHITE 0xEEEEFFC4
#define COLOR_LIGHTNEUTRALBLUE 0xabcdef66
#define COLOR_GREENISHGOLD 0xCCFFDD56
#define COLOR_LIGHTBLUEGREEN 0x0FFDD349
#define COLOR_NEUTRALBLUE 0xABCDEF01
#define COLOR_LIGHTCYAN 0xAAFFCC33
#define COLOR_LEMON 0xDDDD2357
#define COLOR_MEDIUMBLUE 0x63AFF00A
#define COLOR_NEUTRAL 0xABCDEF97
#define COLOR_BLACK 0x00000000
#define COLOR_NEUTRALGREEN 0x81CFAB00
#define COLOR_DARKGREEN 0x12900BBF
#define COLOR_LIGHTGREEN 0x24FF0AB9
#define COLOR_DARKBLUE 0x300FFAAB
#define COLOR_BLUEGREEN 0x46BBAA00
#define COLOR_PINK 0xFF66FFAA
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_DARKRED 0x660000AA
#define COLOR_ORANGE 0xFF9900AA
#define COLOR_PURPLE 0x800080AA
#define COLOR_GRAD1 0xB4B5B7FF
#define COLOR_GRAD2 0xBFC0C2FF
#define COLOR_RED1 0xFF0000AA
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_BROWN 0x993300AA
#define COLOR_CYAN 0x99FFFFAA
#define COLOR_TAN 0xFFFFCCAA
#define COLOR_PINK 0xFF66FFAA
#define COLOR_KHAKI 0x999900AA
#define COLOR_LIME 0x99FF00AA
#define COLOR_SYSTEM 0xEFEFF7AA
#define COLOR_GRAD2 0xBFC0C2FF
#define COLOR_GRAD4 0xD8D8D8FF
#define COLOR_GRAD6 0xF0F0F0FF
#define COLOR_GRAD2 0xBFC0C2FF
#define COLOR_GRAD3 0xCBCCCEFF
#define COLOR_GRAD5 0xE3E3E3FF
#define COLOR_GRAD1 0xB4B5B7FF
#pragma tabsize 0
// Yellow Color
#define COLOR_SAY 0xFFDD00AA

#define Grey 0xC0C0C0FF // Defining the color 'Grey'
//-----------------------------
//      PLAYER INFO
//-----------------------------

enum pInfo
{
    pPass,
    pCash,
    pAdmin,
    pKills,
    pDeaths,
    pMute,
    pWarns,
    pBan,
	pClan,
	pRank,
	pLider,
	pVip
}

//-----------------------------
//      VARIABLES
//-----------------------------
new PlayerInfo[MAX_PLAYERS][pInfo];
new TempStr[255];
new String[128], Float:SpecX[MAX_PLAYERS], Float:SpecY[MAX_PLAYERS], Float:SpecZ[MAX_PLAYERS], vWorld[MAX_PLAYERS], Inter[MAX_PLAYERS];
new IsSpecing[MAX_PLAYERS], Name[MAX_PLAYER_NAME], IsBeingSpeced[MAX_PLAYERS],spectatorid[MAX_PLAYERS];
new NotMoving[MAX_PLAYERS];
new WeaponID[MAX_PLAYERS];
new CheckCrouch[MAX_PLAYERS];
new Ammo[MAX_PLAYERS][MAX_SLOTS];
new AdminRank[128]; //Admin ranks
new Text:Time, Text:Date;
forward settime(playerid);
//-----------------------------
//      WEAPON NAMES
//-----------------------------

new aWeaponNames[][32] = {
        {"Fist"}, // 0
        {"Brass Knuckles"}, // 1
        {"Golf Club"}, // 2
        {"Night Stick"}, // 3
        {"Knife"}, // 4
        {"Baseball Bat"}, // 5
        {"Shovel"}, // 6
        {"Pool Cue"}, // 7
        {"Katana"}, // 8
        {"Chainsaw"}, // 9
        {"Purple Dildo"}, // 10
        {"Vibrator"}, // 11
        {"Vibrator"}, // 12
        {"Vibrator"}, // 13
        {"Flowers"}, // 14
        {"Cane"}, // 15
        {"Grenade"}, // 16
        {"Teargas"}, // 17
        {"Molotov"}, // 18
        {" "}, // 19
        {" "}, // 20
        {" "}, // 21
        {"Colt 45"}, // 22
        {"Silenced Pistol"}, // 23
        {"Deagle"}, // 24
        {"Shotgun"}, // 25
        {"Sawns"}, // 26
        {"Spas"}, // 27
        {"Uzi"}, // 28
        {"MP5"}, // 29
        {"AK47"}, // 30
        {"M4"}, // 31
        {"Tec9"}, // 32
        {"Country Rifle"}, // 33
        {"Sniper Rifle"}, // 34
        {"Rocket Launcher"}, // 35
        {"Heat-Seeking Rocket Launcher"}, // 36
        {"Flamethrower"}, // 37
        {"Minigun"}, // 38
        {"Satchel Charge"}, // 39
        {"Detonator"}, // 40
        {"Spray Can"}, // 41
        {"Fire Extinguisher"}, // 42
        {"Camera"}, // 43
        {"Night Vision Goggles"}, // 44
        {"Infrared Vision Goggles"}, // 45
        {"Parachute"}, // 46
        {"Fake Pistol"} // 47
};
public OnGameModeInit(playerid)
{
	SetTimer("Cycle1", 1000,true);//1sec
    SetWorldTime(9);

    print("\n-- Laser system ucitan --\n");
    new p = GetMaxPlayers();
    for (new i=0; i < p; i++) {
	   SetPVarInt(i, "laser", 0);
       SetPVarInt(i, "color", 18643);
    }
	{
	SetGameModeText("Wild West");
	ShowPlayerMarkers(0);
	ShowNameTags(1);
	SetNameTagDrawDistance(25.0);
	EnableStuntBonusForAll(0);
	DisableInteriorEnterExits();
	SetWeather(2);
	SetWorldTime(11);
	}
// Vozila
	AddStaticVehicle(509,-379.9825,2251.5732,41.9917,106.3848,0,0);
	AddStaticVehicle(509,-379.9639,2252.4304,41.9915,100.0553,0,0);
	/////////////////////////////////////////////////////////////////////
	AddPlayerClass(34,-375.0865,2219.8130,42.4177,100.0904,24,20,0,0,0,0);
    AddPlayerClass(33,-391.7039,2274.1560,41.0381,182.3903,24,20,0,0,0,0);
 // Sat

//----------------------//
//      TEXTDARW
//---------------------//
        SetTimer("settime",1000,true);
		Date = TextDrawCreate(547.000000,11.000000,"--");

        TextDrawFont(Date,3);
        TextDrawLetterSize(Date,0.399999,1.600000);
    TextDrawColor(Date,0xffffffff);

        Time = TextDrawCreate(547.000000,28.000000,"--");

        TextDrawFont(Time,3);
        TextDrawLetterSize(Time,0.399999,1.600000);
        TextDrawColor(Time,0xffffffff);
//--------------------//
//      MAPE         //
//------------------//
	return 1;
}

forward message();
public message()
{
    print("Promena mape...");
}
public OnGameModeExit()
{

	new p = GetMaxPlayers();
	for (new i=0; i < p; i++) {
		SetPVarInt(i, "laser", 0);
		RemovePlayerAttachedObject(i, 0);
	}
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
    SetPlayerInterior(playerid,14);
	SetPlayerPos(playerid,258.4893,-41.4008,1002.0234);
	SetPlayerFacingAngle(playerid, 270.0);
	SetPlayerCameraPos(playerid,256.0815,-43.0475,1004.0234);
	SetPlayerCameraLookAt(playerid,258.4893,-41.4008,1002.0234);
	return 1;
}

public OnPlayerConnect(playerid)
{
    if(fexist(UserPath(playerid)))
    {
        INI_ParseFile(UserPath(playerid), "LoadUser_%s", .bExtra = true, .extra = playerid);
        ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD,""COL_WHITE"Login",""COL_WHITE"Unesite vasu lozinku ispod da se ulogujete.","Login","Izlaz");
    }
    else
    {
        ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT,""COL_WHITE"Registrovanje...",""COL_WHITE"Unesite vasu lozinku ispod da kreirate novi nalog.","Register","Izlaz");
    }
    if(PlayerInfo[playerid][pBan] == 1)
	{
		SendClientMessage(playerid,COLOR_WHITE, "[WW]{FF6600}Banovani ste postavite zahtev za unban na forumu ukoliko zelite unban Adresa [uskoro.com].");
	    Kick(playerid);
	}
	if(PlayerInfo[playerid][pMute] == 1)
	{
		SendClientMessage(playerid, COLOR_WHITE, "[WW]{FF6600} Mutirani ste. Da dobijete unmute kucajte /paymute. (Cena 300000$)");
	}
	new string[64], pName[MAX_PLAYER_NAME];
    GetPlayerName(playerid,pName,MAX_PLAYER_NAME);
    format(string,sizeof string,"{#f0f0f0}%s {FF6600} se konektovao na server.",pName);
    SendClientMessageToAll(COLOR_GREY,string);
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    new INI:File = INI_Open(UserPath(playerid));
    INI_SetTag(File,"data");
    INI_WriteInt(File,"Cash",GetPlayerMoney(playerid));
    INI_WriteInt(File,"Admin",PlayerInfo[playerid][pAdmin]);
    INI_WriteInt(File,"Kills",PlayerInfo[playerid][pKills]);
    INI_WriteInt(File,"Deaths",PlayerInfo[playerid][pDeaths]);
    INI_WriteInt(File,"Mute",PlayerInfo[playerid][pMute]);
    INI_WriteInt(File,"Warns",PlayerInfo[playerid][pWarns]);
    INI_WriteInt(File,"Ban",PlayerInfo[playerid][pBan]);
    INI_WriteInt(File,"Clan",PlayerInfo[playerid][pClan]);
    INI_WriteInt(File,"Rank",PlayerInfo[playerid][pRank]);
    INI_WriteInt(File,"Lider",PlayerInfo[playerid][pLider]);
    INI_WriteInt(File,"Vip",PlayerInfo[playerid][pVip]);
	INI_Close(File);

    if(IsBeingSpeced[playerid] == 1)//If the player being spectated, disconnects, then turn off the spec mode for the spectator.
    {
        foreach(Player,i)
        {
            if(spectatorid[i] == playerid)
            {
                TogglePlayerSpectating(i,false);// This justifies what's above, if it's not off then you'll be either spectating your connect screen, or somewhere in blueberry (I don't know why)
            }
        }
    }

   	new pName[24];
    new str[128];
    GetPlayerName(playerid, pName, 24);

    switch(reason)
    {
	    case 0: format(str, 128, "{0xFFFFFFAA} %s {FF6600} je napustio server. {0xFFFFFFAA} (Timeout)", pName);
	    case 1: format(str, 128, "{0xFFFFFFAA} %s {FF6600} je napustio server. {0xFFFFFFAA} (Leaving)", pName);
	    case 2: format(str, 128, "{0xFFFFFFAA} %s {FF6600} je napustio server. {0xFFFFFFAA} (Kicked)", pName);
    }

    SetPVarInt(playerid, "laser", 0);
    RemovePlayerAttachedObject(playerid, 0);
	// Sat
	TextDrawHideForPlayer(playerid, Time), TextDrawHideForPlayer(playerid, Date);
	return 1;
}

public OnPlayerSpawn(playerid)
{
    SetPlayerInterior(playerid,0);
    TextDrawShowForPlayer(playerid, Time), TextDrawShowForPlayer(playerid, Date);
	return 1;
}

forward PlayerUnfrozen(playerid);
public PlayerUnfrozen(playerid)
{
	TogglePlayerControllable(playerid, 1);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    PlayerInfo[killerid][pKills]++;
     if(killerid != INVALID_PLAYER_ID)
    {
        GivePlayerMoney(killerid, 1000);
        SetPlayerScore(playerid,GetPlayerScore(playerid)+1);
    }
	PlayerInfo[playerid][pDeaths]++;
    if(IsBeingSpeced[playerid] == 1)//If the player being spectated, dies, then turn off the spec mode for the spectator.
    {
        foreach(Player,i)
        {
            if(spectatorid[i] == playerid)
            {
                TogglePlayerSpectating(i,false);// This justifies what's above, if it's not off then you'll be either spectating your connect screen, or somewhere in blueberry (I don't know why)
            }
        }
    }

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
    if(PlayerInfo[playerid][pMute] == 1)
 	{
		SendClientMessage(playerid, COLOR_WHITE, "[WW] {FF6600}Mutirani ste. /paymute da dobijete unmute. {0xFFFFFFAA} (Cena 300000$)");
		return 0;
 	}
	return 1;
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
    if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)// If the player's state changes to a vehicle state we'll have to spec the vehicle.
    {
        if(IsBeingSpeced[playerid] == 1)//If the player being spectated, enters a vehicle, then let the spectator spectate the vehicle.
        {
            foreach(Player,i)
            {
                if(spectatorid[i] == playerid)
                {
                    PlayerSpectateVehicle(i, GetPlayerVehicleID(playerid));// Letting the spectator, spectate the vehicle of the player being spectated (I hope you understand this xD)
                }
            }
        }
    }
    if(newstate == PLAYER_STATE_ONFOOT)
    {
        if(IsBeingSpeced[playerid] == 1)//If the player being spectated, exists a vehicle, then let the spectator spectate the player.
        {
            foreach(Player,i)
            {
                if(spectatorid[i] == playerid)
                {
                    PlayerSpectatePlayer(i, playerid);// Letting the spectator, spectate the player who exited the vehicle.
                }
            }
        }
    }
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

public OnPlayerTakeDamage(playerid, issuerid, Float: amount)
{
    if(issuerid != INVALID_PLAYER_ID )
    {
        // Jednim metkom bilo kojim oruzijem stavlja helte na 0
        SetPlayerHealth(playerid, 0.0);
        GameTextForPlayer(playerid, "~r~UBIJENI STE", 3000, 5);
	}
    return 1;
}
public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)//This is called when a player's interior is changed.
{
    if(IsBeingSpeced[playerid] == 1)//If the player being spectated, changes an interior, then update the interior and virtualword for the spectator.
    {
        foreach(Player,i)
        {
            if(spectatorid[i] == playerid)
            {
                SetPlayerInterior(i,GetPlayerInterior(playerid));
                SetPlayerVirtualWorld(i,GetPlayerVirtualWorld(playerid));
            }
        }
    }
    return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if((newkeys & KEY_FIRE) && (oldkeys & KEY_CROUCH) && !((oldkeys & KEY_FIRE) || (newkeys & KEY_HANDBRAKE)) || (oldkeys & KEY_FIRE) && (newkeys & KEY_CROUCH) && !((newkeys & KEY_FIRE) || (newkeys & KEY_HANDBRAKE)) ) {
        switch(GetPlayerWeapon(playerid)) {
		    case 23..25, 27, 29..34, 41: {
		        if(Ammo[playerid][GetPlayerWeapon(playerid)] > GetPlayerAmmo(playerid)) {
					OnPlayerCBug(playerid);
				}
				return 1;
			}
		}
	}

	if(CheckCrouch[playerid] == 1) {
		switch(WeaponID[playerid]) {
		    case 23..25, 27, 29..34, 41: {
		    	if((newkeys & KEY_CROUCH) && !((newkeys & KEY_FIRE) || (newkeys & KEY_HANDBRAKE)) && GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK ) {
		    		if(Ammo[playerid][GetPlayerWeapon(playerid)] > GetPlayerAmmo(playerid)) {
						OnPlayerCBug(playerid);
					}
		    	}
		    }
		}
	}

	//if(newkeys & KEY_CROUCH || (oldkeys & KEY_CROUCH)) return 1;

	else if(((newkeys & KEY_FIRE) && (newkeys & KEY_HANDBRAKE) && !((newkeys & KEY_SPRINT) || (newkeys & KEY_JUMP))) ||
	(newkeys & KEY_FIRE) && !((newkeys & KEY_SPRINT) || (newkeys & KEY_JUMP)) ||
	(NotMoving[playerid] && (newkeys & KEY_FIRE) && (newkeys & KEY_HANDBRAKE)) ||
	(NotMoving[playerid] && (newkeys & KEY_FIRE)) ||
	(newkeys & KEY_FIRE) && (oldkeys & KEY_CROUCH) && !((oldkeys & KEY_FIRE) || (newkeys & KEY_HANDBRAKE)) ||
	(oldkeys & KEY_FIRE) && (newkeys & KEY_CROUCH) && !((newkeys & KEY_FIRE) || (newkeys & KEY_HANDBRAKE)) ) {
		SetTimerEx("CrouchCheck", 3000, 0, "d", playerid);
		CheckCrouch[playerid] = 1;
		WeaponID[playerid] = GetPlayerWeapon(playerid);
		Ammo[playerid][GetPlayerWeapon(playerid)] = GetPlayerAmmo(playerid);
		return 1;
	}
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{

		if (GetPVarInt(playerid, "laser")) {
                RemovePlayerAttachedObject(playerid, 0);
                if ((IsPlayerInAnyVehicle(playerid)) || (IsPlayerInWater(playerid))) return 1;
                switch (GetPlayerWeapon(playerid)) {
                        case 23: {
                                if (IsPlayerAiming(playerid)) {
                                        if (GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK) {
                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // SP standing aiming
                                                0.108249, 0.030232, 0.118051, 1.468254, 350.512573, 364.284240);
                                        } else {
                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // SP crouched aiming
                                                0.108249, 0.030232, 0.118051, 1.468254, 349.862579, 364.784240);
                                        }
                                } else {
                                        if (GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK) {
                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // SP standing not aiming
                                                0.078248, 0.027239, 0.113051, -11.131746, 350.602722, 362.384216);
                                        } else {
                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // SP crouched not aiming
                                                0.078248, 0.027239, 0.113051, -11.131746, 350.602722, 362.384216);
                        }       }       }
                        case 27: {
                                if (IsPlayerAiming(playerid)) {
                                        if (GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK) {
                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // SPAS standing aiming
                                                0.588246, -0.022766, 0.138052, -11.531745, 347.712585, 352.784271);
                                        } else {
                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // SPAS crouched aiming
                                                0.588246, -0.022766, 0.138052, 1.468254, 350.712585, 352.784271);
                                        }
                                } else {
                                        if (GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK) {
                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // SPAS standing not aiming
                                                0.563249, -0.01976, 0.134051, -11.131746, 351.602722, 351.384216);
                                        } else {
                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // SPAS crouched not aiming
                                                0.563249, -0.01976, 0.134051, -11.131746, 351.602722, 351.384216);
                        }       }       }
                        case 30: {
                                if (IsPlayerAiming(playerid)) {
                                        if (GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK) {
                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // AK standing aiming
                                                0.628249, -0.027766, 0.078052, -6.621746, 352.552642, 355.084289);
                                        } else {
                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // AK crouched aiming
                                                0.628249, -0.027766, 0.078052, -1.621746, 356.202667, 355.084289);
                                        }
                                } else {
                                        if (GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK) {
                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // AK standing not aiming
                                                0.663249, -0.02976, 0.080051, -11.131746, 358.302734, 353.384216);
                                        } else {
                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // AK crouched not aiming
                                                0.663249, -0.02976, 0.080051, -11.131746, 358.302734, 353.384216);
                        }       }       }
                        case 31: {
                                if (IsPlayerAiming(playerid)) {
                                        if (GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK) {
                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // M4 standing aiming
                                                0.528249, -0.020266, 0.068052, -6.621746, 352.552642, 355.084289);
                                        } else {
                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // M4 crouched aiming
                                                0.528249, -0.020266, 0.068052, -1.621746, 356.202667, 355.084289);
                                        }
                                } else {
                                        if (GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK) {
                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // M4 standing not aiming
                                                0.503249, -0.02376, 0.065051, -11.131746, 357.302734, 354.484222);
                                        } else {
                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // M4 crouched not aiming
                                                0.503249, -0.02376, 0.065051, -11.131746, 357.302734, 354.484222);
                        }       }       }
			case 34: {
				if (IsPlayerAiming(playerid)) {
					/*if (GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK) {
						SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // Sniper standing aiming
						0.528249, -0.020266, 0.068052, -6.621746, 352.552642, 355.084289);
					} else {
						SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // Sniper crouched aiming
						0.528249, -0.020266, 0.068052, -1.621746, 356.202667, 355.084289);
					}*/
					return 1;
				} else {
					if (GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK) {
						SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // Sniper standing not aiming
						0.658248, -0.03276, 0.133051, -11.631746, 355.302673, 353.584259);
					} else {
						SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // Sniper crouched not aiming
						0.658248, -0.03276, 0.133051, -11.631746, 355.302673, 353.584259);
			}	}	}
                        case 29: {
                                if (IsPlayerAiming(playerid)) {
                                        if (GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK) {
                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // MP5 standing aiming
                                                0.298249, -0.02776, 0.158052, -11.631746, 359.302673, 357.584259);
                                        } else {
                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // MP5 crouched aiming
                                                0.298249, -0.02776, 0.158052, 8.368253, 358.302673, 352.584259);
                                        }
                                } else {
                                        if (GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK) {
                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // MP5 standing not aiming
                                                0.293249, -0.027759, 0.195051, -12.131746, 354.302734, 352.484222);
                                        } else {
                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // MP5 crouched not aiming
                                                0.293249, -0.027759, 0.195051, -12.131746, 354.302734, 352.484222);
        }       }       }       }       }


	    new Keys, ud, lr;
		GetPlayerKeys(playerid, Keys, ud, lr);
		if(CheckCrouch[playerid] == 1) {
			switch(WeaponID[playerid]) {
			    case 23..25, 27, 29..34, 41: {
			    	if((Keys & KEY_CROUCH) && !((Keys & KEY_FIRE) || (Keys & KEY_HANDBRAKE)) && GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK ) {
			    		if(Ammo[playerid][GetPlayerWeapon(playerid)] > GetPlayerAmmo(playerid)) {
							OnPlayerCBug(playerid);
						}
			    	}
			    	//else SendClientMessage(playerid, COLOR_RED, "Failed in onplayer update");
			    }
			}
		}

		if(!ud && !lr) { NotMoving[playerid] = 1; /*OnPlayerKeyStateChange(playerid, Keys, 0);*/ }
		else { NotMoving[playerid] = 0; /*OnPlayerKeyStateChange(playerid, Keys, 0);*/ }
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

public OnPlayerGiveDamage(playerid, damagedid, Float: amount, weaponid)
{
    PlayerPlaySound(playerid, 6401, 0.0, 0.0, 10.0);
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
                if(!strlen(inputtext)) return ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, ""COL_WHITE"Registracija...",""COL_RED"Uneli ste pogresnu lozinku.\n"COL_WHITE"Unesite vasu zeljenu lozinku.","Register","Quit");
                new INI:File = INI_Open(UserPath(playerid));
                INI_SetTag(File,"data");
                INI_WriteInt(File,"Password",udb_hash(inputtext));
                INI_WriteInt(File,"Cash",0);
                INI_WriteInt(File,"Admin",0);
                INI_WriteInt(File,"Kills",0);
                INI_WriteInt(File,"Deaths",0);
                INI_WriteInt(File,"Mute",0);
                INI_WriteInt(File,"Warns",0);
                INI_WriteInt(File,"Ban",0);
                INI_WriteInt(File,"Clan",0);
                INI_WriteInt(File,"Rank",0);
                INI_WriteInt(File,"Lider",0);
                INI_WriteInt(File,"Vip",0);
				INI_Close(File);

                SetSpawnInfo(playerid, 0, 0, 1958.33, 1343.12, 15.36, 269.15, 0, 0, 0, 0, 0, 0);
                ShowPlayerDialog(playerid, DIALOG_SUCCESS_1, DIALOG_STYLE_MSGBOX,""COL_WHITE"Success!",""COL_GREEN"Dobro dosli na Wild West","Ok","");
            }
        }

        case DIALOG_LOGIN:
        {
            if ( !response ) return Kick ( playerid );
            if( response )
            {
                if(udb_hash(inputtext) == PlayerInfo[playerid][pPass])
                {
                    INI_ParseFile(UserPath(playerid), "LoadUser_%s", .bExtra = true, .extra = playerid);
                    GivePlayerMoney(playerid, PlayerInfo[playerid][pCash]);
                    ShowPlayerDialog(playerid, DIALOG_SUCCESS_2, DIALOG_STYLE_MSGBOX,""COL_WHITE"Success!",""COL_GREEN"Uspesno ste se ulogovali!","Ok","");
                }
                else
                {
                    ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_INPUT,""COL_WHITE"Login",""COL_RED"Uneli ste pogresnu lozinku.\n"COL_WHITE"Napisite lozinku ispod da se ulogujete.","Login","Izlaz");
                }
                return 1;
            }
        }

	}

	{
	if(dialogid == 5)
	{
	if(!response)
	return 1;
	switch(listitem)
	{
    case 0:
    {
    if(GetPlayerMoney(playerid) < 1000)
    return SendClientMessage(playerid, 0x0000FFAA, "Prodavac: Nemas dovoljno novca.");
    GivePlayerMoney(playerid, -1000);
    GivePlayerWeapon(playerid, 24, 20);
    SendClientMessage(playerid, 0xFFFFFFAA, "[GS]{FF6600}Kupio si oruzije");
    }
    case 1:
    {
    if(GetPlayerMoney(playerid) < 2000)
    return SendClientMessage(playerid, 0x33FF00AA, "Prodavac: Nemas dovoljno novca.");
    GivePlayerMoney(playerid, -2000);
    GivePlayerWeapon(playerid, 25, 20);
    SendClientMessage(playerid, 0xFFFFFFAA, "[GS]{FF6600}Kupio si oruzije.");
    }
    case 2:
    {
    if(GetPlayerMoney(playerid) < 100)
    return SendClientMessage(playerid, 0x00FFFFAA, "Prodavac: Nemas dovoljno novca.");
    GivePlayerMoney(playerid, -100);
    GivePlayerWeapon(playerid, 4, 1);
    SendClientMessage(playerid, 0xFFFFFFAA, "[GS]{FF6600}Kupio si oruzije.");
    }
    case 3:
    {
    if(GetPlayerMoney(playerid) < 5000)
    return SendClientMessage(playerid, 0x6600FFAA, "Prodavac: Nemas dovoljno novca.");
    GivePlayerMoney(playerid, -5000);
    GivePlayerWeapon(playerid, 33, 20);
    SendClientMessage(playerid, 0xFFFFFFAA, "[GS]{FF6600}Kupio si oruzije.");
    }
        }
  		}
        return 1;
    	}
	}
public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}


//-----------------------------
//      FORWARDS & CALLBACKS
//-----------------------------

forward LoadUser_data(playerid,name[],value[]);
public LoadUser_data(playerid,name[],value[])
{
    INI_Int("Password",PlayerInfo[playerid][pPass]);
    INI_Int("Cash",PlayerInfo[playerid][pCash]);
    INI_Int("Admin",PlayerInfo[playerid][pAdmin]);
    INI_Int("Kills",PlayerInfo[playerid][pKills]);
    INI_Int("Deaths",PlayerInfo[playerid][pDeaths]);
    INI_Int("Mute",PlayerInfo[playerid][pMute]);
    INI_Int("Warns",PlayerInfo[playerid][pWarns]);
    INI_Int("Ban",PlayerInfo[playerid][pBan]);
    INI_Int("Clan",PlayerInfo[playerid][pClan]);
    INI_Int("Rank",PlayerInfo[playerid][pRank]);
    INI_Int("Lider",PlayerInfo[playerid][pLider]);
    INI_Int("Vip",PlayerInfo[playerid][pVip]);
	return 1;
}



forward OnPlayerCBug(playerid);
public OnPlayerCBug(playerid) {
	new playername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playername, sizeof(playername));
	new str2[128];
	format(str2, sizeof(str2), "{F81414}[Anti-Cbug] {FFFFFF}je kickovan {F81414}%s {FFFFFF}xbog CBug {F81414}(%s)", playername, aWeaponNames[WeaponID[playerid]]);
	SendClientMessageToAll(COLOR_WHITE, str2);
	CheckCrouch[playerid] = 0;
	Kick(playerid);
	return 1;
}
forward CrouchCheck(playerid);
public CrouchCheck(playerid) {
	CheckCrouch[playerid] = 0;
	return 1;
}
/////////////
public settime(playerid)
{
        new string[256],year,month,day,hours,minutes,seconds;
        getdate(year, month, day), gettime(hours, minutes, seconds);
        format(string, sizeof string, "%d/%s%d/%s%d", day, ((month < 10) ? ("0") : ("")), month, (year < 10) ? ("0") : (""), year);
        TextDrawSetString(Date, string);
        format(string, sizeof string, "%s%d:%s%d:%s%d", (hours < 10) ? ("0") : (""), hours, (minutes < 10) ? ("0") : (""), minutes, (seconds < 10) ? ("0") : (""), seconds);
        TextDrawSetString(Time, string);
}
////////////////////////////////
//-----------------------------
//      STOCKS
//-----------------------------

stock UserPath(playerid)
{
    new string[128],playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid,playername,sizeof(playername));
    format(string,sizeof(string),PATH,playername);
    return string;
}

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

stock GetAdminLvlName(playerid)
{
	new str[64];
	if (PlayerInfo[playerid][pAdmin] == 0) str = ("None");
	if (PlayerInfo[playerid][pAdmin] == 1) str = ("Helper");
	if (PlayerInfo[playerid][pAdmin] == 2) str = ("Moderator");
	if (PlayerInfo[playerid][pAdmin] == 3) str = ("Administrator");
	if (PlayerInfo[playerid][pAdmin] == 4) str = ("Manager");
	if (PlayerInfo[playerid][pAdmin] == 5) str = ("Server Owner");
	return str;
}

stock GetName(playerid)
{
    new pName[MAX_PLAYER_NAME];
    if(IsPlayerConnected(playerid))
    {
		GetPlayerName(playerid, pName, sizeof(pName));
	}
	return Name;
}

stock UnbanIP(ip[])
{
	new string[64];
	format(string, sizeof(string), "unbanip %s", ip);
	SendRconCommand(string);
	SendRconCommand("reloadbans");
	return 1;
}


stock IsPlayerInWater(playerid) {
        new anim = GetPlayerAnimationIndex(playerid);
        if (((anim >=  1538) && (anim <= 1542)) || (anim == 1544) || (anim == 1250) || (anim == 1062)) return 1;
        return 0;
}

stock IsPlayerAiming(playerid) {
	new anim = GetPlayerAnimationIndex(playerid);
	if (((anim >= 1160) && (anim <= 1163)) || (anim == 1167) || (anim == 1365) ||
	(anim == 1643) || (anim == 1453) || (anim == 220)) return 1;
    return 0;
}


//----------------------------------------------------------------------------//


//-----------------------------
//      COMMANDS
//-----------------------------


CMD:laseron(playerid, params[])
{
	SetPVarInt(playerid, "laser", 1);
	SetPVarInt(playerid, "color", GetPVarInt(playerid, "color"));	return 1;
}


CMD:laseroff(playerid, params[])
{
	SetPVarInt(playerid, "laser", 0);
	RemovePlayerAttachedObject(playerid, 0);	return 1;
}


CMD:lasercolor(playerid, params[])
{
	new tmp[256];
	if (!strlen(tmp)) {
		SendClientMessage(playerid, 0x00E800FF, "Koristi: /lasercolor [boja]");
		return 1;
	}
	if (!strcmp(tmp, "red", true)) SetPVarInt(playerid, "color", 18643);
	else if (!strcmp(tmp, "blue", true)) SetPVarInt(playerid, "color", 19080);
	else if (!strcmp(tmp, "pink", true)) SetPVarInt(playerid, "color", 19081);
	else if (!strcmp(tmp, "orange", true)) SetPVarInt(playerid, "color", 19082);
	else if (!strcmp(tmp, "green", true)) SetPVarInt(playerid, "color", 19083);
	else if (!strcmp(tmp, "yellow", true)) SetPVarInt(playerid, "color", 19084);
	else SendClientMessage(playerid, 0x00E800FF, "Color not available!");
	return 1;
}


CMD:paymute(playerid, params[])
{
    if(PlayerInfo[playerid][pMute] == 1)
    {
		if(GetPlayerMoney(playerid) <3000) return SendClientMessage(playerid, COLOR_WHITE,"[WW] {FF6600}Nemate dovoljno novca");
        PlayerInfo[playerid][pMute] = 0;
		GivePlayerMoney(playerid, -300000);
		SendClientMessage(playerid,COLOR_GREEN, "Platili ste unmute. Pripazite na ponasanje.");
	}
	else SendClientMessage(playerid, COLOR_WHITE,"[WW] Greska: {FF6600}Vi niste mutirani");
	return 1;
}

COMMAND:admini(playerid,params[])
{
	new count = 0;
	new string[128];
	SendClientMessage(playerid,COLOR_RED,"");
	SendClientMessage(playerid,COLOR_GREEN,"________________|ONLINE ADMINI|________________");
	SendClientMessage(playerid,COLOR_RED,"");
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if(PlayerInfo[i][pAdmin] > 0)
			{
				if(PlayerInfo[i][pAdmin] == 1)
				{
					AdminRank = "Helper";
				}
				else if(PlayerInfo[i][pAdmin] == 2)
				{
					AdminRank = "Moderator";
				}
				else if(PlayerInfo[i][pAdmin] == 3)
				{
					AdminRank = "Administrator";
				}
				else if(PlayerInfo[i][pAdmin] == 4)
				{
					AdminRank = "UnBan Manager";
				}
				else if(PlayerInfo[i][pAdmin] == 5)
				{
					AdminRank = "Server Owner";
				}
				new aName[MAX_PLAYER_NAME];
				GetPlayerName(i,aName,sizeof(aName));
				format(string, sizeof(string), "Level: %d | Ime: %s (ID:%i) | Rank: %s ", PlayerInfo[i][pAdmin], aName,i,AdminRank);
				SendClientMessage(playerid,COLOR_CYAN,string);
				count++;
			}
		}
	}
	if(count == 0)
	SendClientMessage(playerid,COLOR_RED,"Trenutno nema admina online!");
	SendClientMessage(playerid,COLOR_GREEN,"_________________________________________________");
	return 1;
}

COMMAND:kill(playerid, params[])
{

	SetPlayerHealth(playerid, 0);
	return 1;
}

COMMAND:pm(playerid,params[])
{
		new pid;
		new message1[100];
		if(sscanf(params, "us[32]", pid, message1))
		{
			return SendClientMessage(playerid, 0xADFF2F, "Koristi: /pm <id igraca> <tekst>");
		}
		if(pid == INVALID_PLAYER_ID) SendClientMessage(playerid,-1,"ERROR: Taj igrac je ofline.");
		new pmsg[256];
		new pname[MAX_PLAYER_NAME];
		GetPlayerName(playerid,pname,sizeof(pname));
		format(pmsg,sizeof(pmsg),"[PM Primjen] Administrator %s(%d): %s",pname,playerid,message1);
		new pidmsg[256];
		new pidname[MAX_PLAYER_NAME];
		GetPlayerName(pid,pidname,sizeof(pidname));
		format(pidmsg,sizeof(pidmsg),"[PM Poslat] %s(%d): %s",pidname,pid,message1);
		SendClientMessage(pid, 0xADFF2F, pmsg);
		PlayerPlaySound(pid,1057,0.0,0.0,0.0);
		SendClientMessage(playerid, 0xADFF2F, pidmsg);
		return 1;
}

COMMAND:stats(playerid, params[])
{

	// Create variable
	new
		lookupid;


	// If player didn't enter anyones ID
	if(sscanf(params, "u", lookupid))
	{

		// Create big temporary string and player name variable
	    new
			TempStr_Stats[512],
			pname[24];

		new deaths = PlayerInfo[playerid][pDeaths];
	    new kills = PlayerInfo[playerid][pKills];
		new vip = PlayerInfo[playerid][pVip];

		// Get players names
		GetPlayerName(playerid,pname,sizeof(pname));

	    // Format player stats in dialog
	    format(TempStr_Stats, sizeof(TempStr_Stats), "\n%s {FFFFFF}� {FF6600} Nalog: {FF6600} %s\n", TempStr_Stats, pname);
	    format(TempStr_Stats, sizeof(TempStr_Stats), "%s {FFFFFF}� {FF6600} ID Igraca: {FF6600} %d\n", TempStr_Stats, playerid);
	    format(TempStr_Stats, sizeof(TempStr_Stats), "%s {FFFFFF}� {FF6600} Ubistava: {FF6600} %i\n", TempStr_Stats, kills);
	    format(TempStr_Stats, sizeof(TempStr_Stats), "%s {FFFFFF}� {FF6600} Smrti: {FF6600} %i\n", TempStr_Stats, deaths);
        format(TempStr_Stats, sizeof(TempStr_Stats), "%s {FFFFFF}� {FF6600} Vip: {FF6600} %i\n", TempStr_Stats, vip);
		format(TempStr_Stats, sizeof(TempStr_Stats), "%s {FFFFFF}� {FF6600} U/S Ratio: {FF6600} }%.3f\n", TempStr_Stats, Float:kills/Float:deaths);
		format(TempStr_Stats, sizeof(TempStr_Stats), "%s {FFFFFF}� {FF6600} Score: {FF6600} %i\n", TempStr_Stats, GetPlayerScore(lookupid));
	    format(TempStr_Stats, sizeof(TempStr_Stats), "%s {FFFFFF}� {FF6600} Novac: {FF6600} %i\n", TempStr_Stats, GetPlayerMoney(playerid));

		// Show stats dialog box
	    ShowPlayerDialog(playerid, STA_Dialog, DIALOG_STYLE_MSGBOX, "Statistika igraca..", TempStr_Stats, "OK", "");

	    return 1;
	}

	// Check is player connected
	if(!IsPlayerConnected(lookupid))
	{
	    // Send message and exit
		SendClientMessage(playerid, COLOR_WHITE, "[WW] {FF6600}Igrac cije statse zelite da proverite nije na serveru.");
	    return 1;
	}


	// Create big temporary string and player name variable
    new
		TempStr_Stats[512],
		xname[24];

    new deaths = PlayerInfo[playerid][pDeaths];
    new kills = PlayerInfo[playerid][pKills];
	new vip = PlayerInfo[playerid][pVip];

	// Get players names
	GetPlayerName(lookupid,xname,sizeof(xname));

    // Format player stats in dialog
    format(TempStr_Stats, sizeof(TempStr_Stats), "\n%s {FFFFFF}� {{FF6600} }Nalog: {FF6600} %s\n", TempStr_Stats, xname);
    format(TempStr_Stats, sizeof(TempStr_Stats), "%s {FFFFFF}� {{FF6600} }ID Igraca: {FF6600} %d\n", TempStr_Stats, lookupid);
    format(TempStr_Stats, sizeof(TempStr_Stats), "%s {FFFFFF}� {{FF6600} }Ubistava: {FF6600} %i\n", TempStr_Stats, kills);
    format(TempStr_Stats, sizeof(TempStr_Stats), "%s {FFFFFF}� {{FF6600} }Smrti: {FF6600} %i\n", TempStr_Stats, deaths);
    format(TempStr_Stats, sizeof(TempStr_Stats), "%s {FFFFFF}� {{FF6600} }Vip: {FF6600} %i\n", TempStr_Stats, vip);
	format(TempStr_Stats, sizeof(TempStr_Stats), "%s {FFFFFF}� {{FF6600} }U/S Ratio: {FF6600} %.3f\n", TempStr_Stats, Float:kills/Float:deaths);
    format(TempStr_Stats, sizeof(TempStr_Stats), "%s {FFFFFF}� {{FF6600} }Score: {FF6600} %i\n", TempStr_Stats, GetPlayerScore(lookupid));
    format(TempStr_Stats, sizeof(TempStr_Stats), "%s {FFFFFF}� {{FF6600} }Novac: {FF6600} %i\n", TempStr_Stats, GetPlayerMoney(playerid));

	// Show stats dialog box
    ShowPlayerDialog(playerid, STA_Dialog, DIALOG_STYLE_MSGBOX, "Statistika igraca..", TempStr_Stats, "OK", "");

	// Exit here
	return 1;
}

// ADMINISTRATOR LEVEL 1 COMMANDS

COMMAND:warn(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin]>=1)
	{
	    new id, reason[64];
	    if(sscanf(params, "us", id, reason)) return SendClientMessage(playerid, COLOR_WHITE, "Koristi: /warn [ID igraca] [Razlog]");
	    {
	        if(!IsPlayerConnected(id)) return SendClientMessage(playerid, COLOR_BRIGHTRED, "ERROR: Taj igrac je ofline.");
	        {
	            if(PlayerInfo[id][pWarns] == 2)
	            {
	                new Target;
	                new string[128];
	                new tname[MAX_PLAYER_NAME];
					GetPlayerName(Target,tname,sizeof(tname));
					new pname[MAX_PLAYER_NAME];
					GetPlayerName(playerid,pname,sizeof(pname));
	            	format(string, sizeof(string), "SERVER: Upozoreni ste i kickovani (imali ste 3 warn-a) od %s, razlog: %s", GetName(playerid), reason);
	            	SendClientMessage(id, COLOR_BRIGHTRED, string);
	            	format(string, sizeof(string), "SERVER: Upozoreni ste i kickovani (imali ste 3 warn-a) od %s, razlog: Nema", GetName(id), reason);
	            	SendClientMessage(playerid, COLOR_GREEN, string);
	            	PlayerInfo[id][pWarns] = 0;
	                Kick(id);
	                return 1;
      			}
      			new Target;
            	new string[128];
            	new tname[MAX_PLAYER_NAME];
				GetPlayerName(Target,tname,sizeof(tname));
				new pname[MAX_PLAYER_NAME];
				GetPlayerName(playerid,pname,sizeof(pname));
	            format(string, sizeof(string), "{0xFFFFFFAA} SERVER: Upozoreni ste od strane %s, (Reason: %s )", pname, reason);
	            SendClientMessage(id, COLOR_ORANGE, string);
	            format(string, sizeof(string), "{FF0000}%s {FFFFFF}je upozoren {2EAD15}%s %s. {E0A21B}(Razlog: %s )", tname,GetAdminLvlName(playerid),pname,reason);
	            SendClientMessageToAll(COLOR_ORANGE, string);
	            PlayerInfo[id][pWarns]++;
				return 1;
				}
			}
		}
	return 1;
}

CMD:resetwarns(playerid, params[])
{
	new pid;
	new reason[128];
	new str[128];
	if(sscanf(params, "us-128]", pid, reason)) return SendClientMessage(playerid, COLOR_WHITE, "[WW]Koristi:{FF6600}/resetwarns [Player ID] [Razlog]");
	if(!IsPlayerConnected(pid)) return SendClientMessage(playerid, COLOR_WHITE, "[WW] Greska:{FF6600}Igrac nije povezan.");
	if(PlayerInfo[playerid][pAdmin] >=2)
	{
        new Target;
	    new tname[MAX_PLAYER_NAME];
		GetPlayerName(Target,tname,sizeof(tname));
		new pname[MAX_PLAYER_NAME];
		GetPlayerName(playerid,pname,sizeof(pname));
	    format(str,sizeof(str), "Administrator %s je restartovao igracu %s's Warnove. (Razlog: %s )",pname, tname, reason);
	    SendClientMessageToAll(COLOR_ORANGE, str);
	    format(str,sizeof(str), "Resetovali ste igracu %s Warnove.",tname);
	    SendClientMessage(playerid, COLOR_ORANGE, str);
	    PlayerInfo[pid][pWarns] = 0;
	}
	else SendClientMessage(playerid, COLOR_WHITE,"[WW] {FF6600}Samo Admin");
	return 1;
}

CMD:mute(playerid, params[])
{

        if(PlayerInfo[playerid][pAdmin]>=1)
        {
	        new pplayerid;
	        new reason[64];
	        new string[128];
	        if(sscanf(params, "us[48]", pplayerid,reason)) return SendClientMessage(playerid, COLOR_WHITE, "[WW] Koristi:{FF6600}/mute [Player ID/Ime] [Razlog]");
	        if(!IsPlayerConnected(pplayerid)) return SendClientMessage(playerid, COLOR_WHITE, "[WW] Greska: {FF6600}Igrac nije povezan.");
	        format(string,sizeof(string),"{2EAD15}%s %s {FFFFFF}je mutirao igraca {FF0000}%s. {E0A21B}(Razlog: %s )",GetAdminLvlName(playerid),GetName(playerid),GetName(pplayerid),reason);
	        SendClientMessageToAll(COLOR_ORANGE,string);
	        PlayerInfo[pplayerid][pMute] = 1;
		 }
		else SendClientMessage(playerid, COLOR_BRIGHTRED, "You're not authorized to use this command.");
		return 1;
}

CMD:unmute(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin]>1)
	{
	    new pplayerid;
		new string[128];
		if(sscanf(params, "u[48]", pplayerid)) return SendClientMessage(playerid, COLOR_WHITE, "Koristi: /unmute [Player ID]");
		if(!IsPlayerConnected(pplayerid)) return SendClientMessage(playerid, COLOR_BRIGHTRED, "Greska: igrac nije povezan.");
		format(string,sizeof(string), "{2EAD15}%s %s {FFFFFF}je unmute igraca {FF0000}%s",GetAdminLvlName(playerid),GetName(playerid),GetName(pplayerid));
		SendClientMessageToAll(COLOR_ORANGE, string);
		PlayerInfo[pplayerid][pMute] = 0;
	}
	else SendClientMessage(playerid, COLOR_WHITE,"[WW] {FF6600}Samo Admin");
	return 1;
}

COMMAND:freeze(playerid,params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 1)
    {
    	new Target;
     	if(!sscanf(params, "u", Target))
	    {
            if(Target == INVALID_PLAYER_ID) return SendClientMessage(playerid,COLOR_BRIGHTRED,"Greska: Igrac nije povezan.");
            new tname[MAX_PLAYER_NAME];
			GetPlayerName(Target,tname,sizeof(tname));
			new pname[MAX_PLAYER_NAME];
			GetPlayerName(playerid,pname,sizeof(pname));
			new tstring[256];
			new pstring[256];
			format(tstring,sizeof(tstring),"Zaledjen si od strane admina %s! Nemozes da se pomeras!",pname);
			format(pstring,sizeof(pstring),"Je zaledio igraca %s(%d)",tname,Target);
			SendClientMessage(Target,COLOR_BRIGHTRED,tstring);
			SendClientMessage(playerid,COLOR_BRIGHTRED	,pstring);
			TogglePlayerControllable(Target,0);
		}
		else SendClientMessage(playerid,COLOR_WHITE,"Koristi:[WW]{FF6600} /freeze <playerid> <razlog>");
	}
	else SendClientMessage(playerid,COLOR_WHITE,"[WW]{FF6600}Samo Admin.!");
	return 1;
}

COMMAND:unfreeze(playerid,params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 1)
    {
    	new Target;
     	if(!sscanf(params, "u", Target))
	    {
     		if(Target == INVALID_PLAYER_ID) return SendClientMessage(playerid,COLOR_BRIGHTRED,"Greska: Igrac nije povezan");
     		new tname[MAX_PLAYER_NAME];
			GetPlayerName(Target,tname,sizeof(tname));
			new pname[MAX_PLAYER_NAME];
			GetPlayerName(playerid,pname,sizeof(pname));
			new tstring[256];
			new pstring[256];
			format(tstring,sizeof(tstring),"Odledjen si od strane %s! Sada mozes da se kreces!",pname);
			format(pstring,sizeof(pstring),"You have unfrozen player %s(%d)",tname,Target);
			SendClientMessage(Target,COLOR_GREEN,tstring);
			SendClientMessage(playerid,COLOR_GREEN,pstring);
			TogglePlayerControllable(Target,1);
		}
		else SendClientMessage(playerid,COLOR_WHITE,"Koristi:{FF6600}/unfreeze <playerid>");
 	}
	else SendClientMessage(playerid,COLOR_WHITE,"{FF6600}Samo Admin.");
	return 1;
}


COMMAND:ahelp(playerid, params[])
{
        if(PlayerInfo[playerid][pAdmin] == 1){
        ShowPlayerDialog(playerid, 1, DIALOG_STYLE_MSGBOX, "Admin Komande Wild West", ""COL_YELLOW"Level 1:"COL_RED"  /spec(off)  | /unfreeze | /goto | /un(mute) | /cc  ", "OK", "Cancel");}
        if(PlayerInfo[playerid][pAdmin] == 2){
        ShowPlayerDialog(playerid, 1, DIALOG_STYLE_MSGBOX, "Admin Komande Wild West", ""COL_YELLOW"Level 1:"COL_RED"  /spec(off)  | /unfreeze | /goto | /un(mute) | /cc /n "COL_YELLOW"Level 2:"COL_RED" /kick | /announce | /bring | /spawn ", "OK", "Cancel");}
        if(PlayerInfo[playerid][pAdmin] == 3){
		ShowPlayerDialog(playerid, 1, DIALOG_STYLE_MSGBOX, "Admin Komande Wild West", ""COL_YELLOW"Level 1:"COL_RED"  /spec(off)  | /unfreeze | /goto | /un(mute) | /cc/n "COL_YELLOW"Level 2:"COL_RED" /kick | /announce | /bring | /spawn /n "COL_YELLOW"Level 3:"COL_RED" /ban | /ip | /disarm | /explode | /setskin ", "OK", "Cancel");}
        if(PlayerInfo[playerid][pAdmin] == 4){
		ShowPlayerDialog(playerid, 1, DIALOG_STYLE_MSGBOX, "Admin Komande Wild West", ""COL_YELLOW"Level 1:"COL_RED"  /spec(off)  | /unfreeze | /goto | /un(mute) | /cc/n "COL_YELLOW"Level 2:"COL_RED" /kick | /announce | /bring | /spawn /n "COL_YELLOW"Level 3:"COL_RED" /ban | /ip | /disarm | /explode | /setskin/n "COL_YELLOW"Level 4:"COL_RED" /unban ", "OK", "Cancel");}
        if(PlayerInfo[playerid][pAdmin] == 5){
		ShowPlayerDialog(playerid, 1, DIALOG_STYLE_MSGBOX, "Admin Komande Wild West", ""COL_YELLOW"Level 1:"COL_RED"  /spec(off)  | /unfreeze | /goto | /un(mute) | /cc/n "COL_YELLOW"Level 2:"COL_RED" /kick | /announce | /bring | /spawn /n "COL_YELLOW"Level 3:"COL_RED" /ban | /ip | /disarm | /explode | /setskin/n "COL_YELLOW"Level 4:"COL_RED" /unban /n "COL_YELLOW"Level 5:"COL_RED" /setlevel | /gmx ", "OK", "Cancel");}
		return 1;
}

COMMAND:spec(playerid, params[])
{
    new id;// This will hold the ID of the player you are going to be spectating.
    if(PlayerInfo[playerid][pAdmin] >=1)
    if(sscanf(params,"u", id))return SendClientMessage(playerid, COLOR_WHITE, "[WW] Koristi:{FF6600}/spec [id]");// Now this is where we use sscanf to check if the params were filled, if not we'll ask you to fill them
    if(id == playerid)return SendClientMessage(playerid,COLOR_WHITE,"{FF6600}Nemozes da specas sebe.");// Just making sure.
    if(id == INVALID_PLAYER_ID)return SendClientMessage(playerid, COLOR_WHITE, "{FF6600}Igrac nije online!");// This is to ensure that you don't fill the param with an invalid player id.
    if(IsSpecing[playerid] == 1)return SendClientMessage(playerid,COLOR_WHITE,"{FF6600}Vec specas nekog.");// This will make you not automatically spec someone else by mistake.
    GetPlayerPos(playerid,SpecX[playerid],SpecY[playerid],SpecZ[playerid]);// This is getting and saving the player's position in a variable so they'll respawn at the same place they typed '/spec'
    Inter[playerid] = GetPlayerInterior(playerid);// Getting and saving the interior.
    vWorld[playerid] = GetPlayerVirtualWorld(playerid);//Getting and saving the virtual world.
    TogglePlayerSpectating(playerid, true);// Now before we use any of the 3 functions listed above, we need to use this one. It turns the spectating mode on.
    if(IsPlayerInAnyVehicle(id))//Checking if the player is in a vehicle.
    {
        if(GetPlayerInterior(id) > 0)//If the player's interior is more than 0 (the default) then.....
        {
            SetPlayerInterior(playerid,GetPlayerInterior(id));//.....set the spectator's interior to that of the player being spectated.
        }
        if(GetPlayerVirtualWorld(id) > 0)//If the player's virtual world is more than 0 (the default) then.....
        {
            SetPlayerVirtualWorld(playerid,GetPlayerVirtualWorld(id));//.....set the spectator's virtual world to that of the player being spectated.
        }
        PlayerSpectateVehicle(playerid,GetPlayerVehicleID(id));// Now remember we checked if the player is in a vehicle, well if they're in a vehicle then we'll spec the vehicle.
    }
    else// If they're not in a vehicle, then we'll spec the player.
    {
        if(GetPlayerInterior(id) > 0)
        {
            SetPlayerInterior(playerid,GetPlayerInterior(id));
        }
        if(GetPlayerVirtualWorld(id) > 0)
        {
            SetPlayerVirtualWorld(playerid,GetPlayerVirtualWorld(id));
        }
        PlayerSpectatePlayer(playerid,id);// Letting the spectator spec the person and not a vehicle.
    }
    GetPlayerName(id, Name, sizeof(Name));//Getting the name of the player being spectated.
    format(String, sizeof(String),"Specate %s.",Name);// Formatting a string to send to the spectator.
    SendClientMessage(playerid,0xFF9900AA,String);//Sending the formatted message to the spectator.
    IsSpecing[playerid] = 1;// Just saying that the spectator has begun to spectate someone.
    IsBeingSpeced[id] = 1;// Just saying that a player is being spectated (You'll see where this comes in)
    spectatorid[playerid] = id;// Saving the spectator's id into this variable.
    return 1;// Returning 1 - saying that the command has been sent.
}

COMMAND:specoff(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] >=1)
    if(IsSpecing[playerid] == 0)return SendClientMessage(playerid,COLOR_WHITE,"{FF6600}Ne specas nikog.");
    TogglePlayerSpectating(playerid, 0);//Toggling spectate mode, off. Note: Once this is called, the player will be spawned, there we'll need to reset their positions, virtual world and interior to where they typed '/spec'
    return 1;
}

COMMAND:goto(playerid,params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 1)
    {
    	new Target;
     	if(!sscanf(params, "u", Target))
		{
	        if(Target == INVALID_PLAYER_ID) return SendClientMessage(playerid,COLOR_BRIGHTRED,"ERROR:{FF6600} Taj igrac nije konektovan.");
			new Float:X;
			new Float:Y;
			new Float:Z;
			GetPlayerPos(Target,X,Y,Z);
			SetPlayerPos(playerid,X+2,Y,Z);
			new pname[MAX_PLAYER_NAME];
			new tname[MAX_PLAYER_NAME];
			GetPlayerName(playerid,pname,sizeof(pname));
			GetPlayerName(Target,tname,sizeof(tname));
			new pstring[256];
			new tstring[256];
			format(pstring,sizeof(pstring),"Teleportovali ste se do %s",tname);
			format(tstring,sizeof(tstring),"%s %s se teleportovao do vas",GetAdminLvlName(playerid), pname);
			SendClientMessage(playerid,COLOR_GREEN,pstring);
			SendClientMessage(Target,COLOR_GREEN,tstring);
		}
		else SendClientMessage(playerid,COLOR_WHITE,"Koristi:{FF6600}/goto <playerid>");
	}
	else SendClientMessage(playerid,COLOR_WHITE,"[WW] Greska:{FF6600}Samo Admin");
	return 1;
}

// ADMINISTRATOR LEVEL 2 COMMANDS

COMMAND:announce(playerid, params[])
{
	// Check is player an admin
	if(PlayerInfo[playerid][pAdmin] < 2)
	{
		// Send message and exit
	    SendClientMessage(playerid, COLOR_WHITE, "[WW]{FF6600}Samo Admin.");
		return 1;
	}

	// Create variable
	new
	    announce[16];

	// If admin didn't enter message
	if(sscanf(params, "s[16]", announce))
	{
	    // Send messages and exit
		SendClientMessage(playerid, COLOR_WHITE, "[WW]{FF6600}Koristi: /announce <Poruka>");
		SendClientMessage(playerid, COLOR_WHITE, "[WW]{FF6600}Ovo ce postali poruku svima.");
	    return 1;
	}

	// Count did admin reach message characters limit
	if(strlen(announce) > 16)
	{
	    // Send message and exit
		SendClientMessage(playerid, COLOR_WHITE, "[WW]{FF6600}Vasa poruka je predugacka 16 karaktera max.");
	    return 1;
	}

    format(TempStr, sizeof(TempStr), "%s", announce);
    GameTextForAll(TempStr, 3000, 3);

	// Exit
	return 1;
}

COMMAND:bring(playerid, params[])
{
	// Check is player an admin
	if(PlayerInfo[playerid][pAdmin] < 2)
	{
		// Send message and exit
	    SendClientMessage(playerid, COLOR_WHITE, "[WW]{FF6600}Greska.");
		return 1;
	}

	// Create variable
	new
		lookupid;

	// Check did admin enter player ID
	if(sscanf(params, "u", lookupid))
	{
	    // Send messages and exit
		SendClientMessage(playerid, COLOR_WHITE, "[WW]{FF6600}Koristi: /bring <PlayerID/Ime>");
		SendClientMessage(playerid, COLOR_WHITE, "[WW]{FF6600}Ovo ce teleportovati igraca do vas.");
	    return 1;
	}

	// Check is player connected
	if(!IsPlayerConnected(lookupid))
	{
	    // Send message and exit
		SendClientMessage(playerid, COLOR_WHITE, "[WW]{FF6600}Greska.");
	    return 1;
	}

 	// Create variables
	new
	    Float:X,
	    Float:Y,
	    Float:Z,
	    Float:Angle,
		xname[24];

	// Get name from player
	GetPlayerName(lookupid,xname,sizeof(xname));

	// If admin entered his own ID
	if (lookupid == playerid)
	{
	    // Send message to admin
		SendClientMessage(playerid, COLOR_WHITE, "*[WW]{FF6600}  To nikako.");
		return 1;
	}

	// Get admin current angle
	GetPlayerFacingAngle(playerid, Angle);

	// Get admin current position
	GetPlayerPos(playerid,X,Y,Z);

	// Teleport player 3 feet above admin
	SetPlayerPos(lookupid, X,Y,Z+3);

	// Set player angle same as admins
	SetPlayerFacingAngle(lookupid, Angle);

	// Set player interior same admins
	SetPlayerInterior(lookupid, GetPlayerInterior(playerid));

	// Set player virtual world same as admins
	SetPlayerVirtualWorld(lookupid, GetPlayerVirtualWorld(playerid));

	// Send success message to admin
	format(TempStr, sizeof(TempStr),"[WW]{FF6600}Uspesno ste teleportovali %s do vas.", xname);
    SendClientMessage(playerid, COLOR_WHITE, TempStr);

	// Exit here
	return 1;
}

COMMAND:spawn(playerid, params[])
{
	// Check is player an admin
	if(PlayerInfo[playerid][pAdmin] < 2)
	{
		// Send message and exit
	    SendClientMessage(playerid, COLOR_WHITE,"[WW] {FF6600}Samo Admin");
		return 1;
	}

	// Create variable
	new
		lookupid;

	// Check did admin enter player ID
	if(sscanf(params, "u", lookupid))
	{
	    // Send message and exit
  SendClientMessage(playerid, COLOR_WHITE,"[WW] {FF6600}/spawn [playerid] [razlog]");
	    return 1;
	}

	// Check is player connected
	if(!IsPlayerConnected(lookupid))
	{
	    // Send message and exit
		SendClientMessage(playerid, COLOR_RED, "* Greska.");
	    return 1;
	}

 	// Create variables
	new
		pname[24],
		xname[24];

	// Get players names
	GetPlayerName(playerid,pname,sizeof(pname));
	GetPlayerName(lookupid,xname,sizeof(xname));

	// Spawn player
	SpawnPlayer(lookupid);

	// Announce jail message for player
	GameTextForPlayer(lookupid, "~y~Spawnowani ste", 3000, 5);

	// Format and end message to everyone on server
	format(TempStr, sizeof (TempStr), "%s (ID: %d) je spawnowan od strane %s (ID: %d)", xname, lookupid, pname, playerid);
    SendClientMessageToAll(COLOR_GREEN, TempStr);

	// Exit here
	return 1;
}

COMMAND:explode(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 2)
	{
	    new str[255];
	    new ID;
        if(sscanf(params, "u", ID)) return SendClientMessage(playerid, COLOR_WHITE,"[WW] {FF6600}/explode [ID/Ime]");
		new Nam[MAX_PLAYER_NAME];
		GetPlayerName(playerid,Nam,sizeof(Nam));
		new pname[MAX_PLAYER_NAME];
        GetPlayerName(ID,pname,sizeof(pname));
        if(!IsPlayerConnected(ID)) return SendClientMessage(playerid, 0xFF0000FF, "Igrac nije konektovan.");
        format(str, sizeof(str),"You had burned %s!",pname);
        SendClientMessage(playerid, 0xFF9900AA,str);
        format(str, sizeof(str),"Administrator %s vas je spalio!",Nam);
        SendClientMessage(ID, 0xFF9900AA,str);
        new Float:burnx, Float:burny, Float:burnz;
        GetPlayerPos(ID,burnx,burny,burnz);
        CreateExplosion(burnx,burny,burnz,0,10.0);
 	}
	else SendClientMessage(playerid, COLOR_WHITE,"[WW] {FF6600}Samo Admin");
    return 1;
}

COMMAND:kick(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 2)
	{
	    new Target;
	    new Reason[100];
	    if(!sscanf(params, "us[70]", Target,Reason))
	    {
	    	if(Target == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE,"[WW] {FF6600}Igrac nije konektovan");
	    	if(PlayerInfo[Target][pAdmin] >= 1 && PlayerInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COLOR_WHITE,"[WW] {FF6600}Samo Admin");
			new tname[MAX_PLAYER_NAME];
			GetPlayerName(Target,tname,sizeof(tname));
			new pname[MAX_PLAYER_NAME];
			GetPlayerName(playerid,pname,sizeof(pname));
			new MyString[256];
			new TargetString[256];
			format(MyString,sizeof(MyString),"Kickovali ste %s(%d)! (Razlog: %s)",tname,Target,Reason);
			format(TargetString,sizeof(TargetString),"Kickovani ste od strane %s! (Reason: %s)", pname, playerid,Reason);
			SendClientMessage(playerid,COLOR_GREEN,MyString);
			SendClientMessage(Target,COLOR_RED,TargetString);
			new AllString[256];
			format(AllString,sizeof(AllString),"{2EAD15}%s %s{FFFFFF}je kickovao igraca {FF0000}%s(%d)! {E0A21B}(Razlog: %s)",GetAdminLvlName(playerid),pname,tname,Target,Reason);
			SendClientMessageToAll(COLOR_ORANGE,AllString);
			Kick(Target);
		}
	    else SendClientMessage(playerid, COLOR_WHITE,"[WW] {FF6600}/kick [id] [razlog]");
	}
	else SendClientMessage(playerid, COLOR_WHITE,"[WW] {FF6600}Samo Admin");
	return 1;
}

COMMAND:disarm(playerid, params[])
{
	// Check is player an admin
	if(PlayerInfo[playerid][pAdmin] < 2)
	{
		// Send message and exit
	    SendClientMessage(playerid, COLOR_WHITE,"[WW] {FF6600}Samo Admin");
		return 1;
	}

	// Create variable
	new
		lookupid;

	// Check did admin enter player ID
	if(sscanf(params, "u", lookupid))
	{
	    // Send messages and exit
		SendClientMessage(playerid, COLOR_WHITE,"[WW] Koristi {FF6600}/disarm [ID Igraca] ");
	    return 1;
	}

	// Check is player connected
	if(!IsPlayerConnected(lookupid))
	{
	    // Send message and exit
		SendClientMessage(playerid, COLOR_WHITE,"[WW] {FF6600}GRESKA");
	    return 1;
	}

 	// Create variables
	new
		pname[24],
		xname[24];

	// Get players names
	GetPlayerName(playerid,pname,sizeof(pname));
	GetPlayerName(lookupid,xname,sizeof(xname));

	// If admin entered his own ID
	if (lookupid == playerid)
	{
	    // Send message to admin
		SendClientMessage(playerid, COLOR_WHITE,"[WW] {FF6600}Razoruzali ste se");

		// Send message to all players
		format(TempStr, sizeof (TempStr), "{375FFF}[AdvancedDisarm] {FFDD00}%s (ID: %d) se razoruzao..", xname, lookupid);
	    SendClientMessageToAll(COLOR_GREEN, TempStr);

		// Send announce to player
		GameTextForPlayer(lookupid, "~r~RAZORUZANI STE", 3000, 5);

		// Disarm player
		ResetPlayerWeapons(lookupid);

		// Exit
		return 1;
	}

	// Disarm player
	ResetPlayerWeapons(lookupid);

	// Send message to everyone on server
	format(TempStr, sizeof (TempStr), "{375FFF}[AdvancedDisarm] {FFDD00}Razoruzali ste %s (ID: %d).", xname, lookupid);
	SendClientMessage(playerid, COLOR_GREEN, TempStr);

	// Exit
	return 1;
}

// ADMINISTRATOR LEVEL 3 COMMANDS

COMMAND:ip(playerid, params[])
{
	// Check is player an admin
	if(PlayerInfo[playerid][pAdmin] < 3)
	{
		// Send message and exit
	    SendClientMessage(playerid, COLOR_WHITE,"[WW] {FF6600}Samo Admin");
		return 1;
	}

	// Create variable
	new
		lookupid;

	// Check did admin enter player ID
	if(sscanf(params, "u", lookupid))
	{
	    // Send messages and exit
		SendClientMessage(playerid, COLOR_WHITE,"[WW] Koristi {FF6600}/ip [id]");
		SendClientMessage(playerid, COLOR_WHITE,"[WW] {FF6600}Pokazace vam ip igraca");
	    return 1;
	}

	// Check is player connected
	if(!IsPlayerConnected(lookupid))
	{
	    // Send message and exit
		SendClientMessage(playerid, COLOR_RED, "* Greska.");
	    return 1;
	}

 	// Create variables
	new
		pname[24],
		xname[24],
		IP[16];

	// Get players names
	GetPlayerName(playerid,pname,sizeof(pname));
	GetPlayerName(lookupid,xname,sizeof(xname));

    // Get player current IP
    GetPlayerIp(playerid, IP, 16);

	// Send message to everyone on server
	format(TempStr, sizeof (TempStr), "{375FFF}[AdvancedIP] {FFDD00}%s (ID: %d) IP je zatrazen od strane Admina %s (ID: %d).", xname, lookupid, pname, playerid);
    SendClientMessageToAll(COLOR_GREEN, TempStr);

	// Send player IP to admin
	format(TempStr, sizeof (TempStr), "{375FFF}[AdvancedIP] {FFDD00}%s (ID: %d) IP is: %s", xname, lookupid, IP);
    SendClientMessage(playerid, COLOR_GREEN, TempStr);

	// Exit here
	return 1;
}

COMMAND:ban(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >=3)
	{
	    new File:Log = fopen(banPATH, io_append);
	    new logData[128];
	    new target;
	    new reason[112];
	    if(target == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE,"[WW] {FF6600}");
	    if(sscanf(params,"us[112]",target,reason)) return SendClientMessage(playerid, COLOR_WHITE,"[WW] {FF6600}Koristi /ban [id] [razlog]");
	    if(PlayerInfo[target][pAdmin] >=1 && PlayerInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COLOR_WHITE,"[WW] {FF6600}Samo Admin");
	    {
	        new pstring[128];
	        new pname[24];
	        new xname[24];
	        GetPlayerName(playerid, pname, sizeof(pname));
	        GetPlayerName(target, xname, sizeof(xname));
         	format(pstring,sizeof(pstring), "{2EAD15}[ADMIN] %s {FFFFFF} je banovao {FF0000}%s. {E0A21B}(Razlog: %s )",pname,xname,reason);
	        SendClientMessageToAll(COLOR_ORANGE, pstring);
	        format(logData,sizeof logData, "%s je banovan od strane %s. (Razlog: %s ) \r\n",xname,pname,reason);
	        fwrite(Log, logData);
	        fclose(Log);
	        PlayerInfo[target][pBan] = 1;
			Ban(target);
		}
	}
	else SendClientMessage(playerid, COLOR_WHITE,"[WW] {FF6600}Samo Admin");
	return 1;
}


// ADMINISTRATOR LEVEL 4 COMMANDS

COMMAND:unban(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 4)
	{
		new ip[16];
		if(!sscanf(params, "s", ip))
		{
			new string[64];
			format(string, sizeof(string), "AdmCmd: %s je unbanovao igracev IP: %s", GetName(playerid), ip);
			SendClientMessageToAll(COLOR_ORANGE, string);
			UnbanIP(ip);
			return 1;
		}
	}
	else SendClientMessage(playerid, COLOR_WHITE,"[WW] {FF6600}Samo Admin");
	return 1;
}

// ADMINISTRATOR LEVEL 5 COMMANDS

////////////////////////////////////////////////
COMMAND:setlevel(playerid, params[])
{
	// Check is player an admin
	if(PlayerInfo[playerid][pAdmin] == 5)
	{
		// Create variable
		new
			lookupid,
			level;

		// Check did admin enter player ID and level
		if(sscanf(params, "ui", lookupid, level))
		{
		    // Send messages and exit
			SendClientMessage(playerid, COLOR_WHITE, "[WW] {FF6600} Koristi: /setlevel <IgracID/Ime> <Level 1-5>");
		    return 1;
		}

		// Check is player connected
		if(!IsPlayerConnected(lookupid))
		{
		    // Send message and exit
			SendClientMessage(playerid, COLOR_RED, "* Igrac je offline.");
		    return 1;
		}

		// Check if player is not an RCON admin
		if(PlayerInfo[playerid][pAdmin] == 5)
		{
			// Did admin enter valid level
			if (level > 4 || level < 0 )
			{
			    // Send message and exit
		  		SendClientMessage(playerid, COLOR_WHITE,"[WW] {FF6600}Greska Taj Admin Level nepostoji");
				return 1;
			}
		}

		// Check if player is an RCON admin
		if(PlayerInfo[playerid][pAdmin] == 5)
		{
			// Did admin enter valid level
			if (level > 5 || level < 0 )
			{
			    // Send message and exit
		  		SendClientMessage(playerid, COLOR_WHITE,"[WW] {FF6600}Greska taj Admin Level nepostoji");
				return 1;
			}
		}

	 	// Create variables
		new
			pname[24],
			xname[24];

		// Get players names
		GetPlayerName(playerid,pname,sizeof(pname));
		GetPlayerName(lookupid,xname,sizeof(xname));


		// Set player new level
     	PlayerInfo[playerid][pAdmin] = level;

		// Announce new level message for player
		GameTextForPlayer(lookupid, "~r~VAS AL JE PROMENJEN", 3000, 5);

		// Format and end message to everyone on server
		format(TempStr, sizeof (TempStr), "{375FFF}[AdvancedLevel] {FFDD00} %s (ID: %d) trenutni al je promenjen adminu %s (ID: %d) (Novi Level %i)", xname, lookupid, pname, playerid, level);
	    SendClientMessageToAll(COLOR_ORANGE, TempStr);
	}

	// Exit here
	return 1;
}

COMMAND:gmx(playerid, params[])
{
	// Check is player an admin
	if(PlayerInfo[playerid][pAdmin] == 5 || IsPlayerAdmin(playerid))
	{
	 	// Create variables
		new
			pname[24];

		// Get player name
		GetPlayerName(playerid,pname,sizeof(pname));


		// Format and end message to everyone on server
		format(TempStr, sizeof (TempStr), "{375FFF}[AdvancedGMX] {FFDD00} Admin %s (ID: %d) restartuje server [uradite relog (/q)]!", pname, playerid);
	    SendClientMessageToAll(COLOR_GREEN, TempStr);

		// Loop
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			// Announce GMX process to all players
			GameTextForAll("~r~SERVER SE RESTARTUJE", 3000, 5);

		    // Kick all players
		    Kick(i);
		}

		// Loop
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
		    // Set of all players health to 100 units
		    SetPlayerHealth(i, 100);
		}

		// Request GMX
	    SendRconCommand("gmx");
	}
	// Send message and exit
	else return SendClientMessage(playerid, COLOR_WHITE,"[WW] {FF6600}Samo Admin");

	// Exit here
	return 1;
}
CMD:setskin(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, COLOR_WHITE,"[WW] {FF6600}Samo Admin");
	new pID,sID, name[MAX_PLAYER_NAME], str[128];
	GetPlayerName(playerid, name, sizeof(name));
	if(sscanf(params, "ui",pID,sID))return SendClientMessage(playerid, COLOR_WHITE,"[WW] {FF6600}/setskin <playerid> <skin id>");
	if(pID == INVALID_PLAYER_ID)return SendClientMessage(playerid, COLOR_WHITE,"[WW] {FF6600}Pogresan ID");
	if(sID > 311)return SendClientMessage(playerid, COLOR_WHITE,"[WW] {FF6600}Samo Admin");
	SetPlayerSkin(pID,sID);
	format(str, sizeof(str), "Admin %s vam je postavio skin %i.", name, sID);
	SendClientMessage(pID, COLOR_RED,str);
	return 1;
}
CMD:cc(playerid,params[])
{
#pragma unused params
if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_WHITE,"[WW] {FF6600}Samo Admin");
for(new i = 0; i < 50; i++) SendClientMessageToAll(0xFFFFFFAA," ");
SendClientMessageToAll(0xFFFFFFAA,"{F81414}Chat Cleard ");
return 1;
}
CMD:aizbaci(playerid,params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 3)//Replace this with your player variable
	{
	    new targetid;//establishes a person on the server to use the command on
	    if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, COLOR_RED, "/aizbaci [id]");//tells you how to use the command if you use it incorrectly
	    if(targetid != INVALID_PLAYER_ID)//checks if the id you type in is an id that is not connected to the server
	    {
			PlayerInfo[targetid][pClan] = 0; //kicks the player from his faction
			PlayerInfo[targetid][pRank] = 0;//sets his rank to 0
			PlayerInfo[targetid][pLider] = 0;// revokes his leadership status
			SendClientMessage(targetid,COLOR_CYAN,"Izbaceni ste iz organizacije od strane admina.");//tells them they have been kicked out of their faction by an admin.
	    }
	}
	else//if they arent an admin then it will send them they message below telling them they may not use the command
	{
	    SendClientMessage(playerid, COLOR_WHITE,"[WW] {FF6600}Samo Admin");
	}
	return 1;
}
CMD:makeleader(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 4) //Replace this with your player variable
	{
	    new targetid, orgid;//establishes a player and a faction id, to be typed in
	    if(sscanf(params,"ui",targetid, orgid)) return SendClientMessage(playerid, COLOR_RED,"/makeleader [id][ORG id]");//if the command is misused it will tell them the correct way to use it
	    if(targetid != INVALID_PLAYER_ID)//checks if the id you type in is an id that is not connected to the server
	    {
	        PlayerInfo[targetid][pClan] = orgid; //sets the players faction to the faction you choose
	        PlayerInfo[targetid][pRank] = 2;//sets their rank to the highest rank
	        PlayerInfo[targetid][pLider] = orgid;//sets their leadership to the id of the faction
	        if(orgid == 1)//checks if the factionid typed was 1, and tells them they are the leader of the police below
	        {
				SendClientMessage(playerid, COLOR_WHITE,"[WW] {FF6600}Cestitamo postali ste Marshall");
			}
	    }
	}
	else //if the player is not an admin it will show the below message telling them they are not an admin.
	{
	    SendClientMessage(playerid, COLOR_WHITE,"[WW] {FF6600}Samo Admin");
	}
	return 1;
}
CMD:invite(playerid, params[])
{
	if(PlayerInfo[playerid][pLider] > 0 || PlayerInfo[playerid][pRank] >= 6)//checks if the player is the leader of a faction or a high rank in it
	{
		new tarid, orgid;//establishes a player in the server and a faction id for you to type in
		if(sscanf(params, "u", tarid)) return SendClientMessage(playerid, COLOR_RED, "> Koristi: /invite [playerid]");//if the command is not typed correctly, it will show you the correct way to use the command.
		orgid = PlayerInfo[playerid][pClan];//sets the faction the player is being invited to, as the faction the player that is inviting is in.
		SetPVarInt(tarid, "invitefac", orgid);//saves the invite, to /accept it
		SendClientMessage(tarid, COLOR_ORANGE, "Pozvani ste da se pridruzite organizaciji, koristi /acceptinvite da se pridruzis");//tells you that you have been invited to a faction
	}
	else //if you're not the correct rank it will display the message below stating that the player is not the rank to invite
	{
	    SendClientMessage(playerid, COLOR_WHITE,"[WW] {FF6600}Samo Marshall");
	}
	return 1;
}
CMD:acceptinvite(playerid, params[])
{

 	new orgid, string[128];//creates a faction id and some text on the players screen
	orgid = GetPVarInt(playerid, "invitefac");//calls the saved invite from the previous command
	PlayerInfo[playerid][pClan] = orgid; //sets the players faction to that of the person inviting.
	PlayerInfo[playerid][pRank] = 1;//sets the players faction rank to 1
	format(string, sizeof(string), "> Prihvatili ste poziv da se pridruzite organizaciji %d", orgid);//tells the player they have accepted the faction invite
	SendClientMessage(playerid, COLOR_CYAN, string);//shows the above message in the color of CYAN
	DeletePVar(playerid, "invitefac");//deletes the saved invite
	return 1;
}
CMD:uninvite(playerid,params[])
{
	if(PlayerInfo[playerid][pLider] > 0 || PlayerInfo[playerid][pRank] >= 5)//checks if the player is high enough rank to uninvite
	{
	    new targetid;//establishes a person to use the command on in the server
	    if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, COLOR_RED, "/uninvite [id]");//if the command is not typed correctly it will display how to do it the right way.
	    if(targetid != INVALID_PLAYER_ID)//checks if the id typed is an actual player on the server
	    {
			PlayerInfo[targetid][pClan] = 0;//uninvites the player from the faction
			PlayerInfo[targetid][pRank] = 0;//sets the players rank to 0
			PlayerInfo[targetid][pLider] = 0;//revokes leadership status
			SendClientMessage(targetid,COLOR_CYAN,"Izbaceni ste.");//states you've been kicked from the faction to the player the command is used on.
	    }
	}
	else //if the player is not the sufficient rank to uninvinte it will state that in the chat
	{
	    SendClientMessage(playerid, COLOR_WHITE,"[WW] {FF6600}Samo Marshall");
	}
	return 1;
}
CMD:gotospawn(playerid, params[])
{
     if(PlayerInfo[playerid][pAdmin] >= 1) //This is the line that define if the player is an admin or not, notice: the "!" is same as "if is not" (you can change with your enums);

	        {
    	      	SetPlayerPos(playerid, -391.7039,2274.1560,41.0381);
                SendClientMessage(playerid, COLOR_WHITE,"[WW] {FF6600}Teleportovali ste se do Spawna");
				 return 1;
			}
			else
			{
			    SendClientMessage(playerid, COLOR_WHITE,"[WW] {FF6600}Samo Admin");
			    return 1;
			}
	}
CMD:generalstore(playerid, params[])
	{
	ShowPlayerDialog(playerid, 5, DIALOG_STYLE_LIST, "General Store", ">>Deagle\n>>Shotgun\n>>Noz\n>>Country Rifle{640000}", "Buy", "Cancel");
	return 1;
}
CMD:slap(playerid, params[])
{
	new id, string[126], Float: PPos[3];
    if(PlayerInfo[playerid][pAdmin] >= 1)
	if(sscanf(params, "u", id))
        return SendClientMessage(playerid, COLOR_WHITE,"[WW] Koristi: {FF6600}/slap [id]");

    GetPlayerPos(id, PPos[0], PPos[1], PPos[2]);
    SetPlayerPos(id, PPos[0], PPos[1], PPos[2]+4);

    format(string, sizeof(string), "Slap %s", GetName(id));
    SendClientMessage(playerid, -1, string);
    return 1;
}
CMD:sethp(playerid, params[])
{
new player2, Float:health;
if(sscanf(params, "uf", player2, health)) SendClientMessage(playerid, COLOR_WHITE, "[USAGE]:/sethp <playerid> <health>");
else if(!IsPlayerConnected(player2)) SendClientMessage(playerid, COLOR_WHITE, "Invalid Player.");
else
{
SetPlayerHealth(player2, health);
SendClientMessage(playerid, COLOR_WHITE, "Player Health Set.");
SendClientMessage(player2 , COLOR_WHITE, "Your health has been set.");
return 1;
}
return 1;
}
//----------------//
// 		KOMANDE    //
//--------------//
CMD:help(playerid, params[]) {
	ShowPlayerDialog(playerid, 5, DIALOG_STYLE_MSGBOX, "Komande Wild West", "/help /paymute /stats /generalstore", "OK", "Cancel");
		return 1;
}
//---------------//
// VIP KOMANDE  //
//-------------//
CMD:makevip(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] == 5)
	{
	    new targetid, vlevel;
	    if(sscanf(params,"ui",targetid, vlevel)) return SendClientMessage(playerid, COLOR_WHITE,"[WW] {FF6600}/makevip [id][Vip Level]");
	    if(targetid != INVALID_PLAYER_ID)
	    {
	        PlayerInfo[targetid][pVip] = vlevel;
	        if(vlevel == 1)
	        {
				SendClientMessage(playerid, COLOR_WHITE,"[WW] {#ffffff} Cestitamo! Promovisani ste na Bronzanog VIP-a");
			}
	    }
	}
	else
	{
	    SendClientMessage(playerid, COLOR_RED, "Samo Admini.");
	}
	return 1;
}
