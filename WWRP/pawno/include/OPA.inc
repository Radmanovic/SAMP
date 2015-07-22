/*
	OnPlayerAirbreak(playerid);

	This include is one of the only accurate airbreak detecting
	methods developed in SA-MP.

	Created by Emmet on Wednesday, November 6, 2013.
*/
#include <a_samp>

static stock
	Float:g_abLastPosition[MAX_PLAYERS][3],
	g_abLastTick[MAX_PLAYERS],
	g_abPosTick[MAX_PLAYERS],
	g_abDetected[MAX_PLAYERS],
	g_abResetTimer[MAX_PLAYERS]
;

forward AB_ResetDetected(playerid);
public AB_ResetDetected(playerid)
{
	g_abDetected[playerid] = 0;
	g_abResetTimer[playerid] = -1;
}

public OnFilterScriptInit()
{
	for (new i = 0, j = GetMaxPlayers(); i != j; i ++)
	{
		if (!IsPlayerConnected(i) || GetPlayerState(i) != PLAYER_STATE_ONFOOT)
			continue;

		g_abLastTick[i] = gettime();
	}
	#if defined AB_OnFilterScriptInit
	    AB_OnFilterScriptInit();
	#endif
	return 1;
}

public OnPlayerConnect(playerid)
{
    g_abDetected[playerid] = 0;
    g_abResetTimer[playerid] = -1;
	g_abLastTick[playerid] = gettime() + 3;

	#if defined AB_OnPlayerConnect
	    AB_OnPlayerConnect(playerid);
	#endif
	return 1;
}

public OnPlayerSpawn(playerid)
{
    g_abDetected[playerid] = 0;
    g_abLastTick[playerid] = gettime() + 3;

	#if defined AB_OnPlayerSpawn
	    AB_OnPlayerSpawn(playerid);
	#endif
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	g_abLastTick[playerid] = gettime() + 3;

	#if defined AB_OnPlayerDeath
	    AB_OnPlayerDeath(playerid, killerid, reason);
	#endif
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	g_abLastTick[playerid] = gettime() + 3;

	#if defined AB_OnPlayerStateChange
	    AB_OnPlayerStateChange(playerid, newstate, oldstate);
	#endif
	return 1;
}

public OnPlayerUpdate(playerid)
{
	AB_Detect(playerid);

	#if defined AB_OnPlayerUpdate
	    AB_OnPlayerUpdate(playerid);
	#endif
	return 1;
}

stock static AB_Detect(playerid)
{
	static playerState;

	playerState = GetPlayerState(playerid);

	if (playerState == 0 || playerState == 2 || playerState == 3 || playerState == 7 || playerState == 9)
	{
	    g_abLastTick[playerid] = gettime() + 1;
	}
	else if (!IsPlayerInAnyVehicle(playerid) && !IsPlayerNPC(playerid) && GetPlayerSurfingVehicleID(playerid) == INVALID_VEHICLE_ID)
	{
		if (gettime() > g_abLastTick[playerid])
		{
			static
				Float:x,
				Float:y,
				Float:z,
				Float:distance;

			GetPlayerPos(playerid, x, y, z);

		    if (floatabs(g_abLastPosition[playerid][2] - z) < 1.0)
		    {
				distance = GetPlayerDistanceFromPoint(playerid, g_abLastPosition[playerid][0], g_abLastPosition[playerid][1], g_abLastPosition[playerid][2]);

				if (floatabs(distance) >= 75.0 && (floatabs(g_abLastPosition[playerid][1] - y) >= 50.0 || floatabs(g_abLastPosition[playerid][0] - x) >= 50.0))
				{
				    if (++g_abDetected[playerid] >= 3)
						CallLocalFunction("OnPlayerAirbreak", "d", playerid);

					if (g_abResetTimer[playerid] == -1)
					    g_abResetTimer[playerid] = SetTimerEx("AB_ResetDetected", 60000, false, "d", playerid);
				}
		    }
		    g_abLastTick[playerid] = gettime();
		}
		if (gettime() > g_abPosTick[playerid])
		{
		    g_abPosTick[playerid] = gettime();
	        GetPlayerPos(playerid, g_abLastPosition[playerid][0], g_abLastPosition[playerid][1], g_abLastPosition[playerid][2]);
		}
	}
	return 1;
}

stock AB_SetPlayerPos(playerid, Float:x, Float:y, Float:z)
{
	g_abLastTick[playerid] = gettime() + 3;
	return SetPlayerPos(playerid, x, y, z);
}

stock AB_PutPlayerInVehicle(playerid, vehicleid, seatid)
{
	g_abLastTick[playerid] = gettime() + 3;
	return PutPlayerInVehicle(playerid, vehicleid, seatid);
}

stock AB_SetPlayerPosFindZ(playerid, Float:x, Float:y, Float:z)
{
    g_abLastTick[playerid] = gettime() + 3;
	return SetPlayerPosFindZ(playerid, x, y, z);
}

#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif

#if defined _ALS_OnPlayerSpawn
	#undef OnPlayerSpawn
 #else
	#define _ALS_OnPlayerSpawn
#endif

#if defined _ALS_OnPlayerDeath
	#undef OnPlayerDeath
#else
	#define _ALS_OnPlayerDeath
#endif

#if defined _ALS_OnPlayerUpdate
	#undef OnPlayerUpdate
#else
	#define _ALS_OnPlayerUpdate
#endif

#if defined _ALS_OnFilterScriptInit
	#undef OnFilterScriptInit
#else
	#define _ALS_OnFilterScriptInit
#endif

#if defined _ALS_SetPlayerPos
	#undef SetPlayerPos
#else
	#define _ALS_SetPlayerPos
#endif

#if defined _ALS_SetPlayerPosFindZ
	#undef SetPlayerPosFindZ
#else
	#define _ALS_SetPlayerPosFindZ
#endif

#if defined _ALS_PutPlayerInVehicle
	#undef PutPlayerInVehicle
#else
	#define _ALS_PutPlayerInVehicle
#endif

#if defined _ALS_OnPlayerStateChange
	#undef OnPlayerStateChange
#else
	#define _ALS_OnPlayerStateChange
#endif

#define OnPlayerConnect 	AB_OnPlayerConnect
#define OnPlayerSpawn 		AB_OnPlayerSpawn
#define OnPlayerDeath 		AB_OnPlayerDeath
#define OnPlayerUpdate 		AB_OnPlayerUpdate
#define OnFilterScriptInit  AB_OnFilterScriptInit
#define OnPlayerStateChange	AB_OnPlayerStateChange

#define SetPlayerPos        AB_SetPlayerPos
#define SetPlayerPosFindZ   AB_SetPlayerPosFindZ
#define PutPlayerInVehicle  AB_PutPlayerInVehicle

#if defined AB_OnFilterScriptInit
	forward AB_OnFilterScriptInit();
#endif

#if defined AB_OnPlayerConnect
	forward AB_OnPlayerConnect(playerid);
#endif

#if defined AB_OnPlayerSpawn
	forward AB_OnPlayerSpawn(playerid);
#endif

#if defined AB_OnPlayerUpdate
	forward AB_OnPlayerUpdate(playerid);
#endif

#if defined AB_OnPlayerDeath
	forward AB_OnPlayerDeath(playerid, killerid, reason);
#endif

#if defined AB_OnPlayerStateChange
	forward AB_OnPlayerStateChange(playerid, newstate, oldstate);
#endif

forward OnPlayerAirbreak(playerid);