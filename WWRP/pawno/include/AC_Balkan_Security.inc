/*AC-Balkan Security v0.6 by Maki187 (Marko_Dimitrijevic)
http://www.balkan-rising.info/index.php?topic=10.0

http://balkan-samp.com/forum/index.php?topic=35102.0
Zamolio bi vas da ne menjate i neskalnjate creditse u skripti, sve ispod ovog teksta niposto nesmete da menjate,
odnosno ako promenite rizikujete da AC neradi!!*/
#include <a_players>
#include <foreach>
stock AC_BS_ResetPlayerMoney(playerid)
{
	ResetPlayerMoney(playerid);
	SetPVarInt(playerid, "SiguranNovac", 1);
	return 1;
}
stock AC_BS_GivePlayerMoney(playerid, novac)
{
	GivePlayerMoney(playerid, novac);
	SetPVarInt(playerid, "SiguranNovac", 1);
	return 1;
}
stock AC_BS_SetPlayerVirtualWorld(playerid, vw)
{
	SetPVarFloat(playerid,"ZastitaTeleporta",1);
	SetPlayerVirtualWorld(playerid,vw);
	SetPVarInt(playerid, "SiguranVW", vw);
	return 1;
}
stock AC_BS_SetPlayerInterior(playerid, intid)
{
	SetPVarFloat(playerid,"ZastitaTeleporta",1);
	SetPlayerInterior(playerid, intid);
	SetPVarInt(playerid, "SiguranInt", intid);
	return 1;
}
stock AC_BS_SetPlayerPos(playerid, Float:xx, Float:yy, Float:zz)
{
	SetPVarFloat(playerid,"ZastitaTeleporta",1);
	SetPlayerPos(playerid, xx,yy,zz);
	SetPVarInt(playerid, "SiguranTeleport", 1);
	return 1;
}
#define acime "[AC-Balkan Security]:"
stock AC_BS_SetPlayerHealth(playerid,Float:helti)
{
	SetPVarFloat(playerid,"ZastitaHelta",1);
	SetPlayerHealth(playerid,helti);
	SetPVarFloat(playerid,"SigurniHelti",helti);
}
stock AC_BS_SetPlayerArmour(playerid,Float:armor)
{
	SetPVarFloat(playerid,"ZastitaArmora",1);
	SetPlayerArmour(playerid,armor);
	SetPVarFloat(playerid,"SigurniArmor",armor);
}
stock AC_BS_PutPlayerInVehicle(playerid, vozilo, sediste)
{
	SetPVarFloat(playerid,"ZastitaTeleporta",1);
	PutPlayerInVehicle(playerid, vozilo, sediste);
	SetPVarInt(playerid, "SiguranTeleport", 1);
}
stock AC_BS_SetVehicleToRespawn(idvozila)
{
    	foreach(Player, i)
    	{
    	    	new idvoz = GetPlayerVehicleID(i);
    	    	if(idvoz == idvozila)
    	    	{
	    	    	SetPVarInt(i, "PopravkaVozila", 1);
	    	    	SetVehicleToRespawn(idvozila);
	    	    	SetPVarInt(i, "PopravkaVozila", 1);
	    	    	return 1;
    	    	}
    	}
}

#define ACCREDITS SendClientMessage(playerid,BELA, "Ovaj server koristi AntiCheat by: Maki187 (Marko_Dimitrijevic)");
/*SVA PRAVA ZADRZANA, www.balkan-rising.info (c) 2011-2012
Koriscenjem ovog AC-a slazete se sa tim da za sve gubitke koji nastanu na vasem serveru, nije kriv autor ovog AC-a!*/