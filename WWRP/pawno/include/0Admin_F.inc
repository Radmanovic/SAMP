/*******************************************************************************
	0Admin Include.

	Released on: 16. May. 2011

********************************************************************************/

#if defined _0Utils_inc
	#endinput
#endif

#define _0Utils_inc
#include YSI/y_hooks

/*
	native GetPlayerLevel(playerid);
	native GetPlayerLevelName(playerid);
	native GetPlayerVip(playerid);
	native GetPlayerKills(playerid);
	native GetPlayerDeaths(playerid);
	native GetPlayerCookies(playerid);
	native GetPlayerGod(playerid);
	native GetPlayerCarGod(playerid);
	native GetPlayerBooost(playerid);
	native GetPlayerNegativeRespect(playerid);
	native GetPlayerPositiveRespect(playerid);
	native SetPlayerLevel(playerid, level);
	native SetPlayerVip(playerid, viplevel);
	native SetPlayerKills(playerid, kills);
	native SetPlayerDeaths(playerid, deaths);
	native SetPlayerCookies(playerid, cookies);
	native SetPlayerNegativeRespect(playerid, respect);
	native SetPlayerPositiveRespect(playerid, respect);
	native SetPlayerRank(playerid, rank);
	native TogglePlayerBoost(playerid, bool:toggle);
	native TogglePlayerGod(playerid, bool:toggle);
	native TogglePlayerVehicleGod(playerid, bool:toggle);
*/

new
	_0A_INI[ 11 ][ ] =
	{
		{   "0_Level"		},
		{   "0_Vip"			},
		{   "0_Kills"		},
		{   "0_Deaths"		},
		{   "0_Cookies"		},
		{   "0_God"			},
		{   "0_CarGod"		},
		{   "0_Negative"	},
		{   "0_Positive"	},
		{   "0_Rank"		},
		{   "0_Boost"		}
	},
	DB:a_0_DB
;


stock GetPlayerLevel(playerid)				return GetPVarInt( playerid, _0A_INI[ 0 ] );
stock GetPlayerVip(playerid)				return GetPVarInt( playerid, _0A_INI[ 1 ] );
stock GetPlayerKills(playerid)				return GetPVarInt( playerid, _0A_INI[ 2 ] );
stock GetPlayerDeaths(playerid)				return GetPVarInt( playerid, _0A_INI[ 3 ] );
stock GetPlayerCookies(playerid)			return GetPVarInt( playerid, _0A_INI[ 4 ] );
stock GetPlayerGod(playerid)				return GetPVarInt( playerid, _0A_INI[ 5 ] );
stock GetPlayerCarGod(playerid)				return GetPVarInt( playerid, _0A_INI[ 6 ] );
stock GetPlayerNegativeRespect(playerid)	return GetPVarInt( playerid, _0A_INI[ 7 ] );
stock GetPlayerPositiveRespect(playerid)	return GetPVarInt( playerid, _0A_INI[ 8 ] );
stock GetPlayerRank(playerid)				return GetPVarInt( playerid, _0A_INI[ 9 ] );
stock GetPlayerBoost(playerid)				return GetPVarInt( playerid, _0A_INI[ 10 ] );

#if defined FILTERSCRIPT
Hook:a_OnFilterScriptInit()
{
    	a_0_DB = db_open("0Admin/Database.db");
	return 1;
}
Hook:a_OnFilterScriptExit()
{
	db_close(a_0_DB);
	return 1;
}
#else
Hook:a_OnGameModeInit()
{
	a_0_DB = db_open("0Admin/Database.db");
	return 1;
}
Hook:a_OnGameModeExit()
{
	db_close(a_0_DB);
	return 1;
}
#endif

stock db_Account(account[])
{
	new Buffer[240], bool:Entry, DBResult:Result;

	format(Buffer, sizeof(Buffer), "SELECT `Key` FROM `Accounts` WHERE `Name` = '%s'", account);
	Result = db_query(a_0_DB, Buffer);

	if(Result)
	{
		if(db_num_rows(Result))
		{
			Entry = true;
			db_free_result(Result);
		}
		else Entry = false;
	}
	return Entry;
}
stock db_Insert(account[], column[], int)
{
	new Query[100];
	format(Query, 100, "UPDATE `Accounts` SET `%s` = '%d' WHERE `Name` = '%s'", column, int, account);
	db_query(a_0_DB, Query);
}

stock SetPlayerLevel(playerid, level)
{
	if ( level < 0 ) level = 0;
	if ( level > 5 ) level = 5;
	SetPVarInt( playerid, _0A_INI[ 0 ], level );

	if(db_Account(__Name(playerid))){
	    db_Insert(__Name(playerid), "Level", level);
	}
	return true;
}
stock SetPlayerVip(playerid, viplevel)
{
	if ( viplevel < 0 ) viplevel = 0;
	if ( viplevel > 3 ) viplevel = 3;
	SetPVarInt( playerid, _0A_INI[ 1 ], viplevel );

	if(db_Account(__Name(playerid))){
	    db_Insert(__Name(playerid), "VIP", viplevel );
	}
	return true;
}
stock SetPlayerKills(playerid, kills)
{
	if ( kills < 0 ) kills = 0;
	SetPVarInt( playerid, _0A_INI[ 2 ], kills );

	if(db_Account(__Name(playerid))){
	    db_Insert(__Name(playerid), "Kills", kills);
	}
	return true;
}
stock SetPlayerDeaths(playerid, deaths)
{
	if ( deaths < 0 ) deaths = 0;
	SetPVarInt( playerid, _0A_INI[ 3 ], deaths );

	if(db_Account(__Name(playerid))){
	    db_Insert(__Name(playerid), "Deaths", deaths);
	}
	return true;
}
stock SetPlayerCookies(playerid, cookies)
{
	if ( cookies < 0 ) cookies = 0;
	SetPVarInt( playerid, _0A_INI[ 4 ], cookies );

	if(db_Account(__Name(playerid))){
	    db_Insert(__Name(playerid), "Cookies", cokies);
	}
	return true;
}
stock TogglePlayerVehicleGod(playerid, bool:toggle)
{
	SetPVarInt( playerid, _0A_INI[ 5 ], toggle );

	if(db_Account(__Name(playerid))){
	    db_Insert(__Name(playerid), "CarGod", toggle);
	}
	return true;
}
stock TogglePlayerGod(playerid, bool:toggle)
{
	SetPVarInt( playerid, _0A_INI[ 6 ], toggle );

	if(db_Account(__Name(playerid))){
	    db_Insert(__Name(playerid), "God", toggle);
	}
	return true;
}
stock SetPlayerNegativeRespect(playerid, respect)
{
	if ( respect < 0 ) respect = 0;
	SetPVarInt( playerid, _0A_INI[ 7 ], respect );

	if(db_Account(__Name(playerid))){
	    db_Insert(__Name(playerid), "Negative", respect);
	}
	return true;
}
stock SetPlayerPositiveRespect(playerid, respect)
{
	if ( respect < 0 ) respect = 0;
	SetPVarInt( playerid, _0A_INI[ 8 ], respect );

	if(db_Account(__Name(playerid))){
	    db_Insert(__Name(playerid), "Positive", respect);
	}
	return true;
}
stock SetPlayerRank(playerid, rank)
{
	if ( rank < 0 ) rank = 0;
	if ( rank > 11 ) rank = 11;
	SetPVarInt( playerid, _0A_INI[ 9 ], rank );

	if(db_Account(__Name(playerid))){
	    db_Insert(__Name(playerid), "Rank", rank);
	}
	return true;
}
stock TogglePlayerBoost(playerid, bool:toggle)
{
	SetPVarInt( playerid, _0A_INI[ 10 ], toggle );

	if(db_Account(__Name(playerid))){
	    db_Insert(__Name(playerid), "Boost", toggle);
	}
	return true;
}
__Name(p)
{
	new __Name_[24];
	GetPlayerName(p, __Name_, 24);
	return __Name_;
}