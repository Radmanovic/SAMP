// Include
#include <a_samp>

stock GetPlayerGiftFounds(playerid)
{
	return CallRemoteFunction("GetPlayerGiftFounds", "i", playerid);
}

stock GetPlayerGiftReceiveds(playerid)
{
	return CallRemoteFunction("GetPlayerGiftReceiveds", "i", playerid);
}
