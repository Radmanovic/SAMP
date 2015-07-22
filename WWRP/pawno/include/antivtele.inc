// Tesztelt, mûködõ anti jármû teleport include.
// Ne felejtsd el az OnGameModeInit alá berakni: Antitele_Init();
// Hackermentes játékot!
// © Sramm 2013


#if defined _antivtele_included
	#endinput
#endif
#define _antivtele_included

native IsValidVehicle(vehicleid);
new Float:vcPos[4][MAX_VEHICLES];
new Float:vaPos[4][MAX_VEHICLES];

forward AntiVeh();
forward AntiTeleFunction(vehicleid);

stock new_CreateVehicle(modelid, Float:x, Float:y, Float:z, Float:angle, color1, color2, respawn_delay = 60000)
{
	new veh = CreateVehicle(modelid, x, y, z, angle, color1, color2, respawn_delay);
	vcPos[0][veh] = x;
	vcPos[1][veh] = y;
	vcPos[2][veh] = z;
	vaPos[0][veh] = x;
	vaPos[1][veh] = y;
	vaPos[2][veh] = z;
	vaPos[3][veh] = angle;
	vcPos[3][veh] = angle;
	return veh;
}

#define CreateVehicle new_CreateVehicle

stock new_AddStaticVehicle(modelid, Float:x, Float:y, Float:z, Float:angle, color1, color2)
{
	new veh = AddStaticVehicle(modelid, x, y, z, angle, color1, color2);
	vcPos[0][veh] = x;
	vcPos[1][veh] = y;
	vcPos[2][veh] = z;
	vaPos[0][veh] = x;
	vaPos[1][veh] = y;
	vaPos[2][veh] = z;
	vaPos[3][veh] = angle;
	vcPos[3][veh] = angle;
	return veh;
}

#define AddStaticVehicle new_AddStaticVehicle

stock new_AddStaticVehicleEx(modelid, Float:x, Float:y, Float:z, Float:angle, color1, color2, respawn_delay = 60000)
{
	new veh = AddStaticVehicleEx(modelid, x, y, z, angle, color1, color2, respawn_delay);
	vcPos[0][veh] = x;
	vcPos[1][veh] = y;
	vcPos[2][veh] = z;
	vaPos[0][veh] = x;
	vaPos[1][veh] = y;
	vaPos[2][veh] = z;
	vaPos[3][veh] = angle;
	vcPos[3][veh] = angle;
	return veh;
}

#define AddStaticVehicleEx new_AddStaticVehicleEx

stock new_SetVehiclePos(veh, Float:x, Float:y, Float:z)
{
    vcPos[0][veh] = x;
	vcPos[1][veh] = y;
	vcPos[2][veh] = z;
    SetVehiclePos(veh, x, y, z);
	return 1;
}

#define SetVehiclePos new_SetVehiclePos

stock new_SetVehicleZAngle(veh, Float:angle)
{
    vcPos[3][veh] = angle;
    SetVehicleZAngle(veh, angle);
    return 1;
}

#define SetVehicleZAngle new_SetVehicleZAngle

stock new_SetVehicleToRespawn(vid)
{
    vcPos[0][vid] = vaPos[0][vid];
	vcPos[1][vid] = vaPos[1][vid];
	vcPos[2][vid] = vaPos[2][vid];
	vcPos[3][vid] = vaPos[3][vid];
	SetVehiclePos(vid,vaPos[0][vid],vaPos[1][vid],vaPos[2][vid]);
	SetVehicleZAngle(vid,vaPos[3][vid]);
	return 1;
}

#define SetVehicleToRespawn new_SetVehicleToRespawn

stock Antitele_Init()
{
	SetTimer("AntiVeh",200,1);
	return 1;
}

public AntiVeh()
{
	for(new v = 1; v<MAX_VEHICLES; v++)
	{
	    if(IsValidVehicle(v))
	    {
	        CallRemoteFunction("AntiTeleFunction","i",v);
		}
	}
	return 1;
}

stock IsVehicleInRangeOfPoint(vehicleid, Float:radi, Float:x, Float:y, Float:z)
{
	new Float:oldposx, Float:oldposy, Float:oldposz;
	new Float:tempposx, Float:tempposy, Float:tempposz;
	GetVehiclePos(vehicleid, oldposx, oldposy, oldposz);
	tempposx = (oldposx -x);
	tempposy = (oldposy -y);
	tempposz = (oldposz -z);
	if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
	{
		return 1;
	}
	return 0;
}

public AntiTeleFunction(vehicleid) // Tudom, hogy van rá függvény, de azzal vmiért nem hajlandó lefutni.
{
    new Float:vpos_x, Float:vpos_y, Float:vpos_z, Float:vpos_a;
    GetVehiclePos(vehicleid, vpos_x, vpos_y, vpos_z); GetVehicleZAngle(vehicleid,vpos_a);
	if(!IsVehicleInRangeOfPoint(vehicleid, 15.0, vcPos[0][vehicleid], vcPos[1][vehicleid], vcPos[2][vehicleid]))
	{
	    SetVehiclePos(vehicleid,vcPos[0][vehicleid], vcPos[1][vehicleid], vcPos[2][vehicleid]);
	    SetVehicleZAngle(vehicleid, vcPos[3][vehicleid]);
	}
	else
	{
		vcPos[0][vehicleid] = vpos_x;
		vcPos[1][vehicleid] = vpos_y;
		vcPos[2][vehicleid] = vpos_z;
		vcPos[3][vehicleid] = vpos_a;
	}
	return 1;
}

