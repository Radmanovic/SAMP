/*
        @Release:               GetVehicleColor
        @Release Type:  Include
        @Author:                RyDeR`
        @Last Update:   05/03/2011 - 17:49
        @Version:               2.0
*/
 
stock __ChangeVehicleColor(vehicleid, color1, color2)
{
        new
                string[16]
        ;
        format(string, sizeof(string), "%d-%d", color1, color2);
        setproperty(0, "", ((vehicleid * (vehicleid * 2)) / 2) + 65536, string);
       
        return ChangeVehicleColor(vehicleid, color1, color2);
}
 
public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
        new
                string[16]
        ;
        format(string, sizeof(string), "%d-%d", color1, color2);
        setproperty(0, "", ((vehicleid * (vehicleid * 2)) / 2) + 65536, string);
       
        if(funcidx("__OnVehicleRespray") != -1)
        {
                return CallLocalFunction("__OnVehicleRespray", "iiii", playerid, vehicleid, color1, color2);
        }
        return 1;
}
 
stock GetVehicleColor(vehicleid, &color1, &color2)
{
        if(existproperty(0, "", ((vehicleid * (vehicleid * 2)) / 2) + 65536))
        {
                new
                        string[16],
                        stringParts[2][8],
                        index
                ;
                getproperty(0, "", ((vehicleid * (vehicleid * 2)) / 2) + 65536, string);
                strunpack(string, string);
               
                if((index = strfind(string, "-", false)) != -1)
                {
                        strmid(stringParts[0], string, 0, index);
                        strmid(stringParts[1], string, (index + 1), strlen(string));
                       
                        color1 = strval(stringParts[0]);
                        color2 = strval(stringParts[1]);
                        return 1;
                }
        }
        return 0;
}
       
#define ChangeVehicleColor \
        __ChangeVehicleColor
       
#if defined _ALS_OnVehicleRespray
        #undef OnVehicleRespray
#else
        #define _ALS_OnVehicleRespray
#endif
 
#define OnVehicleRespray \
        __OnVehicleRespray
       
forward __OnVehicleRespray(playerid, vehicleid, color1, color2);