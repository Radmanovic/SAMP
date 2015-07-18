/*

***********************************************
********** Wild West Rolepaly ***************
***********************************************

Original credits to Jack Leslie.
Edit by: Nikola Radmanovic
*/
// [PRAGMAS] //
#pragma unused TaxiJob
// [Main Includes] //
#include <a_samp>
#include <sscanf2>
#include <streamer>
#include <foreach>
#define YSI_NO_MASTER
#include <YSI\y_commands>
#include <YSI\y_ini>
// [Dialog Define] //
#define DIALOG_PASS   	DIALOG_STYLE_INPUT
#define DIALOG_LIST 	DIALOG_STYLE_LIST
#define DIALOG_INFO     DIALOG_STYLE_MSGBOX
#define DIALOG_INPUT    DIALOG_STYLE_INPUT
#define ShowDialog  	ShowPlayerDialog
// [Color Defines] //
#define NEWBIE_COLOR 		0x7DAEFFFF
#define TCOLOR_WHITE 		0xFFFFFF00
#define COLOR_GRAD1 		0xB4B5B7FF
#define COLOR_GRAD2 		0xBFC0C2FF
#define COLOR_GRAD3 		0xCBCCCEFF
#define COLOR_GRAD4 		0xD8D8D8FF
#define COLOR_GRAD5 		0xE3E3E3FF
#define COLOR_GRAD6 		0xF0F0F0FF
#define COLOR_FADE1 		0xE6E6E6E6
#define COLOR_FADE2 		0xC8C8C8C8
#define COLOR_FADE3 		0xAAAAAAAA
#define COLOR_FADE4 		0x8C8C8C8C
#define COLOR_FADE5 		0x6E6E6E6E
#define COLOR_PURPLE 		0xC2A2DAAA
#define COLOR_RED 			0xAA3333AA
#define COLOR_GREY 			0xAFAFAFAA
#define COLOR_GREEN 		0x33AA33AA
#define COLOR_BLACK         0x000001FF
#define COLOR_BLUE 			0x007BD0FF
#define COLOR_LIGHTORANGE 	0xFFA100FF
#define COLOR_FLASH 		0xFF000080
#define COLOR_LIGHTRED 		0xFF6347AA
#define COLOR_LIGHTBLUE 	0x33CCFFAA
#define COLOR_LIGHTGREEN 	0x9ACD32AA
#define COLOR_YELLOW 		0xFFFF00AA
#define COLOR_LIGHTYELLOW	0xFFFF91FF
#define COLOR_YELLOW2 		0xF5DEB3AA
#define COLOR_WHITE 		0xFFFFFFAA
// [new Defines] //
new TaxiJob;
new BigEar[MAX_PLAYERS];
new CreatedCars[MAX_VEHICLES] = {INVALID_VEHICLE_ID, ...};
new gPlayerLoggedIn[MAX_PLAYERS];
new PlayerSpectating[MAX_PLAYERS];
new noooc = 0;
new KnowsIt[MAX_PLAYERS];
new gLastCar[MAX_PLAYERS];
new vehName[][] =
{
    "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster",
    "Stretch", "Manana", "Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
    "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer",
    "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach",
    "Cabbie", "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo", "Seasparrow",
    "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair",
    "Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic",
    "Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton",
    "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper", "Rancher",
    "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "Blista Compact", "Police Maverick",
    "Boxville", "Benson", "Mesa", "RC Goblin", "Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher",
    "Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt", "Tanker", "Roadtrain",
    "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck",
    "Fortune", "Cadrona", "SWAT Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan",
    "Blade", "Streak", "Freight", "Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder",
    "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite", "Windsor", "Monster", "Monster",
    "Uranus", "Jester", "Sultan", "Stratium", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
    "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30",
    "Huntley", "Stafford", "BF-400", "News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
    "Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "LSPD Car", "SFPD Car", "LVPD Car",
    "Police Rancher", "Picador", "S.W.A.T", "Alpha", "Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs",
    "Boxville", "Tiller", "Utility Trailer"
};
// [Vehicles] //


// [Objects] //


// [Forwards] //
forward RestartGamemode();
forward SavePlayer(playerid);
forward UnfreezeBastard(playerid);
forward ClearScreen(playerid);
forward AMessage(color, const string[]);
forward HelperMessage(color, const string[]);
forward DeveloperMessage(color, const string[]);
forward split(const strsrc[], strdest[][], delimiter);
forward LoadHouses();
forward SaveHouses();
forward SaveCars();
forward LoadCar();
forward LoadDCars();
// [Defines] //
#define SetPlayerHoldingObject(%1,%2,%3,%4,%5,%6,%7,%8,%9) SetPlayerAttachedObject(%1,MAX_PLAYER_ATTACHED_OBJECTS-1,%2,%3,%4,%5,%6,%7,%8,%9)
#define StopPlayerHoldingObject(%1) RemovePlayerAttachedObject(%1,MAX_PLAYER_ATTACHED_OBJECTS-1)
#define IsPlayerHoldingObject(%1) IsPlayerAttachedObjectSlotUsed(%1,MAX_PLAYER_ATTACHED_OBJECTS-1)
#define MAX_ZONE_NAME 28
// [Zone] //
enum SAZONE_MAIN
{
    SAZONE_NAME[28],
    Float:SAZONE_AREA[6]
};

static const gSAZones[][SAZONE_MAIN] = {

	{"The Big Ear",	                {-410.00,1403.30,-3.00,-137.90,1681.20,200.00}},
	{"Aldea Malvada",               {-1372.10,2498.50,0.00,-1277.50,2615.30,200.00}},
	{"Angel Pine",                  {-2324.90,-2584.20,-6.10,-1964.20,-2212.10,200.00}},
	{"Arco del Oeste",              {-901.10,2221.80,0.00,-592.00,2571.90,200.00}},
	{"Avispa Country Club",         {-2646.40,-355.40,0.00,-2270.00,-222.50,200.00}},
	{"Avispa Country Club",         {-2831.80,-430.20,-6.10,-2646.40,-222.50,200.00}},
	{"Avispa Country Club",         {-2361.50,-417.10,0.00,-2270.00,-355.40,200.00}},
	{"Avispa Country Club",         {-2667.80,-302.10,-28.80,-2646.40,-262.30,71.10}},
	{"Avispa Country Club",         {-2470.00,-355.40,0.00,-2270.00,-318.40,46.10}},
	{"Avispa Country Club",         {-2550.00,-355.40,0.00,-2470.00,-318.40,39.70}},
	{"Back o Beyond",               {-1166.90,-2641.10,0.00,-321.70,-1856.00,200.00}},
	{"Battery Point",               {-2741.00,1268.40,-4.50,-2533.00,1490.40,200.00}},
	{"Bayside",                     {-2741.00,2175.10,0.00,-2353.10,2722.70,200.00}},
	{"Bayside Marina",              {-2353.10,2275.70,0.00,-2153.10,2475.70,200.00}},
	{"Beacon Hill",                 {-399.60,-1075.50,-1.40,-319.00,-977.50,198.50}},
	{"Blackfield",                  {964.30,1203.20,-89.00,1197.30,1403.20,110.90}},
	{"Blackfield",                  {964.30,1403.20,-89.00,1197.30,1726.20,110.90}},
	{"Blackfield Chapel",           {1375.60,596.30,-89.00,1558.00,823.20,110.90}},
	{"Blackfield Chapel",           {1325.60,596.30,-89.00,1375.60,795.00,110.90}},
	{"Blackfield Intersection",     {1197.30,1044.60,-89.00,1277.00,1163.30,110.90}},
	{"Blackfield Intersection",     {1166.50,795.00,-89.00,1375.60,1044.60,110.90}},
	{"Blackfield Intersection",     {1277.00,1044.60,-89.00,1315.30,1087.60,110.90}},
	{"Blackfield Intersection",     {1375.60,823.20,-89.00,1457.30,919.40,110.90}},
	{"Blueberry",                   {104.50,-220.10,2.30,349.60,152.20,200.00}},
	{"Blueberry",                   {19.60,-404.10,3.80,349.60,-220.10,200.00}},
	{"Blueberry Acres",             {-319.60,-220.10,0.00,104.50,293.30,200.00}},
	{"Caligula's Palace",           {2087.30,1543.20,-89.00,2437.30,1703.20,110.90}},
	{"Caligula's Palace",           {2137.40,1703.20,-89.00,2437.30,1783.20,110.90}},
	{"Calton Heights",              {-2274.10,744.10,-6.10,-1982.30,1358.90,200.00}},
	{"Chinatown",                   {-2274.10,578.30,-7.60,-2078.60,744.10,200.00}},
	{"City Hall",                   {-2867.80,277.40,-9.10,-2593.40,458.40,200.00}},
	{"Come-A-Lot",                  {2087.30,943.20,-89.00,2623.10,1203.20,110.90}},
	{"Commerce",                    {1323.90,-1842.20,-89.00,1701.90,-1722.20,110.90}},
	{"Commerce",                    {1323.90,-1722.20,-89.00,1440.90,-1577.50,110.90}},
	{"Commerce",                    {1370.80,-1577.50,-89.00,1463.90,-1384.90,110.90}},
	{"Commerce",                    {1463.90,-1577.50,-89.00,1667.90,-1430.80,110.90}},
	{"Commerce",                    {1583.50,-1722.20,-89.00,1758.90,-1577.50,110.90}},
	{"Commerce",                    {1667.90,-1577.50,-89.00,1812.60,-1430.80,110.90}},
	{"Conference Center",           {1046.10,-1804.20,-89.00,1323.90,-1722.20,110.90}},
	{"Conference Center",           {1073.20,-1842.20,-89.00,1323.90,-1804.20,110.90}},
	{"Cranberry Station",           {-2007.80,56.30,0.00,-1922.00,224.70,100.00}},
	{"Creek",                       {2749.90,1937.20,-89.00,2921.60,2669.70,110.90}},
	{"Dillimore",                   {580.70,-674.80,-9.50,861.00,-404.70,200.00}},
	{"Doherty",                     {-2270.00,-324.10,-0.00,-1794.90,-222.50,200.00}},
	{"Doherty",                     {-2173.00,-222.50,-0.00,-1794.90,265.20,200.00}},
	{"Downtown",                    {-1982.30,744.10,-6.10,-1871.70,1274.20,200.00}},
	{"Downtown",                    {-1871.70,1176.40,-4.50,-1620.30,1274.20,200.00}},
	{"Downtown",                    {-1700.00,744.20,-6.10,-1580.00,1176.50,200.00}},
	{"Downtown",                    {-1580.00,744.20,-6.10,-1499.80,1025.90,200.00}},
	{"Downtown",                    {-2078.60,578.30,-7.60,-1499.80,744.20,200.00}},
	{"Downtown",                    {-1993.20,265.20,-9.10,-1794.90,578.30,200.00}},
	{"Downtown Los Santos",         {1463.90,-1430.80,-89.00,1724.70,-1290.80,110.90}},
	{"Downtown Los Santos",         {1724.70,-1430.80,-89.00,1812.60,-1250.90,110.90}},
	{"Downtown Los Santos",         {1463.90,-1290.80,-89.00,1724.70,-1150.80,110.90}},
	{"Downtown Los Santos",         {1370.80,-1384.90,-89.00,1463.90,-1170.80,110.90}},
	{"Downtown Los Santos",         {1724.70,-1250.90,-89.00,1812.60,-1150.80,110.90}},
	{"Downtown Los Santos",         {1370.80,-1170.80,-89.00,1463.90,-1130.80,110.90}},
	{"Downtown Los Santos",         {1378.30,-1130.80,-89.00,1463.90,-1026.30,110.90}},
	{"Downtown Los Santos",         {1391.00,-1026.30,-89.00,1463.90,-926.90,110.90}},
	{"Downtown Los Santos",         {1507.50,-1385.20,110.90,1582.50,-1325.30,335.90}},
	{"East Beach",                  {2632.80,-1852.80,-89.00,2959.30,-1668.10,110.90}},
	{"East Beach",                  {2632.80,-1668.10,-89.00,2747.70,-1393.40,110.90}},
	{"East Beach",                  {2747.70,-1668.10,-89.00,2959.30,-1498.60,110.90}},
	{"East Beach",                  {2747.70,-1498.60,-89.00,2959.30,-1120.00,110.90}},
	{"East Los Santos",             {2421.00,-1628.50,-89.00,2632.80,-1454.30,110.90}},
	{"East Los Santos",             {2222.50,-1628.50,-89.00,2421.00,-1494.00,110.90}},
	{"East Los Santos",             {2266.20,-1494.00,-89.00,2381.60,-1372.00,110.90}},
	{"East Los Santos",             {2381.60,-1494.00,-89.00,2421.00,-1454.30,110.90}},
	{"East Los Santos",             {2281.40,-1372.00,-89.00,2381.60,-1135.00,110.90}},
	{"East Los Santos",             {2381.60,-1454.30,-89.00,2462.10,-1135.00,110.90}},
	{"East Los Santos",             {2462.10,-1454.30,-89.00,2581.70,-1135.00,110.90}},
	{"Easter Basin",                {-1794.90,249.90,-9.10,-1242.90,578.30,200.00}},
	{"Easter Basin",                {-1794.90,-50.00,-0.00,-1499.80,249.90,200.00}},
	{"Easter Bay Airport",          {-1499.80,-50.00,-0.00,-1242.90,249.90,200.00}},
	{"Easter Bay Airport",          {-1794.90,-730.10,-3.00,-1213.90,-50.00,200.00}},
	{"Easter Bay Airport",          {-1213.90,-730.10,0.00,-1132.80,-50.00,200.00}},
	{"Easter Bay Airport",          {-1242.90,-50.00,0.00,-1213.90,578.30,200.00}},
	{"Easter Bay Airport",          {-1213.90,-50.00,-4.50,-947.90,578.30,200.00}},
	{"Easter Bay Airport",          {-1315.40,-405.30,15.40,-1264.40,-209.50,25.40}},
	{"Easter Bay Airport",          {-1354.30,-287.30,15.40,-1315.40,-209.50,25.40}},
	{"Easter Bay Airport",          {-1490.30,-209.50,15.40,-1264.40,-148.30,25.40}},
	{"Easter Bay Chemicals",        {-1132.80,-768.00,0.00,-956.40,-578.10,200.00}},
	{"Easter Bay Chemicals",        {-1132.80,-787.30,0.00,-956.40,-768.00,200.00}},
	{"El Castillo del Diablo",      {-464.50,2217.60,0.00,-208.50,2580.30,200.00}},
	{"El Castillo del Diablo",      {-208.50,2123.00,-7.60,114.00,2337.10,200.00}},
	{"El Castillo del Diablo",      {-208.50,2337.10,0.00,8.40,2487.10,200.00}},
	{"El Corona",                   {1812.60,-2179.20,-89.00,1970.60,-1852.80,110.90}},
	{"El Corona",                   {1692.60,-2179.20,-89.00,1812.60,-1842.20,110.90}},
	{"El Quebrados",                {-1645.20,2498.50,0.00,-1372.10,2777.80,200.00}},
	{"Esplanade East",              {-1620.30,1176.50,-4.50,-1580.00,1274.20,200.00}},
	{"Esplanade East",              {-1580.00,1025.90,-6.10,-1499.80,1274.20,200.00}},
	{"Esplanade East",              {-1499.80,578.30,-79.60,-1339.80,1274.20,20.30}},
	{"Esplanade North",             {-2533.00,1358.90,-4.50,-1996.60,1501.20,200.00}},
	{"Esplanade North",             {-1996.60,1358.90,-4.50,-1524.20,1592.50,200.00}},
	{"Esplanade North",             {-1982.30,1274.20,-4.50,-1524.20,1358.90,200.00}},
	{"Fallen Tree",                 {-792.20,-698.50,-5.30,-452.40,-380.00,200.00}},
	{"Fallow Bridge",               {434.30,366.50,0.00,603.00,555.60,200.00}},
	{"Fern Ridge",                  {508.10,-139.20,0.00,1306.60,119.50,200.00}},
	{"Financial",                   {-1871.70,744.10,-6.10,-1701.30,1176.40,300.00}},
	{"Fisher's Lagoon",             {1916.90,-233.30,-100.00,2131.70,13.80,200.00}},
	{"Flint Intersection",          {-187.70,-1596.70,-89.00,17.00,-1276.60,110.90}},
	{"Flint Range",                 {-594.10,-1648.50,0.00,-187.70,-1276.60,200.00}},
	{"Fort Carson",                 {-376.20,826.30,-3.00,123.70,1220.40,200.00}},
	{"Foster Valley",               {-2270.00,-430.20,-0.00,-2178.60,-324.10,200.00}},
	{"Foster Valley",               {-2178.60,-599.80,-0.00,-1794.90,-324.10,200.00}},
	{"Foster Valley",               {-2178.60,-1115.50,0.00,-1794.90,-599.80,200.00}},
	{"Foster Valley",               {-2178.60,-1250.90,0.00,-1794.90,-1115.50,200.00}},
	{"Frederick Bridge",            {2759.20,296.50,0.00,2774.20,594.70,200.00}},
	{"Gant Bridge",                 {-2741.40,1659.60,-6.10,-2616.40,2175.10,200.00}},
	{"Gant Bridge",                 {-2741.00,1490.40,-6.10,-2616.40,1659.60,200.00}},
	{"Ganton",                      {2222.50,-1852.80,-89.00,2632.80,-1722.30,110.90}},
	{"Ganton",                      {2222.50,-1722.30,-89.00,2632.80,-1628.50,110.90}},
	{"Garcia",                      {-2411.20,-222.50,-0.00,-2173.00,265.20,200.00}},
	{"Garcia",                      {-2395.10,-222.50,-5.30,-2354.00,-204.70,200.00}},
	{"Garver Bridge",               {-1339.80,828.10,-89.00,-1213.90,1057.00,110.90}},
	{"Garver Bridge",               {-1213.90,950.00,-89.00,-1087.90,1178.90,110.90}},
	{"Garver Bridge",               {-1499.80,696.40,-179.60,-1339.80,925.30,20.30}},
	{"Glen Park",                   {1812.60,-1449.60,-89.00,1996.90,-1350.70,110.90}},
	{"Glen Park",                   {1812.60,-1100.80,-89.00,1994.30,-973.30,110.90}},
	{"Glen Park",                   {1812.60,-1350.70,-89.00,2056.80,-1100.80,110.90}},
	{"Green Palms",                 {176.50,1305.40,-3.00,338.60,1520.70,200.00}},
	{"Greenglass College",          {964.30,1044.60,-89.00,1197.30,1203.20,110.90}},
	{"Greenglass College",          {964.30,930.80,-89.00,1166.50,1044.60,110.90}},
	{"Hampton Barns",               {603.00,264.30,0.00,761.90,366.50,200.00}},
	{"Hankypanky Point",            {2576.90,62.10,0.00,2759.20,385.50,200.00}},
	{"Harry Gold Parkway",          {1777.30,863.20,-89.00,1817.30,2342.80,110.90}},
	{"Hashbury",                    {-2593.40,-222.50,-0.00,-2411.20,54.70,200.00}},
	{"Hilltop Farm",                {967.30,-450.30,-3.00,1176.70,-217.90,200.00}},
	{"Hunter Quarry",               {337.20,710.80,-115.20,860.50,1031.70,203.70}},
	{"Idlewood",                    {1812.60,-1852.80,-89.00,1971.60,-1742.30,110.90}},
	{"Idlewood",                    {1812.60,-1742.30,-89.00,1951.60,-1602.30,110.90}},
	{"Idlewood",                    {1951.60,-1742.30,-89.00,2124.60,-1602.30,110.90}},
	{"Idlewood",                    {1812.60,-1602.30,-89.00,2124.60,-1449.60,110.90}},
	{"Idlewood",                    {2124.60,-1742.30,-89.00,2222.50,-1494.00,110.90}},
	{"Idlewood",                    {1971.60,-1852.80,-89.00,2222.50,-1742.30,110.90}},
	{"Jefferson",                   {1996.90,-1449.60,-89.00,2056.80,-1350.70,110.90}},
	{"Jefferson",                   {2124.60,-1494.00,-89.00,2266.20,-1449.60,110.90}},
	{"Jefferson",                   {2056.80,-1372.00,-89.00,2281.40,-1210.70,110.90}},
	{"Jefferson",                   {2056.80,-1210.70,-89.00,2185.30,-1126.30,110.90}},
	{"Jefferson",                   {2185.30,-1210.70,-89.00,2281.40,-1154.50,110.90}},
	{"Jefferson",                   {2056.80,-1449.60,-89.00,2266.20,-1372.00,110.90}},
	{"Julius Thruway East",         {2623.10,943.20,-89.00,2749.90,1055.90,110.90}},
	{"Julius Thruway East",         {2685.10,1055.90,-89.00,2749.90,2626.50,110.90}},
	{"Julius Thruway East",         {2536.40,2442.50,-89.00,2685.10,2542.50,110.90}},
	{"Julius Thruway East",         {2625.10,2202.70,-89.00,2685.10,2442.50,110.90}},
	{"Julius Thruway North",        {2498.20,2542.50,-89.00,2685.10,2626.50,110.90}},
	{"Julius Thruway North",        {2237.40,2542.50,-89.00,2498.20,2663.10,110.90}},
	{"Julius Thruway North",        {2121.40,2508.20,-89.00,2237.40,2663.10,110.90}},
	{"Julius Thruway North",        {1938.80,2508.20,-89.00,2121.40,2624.20,110.90}},
	{"Julius Thruway North",        {1534.50,2433.20,-89.00,1848.40,2583.20,110.90}},
	{"Julius Thruway North",        {1848.40,2478.40,-89.00,1938.80,2553.40,110.90}},
	{"Julius Thruway North",        {1704.50,2342.80,-89.00,1848.40,2433.20,110.90}},
	{"Julius Thruway North",        {1377.30,2433.20,-89.00,1534.50,2507.20,110.90}},
	{"Julius Thruway South",        {1457.30,823.20,-89.00,2377.30,863.20,110.90}},
	{"Julius Thruway South",        {2377.30,788.80,-89.00,2537.30,897.90,110.90}},
	{"Julius Thruway West",         {1197.30,1163.30,-89.00,1236.60,2243.20,110.90}},
	{"Julius Thruway West",         {1236.60,2142.80,-89.00,1297.40,2243.20,110.90}},
	{"Juniper Hill",                {-2533.00,578.30,-7.60,-2274.10,968.30,200.00}},
	{"Juniper Hollow",              {-2533.00,968.30,-6.10,-2274.10,1358.90,200.00}},
	{"K.A.C.C. Military Fuels",     {2498.20,2626.50,-89.00,2749.90,2861.50,110.90}},
	{"Kincaid Bridge",              {-1339.80,599.20,-89.00,-1213.90,828.10,110.90}},
	{"Kincaid Bridge",              {-1213.90,721.10,-89.00,-1087.90,950.00,110.90}},
	{"Kincaid Bridge",              {-1087.90,855.30,-89.00,-961.90,986.20,110.90}},
	{"King's",                      {-2329.30,458.40,-7.60,-1993.20,578.30,200.00}},
	{"King's",                      {-2411.20,265.20,-9.10,-1993.20,373.50,200.00}},
	{"King's",                      {-2253.50,373.50,-9.10,-1993.20,458.40,200.00}},
	{"LVA Freight Depot",           {1457.30,863.20,-89.00,1777.40,1143.20,110.90}},
	{"LVA Freight Depot",           {1375.60,919.40,-89.00,1457.30,1203.20,110.90}},
	{"LVA Freight Depot",           {1277.00,1087.60,-89.00,1375.60,1203.20,110.90}},
	{"LVA Freight Depot",           {1315.30,1044.60,-89.00,1375.60,1087.60,110.90}},
	{"LVA Freight Depot",           {1236.60,1163.40,-89.00,1277.00,1203.20,110.90}},
	{"Las Barrancas",               {-926.10,1398.70,-3.00,-719.20,1634.60,200.00}},
	{"Las Brujas",                  {-365.10,2123.00,-3.00,-208.50,2217.60,200.00}},
	{"Las Colinas",                 {1994.30,-1100.80,-89.00,2056.80,-920.80,110.90}},
	{"Las Colinas",                 {2056.80,-1126.30,-89.00,2126.80,-920.80,110.90}},
	{"Las Colinas",                 {2185.30,-1154.50,-89.00,2281.40,-934.40,110.90}},
	{"Las Colinas",                 {2126.80,-1126.30,-89.00,2185.30,-934.40,110.90}},
	{"Las Colinas",                 {2747.70,-1120.00,-89.00,2959.30,-945.00,110.90}},
	{"Las Colinas",                 {2632.70,-1135.00,-89.00,2747.70,-945.00,110.90}},
	{"Las Colinas",                 {2281.40,-1135.00,-89.00,2632.70,-945.00,110.90}},
	{"Las Payasadas",               {-354.30,2580.30,2.00,-133.60,2816.80,200.00}},
	{"Las Venturas Airport",        {1236.60,1203.20,-89.00,1457.30,1883.10,110.90}},
	{"Las Venturas Airport",        {1457.30,1203.20,-89.00,1777.30,1883.10,110.90}},
	{"Las Venturas Airport",        {1457.30,1143.20,-89.00,1777.40,1203.20,110.90}},
	{"Las Venturas Airport",        {1515.80,1586.40,-12.50,1729.90,1714.50,87.50}},
	{"Last Dime Motel",             {1823.00,596.30,-89.00,1997.20,823.20,110.90}},
	{"Leafy Hollow",                {-1166.90,-1856.00,0.00,-815.60,-1602.00,200.00}},
	{"Liberty City",                {-1000.00,400.00,1300.00,-700.00,600.00,1400.00}},
	{"Lil' Probe Inn",              {-90.20,1286.80,-3.00,153.80,1554.10,200.00}},
	{"Linden Side",                 {2749.90,943.20,-89.00,2923.30,1198.90,110.90}},
	{"Linden Station",              {2749.90,1198.90,-89.00,2923.30,1548.90,110.90}},
	{"Linden Station",              {2811.20,1229.50,-39.50,2861.20,1407.50,60.40}},
	{"Little Mexico",               {1701.90,-1842.20,-89.00,1812.60,-1722.20,110.90}},
	{"Little Mexico",               {1758.90,-1722.20,-89.00,1812.60,-1577.50,110.90}},
	{"Los Flores",                  {2581.70,-1454.30,-89.00,2632.80,-1393.40,110.90}},
	{"Los Flores",                  {2581.70,-1393.40,-89.00,2747.70,-1135.00,110.90}},
	{"Los Santos International",    {1249.60,-2394.30,-89.00,1852.00,-2179.20,110.90}},
	{"Los Santos International",    {1852.00,-2394.30,-89.00,2089.00,-2179.20,110.90}},
	{"Los Santos International",    {1382.70,-2730.80,-89.00,2201.80,-2394.30,110.90}},
	{"Los Santos International",    {1974.60,-2394.30,-39.00,2089.00,-2256.50,60.90}},
	{"Los Santos International",    {1400.90,-2669.20,-39.00,2189.80,-2597.20,60.90}},
	{"Los Santos International",    {2051.60,-2597.20,-39.00,2152.40,-2394.30,60.90}},
	{"Marina",                      {647.70,-1804.20,-89.00,851.40,-1577.50,110.90}},
	{"Marina",                      {647.70,-1577.50,-89.00,807.90,-1416.20,110.90}},
	{"Marina",                      {807.90,-1577.50,-89.00,926.90,-1416.20,110.90}},
	{"Market",                      {787.40,-1416.20,-89.00,1072.60,-1310.20,110.90}},
	{"Market",                      {952.60,-1310.20,-89.00,1072.60,-1130.80,110.90}},
	{"Market",                      {1072.60,-1416.20,-89.00,1370.80,-1130.80,110.90}},
	{"Market",                      {926.90,-1577.50,-89.00,1370.80,-1416.20,110.90}},
	{"Market Station",              {787.40,-1410.90,-34.10,866.00,-1310.20,65.80}},
	{"Martin Bridge",               {-222.10,293.30,0.00,-122.10,476.40,200.00}},
	{"Missionary Hill",             {-2994.40,-811.20,0.00,-2178.60,-430.20,200.00}},
	{"Montgomery",                  {1119.50,119.50,-3.00,1451.40,493.30,200.00}},
	{"Montgomery",                  {1451.40,347.40,-6.10,1582.40,420.80,200.00}},
	{"Montgomery Intersection",     {1546.60,208.10,0.00,1745.80,347.40,200.00}},
	{"Montgomery Intersection",     {1582.40,347.40,0.00,1664.60,401.70,200.00}},
	{"Mulholland",                  {1414.00,-768.00,-89.00,1667.60,-452.40,110.90}},
	{"Mulholland",                  {1281.10,-452.40,-89.00,1641.10,-290.90,110.90}},
	{"Mulholland",                  {1269.10,-768.00,-89.00,1414.00,-452.40,110.90}},
	{"Mulholland",                  {1357.00,-926.90,-89.00,1463.90,-768.00,110.90}},
	{"Mulholland",                  {1318.10,-910.10,-89.00,1357.00,-768.00,110.90}},
	{"Mulholland",                  {1169.10,-910.10,-89.00,1318.10,-768.00,110.90}},
	{"Mulholland",                  {768.60,-954.60,-89.00,952.60,-860.60,110.90}},
	{"Mulholland",                  {687.80,-860.60,-89.00,911.80,-768.00,110.90}},
	{"Mulholland",                  {737.50,-768.00,-89.00,1142.20,-674.80,110.90}},
	{"Mulholland",                  {1096.40,-910.10,-89.00,1169.10,-768.00,110.90}},
	{"Mulholland",                  {952.60,-937.10,-89.00,1096.40,-860.60,110.90}},
	{"Mulholland",                  {911.80,-860.60,-89.00,1096.40,-768.00,110.90}},
	{"Mulholland",                  {861.00,-674.80,-89.00,1156.50,-600.80,110.90}},
	{"Mulholland Intersection",     {1463.90,-1150.80,-89.00,1812.60,-768.00,110.90}},
	{"North Rock",                  {2285.30,-768.00,0.00,2770.50,-269.70,200.00}},
	{"Ocean Docks",                 {2373.70,-2697.00,-89.00,2809.20,-2330.40,110.90}},
	{"Ocean Docks",                 {2201.80,-2418.30,-89.00,2324.00,-2095.00,110.90}},
	{"Ocean Docks",                 {2324.00,-2302.30,-89.00,2703.50,-2145.10,110.90}},
	{"Ocean Docks",                 {2089.00,-2394.30,-89.00,2201.80,-2235.80,110.90}},
	{"Ocean Docks",                 {2201.80,-2730.80,-89.00,2324.00,-2418.30,110.90}},
	{"Ocean Docks",                 {2703.50,-2302.30,-89.00,2959.30,-2126.90,110.90}},
	{"Ocean Docks",                 {2324.00,-2145.10,-89.00,2703.50,-2059.20,110.90}},
	{"Ocean Flats",                 {-2994.40,277.40,-9.10,-2867.80,458.40,200.00}},
	{"Ocean Flats",                 {-2994.40,-222.50,-0.00,-2593.40,277.40,200.00}},
	{"Ocean Flats",                 {-2994.40,-430.20,-0.00,-2831.80,-222.50,200.00}},
	{"Octane Springs",              {338.60,1228.50,0.00,664.30,1655.00,200.00}},
	{"Old Venturas Strip",          {2162.30,2012.10,-89.00,2685.10,2202.70,110.90}},
	{"Palisades",                   {-2994.40,458.40,-6.10,-2741.00,1339.60,200.00}},
	{"Palomino Creek",              {2160.20,-149.00,0.00,2576.90,228.30,200.00}},
	{"Paradiso",                    {-2741.00,793.40,-6.10,-2533.00,1268.40,200.00}},
	{"Pershing Square",             {1440.90,-1722.20,-89.00,1583.50,-1577.50,110.90}},
	{"Pilgrim",                     {2437.30,1383.20,-89.00,2624.40,1783.20,110.90}},
	{"Pilgrim",                     {2624.40,1383.20,-89.00,2685.10,1783.20,110.90}},
	{"Pilson Intersection",         {1098.30,2243.20,-89.00,1377.30,2507.20,110.90}},
	{"Pirates in Men's Pants",      {1817.30,1469.20,-89.00,2027.40,1703.20,110.90}},
	{"Playa del Seville",           {2703.50,-2126.90,-89.00,2959.30,-1852.80,110.90}},
	{"Prickle Pine",                {1534.50,2583.20,-89.00,1848.40,2863.20,110.90}},
	{"Prickle Pine",                {1117.40,2507.20,-89.00,1534.50,2723.20,110.90}},
	{"Prickle Pine",                {1848.40,2553.40,-89.00,1938.80,2863.20,110.90}},
	{"Prickle Pine",                {1938.80,2624.20,-89.00,2121.40,2861.50,110.90}},
	{"Queens",                      {-2533.00,458.40,0.00,-2329.30,578.30,200.00}},
	{"Queens",                      {-2593.40,54.70,0.00,-2411.20,458.40,200.00}},
	{"Queens",                      {-2411.20,373.50,0.00,-2253.50,458.40,200.00}},
	{"Randolph Industrial Estate",  {1558.00,596.30,-89.00,1823.00,823.20,110.90}},
	{"Redsands East",               {1817.30,2011.80,-89.00,2106.70,2202.70,110.90}},
	{"Redsands East",               {1817.30,2202.70,-89.00,2011.90,2342.80,110.90}},
	{"Redsands East",               {1848.40,2342.80,-89.00,2011.90,2478.40,110.90}},
	{"Redsands West",               {1236.60,1883.10,-89.00,1777.30,2142.80,110.90}},
	{"Redsands West",               {1297.40,2142.80,-89.00,1777.30,2243.20,110.90}},
	{"Redsands West",               {1377.30,2243.20,-89.00,1704.50,2433.20,110.90}},
	{"Redsands West",               {1704.50,2243.20,-89.00,1777.30,2342.80,110.90}},
	{"Regular Tom",                 {-405.70,1712.80,-3.00,-276.70,1892.70,200.00}},
	{"Richman",                     {647.50,-1118.20,-89.00,787.40,-954.60,110.90}},
	{"Richman",                     {647.50,-954.60,-89.00,768.60,-860.60,110.90}},
	{"Richman",                     {225.10,-1369.60,-89.00,334.50,-1292.00,110.90}},
	{"Richman",                     {225.10,-1292.00,-89.00,466.20,-1235.00,110.90}},
	{"Richman",                     {72.60,-1404.90,-89.00,225.10,-1235.00,110.90}},
	{"Richman",                     {72.60,-1235.00,-89.00,321.30,-1008.10,110.90}},
	{"Richman",                     {321.30,-1235.00,-89.00,647.50,-1044.00,110.90}},
	{"Richman",                     {321.30,-1044.00,-89.00,647.50,-860.60,110.90}},
	{"Richman",                     {321.30,-860.60,-89.00,687.80,-768.00,110.90}},
	{"Richman",                     {321.30,-768.00,-89.00,700.70,-674.80,110.90}},
	{"Robada Intersection",         {-1119.00,1178.90,-89.00,-862.00,1351.40,110.90}},
	{"Roca Escalante",              {2237.40,2202.70,-89.00,2536.40,2542.50,110.90}},
	{"Roca Escalante",              {2536.40,2202.70,-89.00,2625.10,2442.50,110.90}},
	{"Rockshore East",              {2537.30,676.50,-89.00,2902.30,943.20,110.90}},
	{"Rockshore West",              {1997.20,596.30,-89.00,2377.30,823.20,110.90}},
	{"Rockshore West",              {2377.30,596.30,-89.00,2537.30,788.80,110.90}},
	{"Rodeo",                       {72.60,-1684.60,-89.00,225.10,-1544.10,110.90}},
	{"Rodeo",                       {72.60,-1544.10,-89.00,225.10,-1404.90,110.90}},
	{"Rodeo",                       {225.10,-1684.60,-89.00,312.80,-1501.90,110.90}},
	{"Rodeo",                       {225.10,-1501.90,-89.00,334.50,-1369.60,110.90}},
	{"Rodeo",                       {334.50,-1501.90,-89.00,422.60,-1406.00,110.90}},
	{"Rodeo",                       {312.80,-1684.60,-89.00,422.60,-1501.90,110.90}},
	{"Rodeo",                       {422.60,-1684.60,-89.00,558.00,-1570.20,110.90}},
	{"Rodeo",                       {558.00,-1684.60,-89.00,647.50,-1384.90,110.90}},
	{"Rodeo",                       {466.20,-1570.20,-89.00,558.00,-1385.00,110.90}},
	{"Rodeo",                       {422.60,-1570.20,-89.00,466.20,-1406.00,110.90}},
	{"Rodeo",                       {466.20,-1385.00,-89.00,647.50,-1235.00,110.90}},
	{"Rodeo",                       {334.50,-1406.00,-89.00,466.20,-1292.00,110.90}},
	{"Royal Casino",                {2087.30,1383.20,-89.00,2437.30,1543.20,110.90}},
	{"San Andreas Sound",           {2450.30,385.50,-100.00,2759.20,562.30,200.00}},
	{"Santa Flora",                 {-2741.00,458.40,-7.60,-2533.00,793.40,200.00}},
	{"Santa Maria Beach",           {342.60,-2173.20,-89.00,647.70,-1684.60,110.90}},
	{"Santa Maria Beach",           {72.60,-2173.20,-89.00,342.60,-1684.60,110.90}},
	{"Shady Cabin",                 {-1632.80,-2263.40,-3.00,-1601.30,-2231.70,200.00}},
	{"Shady Creeks",                {-1820.60,-2643.60,-8.00,-1226.70,-1771.60,200.00}},
	{"Shady Creeks",                {-2030.10,-2174.80,-6.10,-1820.60,-1771.60,200.00}},
	{"Sobell Rail Yards",           {2749.90,1548.90,-89.00,2923.30,1937.20,110.90}},
	{"Spinybed",                    {2121.40,2663.10,-89.00,2498.20,2861.50,110.90}},
	{"Starfish Casino",             {2437.30,1783.20,-89.00,2685.10,2012.10,110.90}},
	{"Starfish Casino",             {2437.30,1858.10,-39.00,2495.00,1970.80,60.90}},
	{"Starfish Casino",             {2162.30,1883.20,-89.00,2437.30,2012.10,110.90}},
	{"Temple",                      {1252.30,-1130.80,-89.00,1378.30,-1026.30,110.90}},
	{"Temple",                      {1252.30,-1026.30,-89.00,1391.00,-926.90,110.90}},
	{"Temple",                      {1252.30,-926.90,-89.00,1357.00,-910.10,110.90}},
	{"Temple",                      {952.60,-1130.80,-89.00,1096.40,-937.10,110.90}},
	{"Temple",                      {1096.40,-1130.80,-89.00,1252.30,-1026.30,110.90}},
	{"Temple",                      {1096.40,-1026.30,-89.00,1252.30,-910.10,110.90}},
	{"The Camel's Toe",             {2087.30,1203.20,-89.00,2640.40,1383.20,110.90}},
	{"The Clown's Pocket",          {2162.30,1783.20,-89.00,2437.30,1883.20,110.90}},
	{"The Emerald Isle",            {2011.90,2202.70,-89.00,2237.40,2508.20,110.90}},
	{"The Farm",                    {-1209.60,-1317.10,114.90,-908.10,-787.30,251.90}},
	{"The Four Dragons Casino",     {1817.30,863.20,-89.00,2027.30,1083.20,110.90}},
	{"The High Roller",             {1817.30,1283.20,-89.00,2027.30,1469.20,110.90}},
	{"The Mako Span",               {1664.60,401.70,0.00,1785.10,567.20,200.00}},
	{"The Panopticon",              {-947.90,-304.30,-1.10,-319.60,327.00,200.00}},
	{"The Pink Swan",               {1817.30,1083.20,-89.00,2027.30,1283.20,110.90}},
	{"The Sherman Dam",             {-968.70,1929.40,-3.00,-481.10,2155.20,200.00}},
	{"The Strip",                   {2027.40,863.20,-89.00,2087.30,1703.20,110.90}},
	{"The Strip",                   {2106.70,1863.20,-89.00,2162.30,2202.70,110.90}},
	{"The Strip",                   {2027.40,1783.20,-89.00,2162.30,1863.20,110.90}},
	{"The Strip",                   {2027.40,1703.20,-89.00,2137.40,1783.20,110.90}},
	{"The Visage",                  {1817.30,1863.20,-89.00,2106.70,2011.80,110.90}},
	{"The Visage",                  {1817.30,1703.20,-89.00,2027.40,1863.20,110.90}},
	{"Unity Station",               {1692.60,-1971.80,-20.40,1812.60,-1932.80,79.50}},
	{"Valle Ocultado",              {-936.60,2611.40,2.00,-715.90,2847.90,200.00}},
	{"Verdant Bluffs",              {930.20,-2488.40,-89.00,1249.60,-2006.70,110.90}},
	{"Verdant Bluffs",              {1073.20,-2006.70,-89.00,1249.60,-1842.20,110.90}},
	{"Verdant Bluffs",              {1249.60,-2179.20,-89.00,1692.60,-1842.20,110.90}},
	{"Verdant Meadows",             {37.00,2337.10,-3.00,435.90,2677.90,200.00}},
	{"Verona Beach",                {647.70,-2173.20,-89.00,930.20,-1804.20,110.90}},
	{"Verona Beach",                {930.20,-2006.70,-89.00,1073.20,-1804.20,110.90}},
	{"Verona Beach",                {851.40,-1804.20,-89.00,1046.10,-1577.50,110.90}},
	{"Verona Beach",                {1161.50,-1722.20,-89.00,1323.90,-1577.50,110.90}},
	{"Verona Beach",                {1046.10,-1722.20,-89.00,1161.50,-1577.50,110.90}},
	{"Vinewood",                    {787.40,-1310.20,-89.00,952.60,-1130.80,110.90}},
	{"Vinewood",                    {787.40,-1130.80,-89.00,952.60,-954.60,110.90}},
	{"Vinewood",                    {647.50,-1227.20,-89.00,787.40,-1118.20,110.90}},
	{"Vinewood",                    {647.70,-1416.20,-89.00,787.40,-1227.20,110.90}},
	{"Whitewood Estates",           {883.30,1726.20,-89.00,1098.30,2507.20,110.90}},
	{"Whitewood Estates",           {1098.30,1726.20,-89.00,1197.30,2243.20,110.90}},
	{"Willowfield",                 {1970.60,-2179.20,-89.00,2089.00,-1852.80,110.90}},
	{"Willowfield",                 {2089.00,-2235.80,-89.00,2201.80,-1989.90,110.90}},
	{"Willowfield",                 {2089.00,-1989.90,-89.00,2324.00,-1852.80,110.90}},
	{"Willowfield",                 {2201.80,-2095.00,-89.00,2324.00,-1989.90,110.90}},
	{"Willowfield",                 {2541.70,-1941.40,-89.00,2703.50,-1852.80,110.90}},
	{"Willowfield",                 {2324.00,-2059.20,-89.00,2541.70,-1852.80,110.90}},
	{"Willowfield",                 {2541.70,-2059.20,-89.00,2703.50,-1941.40,110.90}},
	{"Yellow Bell Station",         {1377.40,2600.40,-21.90,1492.40,2687.30,78.00}},
	{"Los Santos",                  {44.60,-2892.90,-242.90,2997.00,-768.00,900.00}},
	{"Las Venturas",                {869.40,596.30,-242.90,2997.00,2993.80,900.00}},
	{"Bone County",                 {-480.50,596.30,-242.90,869.40,2993.80,900.00}},
	{"Tierra Robada",               {-2997.40,1659.60,-242.90,-480.50,2993.80,900.00}},
	{"Tierra Robada",               {-1213.90,596.30,-242.90,-480.50,1659.60,900.00}},
	{"San Fierro",                  {-2997.40,-1115.50,-242.90,-1213.90,1659.60,900.00}},
	{"Red County",                  {-1213.90,-768.00,-242.90,2997.00,596.30,900.00}},
	{"Flint County",                {-1213.90,-2892.90,-242.90,44.60,-768.00,900.00}},
	{"Whetstone",                   {-2997.40,-2892.90,-242.90,-1213.90,-1115.50,900.00}}
};
//===========================================================================//
enum vInfo
{
	vModel,
	Float:vLocationx,
	Float:vLocationy,
	Float:vLocationz,
	Float:vAngle,
	vColorOne,
	vColorTwo,
	vOwner[MAX_PLAYER_NAME],
	vDescription[MAX_PLAYER_NAME],
	vValue,
	vLicense,
	vRegistration,
	vOwned,
	vLock,
	ownedvehicle,
	vMod1,
	vMod2,
	vMod3,
	vMod4,
	vMod5,
	vMod6,
	vMod7,
	vMod8,
	vMod9,
	vMod10,
	vMod11,
	vMod12,
	vMod13,
	vMod14,
	vMod15,
	vMod16,
	vMod17,
	vPlate,
	vPot,
	vCrack,
	vMats,
	vGun1,
	vGun2,
	vGun3,

};
new CarInfo[500][vInfo];

enum vdInfo
{
	vdModel,
	Float:vdLocationx,
	Float:vdLocationy,
	Float:vdLocationz,
	Float:vdAngle,
	vdColorOne,
	vdColorTwo,
	vdPrice,
	Float:vdSpawnX,
	Float:vdSpawnY,
	Float:vdSpawnZ,
	Float:vdSpawnA,
	dealervehicle
};
new DCarInfo[200][vdInfo];

enum pInfo
{
	Password,
	Admin,
	Origin,
	Gender,
	Age,
	Float:sPosX,
	Float:sPosY,
	Float:sPosZ,
	Float:sPosA,
	Float:sHealth,
	Float:sArmor,
	Money,
	BankBalance,
	BankPin,
	Cellphone,
	HouseID,
	CarID,
	Gun1,
	Gun2,
	Gun3,
	Gun4,
	Gun5,
	Gun6,
	Gun7,
	Gun8,
	Gun9,
	Gun10,
	Gun11,
	Gun12,
	Gun13,
	WTChannel,
	Faction,
	FLeader,
	Job[64],
	sInterior,
	sVW,
	Skin,
	Muted,
	nMute,
	Helper,
	Developer,
	RentingID,
	FRank
}
new PlayerInfo[MAX_PLAYERS][pInfo];
//============================================================================//

// [Stocks] //
stock IsABike(vehicleid) { switch(GetVehicleModel(vehicleid)) { case 448,461,462,463,468,521,522,523,581,586,481,509,510: return 1; } return 0; }
stock IsABoat(vehicleid) { switch(GetVehicleModel(vehicleid)) { case 430,446,452,453,454,472,473,484,493,595: return 1; } return 0; }
stock IsAPlane(vehicleid) { switch(GetVehicleModel(vehicleid)) { case 460,464,476,511,512,513,519,520,553,577,592,593: return 1; } return 0; }
stock IsAHelicopter(vehicleid) { switch(GetVehicleModel(vehicleid)) { case 417,425,447,465,469,487,488,497,501,548,563: return 1; } return 0; }
stock IsATrain(vehicleid) { switch(GetVehicleModel(vehicleid)) { case 449,537,538,569,570,590: return 1; } return 0; }
stock IsABus(vehicleid) { switch(GetVehicleModel(vehicleid)) { case 431,437: return 1; } return 0; }

stock GetVehicleName(vehicleid, model[], len)
{
	new checking = GetVehicleModel(vehicleid);
	if(checking == 400) return format(model, len, "Landstalker", 0);
	else if(checking == 401) return format(model, len, "Bravura", 0);
	else if(checking == 402) return format(model, len, "Buffalo", 0);
	else if(checking == 403) return format(model, len, "Linerunner", 0);
	else if(checking == 404) return format(model, len, "Perenail", 0);
	else if(checking == 405) return format(model, len, "Sentinel", 0);
	else if(checking == 406) return format(model, len, "Dumper", 0);
	else if(checking == 407) return format(model, len, "Firetruck", 0);
	else if(checking == 408) return format(model, len, "Trashmaster", 0);
	else if(checking == 409) return format(model, len, "Stretch", 0);
	else if(checking == 410) return format(model, len, "Manana", 0);
	else if(checking == 411) return format(model, len, "Infernus", 0);
	else if(checking == 412) return format(model, len, "Vodooo", 0);
	else if(checking == 413) return format(model, len, "Pony", 0);
	else if(checking == 414) return format(model, len, "Mule", 0);
	else if(checking == 415) return format(model, len, "Cheetah", 0);
	else if(checking == 416) return format(model, len, "Ambulance", 0);
	else if(checking == 417) return format(model, len, "Leviathan", 0);
	else if(checking == 418) return format(model, len, "Moonbeam", 0);
	else if(checking == 419) return format(model, len, "Esperanto", 0);
	else if(checking == 420) return format(model, len, "Taxi", 0);
	else if(checking == 421) return format(model, len, "Washington", 0);
	else if(checking == 422) return format(model, len, "Bobcat", 0);
	else if(checking == 423) return format(model, len, "Mr Whoopee", 0);
	else if(checking == 424) return format(model, len, "BF Injection", 0);
	else if(checking == 425) return format(model, len, "Hunter", 0);
	else if(checking == 426) return format(model, len, "Premier", 0);
	else if(checking == 427) return format(model, len, "S.W.A.T Truck", 0);
	else if(checking == 428) return format(model, len, "Securicar", 0);
	else if(checking == 429) return format(model, len, "Banshee", 0);
	else if(checking == 430) return format(model, len, "Predator", 0);
	else if(checking == 431) return format(model, len, "Bus", 0);
	else if(checking == 432) return format(model, len, "Rhino", 0);
	else if(checking == 433) return format(model, len, "Barracks", 0);
	else if(checking == 434) return format(model, len, "Hotknife", 0);
	else if(checking == 435) return format(model, len, "Trailer", 0);
	else if(checking == 436) return format(model, len, "Previon", 0);
	else if(checking == 437) return format(model, len, "Coach", 0);
	else if(checking == 438) return format(model, len, "Cabbie", 0);
	else if(checking == 439) return format(model, len, "Stallion", 0);
	else if(checking == 440) return format(model, len, "Rumpo", 0);
	else if(checking == 441) return format(model, len, "RC Bandit", 0);
	else if(checking == 442) return format(model, len, "Romero", 0);
	else if(checking == 443) return format(model, len, "Packer", 0);
	else if(checking == 444) return format(model, len, "Monster", 0);
	else if(checking == 445) return format(model, len, "Admiral", 0);
	else if(checking == 446) return format(model, len, "Squalo", 0);
	else if(checking == 447) return format(model, len, "Seasparrow", 0);
	else if(checking == 448) return format(model, len, "Pizza Boy", 0);
	else if(checking == 449) return format(model, len, "Tram", 0);
	else if(checking == 450) return format(model, len, "Trailer 2", 0);
	else if(checking == 451) return format(model, len, "Turismo", 0);
	else if(checking == 452) return format(model, len, "Speeder", 0);
	else if(checking == 453) return format(model, len, "Refeer", 0);
	else if(checking == 454) return format(model, len, "Tropic", 0);
	else if(checking == 455) return format(model, len, "Flatbed", 0);
	else if(checking == 456) return format(model, len, "Yankee", 0);
	else if(checking == 457) return format(model, len, "Caddy", 0);
	else if(checking == 458) return format(model, len, "Solair", 0);
	else if(checking == 459) return format(model, len, "Top Fun", 0);
	else if(checking == 460) return format(model, len, "Skimmer", 0);
	else if(checking == 461) return format(model, len, "PCJ-600", 0);
	else if(checking == 462) return format(model, len, "Faggio", 0);
	else if(checking == 463) return format(model, len, "Freeway", 0);
	else if(checking == 464) return format(model, len, "RC Baron", 0);
	else if(checking == 465) return format(model, len, "RC Raider", 0);
	else if(checking == 466) return format(model, len, "Glendade", 0);
	else if(checking == 467) return format(model, len, "Oceanic", 0);
	else if(checking == 468) return format(model, len, "Sanchez", 0);
	else if(checking == 469) return format(model, len, "Sparrow", 0);
	else if(checking == 470) return format(model, len, "Patriot", 0);
	else if(checking == 471) return format(model, len, "Quad", 0);
	else if(checking == 472) return format(model, len, "Coastguard", 0);
	else if(checking == 473) return format(model, len, "Dinghy", 0);
	else if(checking == 474) return format(model, len, "Hermes", 0);
	else if(checking == 475) return format(model, len, "Sabre", 0);
	else if(checking == 476) return format(model, len, "Rustler", 0);
	else if(checking == 477) return format(model, len, "ZR-350", 0);
	else if(checking == 478) return format(model, len, "Walton", 0);
	else if(checking == 479) return format(model, len, "Regina", 0);
	else if(checking == 480) return format(model, len, "Comet", 0);
	else if(checking == 481) return format(model, len, "BMX", 0);
	else if(checking == 482) return format(model, len, "Burrito", 0);
	else if(checking == 483) return format(model, len, "Camper", 0);
	else if(checking == 484) return format(model, len, "Marquis", 0);
	else if(checking == 485) return format(model, len, "Baggage", 0);
	else if(checking == 486) return format(model, len, "Dozer", 0);
	else if(checking == 487) return format(model, len, "Maverick", 0);
	else if(checking == 488) return format(model, len, "News Maverick", 0);
	else if(checking == 489) return format(model, len, "Rancher", 0);
	else if(checking == 490) return format(model, len, "Federal Rancher", 0);
	else if(checking == 491) return format(model, len, "Virgo", 0);
	else if(checking == 492) return format(model, len, "Greenwood", 0);
	else if(checking == 493) return format(model, len, "Jetmax", 0);
	else if(checking == 494) return format(model, len, "Hotring", 0);
	else if(checking == 495) return format(model, len, "Sandking", 0);
	else if(checking == 496) return format(model, len, "Blista Compact", 0);
	else if(checking == 497) return format(model, len, "Police Maverick", 0);
	else if(checking == 498) return format(model, len, "Boxville", 0);
	else if(checking == 499) return format(model, len, "Benson", 0);
	else if(checking == 500) return format(model, len, "Mesa", 0);
	else if(checking == 501) return format(model, len, "RC Goblin", 0);
	else if(checking == 502) return format(model, len, "Hotring A", 0);
	else if(checking == 503) return format(model, len, "Hotring B", 0);
	else if(checking == 504) return format(model, len, "Blooding Banger", 0);
	else if(checking == 505) return format(model, len, "Rancher", 0);
	else if(checking == 506) return format(model, len, "Super GT", 0);
	else if(checking == 507) return format(model, len, "Elegant", 0);
	else if(checking == 508) return format(model, len, "Journey", 0);
	else if(checking == 509) return format(model, len, "Bike", 0);
	else if(checking == 510) return format(model, len, "Mountain Bike", 0);
	else if(checking == 511) return format(model, len, "Beagle", 0);
	else if(checking == 512) return format(model, len, "Cropduster", 0);
	else if(checking == 513) return format(model, len, "Stuntplane", 0);
	else if(checking == 514) return format(model, len, "Petrol", 0);
	else if(checking == 515) return format(model, len, "Roadtrain", 0);
	else if(checking == 516) return format(model, len, "Nebula", 0);
	else if(checking == 517) return format(model, len, "Majestic", 0);
	else if(checking == 518) return format(model, len, "Buccaneer", 0);
	else if(checking == 519) return format(model, len, "Shamal", 0);
	else if(checking == 520) return format(model, len, "Hydra", 0);
	else if(checking == 521) return format(model, len, "FCR-300", 0);
	else if(checking == 522) return format(model, len, "NRG-500", 0);
	else if(checking == 523) return format(model, len, "HPV-1000", 0);
	else if(checking == 524) return format(model, len, "Cement Truck", 0);
	else if(checking == 525) return format(model, len, "Towtruck", 0);
	else if(checking == 526) return format(model, len, "Fortune", 0);
	else if(checking == 527) return format(model, len, "Cadrona", 0);
	else if(checking == 528) return format(model, len, "Federal Truck", 0);
	else if(checking == 529) return format(model, len, "Williard", 0);
	else if(checking == 530) return format(model, len, "Fork Lift", 0);
	else if(checking == 531) return format(model, len, "Tractor", 0);
	else if(checking == 532) return format(model, len, "Combine", 0);
	else if(checking == 533) return format(model, len, "Feltzer", 0);
	else if(checking == 534) return format(model, len, "Remington", 0);
	else if(checking == 535) return format(model, len, "Slamvan", 0);
	else if(checking == 536) return format(model, len, "Blade", 0);
	else if(checking == 537) return format(model, len, "Freight", 0);
	else if(checking == 538) return format(model, len, "Streak", 0);
	else if(checking == 539) return format(model, len, "Vortex", 0);
	else if(checking == 540) return format(model, len, "Vincent", 0);
	else if(checking == 541) return format(model, len, "Bullet", 0);
	else if(checking == 542) return format(model, len, "Clover", 0);
	else if(checking == 543) return format(model, len, "Sadler", 0);
	else if(checking == 544) return format(model, len, "Stairs Firetruck", 0);
	else if(checking == 545) return format(model, len, "Hustler", 0);
	else if(checking == 546) return format(model, len, "Intruder", 0);
	else if(checking == 547) return format(model, len, "Primo", 0);
	else if(checking == 548) return format(model, len, "Cargobob", 0);
	else if(checking == 549) return format(model, len, "Tampa", 0);
	else if(checking == 550) return format(model, len, "Sunrise", 0);
	else if(checking == 551) return format(model, len, "Merit", 0);
	else if(checking == 552) return format(model, len, "Utility Van", 0);
	else if(checking == 553) return format(model, len, "Nevada", 0);
	else if(checking == 554) return format(model, len, "Yosemite", 0);
	else if(checking == 555) return format(model, len, "Windsor", 0);
	else if(checking == 556) return format(model, len, "Monster A", 0);
	else if(checking == 557) return format(model, len, "Monster B", 0);
	else if(checking == 558) return format(model, len, "Uranus", 0);
	else if(checking == 559) return format(model, len, "Jester", 0);
	else if(checking == 560) return format(model, len, "Sultan", 0);
	else if(checking == 561) return format(model, len, "Stratum", 0);
	else if(checking == 562) return format(model, len, "Elegy", 0);
	else if(checking == 563) return format(model, len, "Raindance", 0);
	else if(checking == 564) return format(model, len, "RC Tiger", 0);
	else if(checking == 565) return format(model, len, "Flash", 0);
	else if(checking == 566) return format(model, len, "Tahoma", 0);
	else if(checking == 567) return format(model, len, "Savanna", 0);
	else if(checking == 568) return format(model, len, "Bandito", 0);
	else if(checking == 569) return format(model, len, "Freight Flat", 0);
	else if(checking == 570) return format(model, len, "Streak", 0);
	else if(checking == 571) return format(model, len, "Kart", 0);
	else if(checking == 572) return format(model, len, "Mower", 0);
	else if(checking == 573) return format(model, len, "Duneride", 0);
	else if(checking == 574) return format(model, len, "Sweeper", 0);
	else if(checking == 575) return format(model, len, "Broadway", 0);
	else if(checking == 576) return format(model, len, "Tornado", 0);
	else if(checking == 577) return format(model, len, "AT-400", 0);
	else if(checking == 578) return format(model, len, "DFT-30", 0);
	else if(checking == 579) return format(model, len, "Huntley", 0);
	else if(checking == 580) return format(model, len, "Stafford", 0);
	else if(checking == 581) return format(model, len, "BF-400", 0);
	else if(checking == 582) return format(model, len, "News Van", 0);
	else if(checking == 583) return format(model, len, "Tug", 0);
	else if(checking == 584) return format(model, len, "Petrol Tanker", 0);
	else if(checking == 585) return format(model, len, "Emperor", 0);
	else if(checking == 586) return format(model, len, "Wayfarer", 0);
	else if(checking == 587) return format(model, len, "Euros", 0);
	else if(checking == 588) return format(model, len, "Hotdog", 0);
	else if(checking == 589) return format(model, len, "Club", 0);
	else if(checking == 590) return format(model, len, "Freight Box", 0);
	else if(checking == 591) return format(model, len, "Trailer 3", 0);
	else if(checking == 592) return format(model, len, "Andromada", 0);
	else if(checking == 593) return format(model, len, "Dodo", 0);
	else if(checking == 594) return format(model, len, "RC Cam", 0);
	else if(checking == 595) return format(model, len, "Launch", 0);
	else if(checking == 596) return format(model, len, "LSPD Car", 0);
	else if(checking == 597) return format(model, len, "SFPD Car", 0);
	else if(checking == 598) return format(model, len, "LVPD Car", 0);
	else if(checking == 599) return format(model, len, "Police Rancher", 0);
	else if(checking == 600) return format(model, len, "Picador", 0);
	else if(checking == 601) return format(model, len, "S.W.A.T Tank", 0);
    else if(checking == 602) return format(model, len, "Alpha", 0);
	else if(checking == 603) return format(model, len, "Phoenix", 0);
	else if(checking == 604) return format(model, len, "Glendale Shit", 0);
	else if(checking == 605) return format(model, len, "Salder Shit", 0);
	else if(checking == 609) return format(model, len, "Boxville", 0);
	return 0;
}

stock IsPlayerDriver(playerid) //By Sacky
{
	if(IsPlayerConnected(playerid) && GetPlayerState(playerid)==PLAYER_STATE_DRIVER)
	{
		return 1;
	}
	return 0;
}

stock GetFactionName(factionid)
{
    new string[126];
    switch(factionid)
    {
        case 13: string = "Bone County News";
        case 12: string = "Bone County Government";
        case 11: string = "Bayside City Council";
        case 10: string = "Bayside Fire and Rescue";
        case 9: string = "Bayside Medical Department";
        case 8: string = "Bayside Police Department";
        case 7: string = "Las Payasadas Sheriff Department";
		case 6: string = "El Quebrados Council";
        case 5: string = "El Quebrados Sheriff Department";
        case 4: string = "Las Barrancas Sheriff Department";
        case 3: string = "Fort Carson Council";
        case 2: string = "Fort Carson Medical Service";
        case 1: string = "Fort Carson Sheriff Department";
        case 0: string = "None";
        default: string = "Unknown";
    }
    return string;
}

stock GetPlayerOrigin(playerid)
{
    new string[126];
    switch(PlayerInfo[playerid][Origin])
    {
        case 5: string = "Makedonija";
        case 4: string = "Crna Gora";
        case 3: string = "Hrvatska";
        case 2: string = "BIH";
        case 1: string = "Srbija";
        case 0: string = "Ostalo";
        default: string = "None";
    }
    return string;
}

stock Get2DZone(zone[], len, Float:x, Float:y, Float:z)
{
    #pragma unused z
 	for(new i = 0; i != sizeof(gSAZones); i++)
 	{
		if(x >= gSAZones[i][SAZONE_AREA][0] && x <= gSAZones[i][SAZONE_AREA][3] && y >= gSAZones[i][SAZONE_AREA][1] && y <= gSAZones[i][SAZONE_AREA][4])
		{
		    return format(zone, len, gSAZones[i][SAZONE_NAME]);
		}
	}
	return format(zone, len, "San Andreas");
}

stock ReturnVehicleModelID(string[])
{
	if(IsNumeric(string))
	{
		new id = strval(string);
		if(id >= 400 && id <= 611)
		{
		    return id;
		}
	}
	for(new i = 0;i < sizeof(vehName);i++)
    {
        if(strfind(vehName[i],string,true) != -1)
        {
            return i + 400;
        }
    }
    return 0;
}

stock AdminLog(string[], playerid)
{
    new
  		File:adminlogfile,
  		logstring[160],
  		Name[MAX_PLAYER_NAME],
  		day, month, year;
	GetPlayerName(playerid, Name, sizeof(Name));
	getdate(year, month, day);
  	format(logstring,sizeof(logstring),"%d/%d/%d - %s - %s\r\n", day, month, year, Name, string);
 	fopen("adminlog.txt", io_append);
  	fwrite(adminlogfile, logstring);
  	fclose(adminlogfile);
}

stock ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		new invehicle[MAX_PLAYERS];
		new virtualworld = GetPlayerVirtualWorld(playerid);
		new interior = GetPlayerInterior(playerid);
		new vehicleid = GetPlayerVehicleID(playerid);
		new ivehicleid;
		if(vehicleid)
		{
			GetVehiclePos(vehicleid,oldposx,oldposy,oldposz);
		}
		else
		{
			GetPlayerPos(playerid, oldposx, oldposy, oldposz);
			vehicleid = GetPlayerVehicleID(playerid);
		}
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
			    if(!BigEar[i])
			    {
					if(GetPlayerVirtualWorld(i) == virtualworld)
					{
						if((GetPlayerInterior(i) == interior))
						{
						    if(vehicleid)
						    {
							    if(IsPlayerInVehicle(i,vehicleid)) invehicle[i] = 1;
							}
							if(!invehicle[i])
							{
							    if(IsPlayerInAnyVehicle(i))
								{
								    ivehicleid = GetPlayerVehicleID(i);
								    GetVehiclePos(ivehicleid,posx,posy,posz);
								}
								else
								{
					    			GetPlayerPos(i,posx,posy,posz);
								}
								tempposx = (oldposx -posx);
								tempposy = (oldposy -posy);
								tempposz = (oldposz -posz);
								if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16))) SendClientMessage(i, col1, string);
								else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8))) SendClientMessage(i, col2, string);
								else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4))) SendClientMessage(i, col3, string);
								else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2))) SendClientMessage(i, col4, string);
								else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi))) SendClientMessage(i, col5, string);
							}
							else SendClientMessage(i, col1, string);
						}
					}
				}
				else SendClientMessage(i, col1, string);
			}
		}
	}
	return 1;
}

stock PlayerName(playerid)
{
    new name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof(name));
    return name;
}

stock FreezeThenAutoUnfreeze(playerid, time)
{
    TogglePlayerControllable(playerid, 0);
    SetTimerEx("UnfreezeBastard", time, false, "i", playerid);
}

IsNumeric(const string[])
{
    for (new i = 0, j = strlen(string); i < j; i++)
    {
        if (string[i] > '9' || string[i] < '0') return 0;
    }
    return 1;
}
// -------------------------------------------------------------------------- //
enum hInfo {
	hOwned,
	hPrice,
	hOwner[128],
	hLevel,
	hLocked,
	hRentable,
	hRentPrice,
	hGun1,
	hGun2,
	hGun3,
	hMoney,
	Float:hEntranceX,
	Float:hEntranceY,
	Float:hEntranceZ,
	Float:hEntranceA,
	Float:hExitX,
	Float:hExitY,
	Float:hExitZ,
	Float:hExitA,
	hInt,
	hWorld,
	hInsideInt,
	hInsideWorld,
	hInsideIcon,
	hOutsideIcon
}
new HouseInfo[200][hInfo];

public LoadHouses()
{
	new arrCoords[23][64];
    new strFromFile2[256];
    new File: file = fopen("Houses.cfg", io_read);
    if (file)
    {
  		new idx;
        while (idx < sizeof(HouseInfo))
    	{
    		fread(file, strFromFile2);
            split(strFromFile2, arrCoords, '|');
            HouseInfo[idx][hOwned] = strval(arrCoords[0]);
            HouseInfo[idx][hPrice] = strval(arrCoords[1]);
            strmid(HouseInfo[idx][hOwner], arrCoords[2], 0, strlen(arrCoords[2]), 255);
            HouseInfo[idx][hLevel] = strval(arrCoords[3]);
            HouseInfo[idx][hLocked] = strval(arrCoords[4]);
			HouseInfo[idx][hRentable] = strval(arrCoords[5]);
			HouseInfo[idx][hRentPrice] = strval(arrCoords[6]);
			HouseInfo[idx][hGun1] = strval(arrCoords[7]);
			HouseInfo[idx][hGun2] = strval(arrCoords[8]);
			HouseInfo[idx][hGun3] = strval(arrCoords[9]);
			HouseInfo[idx][hMoney] = strval(arrCoords[10]);
			HouseInfo[idx][hEntranceX] = floatstr(arrCoords[11]);
			HouseInfo[idx][hEntranceY] = floatstr(arrCoords[12]);
			HouseInfo[idx][hEntranceZ] = floatstr(arrCoords[13]);
			HouseInfo[idx][hEntranceA] = floatstr(arrCoords[14]);
			HouseInfo[idx][hExitX] = floatstr(arrCoords[15]);
			HouseInfo[idx][hExitY] = floatstr(arrCoords[16]);
			HouseInfo[idx][hExitZ] = floatstr(arrCoords[17]);
			HouseInfo[idx][hExitA] = floatstr(arrCoords[18]);
			HouseInfo[idx][hInt] = strval(arrCoords[19]);
			HouseInfo[idx][hWorld] = strval(arrCoords[20]);
			HouseInfo[idx][hInsideInt] = strval(arrCoords[21]);
			HouseInfo[idx][hInsideWorld] = strval(arrCoords[22]);
			if(HouseInfo[idx][hOutsideIcon]) DestroyDynamicPickup(HouseInfo[idx][hOutsideIcon]);
            if(HouseInfo[idx][hInsideIcon]) DestroyDynamicPickup(HouseInfo[idx][hInsideIcon]);
            HouseInfo[idx][hOutsideIcon] = CreateDynamicPickup(1273, 1, HouseInfo[idx][hEntranceX], HouseInfo[idx][hEntranceY], HouseInfo[idx][hEntranceZ], HouseInfo[idx][hWorld]);
            HouseInfo[idx][hInsideIcon] = CreateDynamicPickup(1273, 1, HouseInfo[idx][hExitX], HouseInfo[idx][hExitY], HouseInfo[idx][hExitZ], HouseInfo[idx][hInsideWorld]);
			idx++;

		}
		fclose(file);
	}
	return 1;
}


public RestartGamemode()
{
	foreach(Player, i) {
	    OnPlayerDisconnect(i, 2);
	}
	OnGameModeExit();
	return 1;
}

public SaveHouses()
{
    new idx;
	new File: file2;
	while (idx < sizeof(HouseInfo))
	{
        new coordsstring[512];
	    format(coordsstring, sizeof(coordsstring), "%d|%d|%s|%d|%d|%d|%d|%d|%d|%d|%d|%f|%f|%f|%f|%f|%f|%f|%f|%d|%d|%d|%d\r\n",
     	HouseInfo[idx][hOwned],
     	HouseInfo[idx][hPrice],
     	HouseInfo[idx][hOwner],
     	HouseInfo[idx][hLevel],
     	HouseInfo[idx][hLocked],
		HouseInfo[idx][hRentable],
		HouseInfo[idx][hRentPrice],
		HouseInfo[idx][hGun1],
		HouseInfo[idx][hGun2],
		HouseInfo[idx][hGun3],
		HouseInfo[idx][hMoney],
		HouseInfo[idx][hEntranceX],
		HouseInfo[idx][hEntranceY],
		HouseInfo[idx][hEntranceZ],
		HouseInfo[idx][hEntranceA],
		HouseInfo[idx][hExitX],
		HouseInfo[idx][hExitY],
		HouseInfo[idx][hExitZ],
		HouseInfo[idx][hExitA],
		HouseInfo[idx][hInt],
		HouseInfo[idx][hWorld],
		HouseInfo[idx][hInsideInt],
		HouseInfo[idx][hInsideWorld]);
        if(idx == 0)
		{
			file2 = fopen("Houses.cfg", io_write);
		}
		else
		{
			file2 = fopen("Houses.cfg", io_append);
		}
		fwrite(file2, coordsstring);
		idx++;
		fclose(file2);
	}
	return 1;
}
#define PATH "/citizens/%s.ini"

forward LoadUser_data(playerid,name[],value[]);
public LoadUser_data(playerid,name[],value[])
{
    INI_Int("Lozinka", PlayerInfo[playerid][Password]);
    INI_Int("Admin", PlayerInfo[playerid][Admin]);
    INI_Int("Drzava", PlayerInfo[playerid][Origin]);
    INI_Int("Pol", PlayerInfo[playerid][Gender]);
    INI_Int("Godina", PlayerInfo[playerid][Age]);
    INI_Float("sPosX", PlayerInfo[playerid][sPosX]);
    INI_Float("sPosY", PlayerInfo[playerid][sPosY]);
    INI_Float("sPosZ", PlayerInfo[playerid][sPosZ]);
    INI_Float("sPosA", PlayerInfo[playerid][sPosA]);
    INI_Float("sHealth", PlayerInfo[playerid][sHealth]);
    INI_Float("sArmor", PlayerInfo[playerid][sArmor]);
    INI_Int("Novac", PlayerInfo[playerid][Money]);
    INI_Int("Banka", PlayerInfo[playerid][BankBalance]);
    INI_Int("BankPin", PlayerInfo[playerid][BankPin]);
    INI_Int("Mobilni", PlayerInfo[playerid][Cellphone]);
    INI_Int("KucaID", PlayerInfo[playerid][HouseID]);
    INI_Int("AutoID", PlayerInfo[playerid][CarID]);
    INI_Int("Gun1", PlayerInfo[playerid][Gun1]);
    INI_Int("Gun2", PlayerInfo[playerid][Gun2]);
    INI_Int("Gun3", PlayerInfo[playerid][Gun3]);
    INI_Int("Gun4", PlayerInfo[playerid][Gun4]);
    INI_Int("Gun5", PlayerInfo[playerid][Gun5]);
    INI_Int("Gun6", PlayerInfo[playerid][Gun6]);
    INI_Int("Gun7", PlayerInfo[playerid][Gun7]);
    INI_Int("Gun8", PlayerInfo[playerid][Gun8]);
    INI_Int("Gun9", PlayerInfo[playerid][Gun9]);
    INI_Int("Gun10", PlayerInfo[playerid][Gun10]);
    INI_Int("Gun11", PlayerInfo[playerid][Gun11]);
    INI_Int("Gun12", PlayerInfo[playerid][Gun12]);
    INI_Int("Gun13", PlayerInfo[playerid][Gun13]);
    INI_Int("WTChannel", PlayerInfo[playerid][WTChannel]);
    INI_Int("Organizacija", PlayerInfo[playerid][Faction]);
	INI_Int("Lider", PlayerInfo[playerid][FLeader]);
	INI_String("Posao", PlayerInfo[playerid][Job], 64);
	INI_Int("sInterior", PlayerInfo[playerid][sInterior]);
	INI_Int("sVW", PlayerInfo[playerid][sVW]);
	INI_Int("Skin", PlayerInfo[playerid][Skin]);
	INI_Int("Muted", PlayerInfo[playerid][Muted]);
	INI_Int("nMute", PlayerInfo[playerid][nMute]);
	INI_Int("Helper", PlayerInfo[playerid][Helper]);
	INI_Int("Developer", PlayerInfo[playerid][Developer]);
	INI_Int("RentingID", PlayerInfo[playerid][RentingID]);
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

// [Publics] //

public LoadCar()
{
	new arrCoords[37][64];
	new strFromFile2[256];
	new File: file = fopen("dealership.cfg", io_read);
	if (file)
	{
		new idx = 0;
		while (idx < sizeof(CarInfo))
		{
			fread(file, strFromFile2);
			split(strFromFile2, arrCoords, ',');
			CarInfo[idx][vModel] = strval(arrCoords[0]);
			CarInfo[idx][vLocationx] = floatstr(arrCoords[1]);
			CarInfo[idx][vLocationy] = floatstr(arrCoords[2]);
			CarInfo[idx][vLocationz] = floatstr(arrCoords[3]);
			CarInfo[idx][vAngle] = floatstr(arrCoords[4]);
			CarInfo[idx][vColorOne] = strval(arrCoords[5]);
			CarInfo[idx][vColorTwo] = strval(arrCoords[6]);
			strmid(CarInfo[idx][vOwner], arrCoords[7], 0, strlen(arrCoords[7]), 255);
			strmid(CarInfo[idx][vDescription], arrCoords[8], 0, strlen(arrCoords[8]), 255);
			CarInfo[idx][vValue] = strval(arrCoords[9]);
			CarInfo[idx][vLicense] = strval(arrCoords[10]);
			CarInfo[idx][vOwned] = strval(arrCoords[11]);
			CarInfo[idx][vLock] = strval(arrCoords[12]);
			CarInfo[idx][vMod1] = strval(arrCoords[13]);
			CarInfo[idx][vMod2] = strval(arrCoords[14]);
			CarInfo[idx][vMod3] = strval(arrCoords[15]);
			CarInfo[idx][vMod4] = strval(arrCoords[16]);
			CarInfo[idx][vMod5] = strval(arrCoords[17]);
			CarInfo[idx][vMod6] = strval(arrCoords[18]);
			CarInfo[idx][vMod7] = strval(arrCoords[19]);
			CarInfo[idx][vMod8] = strval(arrCoords[20]);
			CarInfo[idx][vMod9] = strval(arrCoords[21]);
			CarInfo[idx][vMod10] = strval(arrCoords[22]);
			CarInfo[idx][vMod11] = strval(arrCoords[23]);
			CarInfo[idx][vMod12] = strval(arrCoords[24]);
			CarInfo[idx][vMod13] = strval(arrCoords[25]);
			CarInfo[idx][vMod14] = strval(arrCoords[26]);
			CarInfo[idx][vMod15] = strval(arrCoords[27]);
			CarInfo[idx][vMod16] = strval(arrCoords[28]);
			CarInfo[idx][vMod17] = strval(arrCoords[29]);
			CarInfo[idx][vPlate] = strval(arrCoords[30]);
			CarInfo[idx][vPot] = strval(arrCoords[31]);
			CarInfo[idx][vCrack] = strval(arrCoords[32]);
			CarInfo[idx][vMats] = strval(arrCoords[33]);
			CarInfo[idx][vGun1] = strval(arrCoords[34]);
			CarInfo[idx][vGun2] = strval(arrCoords[35]);
			CarInfo[idx][vGun3] = strval(arrCoords[36]);
			CarInfo[idx][ownedvehicle] = CreateVehicle(CarInfo[idx][vModel],CarInfo[idx][vLocationx],CarInfo[idx][vLocationy],CarInfo[idx][vLocationz],CarInfo[idx][vAngle],CarInfo[idx][vColorOne],CarInfo[idx][vColorTwo],300000);
			idx++;
		}
	}
	return 1;
}

public LoadDCars()
{
	new arrCoords[12][64];
	new strFromFile2[256];
	new File: file = fopen("dealershipcars.cfg", io_read);
	if (file)
	{
		new idx = 0;
		while (idx < sizeof(DCarInfo))
		{
			fread(file, strFromFile2);
			split(strFromFile2, arrCoords, ',');
			DCarInfo[idx][vdModel] = strval(arrCoords[0]);
			DCarInfo[idx][vdLocationx] = floatstr(arrCoords[1]);
			DCarInfo[idx][vdLocationy] = floatstr(arrCoords[2]);
			DCarInfo[idx][vdLocationz] = floatstr(arrCoords[3]);
			DCarInfo[idx][vdAngle] = floatstr(arrCoords[4]);
			DCarInfo[idx][vdColorOne] = strval(arrCoords[5]);
			DCarInfo[idx][vdColorTwo] = strval(arrCoords[6]);
			DCarInfo[idx][vdPrice] = strval(arrCoords[7]);
			DCarInfo[idx][vdSpawnX] = strval(arrCoords[8]);
			DCarInfo[idx][vdSpawnY] = strval(arrCoords[9]);
			DCarInfo[idx][vdSpawnZ] = strval(arrCoords[10]);
			DCarInfo[idx][vdSpawnA] = strval(arrCoords[11]);
			DCarInfo[idx][dealervehicle] = CreateVehicle(DCarInfo[idx][vdModel],DCarInfo[idx][vdLocationx],DCarInfo[idx][vdLocationy],DCarInfo[idx][vdLocationz],DCarInfo[idx][vdAngle],DCarInfo[idx][vdColorOne],DCarInfo[idx][vdColorTwo],1);
			idx++;
		}
		printf("Salonska vozila ucitana.");
	}
	return 1;
}

public SaveCars()
{
	new idx;
	new File: file2;
	while (idx < sizeof(CarInfo))
	{
	    new coordsstring[256];
		format(coordsstring, sizeof(coordsstring), "%d,%f,%f,%f,%f,%d,%d,%s,%s,%d,%s,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%s,%d,%d,%d,%d,%d,%d\r\n",
		CarInfo[idx][vModel],
		CarInfo[idx][vLocationx],
		CarInfo[idx][vLocationy],
		CarInfo[idx][vLocationz],
		CarInfo[idx][vAngle],
		CarInfo[idx][vColorOne],
		CarInfo[idx][vColorTwo],
		CarInfo[idx][vOwner],
		CarInfo[idx][vDescription],
		CarInfo[idx][vValue],
		CarInfo[idx][vLicense],
		CarInfo[idx][vOwned],
		CarInfo[idx][vLock],
		CarInfo[idx][vMod1],
		CarInfo[idx][vMod2],
		CarInfo[idx][vMod3],
		CarInfo[idx][vMod4],
		CarInfo[idx][vMod5],
		CarInfo[idx][vMod6],
		CarInfo[idx][vMod7],
		CarInfo[idx][vMod8],
		CarInfo[idx][vMod9],
		CarInfo[idx][vMod10],
		CarInfo[idx][vMod11],
		CarInfo[idx][vMod12],
		CarInfo[idx][vMod13],
		CarInfo[idx][vMod14],
		CarInfo[idx][vMod15],
		CarInfo[idx][vMod16],
		CarInfo[idx][vMod17],
		CarInfo[idx][vPlate],
		CarInfo[idx][vPot],
		CarInfo[idx][vCrack],
		CarInfo[idx][vMats],
		CarInfo[idx][vGun1],
		CarInfo[idx][vGun2],
		CarInfo[idx][vGun3]);
		if(idx == 0)
		{
			file2 = fopen("dealership.cfg", io_write);
		}
		else
		{
			file2 = fopen("dealership.cfg", io_append);
		}
		fwrite(file2, coordsstring);
		idx++;
		fclose(file2);
	}
	return 1;
}


public DeveloperMessage(color, const string[])
{
	foreach(Player, i)
	{
	    if(PlayerInfo[i][Developer] >= 1)
	    {
	        SendClientMessage(i, color, string);
	        return 1;
		}
	}
	return 1;
}

public HelperMessage(color, const string[])
{
	foreach(Player, i)
	{
	    if(PlayerInfo[i][Helper] >=1)
	    {
	        SendClientMessage(i, color, string);
	        return 1;
		}
	}
	return 1;
}

public AMessage(color, const string[])
{
	foreach(Player, i)
	{
	    if(PlayerInfo[i][Admin] >=1)
	    {
	        SendClientMessage(i, color, string);
	        return 1;
		}
	}
	return 1;
}

public SavePlayer(playerid)
{
	new INI:File = INI_Open(UserPath(playerid));
	INI_SetTag(File,"data");
	new Float:sX, Float:sY, Float:sZ, Float:sA, Float:sH, Float:sAr;
	GetPlayerPos(playerid, sX, sY, sZ);
	GetPlayerFacingAngle(playerid, sA);
	GetPlayerHealth(playerid, sH);
	GetPlayerArmour(playerid, sAr);
	INI_WriteInt(File, "Lozinka", PlayerInfo[playerid][Password]);
	INI_WriteInt(File, "Admin", PlayerInfo[playerid][Admin]);
	INI_WriteInt(File, "Drzava", PlayerInfo[playerid][Origin]);
	INI_WriteInt(File, "Pol", PlayerInfo[playerid][Gender]);
	INI_WriteInt(File, "Godina", PlayerInfo[playerid][Age]);
	INI_WriteFloat(File, "sPosX", sX);
	INI_WriteFloat(File, "sPosY", sY);
	INI_WriteFloat(File, "sPosZ", sZ);
	INI_WriteFloat(File, "sPosA", sA);
	INI_WriteFloat(File, "sHealth", sH);
	INI_WriteFloat(File, "sArmor", sAr);
	INI_WriteInt(File, "Novac", PlayerInfo[playerid][Money]);
	INI_WriteInt(File, "Banka", PlayerInfo[playerid][BankBalance]);
	INI_WriteInt(File, "BankPin", PlayerInfo[playerid][BankPin]);
	INI_WriteInt(File, "Mobilni", PlayerInfo[playerid][Cellphone]);
	INI_WriteInt(File, "KucaID", PlayerInfo[playerid][HouseID]);
	INI_WriteInt(File, "AutoID", PlayerInfo[playerid][CarID]);
	INI_WriteInt(File, "Gun1", 0);
	INI_WriteInt(File, "Gun2", 0);
	INI_WriteInt(File, "Gun3", 0);
	INI_WriteInt(File, "Gun4", 0);
	INI_WriteInt(File, "Gun5", 0);
	INI_WriteInt(File, "Gun6", 0);
	INI_WriteInt(File, "Gun7", 0);
	INI_WriteInt(File, "Gun8", 0);
	INI_WriteInt(File, "Gun9", 0);
	INI_WriteInt(File, "Gun10", 0);
	INI_WriteInt(File, "Gun11", 0);
	INI_WriteInt(File, "Gun12", 0);
	INI_WriteInt(File, "Gun13", 0);
	INI_WriteInt(File, "WTChannel", PlayerInfo[playerid][WTChannel]);
	INI_WriteInt(File, "Organizacija", PlayerInfo[playerid][Faction]);
	INI_WriteInt(File, "Lider", PlayerInfo[playerid][FLeader]);
	INI_WriteString(File, "Posao", PlayerInfo[playerid][Job]);
	INI_WriteInt(File, "sInterior", GetPlayerInterior(playerid));
	INI_WriteInt(File, "sVW", GetPlayerVirtualWorld(playerid));
	INI_WriteInt(File, "Skin", PlayerInfo[playerid][Skin]);
	INI_WriteInt(File, "Muted", PlayerInfo[playerid][Muted]);
	INI_WriteInt(File, "nMute", PlayerInfo[playerid][nMute]);
	INI_WriteInt(File, "Helper", PlayerInfo[playerid][Helper]);
	INI_WriteInt(File, "Developer", PlayerInfo[playerid][Developer]);
	INI_WriteInt(File, "RentingID", PlayerInfo[playerid][RentingID]);
	INI_Close(File);
	gPlayerLoggedIn[playerid] = 0;
	return 1;
}

public UnfreezeBastard(playerid)
{
    TogglePlayerControllable(playerid, 1);
}

public ClearScreen(playerid)
{
	SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");
    SendClientMessage(playerid, COLOR_WHITE, " ");

}

public split(const strsrc[], strdest[][], delimiter)
{
	new i, li;
	new aNum;
	new len;
	while(i <= strlen(strsrc)){
	    if(strsrc[i]==delimiter || i==strlen(strsrc)){
	        len = strmid(strdest[aNum], strsrc, li, i, 128);
	        strdest[aNum][len] = 0;
	        li = i+1;
	        aNum++;
		}
		i++;
	}
	return 1;
}
////////////////////////////////////////////////////////////////////////////////
/*
        case 11: string = "Bayside City Council";
        case 10: string = "Bayside Fire and Rescue";
        case 9: string = "Bayside Medical Department";
        case 8: string = "Bayside Police Department";
        case 7: string = "Las Payasadas Sheriff Department";
		case 6: string = "El Quebrados Council";
        case 5: string = "El Quebrados Sheriff Department";
        case 4: string = "Las Barrancas Sheriff Department";
*/

main()
{
	print("**************************");
	print("   	Wild West Roleplay   ");
	print("         Copyright        ");
	print("  Nikola Radmanovic - 2011   ");
	print("      Gamemode Ucitan     ");
	print("**************************");
}

// [YCMD Commands] //

YCMD:getjob(playerid, params[])
{
	new job[126];
	if(sscanf(params, "s[126]", job)) {
	    SendClientMessage(playerid, COLOR_GREY, "Koristi:{FFFFFF} /getjob [posao]");
	    SendClientMessage(playerid, COLOR_GREY, "Poslovi:{FFFFFF} Taxi Vozac");
	    return 1;
	}
	if(strcmp("Taxi Driver", job, true) == 0)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 1.5, -116.881134, 1132.390014, 19.742187))
	    {
	        if(strcmp("Taxi Driver", PlayerInfo[playerid][Job], true) == 0) return SendClientMessage(playerid, COLOR_GREY, "Error:{FFFFFF} You are already a Taxi Driver.");
	        SendClientMessage(playerid, COLOR_YELLOW, "Postali ste taksista.");
			format(PlayerInfo[playerid][Job], 64, "Taxi Vozac");
			return 1;
	    }
	    else
	    {
	        SendClientMessage(playerid, COLOR_LIGHTRED, "Greska:{FFFFFF} Niste na mestu za zaposljavanje.");
	    }
	}
	return 1;
}

YCMD:quitjob(playerid, params[])
{
	if(strcmp("None", PlayerInfo[playerid][Job], true) == 0) return SendClientMessage(playerid, COLOR_GREY, "You don't have a job to quit.");

	new string[126];
	format(string, sizeof(string), "Dali ste otkaz i vise niste %s.", PlayerInfo[playerid][Job]);
	SendClientMessage(playerid, COLOR_YELLOW, string);
	format(PlayerInfo[playerid][Job], 64, "None");
	return 1;
}

YCMD:makeleader(playerid, params[])
{
    if(gPlayerLoggedIn[playerid] == 0) return 1;

    if(PlayerInfo[playerid][Admin] < 5) return 1;

	new target, factionid, string[126];
	if(sscanf(params, "ud", target, factionid))
	{
		SendClientMessage(playerid, COLOR_GREY, "Koristi:{FFFFFF} /makeleader [Deo Imena/ID] [Organizacija ID]");
		SendClientMessage(playerid, COLOR_GREY,"Faction IDs: 1 - Fort Carson Sheriff Department");
		SendClientMessage(playerid, COLOR_GREY," 2 - Fort Carson Medical Service, 3 - Fort Carson Council");
		SendClientMessage(playerid, COLOR_GREY," 4 - Las Barrancas Sheriff Department, 5 - El Quebrados Sheriff Department");
		SendClientMessage(playerid, COLOR_GREY," 6 - El Quebrados Council, 7 - Las Payasadas Sheriff Department");
		SendClientMessage(playerid, COLOR_GREY," 8 - Bayside Police Department, 9 - Bayside Medical Department");
		SendClientMessage(playerid, COLOR_GREY," 10 - Bayside Fire and Rescue, 11 - Bayside City Council");
		SendClientMessage(playerid, COLOR_GREY," 12 - Bone County Government, 13 - Bone County News");
		return 1;
	}

	if(factionid < 0 || factionid > 13) return SendClientMessage(playerid, COLOR_GREY, "Organizacije idu od 0 do 13.");

	if(!IsPlayerConnected(target)) return SendClientMessage(playerid, COLOR_GREY ,"Igrac nije povezan.");

	if(factionid == PlayerInfo[target][FLeader]) return SendClientMessage(playerid, COLOR_GREY, "Taj igrac je vec lider neke organizacije.");

	if(factionid == 0)
	{
	    PlayerInfo[target][Faction] = 0;
	    PlayerInfo[target][FLeader] = 0;
	    SendClientMessage(target, COLOR_LIGHTRED, "Administrator vam je povukao liderska prava.");
		format(string, sizeof(string), "AdmWarning:{FFFFFF} Oduzeli ste %s liderska prava.", PlayerName(target));
		SendClientMessage(playerid, COLOR_LIGHTRED, string);
		return 1;
	}

	PlayerInfo[target][Faction] = factionid;
 	PlayerInfo[target][FLeader] = factionid;

	format(string, sizeof(string), "Admin %s vas je postavio za lidera %s!", PlayerName(playerid), GetFactionName(factionid));
	SendClientMessage(target, COLOR_LIGHTBLUE, string);

	format(string, sizeof(string), "AdmWarning:{FFFFFF} %s je dao %s lidera %s.", PlayerName(playerid), PlayerName(target), GetFactionName(factionid));
	AMessage(COLOR_LIGHTRED, string);

	return 1;
}

YCMD:door(playerid, params[])
{
    if(gPlayerLoggedIn[playerid] == 0) return 1;

    for(new h = 1; h < sizeof(HouseInfo); h++)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 1.0, HouseInfo[h][hEntranceX], HouseInfo[h][hEntranceY], HouseInfo[h][hEntranceZ]))
	    {
	        if(HouseInfo[h][hLocked] == 1) return SendClientMessage(playerid, COLOR_GREY, "Kuca je zakljucana!");
			SetPlayerPos(playerid, HouseInfo[h][hExitX], HouseInfo[h][hExitY], HouseInfo[h][hExitZ]);
			SetPlayerFacingAngle(playerid, HouseInfo[h][hExitA]);
			SetPlayerInterior(playerid, HouseInfo[h][hInsideInt]);
			SetPlayerVirtualWorld(playerid, HouseInfo[h][hInsideWorld]);
			return 1;
		}
		if(IsPlayerInRangeOfPoint(playerid, 2.0, HouseInfo[h][hExitX], HouseInfo[h][hExitY], HouseInfo[h][hExitZ]) && GetPlayerVirtualWorld(playerid) == HouseInfo[h][hInsideWorld])
	    {
			SetPlayerPos(playerid, HouseInfo[h][hEntranceX], HouseInfo[h][hEntranceY], HouseInfo[h][hEntranceZ]);
			SetPlayerFacingAngle(playerid, HouseInfo[h][hEntranceA]);
			SetPlayerInterior(playerid, HouseInfo[h][hInt]);
			SetPlayerVirtualWorld(playerid, HouseInfo[h][hWorld]);
			return 1;
		}
	}
	return 1;
}

YCMD:givemoney(playerid, params[])
{
    if(gPlayerLoggedIn[playerid] == 0) return 1;

    if(PlayerInfo[playerid][Admin] < 4) return 1;

    new target, money;

    if(sscanf(params, "ud", target, money)) return SendClientMessage(playerid, COLOR_GREY, "Koristi:{FFFFFF} /givemoney [Deo Imena/Player ID] [Amount]");

    new string[128];
	PlayerInfo[target][Money] += money;
	GivePlayerMoney(target, money);

	format(string, sizeof(string), "AdmWarning: %s je dao %s $%d.", PlayerName(playerid), PlayerName(target), money);
	AMessage(COLOR_LIGHTRED, string);
	format(string, sizeof(string), "AdmWarning: %s je dao $%d.", PlayerName(playerid), money);
	SendClientMessage(target, COLOR_GREY, string);

    return 1;
}

YCMD:sellhouse(playerid, params[])
{
    if(gPlayerLoggedIn[playerid] == 0) return 1;

    new id = PlayerInfo[playerid][HouseID];

    if(id == 0) return SendClientMessage(playerid, COLOR_GREY, "Nemate kucu koju bi mogli da prodate.");

    HouseInfo[id][hOwned] = 0;
    HouseInfo[id][hOwner] = 0;
    HouseInfo[id][hLocked] = 1;
	HouseInfo[id][hRentable] = 0;
	HouseInfo[id][hRentPrice] = 0;
	HouseInfo[id][hGun1] = 0;
	HouseInfo[id][hGun2] = 0;
	HouseInfo[id][hGun3] = 0;
	HouseInfo[id][hMoney] = 0;

 	PlayerInfo[playerid][HouseID] = 0;

	SendClientMessage(playerid, COLOR_YELLOW, "Prodali ste kucu!");

	return 1;
}

IsPlayerNearHouseEnt(playerid)
{
    for(new h = 1; h < sizeof(HouseInfo); h++)
	{
 		if(IsPlayerInRangeOfPoint(playerid, 2.0, HouseInfo[h][hEntranceX], HouseInfo[h][hEntranceY], HouseInfo[h][hEntranceZ])) return h;
    }
    return -1;
}

YCMD:renthouse(playerid, params[])
{
    if(gPlayerLoggedIn[playerid] == 0) return 1;
    new rentid = PlayerInfo[playerid][RentingID];
    new houseid = PlayerInfo[playerid][HouseID];
    new atid = IsPlayerNearHouseEnt(playerid);

    if(houseid !=0) return SendClientMessage(playerid, COLOR_GREY, "{#FFFFFF}Agencija:{#bbbfbd}Vec imate kucu te stoga niste u zakonskoj mogucnosti da iznajmite ovu.");

    if(rentid !=0) return SendClientMessage(playerid, COLOR_GREY, "");

    if(atid == 0 || atid == -1) return SendClientMessage(playerid, COLOR_GREY, "pa zar ja vec nisam iznajmio sobu...");

    if(HouseInfo[atid][hRentable] == 0) return SendClientMessage(playerid, COLOR_GREY, "{#FFFFFF}Agencija:{#bbbfbd}Ova kuca ne nudi sobe za izdavanje.");

    if(PlayerInfo[playerid][Money] < HouseInfo[atid][hRentPrice]) return SendClientMessage(playerid, COLOR_GREY, "steta nemam dovojno novca za depozit!");

    PlayerInfo[playerid][RentingID] = atid;
	SendClientMessage(playerid, COLOR_YELLOW, "Iznajmljujete sobu u ovoj kuci! Koristite /renthelp za pomoc.");

	return 1;
}

YCMD:rentoff(playerid, params[])
{
     if(gPlayerLoggedIn[playerid] == 0) return 1;
     if(PlayerInfo[playerid][RentingID] != 0)
     {
   	 	PlayerInfo[playerid][RentingID] = 0;
     	SendClientMessage(playerid, COLOR_YELLOW, "Prestali ste sa iznajmljivanjem sobe i sada mozete kupiti kucu.");
     	return 1;
     }
     else
     {
        SendClientMessage(playerid, COLOR_GREY, "Vi ne iznajmljujete sobu.");
	 }
     return 1;
}

YCMD:lockhouse(playerid, params[])
{
    if(gPlayerLoggedIn[playerid] == 0) return 1;

    new id = PlayerInfo[playerid][HouseID];
    new rentid = PlayerInfo[playerid][RentingID];

	new string[126];

	if(id != 0)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.0, HouseInfo[id][hEntranceX], HouseInfo[id][hEntranceY], HouseInfo[id][hEntranceZ]) || IsPlayerInRangeOfPoint(playerid, 10.0, HouseInfo[id][hExitX], HouseInfo[id][hExitY], HouseInfo[id][hExitZ]))
		{
			if(HouseInfo[id][hLocked] == 0)
			{
			    HouseInfo[id][hLocked] = 1;
			    format(string, sizeof(string), "* %s vadi kljuc iz dzepa i zakljucava kucu.", PlayerName(playerid));
			    ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			    return 1;
			}
			if(HouseInfo[id][hLocked] == 1)
			{
			    HouseInfo[id][hLocked] = 0;
			    format(string, sizeof(string), "* %s vadi kljuc i otkljucava kucu.", PlayerName(playerid));
	            ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				return 1;
			}
		}
		else
		{
	 		SendClientMessage(playerid, COLOR_GREY, "Niste blizu vrata kuce od koje imate kljuc.");
	 		return 1;
		}
	}
	if(rentid !=0)
	{
	 	if(IsPlayerInRangeOfPoint(playerid, 2.0, HouseInfo[rentid][hEntranceX], HouseInfo[rentid][hEntranceY], HouseInfo[rentid][hEntranceZ]) || IsPlayerInRangeOfPoint(playerid, 10.0, HouseInfo[rentid][hExitX], HouseInfo[rentid][hExitY], HouseInfo[rentid][hExitZ]))
		{
			if(HouseInfo[rentid][hLocked] == 0)
			{
			    HouseInfo[rentid][hLocked] = 1;
			    format(string, sizeof(string), "* %s vadi kljuc iz dzepa i zakljucava kucu.", PlayerName(playerid));
			    ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			    return 1;
			}
			if(HouseInfo[rentid][hLocked] == 1)
			{
			    HouseInfo[rentid][hLocked] = 0;
			    format(string, sizeof(string), "* %s vadi kljuc i otkljucava kucu.", PlayerName(playerid));
	            ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				return 1;
			}
		}
		else
		{
	 		SendClientMessage(playerid, COLOR_GREY, "Niste blizu vrata kuce od koje imate kljuc.");
	 		return 1;
		}
	}
	else
	{
	    SendClientMessage(playerid, COLOR_GREY, "Vec imate kucu");
	}
    return 1;
}

YCMD:rentable(playerid, params[])
{
    if(gPlayerLoggedIn[playerid] == 0) return 1;

    new id = PlayerInfo[playerid][HouseID];

    if(id == 0) return SendClientMessage(playerid, COLOR_GREY, "Nemate kucu.");

    if(HouseInfo[id][hRentable] == 0)
    {
		HouseInfo[id][hRentable] =1;
		SendClientMessage(playerid, COLOR_YELLOW, "Izdajete sobu. Koristite /rentprice da podesite cenu.");
		return 1;
	}
	if(HouseInfo[id][hRentable] == 1)
	{
	    HouseInfo[id][hRentable] =0;
	    SendClientMessage(playerid, COLOR_YELLOW, "Vise ne izdajete sobu. Koristite komandu ponovo da bi ste uradili suprotno.");
	    HouseInfo[id][hRentPrice] = 0;
	    return 1;
	}
	return 1;
}

YCMD:rentprice(playerid, params[])
{
    if(gPlayerLoggedIn[playerid] == 0) return 1;

    new id = PlayerInfo[playerid][HouseID];

	if(id == 0) return SendClientMessage(playerid, COLOR_GREY, "Nemate kucu.");

	if(HouseInfo[id][hRentable] == 0) return SendClientMessage(playerid, COLOR_GREY, "Morate da izdate sobu da bi ste podesili cenu.");

	new rentprice, string[126];

	if(sscanf(params, "d", rentprice)) return SendClientMessage(playerid, COLOR_GREY, "Koristi:{FFFFFF} /rentprice [50-500]");

	if(rentprice < 50 || rentprice > 500) return SendClientMessage(playerid, COLOR_GREY, "Koristi:{FFFFFF} /rentprice [50-500]");

	HouseInfo[id][hRentPrice] = rentprice;

	format(string, sizeof(string), "Podesili ste cenu renta na $%d.", rentprice);
	SendClientMessage(playerid, COLOR_YELLOW, string);

	return 1;
}

YCMD:help(playerid, params[])
{
    if(gPlayerLoggedIn[playerid] == 0) return 1;
    SendClientMessage(playerid, COLOR_WHITE, "HELP: /me /do /b /o /s /l");
    SendClientMessage(playerid, COLOR_WHITE, "HELP: /househelp /renthelp /developers /helpers /admini");
	return 1;
}

YCMD:househelp(playerid, params[])
{
    if(gPlayerLoggedIn[playerid] == 0) return 1;

    SendClientMessage(playerid, COLOR_YELLOW, "POMOC:");
    SendClientMessage(playerid, COLOR_WHITE, "/kupikucu /sellhouse /lockhouse /rentable /rentprice");
    return 1;
}

YCMD:renthelp(playerid, params[])
{
    if(gPlayerLoggedIn[playerid] == 0) return 1;

    SendClientMessage(playerid, COLOR_YELLOW, "Renthelp:");
    SendClientMessage(playerid, COLOR_WHITE, "/renthouse /rentoff /lockhouse");
    return 1;
}

YCMD:kupikucu(playerid, params[])
{
    if(gPlayerLoggedIn[playerid] == 0) return 1;

	new id = IsPlayerNearHouseEnt(playerid);
	new rentid = PlayerInfo[playerid][RentingID];

	if(id == -1 || id == 0) return SendClientMessage(playerid, COLOR_GREY, "Niste blizu kuce.");

	if(HouseInfo[id][hOwned] != 0 || HouseInfo[id][hPrice] == 0) return SendClientMessage(playerid, COLOR_GREY, "This house is not for sale.");

	if(rentid != 0) return SendClientMessage(playerid, COLOR_LIGHTRED, "Vi iznajmljujete sobu.");
	if(PlayerInfo[playerid][HouseID] != 0) return SendClientMessage(playerid, COLOR_LIGHTRED, "Vec imate kucu.");

	if(PlayerInfo[playerid][Money] < HouseInfo[id][hPrice]) return SendClientMessage(playerid, COLOR_LIGHTRED, "Nemate dovoljno novca.");

	PlayerInfo[playerid][HouseID] = id;
	PlayerInfo[playerid][Money] -= HouseInfo[id][hPrice];
	GivePlayerMoney(playerid, -HouseInfo[id][hPrice]);

	HouseInfo[id][hLocked] = 0;
	HouseInfo[id][hOwned] = 1;
	HouseInfo[id][hRentable] = 0;
	strmid(HouseInfo[id][hOwner], PlayerName(playerid), 0, strlen(PlayerName(playerid)), 255);

	SendClientMessage(playerid, COLOR_YELLOW, "Cestitamo! Koristite /househelp za pomoc ili, /pitaj!");
	return 1;
}

YCMD:edithouse(playerid, params[])
{
    if(gPlayerLoggedIn[playerid] == 0) return 1;

	if(PlayerInfo[playerid][Admin] < 5) return 1;

	new id, what[128], amount;
	new string[128];
	if(sscanf(params, "ds[128]D(0)", id, what, amount)) return SendClientMessage(playerid, COLOR_GREY, "Koristi:{FFFFFF} /edithouse [id] [int/cena/level] [iznos]");

	if(strcmp(what, "int") == 0)
	{
	    new Float:X, Float:Y, Float:Z, Float:A;

	    GetPlayerPos(playerid, X, Y, Z);
	    GetPlayerFacingAngle(playerid, A);
    	HouseInfo[id][hEntranceX] = X;
		HouseInfo[id][hEntranceY] = Y;
		HouseInfo[id][hEntranceZ] = Z;
		HouseInfo[id][hEntranceA] = A;

		new world = GetPlayerVirtualWorld(playerid);

		HouseInfo[id][hWorld] =world;

 		if(HouseInfo[id][hOutsideIcon]) DestroyDynamicPickup(HouseInfo[id][hOutsideIcon]);
 		if(HouseInfo[id][hInsideIcon]) DestroyDynamicPickup(HouseInfo[id][hInsideIcon]);
 		HouseInfo[id][hOutsideIcon] = CreateDynamicPickup(1273, 1, HouseInfo[id][hEntranceX], HouseInfo[id][hEntranceY], HouseInfo[id][hEntranceZ], HouseInfo[id][hWorld]);

	    SendClientMessage(playerid, COLOR_GREY, "Promenili ste interior kuce.");

	    return 1;
	 }
	if(strcmp(what, "cena") == 0)
	{
		if(amount < 10000) return SendClientMessage(playerid, COLOR_GREY, "Koristi:{FFFFFF} /edithouse [id] [price] [10,000 +]");

		HouseInfo[id][hPrice] = amount;
		format(string, sizeof(string), "AdmWarning: Cena kuce %d je promenjena na $%d", id, amount);
		SendClientMessage(playerid, COLOR_LIGHTRED, string);
		return 1;
	}
	if(strcmp(what, "level") == 0)
	{
		if(amount <= 0) return SendClientMessage(playerid, COLOR_GREY, "Koristi:{FFFFFF} /edithouse [id] [level] [level]");

		HouseInfo[id][hLevel] = amount;
		format(string, sizeof(string), "AdmWarning: Level potreban za kupovinu kuce %d je postavljen na %d", id, amount);
		SendClientMessage(playerid, COLOR_LIGHTRED, string);
		return 1;
	}
	else return SendClientMessage(playerid, COLOR_GREY, "Koristi:{FFFFFF} /edithouse [id] [int/cena/level] [iznos]");
}

YCMD:createhouse(playerid, params[])
{
    if(gPlayerLoggedIn[playerid] == 0) return 1;

	if(PlayerInfo[playerid][Admin] < 5) return 1;

	new price, level, id, int, world, string[128];

	if(sscanf(params, "dd", price, level)) return SendClientMessage(playerid, COLOR_GREY, "Koristi:{FFFFFF} /createhouse [cena] [level]");

	if(level < 0 || level > 10) return SendClientMessage(playerid, COLOR_GREY, "Koristi:{FFFFFF} Level ne moze biti manji od 1 i veci od 10.");

	if(price < 10000) return SendClientMessage(playerid, COLOR_GREY, "Koristi:{FFFFFF} Cena ne moze biti manja od $10,000.");

	for(new h = 1;h < sizeof(HouseInfo);h++)
	{
		if(HouseInfo[h][hPrice] == 0)
		{
			id = h;
			break;
		}
	}

	new Float:X,Float:Y,Float:Z,Float:A;

	GetPlayerPos(playerid, X, Y, Z);
	GetPlayerFacingAngle(playerid, A);
	int = GetPlayerInterior(playerid);
	world = GetPlayerVirtualWorld(playerid);

	HouseInfo[id][hOwned] = 0;
	HouseInfo[id][hPrice] = price;
	HouseInfo[id][hLevel] = level;
	HouseInfo[id][hEntranceX] = X;
	HouseInfo[id][hEntranceY] = Y;
	HouseInfo[id][hEntranceZ] = Z;
	HouseInfo[id][hEntranceA] = A;
	HouseInfo[id][hLocked] = 1;

	HouseInfo[id][hInt] =int;
	HouseInfo[id][hWorld] =world;
	HouseInfo[id][hInsideWorld] =id;

	if(level == 1)
	{
	    HouseInfo[id][hExitX] = 2259.533935;
	    HouseInfo[id][hExitY] = -1135.811401;
	    HouseInfo[id][hExitZ] = 1050.632812;
	    HouseInfo[id][hExitA] = 273.193237;
	    HouseInfo[id][hInsideInt] = 10;
	}

	if(HouseInfo[id][hOutsideIcon]) DestroyDynamicPickup(HouseInfo[id][hOutsideIcon]);
 	if(HouseInfo[id][hInsideIcon]) DestroyDynamicPickup(HouseInfo[id][hInsideIcon]);
 	HouseInfo[id][hOutsideIcon] = CreateDynamicPickup(1273, 1, HouseInfo[id][hEntranceX], HouseInfo[id][hEntranceY], HouseInfo[id][hEntranceZ], HouseInfo[id][hWorld]);
 	HouseInfo[id][hInsideIcon] = CreateDynamicPickup(1273, 1, HouseInfo[id][hExitX], HouseInfo[id][hExitY], HouseInfo[id][hExitZ], HouseInfo[id][hInsideWorld]);

	format(string, sizeof(string), "AdmWarning: %s je napravio kucu id: %d cena: $%d level: %d.", PlayerName(playerid), id, price, level);
	AMessage(COLOR_LIGHTRED, string);
	return 1;
}

YCMD:deletehouse(playerid, params[])
{
    if(gPlayerLoggedIn[playerid] == 0) return 1;

	if(PlayerInfo[playerid][Admin] < 5) return 1;

	new id;

	if(sscanf(params, "d", id)) return SendClientMessage(playerid, COLOR_GREY, "Koristi:{FFFFFF} /deletehouse [id]");

	HouseInfo[id][hOwned] = 0;
	HouseInfo[id][hPrice] = 0;
	HouseInfo[id][hOwner] = 0;
	HouseInfo[id][hLevel] = 0;
	HouseInfo[id][hLocked] = 0;
	HouseInfo[id][hRentable] = 0;
	HouseInfo[id][hRentPrice] = 0;
	HouseInfo[id][hGun1] = 0;
	HouseInfo[id][hGun2] = 0;
	HouseInfo[id][hGun3] = 0;
	HouseInfo[id][hMoney] = 0;
	HouseInfo[id][hEntranceX] = 0;
	HouseInfo[id][hEntranceY] = 0;
	HouseInfo[id][hEntranceZ] = 0;
	HouseInfo[id][hEntranceA] = 0;
	HouseInfo[id][hExitX] = 0;
	HouseInfo[id][hExitY] = 0;
	HouseInfo[id][hExitZ] = 0;
	HouseInfo[id][hExitA] = 0;
	HouseInfo[id][hInt] = 0;
	HouseInfo[id][hWorld] = 0;

	if(HouseInfo[id][hOutsideIcon]) DestroyDynamicPickup(HouseInfo[id][hOutsideIcon]);

	new string[128];

	format(string, sizeof(string), "AdmWarning: %s je obrisao kucu %d.", PlayerName(playerid), id);
	AMessage(COLOR_LIGHTRED, string);

	return 1;
}

YCMD:gotokuca(playerid, params[])
{
    if(gPlayerLoggedIn[playerid] == 0) return 1;

    if(PlayerInfo[playerid][Admin] < 3) return 1;

    new id;
	if(sscanf(params, "d", id)) return SendClientMessage(playerid, COLOR_GREY, "Koristi:{FFFFFF} /gotokuca [kuca id]");

	SetPlayerPos(playerid, HouseInfo[id][hEntranceX], HouseInfo[id][hEntranceY], HouseInfo[id][hEntranceZ]);
	SendClientMessage(playerid, COLOR_WHITE, "Teleportovanje...");
	return 1;
}

YCMD:b(playerid, params[])
{
    if(gPlayerLoggedIn[playerid] == 0) return 1;

	if(isnull(params)) return SendClientMessage(playerid, COLOR_GREY, "Koristi:{FFFFFF} /b [local ooc]");

	new string[126];

	format(string, sizeof(string), "%s kaze: (( %s ))", PlayerName(playerid), params);
	ProxDetector(30.0, playerid, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);

	return 1;
}

YCMD:hc(playerid, params[])
{
	if(gPlayerLoggedIn[playerid] == 0) return 1;

	new string[128], level[128];

	if(PlayerInfo[playerid][Helper] == 0) return 1;

	if(isnull(params)) return SendClientMessage(playerid, COLOR_GREY, "Koristi:{FFFFFF} /hc [tekst]");

	switch(PlayerInfo[playerid][Helper])
	{
		case 1: level = "General Helper";
		case 2: level = "Senior Helper";
		case 3: level = "Head Helper";
	}

	format(string, sizeof(string), "** %s %s kaze: %s", level, PlayerName(playerid), params);
	HelperMessage(COLOR_LIGHTBLUE, string);
	return 1;
}

YCMD:a(playerid, params[])
{
	if(gPlayerLoggedIn[playerid] == 0) return 1;

	new string[128], level[128];

	if(PlayerInfo[playerid][Admin] == 0) return 1;

	if(isnull(params)) return SendClientMessage(playerid, COLOR_GREY, "Koristi:{FFFFFF} /a [tekst]");

	switch(PlayerInfo[playerid][Admin])
	{
	    case 1: level = "Secret Admin";
		case 2: level = "Junior Admin";
		case 3: level = "General Administrator";
		case 4: level = "Head Administrator";
		case 5: level = "Community Owner";
	}
	format(string, sizeof(string), "** %s %s kaze: %s", level, PlayerName(playerid), params);
	AMessage(COLOR_LIGHTORANGE, string);
	return 1;
}

YCMD:dc(playerid, params[])
{
	if(gPlayerLoggedIn[playerid] == 0) return 1;

	new string[128], level[128];

	if(PlayerInfo[playerid][Developer] == 0) return 1;

	if(isnull(params)) return SendClientMessage(playerid, COLOR_GREY, "Koristi:{FFFFFF} /dc [Koristi]");

	switch(PlayerInfo[playerid][Developer])
 	{
      case 1: level = "Developer";
      case 2: level = "Senior Developer";
      case 3: level = "Head Developer";
	}

	format(string, sizeof(string), "** %s %s Koristi: %s", level, PlayerName(playerid), params);
	DeveloperMessage(COLOR_LIGHTORANGE, string);
	return 1;
}

YCMD:o(playerid, params[])
{
	if(isnull(params)) return SendClientMessage(playerid, COLOR_GREY, "Koristi:{FFFFFF} /o [global ooc]");

	new string[126];

	format(string, sizeof(string), "(( [OOC] %s kaze: %s ))", PlayerName(playerid), params);

	if(noooc == 0 && PlayerInfo[playerid][Admin] < 3) return SendClientMessage(playerid, COLOR_GREY, "OOC chat je {#f40000}onemogucen.");
	SendClientMessageToAll(COLOR_WHITE, string);

	return 1;
}

YCMD:me(playerid, params[])
{
    if(isnull(params)) return SendClientMessage(playerid, COLOR_GREY, "Koristi:{FFFFFF} /me [akcija]");

	new string[126];

	format(string, sizeof(string), "* %s %s", PlayerName(playerid), params);
	ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

	return 1;
}

YCMD:l(playerid, params[])
{
    if(isnull(params)) return SendClientMessage(playerid, COLOR_GREY, "Koristi:{FFFFFF} /l [tekst]");

	new string[126];

	format(string, sizeof(string), "%s kaze: [Tiho] %s", PlayerName(playerid), params);
	ProxDetector(5.0, playerid, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);

	return 1;
}


YCMD:s(playerid, params[])
{
    if(isnull(params)) return SendClientMessage(playerid, COLOR_GREY, "Koristi:{FFFFFF} /s [tekst]");

	new string[126];

	format(string, sizeof(string), "%s se dere: %s!", PlayerName(playerid), params);
	ProxDetector(60.0, playerid, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);

	return 1;
}

YCMD:do(playerid, params[])
{
    if(isnull(params)) return SendClientMessage(playerid, COLOR_GREY, "Koristi:{FFFFFF} /do [akcija]");

    new string[126];

	format(string, sizeof(string), "* %s (( %s ))", params, PlayerName(playerid));
	ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

	return 1;
}

YCMD:engine(playerid, params[])
{
    #pragma unused params
	new string[128];
	new sendername[MAX_PLAYER_NAME];
	new vehiclename[128];
	new vehicleid = GetPlayerVehicleID(playerid);
	GetPlayerName(playerid, sendername, sizeof(sendername));
	new engine,lights,alarm,doors,bonnet,boot,objective;
    GetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, alarm, doors, bonnet, boot, objective);
	if(!IsPlayerDriver(playerid))
	{
		SendClientMessage(playerid, COLOR_GREY,"* Niste u vozilu sa motorom!");
		return 1;
	}
		else if(IsPlayerDriver(playerid))
			{
    			if(engine != 1)
				{
				    engine = 1;
					SetVehicleParamsEx(GetPlayerVehicleID(playerid),VEHICLE_PARAMS_ON,lights,alarm,doors,bonnet,boot,objective);
        	    	GetVehicleName(vehicleid, vehiclename, sizeof(vehiclename));
					format(string, sizeof(string), "* %s pokusava da upali motor vozila %s .", sendername, vehiclename);
				    ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				    return 1;
				}
				else
				{
				    engine = 0;
					SetVehicleParamsEx(GetPlayerVehicleID(playerid),VEHICLE_PARAMS_OFF,lights,alarm,doors,bonnet,boot,objective);
					format(string, sizeof(string), "* %s gasi motor vozila.", sendername);
				    ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				    return 1;
				}
		}
  	return engine;
}

YCMD:lights(playerid, params[])
{
    #pragma unused params
	new string[128];
	new sendername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, sendername, sizeof(sendername));
	new engine,lights,alarm,doors,bonnet,boot,objective;
    GetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, alarm, doors, bonnet, boot, objective);
	if(!IsPlayerDriver(playerid))
	{
		SendClientMessage(playerid, COLOR_GREY,"* Niste u vozilu.");
		return 1;
	}
		else if(IsPlayerDriver(playerid))
			{
    			if(lights != 1)
				{
				    lights = 1;
					SetVehicleParamsEx(GetPlayerVehicleID(playerid),engine,VEHICLE_PARAMS_ON,alarm,doors,bonnet,boot,objective);
					format(string, sizeof(string), "* %s pali svetla na vozilu.", sendername);
				    ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				    return 1;
				}
				else
				{
				    lights = 0;
					SetVehicleParamsEx(GetPlayerVehicleID(playerid),engine,VEHICLE_PARAMS_OFF,alarm,doors,bonnet,boot,objective);
					format(string, sizeof(string), "* %s gasi svetla na vozilu.", sendername);
				    ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				    return 1;
				}
		}
  	return lights;
}

YCMD:hood(playerid, params[])
{
    #pragma unused params
	new string[128];
	new sendername[MAX_PLAYER_NAME];
	new vehiclename[128];
	GetPlayerName(playerid, sendername, sizeof(sendername));
	new engine,lights,alarm,doors,bonnet,boot,objective;
    new oldcar = gLastCar[playerid];
	new Float:cX, Float:cY, Float:cZ;
	GetVehicleParamsEx(oldcar, engine, lights, alarm, doors, bonnet, boot, objective);
	GetVehiclePos(oldcar, cX, cY, cZ);
	new vehicleid = GetPlayerVehicleID(playerid);
	if(!IsAPlane(vehicleid) || !IsAHelicopter(vehicleid) || !IsABike(vehicleid) || !IsATrain(vehicleid) || !IsABoat(vehicleid))
	{
		if(IsPlayerDriver(playerid) || IsPlayerInRangeOfPoint(playerid, 5, cX-2, cY, cZ))
			{
    			if(bonnet != 1)
				{
				    bonnet = 1;
					SetVehicleParamsEx(oldcar,engine,lights,alarm,doors,VEHICLE_PARAMS_ON,boot,objective);
					GetVehicleName(vehicleid, vehiclename, sizeof(vehiclename));
					format(string, sizeof(string), "* %s otvara haubu.", sendername);
				    ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				    return 1;
				}
				else
				{
				    bonnet = 0;
					SetVehicleParamsEx(oldcar,engine,lights,alarm,doors,VEHICLE_PARAMS_OFF,boot,objective);
					format(string, sizeof(string), "* %s zatvara haubu.", sendername);
				    ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				    return 1;
				}
		}
	}
  	return bonnet;
}

YCMD:trunk(playerid, params[])
{
    #pragma unused params
	new string[128];
	new sendername[MAX_PLAYER_NAME];
	new vehiclename[128];
	GetPlayerName(playerid, sendername, sizeof(sendername));
	new engine,lights,alarm,doors,bonnet,boot,objective;
    new oldcar = gLastCar[playerid];
	new Float:cX, Float:cY, Float:cZ;
	GetVehicleParamsEx(oldcar, engine, lights, alarm, doors, bonnet, boot, objective);
	GetVehiclePos(oldcar, cX, cY, cZ);
	new vehicleid = GetPlayerVehicleID(playerid);
	if(!IsAPlane(vehicleid) || !IsAHelicopter(vehicleid) || !IsABike(vehicleid) || !IsATrain(vehicleid) || !IsABoat(vehicleid))
	{
		if(IsPlayerDriver(playerid) || IsPlayerInRangeOfPoint(playerid, 5, cX+2, cY, cZ))
		{
 			if(boot != 1)
			{
		 		boot = 1;
				SetVehicleParamsEx(oldcar,engine,lights,alarm,doors,bonnet,VEHICLE_PARAMS_ON,objective);
				GetVehicleName(vehicleid, vehiclename, sizeof(vehiclename));
				format(string, sizeof(string), "* %s otvara gepek.", sendername);
				ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
  				return 1;
			}
			else
			{
		 		boot = 0;
				SetVehicleParamsEx(oldcar,engine,lights,alarm,doors,bonnet,VEHICLE_PARAMS_OFF,objective);
				GetVehicleName(vehicleid, vehiclename, sizeof(vehiclename));
				format(string, sizeof(string), "* %s zatvara gepek.", sendername);
				ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
  				return 1;
			}
		}
	}
  	return boot;
}

YCMD:saveveh(playerid, params[])
{
    if(gPlayerLoggedIn[playerid] == 0) return 1;

    if(PlayerInfo[playerid][Admin] < 4) return 1;

	if(!isnull(params)) {

	    new string[256];
	    new File:onfoot=fopen("savedvehicles.txt", io_append);
	    new Float:X, Float:Y, Float:Z, Float:A, vehicleid, model;

	    vehicleid = GetPlayerVehicleID(playerid);
	    model = GetVehicleModel(vehicleid);

	    GetVehiclePos(vehicleid, X, Y, Z);
		GetVehicleZAngle(vehicleid, A);

		format(string, sizeof(string), "CreateVehicle(%d, %f, %f, %f, %f, -1, -1, 1000); // %s \r\n", model, X, Y, Z, A, params);

		fwrite(onfoot, string);
		fclose(onfoot);

		SendClientMessage(playerid, COLOR_LIGHTRED, "* Sacuvali ste vozilo.");

		return 1;
	}
	else return SendClientMessage(playerid, COLOR_GREY, "* Morate da dodate komentar.");
}

YCMD:saveonfoot(playerid, params[])
{
	if(gPlayerLoggedIn[playerid] == 0) return 1;

    if(PlayerInfo[playerid][Admin] < 3) {
	    SendClientMessage(playerid, COLOR_LIGHTRED, "Koristi:{FFFFFF} Samo Admin.");
	    return 1;
	}

	if(!isnull(params)) {
	    new string[256];
	    new File:onfoot=fopen("onfootpositions.txt", io_append);
	    new Float:X, Float:Y, Float:Z;
	    GetPlayerPos(playerid, X, Y, Z);
		new Float:A;
		GetPlayerFacingAngle(playerid, A);
		format(string, sizeof(string), "SetPlayerPos(playerid, %f, %f, %f); \r\nSetPlayerFacingAngle(playerid, %f);// %s \r\n\r\n\r\n", X, Y, Z, A, params);
		fwrite(onfoot, string);
		fclose(onfoot);
		SendClientMessage(playerid, COLOR_LIGHTRED, "* Sacuvali ste poziciju.");
		return 1;
	}
	else return SendClientMessage(playerid, COLOR_GREY, "* Morate da dodate komentar.");
}

YCMD:gotoint(playerid, params[])
{
    if(gPlayerLoggedIn[playerid] == 0) return 1;

	if(PlayerInfo[playerid][Admin] < 3) {
	    SendClientMessage(playerid, COLOR_LIGHTRED, "Samo Admin.");
	    return 1;
	}

	new inter, Float:X, Float:Y, Float:Z;
	if(sscanf(params, "ifff", inter, X, Y, Z)) return SendClientMessage(playerid, COLOR_GREY, "* YCMD: /gotoint [Int] [X] [Y] [Z]");

	SetPlayerInterior(playerid, inter);
	SetPlayerPos(playerid, X, Y, Z);
	SendClientMessage(playerid, COLOR_YELLOW, "* Teleportovani ste.");
	return 1;
}

YCMD:sethp(playerid, params[])
{
    if(gPlayerLoggedIn[playerid] == 0) return 1;

	if(PlayerInfo[playerid][Admin] < 3) {
	    SendClientMessage(playerid, COLOR_LIGHTRED, "Samo Admin.");
	    return 1;
	}

	new target, hp, string[126];

	if(!IsPlayerConnected(target)) return SendClientMessage(playerid, COLOR_GREY, "Igrac nije konektovan.");

	if(sscanf(params, "ud", target, hp)) return SendClientMessage(playerid, COLOR_GREY, "Koristi:{FFFFFF} /sethp [Deo Imena/ID] [HP]");
	SetPlayerHealth(target, hp);
	format(string, sizeof(string), "Warning: Admin %s vam je podesio HP na %d.", PlayerName(playerid), hp);
	SendClientMessage(target, COLOR_LIGHTRED, string);
	format(string, sizeof(string), "AdmWarning: %s je podesio HP igracu %s na %d.", PlayerName(playerid), PlayerName(target), hp);
	AMessage(COLOR_LIGHTRED, string);
	return 1;
}

YCMD:setarmour(playerid, params[])
{
    if(gPlayerLoggedIn[playerid] == 0) return 1;

	if(PlayerInfo[playerid][Admin] < 3) {
	    SendClientMessage(playerid, COLOR_LIGHTRED, "Samo Admin.");
	    return 1;
	}

	new target, armour, string[126];

	if(!IsPlayerConnected(target)) return SendClientMessage(playerid, COLOR_GREY, "Igrac nije konektovan.");

	if(sscanf(params, "ud", target, armour)) return SendClientMessage(playerid, COLOR_GREY, "Koristi:{FFFFFF} /setarmour [Deo Imena/ID] [Armour]");
	SetPlayerArmour(target, armour);
	format(string, sizeof(string), "Warning: Admin %s vam je podesio Pancir na  %d.", PlayerName(playerid), armour);
	SendClientMessage(target, COLOR_LIGHTRED, string);
 	format(string, sizeof(string), "AdmWarning: %s je podesio igracu %s Pancir na %d.", PlayerName(playerid), PlayerName(target), armour);
 	AMessage(COLOR_LIGHTRED, string);
	return 1;
}

YCMD:goto(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 2) return 1;

	new player;

	if(sscanf(params, "u", player))
	{
        SendClientMessage(playerid, COLOR_GREY, "Koristi:{FFFFFF} /goto [Deo Imena/ID] or [Lokacija]");
        SendClientMessage(playerid, COLOR_GREY, "Lokacije: fc (Fort Carson), lb (Las Barrancas)");
        SendClientMessage(playerid, COLOR_GREY, "Lokacije: elq (El Quebrados), bs (Bayside), lp (Las Payasadas)");
        return 1;
	}

	if(!IsPlayerConnected(player))
	{
	    if(strcmp(params, "fc") == 0)
		{
      		SetPlayerPos(playerid, -185.680358, 945.429443, 16.082176);
		    SetPlayerFacingAngle(playerid, 6.580075);
		    SetPlayerInterior(playerid, 0);
		    SetPlayerVirtualWorld(playerid, 0);
		    SendClientMessage(playerid, COLOR_WHITE, "Teleportovani ste Fort Carson.");
		    return 1;
		}
		if(strcmp(params, "lb") == 0)
		{
		    SetPlayerPos(playerid, -831.134460, 1403.065063, 13.609375);
			SetPlayerFacingAngle(playerid, 19.533414);
		    SetPlayerInterior(playerid, 0);
		    SetPlayerVirtualWorld(playerid, 0);
		    SendClientMessage(playerid, COLOR_WHITE, "Teleportovani ste u Las Barrancas.");
		    return 1;
		}
  		if(strcmp(params, "elq") == 0)
		{
		    SetPlayerPos(playerid, -1617.712890, 2663.154785, 54.806404);
			SetPlayerFacingAngle(playerid, 281.482543);
		    SetPlayerInterior(playerid, 0);
		    SetPlayerVirtualWorld(playerid, 0);
		    SendClientMessage(playerid, COLOR_WHITE, "Teleportovani ste u El Quebrados.");
		    return 1;
		}
        if(strcmp(params, "lp") == 0)
		{
		    SetPlayerPos(playerid, -418.754669, 2709.814697, 62.497531);
			SetPlayerFacingAngle(playerid, 254.535629);
		    SetPlayerInterior(playerid, 0);
		    SetPlayerVirtualWorld(playerid, 0);
		    SendClientMessage(playerid, COLOR_WHITE, "Teleportovani ste u Las Payasadas.");
		    return 1;
		}
		if(strcmp(params, "bs") == 0)
		{
		    SetPlayerPos(playerid, -2501.742675, 2418.709472, 16.599868);
			SetPlayerFacingAngle(playerid, 254.535629);
		    SetPlayerInterior(playerid, 0);
		    SetPlayerVirtualWorld(playerid, 0);
		    SendClientMessage(playerid, COLOR_WHITE, "Teleportovani ste u Bayside.");
		    return 1;
		}
		else return SendClientMessage(playerid, COLOR_GREY, "Nepostojeca Lokacija /igrac nije konektovan !");
	}

	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(player, X, Y, Z);
	SetPlayerPos(playerid, X+1, Y+1, Z+1);

	SendClientMessage(playerid, COLOR_GREY, "Teleportovanje...");

	return 1;
}

YCMD:makeadmin(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 5) return 1;

	new player, level, string[126];
	if(sscanf(params, "ud", player, level)) return SendClientMessage(playerid, COLOR_GREY, "Koristi:{FFFFFF} /makeadmin [Deo Imena/Player ID] [0-5]");

	if(!IsPlayerConnected(playerid)) return SendClientMessage(playerid, COLOR_GREY, "Igrac nije konektovan.");

	if(level < 0 || level > 5) SendClientMessage(playerid, COLOR_GREY, "Koristi:{FFFFFF} /makeadmin [Deo Imena/Player ID] [0-5]");

	PlayerInfo[player][Admin] = level;
	format(string, sizeof(string), "Admin %s vas je postavio za Level %d Administratora.", PlayerName(playerid), level);
	SendClientMessage(player, COLOR_YELLOW, string);
	format(string, sizeof(string), "AdmWarning: %s je postao level %d Administrator | Postavljen na funkciju od strane  %s", PlayerName(player), level, PlayerName(playerid));
	AMessage(COLOR_LIGHTRED, string);

	return 1;
}

YCMD:pmute(playerid, params[])
{
	if(gPlayerLoggedIn[playerid] == 0) return 1;

	if(PlayerInfo[playerid][Admin] >= 1 || PlayerInfo[playerid][Helper] >= 1) {
	    new player, string[128];
	    if(sscanf(params, "u", player)) return SendClientMessage(playerid, COLOR_GREY, "Koristi:{FFFFFF} /nmute [Deo Imena/Player ID]");

		if(PlayerInfo[player][nMute] == 0)
		{
		    PlayerInfo[player][nMute] = 1;
		    SendClientMessage(player, COLOR_LIGHTRED, "Imate zabranu pristupu komandi /pitaj.");
			format(string, sizeof(string), "AdmWarning: %s je postavio zabranu igracu %s na komandu /pitaj.", PlayerName(player), PlayerName(playerid));
			AMessage(COLOR_LIGHTRED, string);
			HelperMessage(COLOR_LIGHTRED, string);
			return 1;
		}
		if(PlayerInfo[player][nMute] == 1)
		{
			PlayerInfo[player][nMute] = 0;
		    SendClientMessage(player, COLOR_LIGHTRED, "Vracen vam je pristup komandi /pitaj.");
			format(string, sizeof(string), "AdmWarning: %s je odobrio igracu %s pristup komandi /pitaj.", PlayerName(player), PlayerName(playerid));
			AMessage(COLOR_LIGHTRED, string);
			HelperMessage(COLOR_LIGHTRED, string);
			return 1;

		}
		return 1;
	}
	return 1;
}

YCMD:destroyveh(playerid, params[])
{
    if(gPlayerLoggedIn[playerid] == 0) return 1;

    if(PlayerInfo[playerid][Admin] < 4) return 1;

	new currentVehicle = GetPlayerVehicleID(playerid);
	new check;
 	for(new i = 0; i < sizeof(CreatedCars); i++)
	{
		if(CreatedCars[i] == currentVehicle)
		{
  			check = 1;
	    	CreatedCars[i] = INVALID_VEHICLE_ID;
		    break;
		}
	}
	if(!check) return SendClientMessage(playerid, COLOR_GRAD1, "* Mozete unistiti samo vozila koja su stvorena komandom /veh.");

	DestroyVehicle(currentVehicle);
	SendClientMessage(playerid, COLOR_WHITE, "Vozilo unisteno.");

	return 1;
}

YCMD:veh(playerid, params[])
{
	if(gPlayerLoggedIn[playerid] == 0) return 1;

	if(PlayerInfo[playerid][Admin] >= 4) {
	new model[128], color1, color2;
	if(sscanf( params, "s[128]dd", model, color1, color2)) return SendClientMessage(playerid, COLOR_GREY, "Koristi:{FFFFFF} /veh [Ime vozila] [Boja1] [Boja2]");

	new Float:X, Float:Y, Float:Z, Float:A;

	GetPlayerPos(playerid, X, Y, Z);
	GetPlayerFacingAngle(playerid, A);

	new car = ReturnVehicleModelID(model);

	if(!car) return SendClientMessage(playerid, COLOR_GREY, "Greska.");

	new carid = CreateVehicle(car, X,Y,Z,A, color1, color2, 0);

	PutPlayerInVehicle(playerid,carid,0);
	LinkVehicleToInterior(carid,GetPlayerInterior(playerid));

	for(new i = 0; i < sizeof(CreatedCars); i++)
	{
 		if(CreatedCars[i] == INVALID_VEHICLE_ID)
 		{
 			CreatedCars[i] = carid;
			break;
		}
	}

	SendClientMessage(playerid, COLOR_GREY, "Stvorili ste vozilo.");

	}
	return 1;
}

YCMD:setskin(playerid, params[])
{
    if(gPlayerLoggedIn[playerid] == 0) return 1;

    if(PlayerInfo[playerid][Admin] >= 2 ) {
		new skin, player;
		if(sscanf(params, "ud", player, skin)) return SendClientMessage(playerid, COLOR_GREY, "Koristi:{FFFFFF} /setskin [Deo Imena/ID] [SkinID]");

        if(!IsPlayerConnected(player)) return SendClientMessage(playerid, COLOR_GREY, "Igrac nije konektovan.");

		if(skin < 0 || skin > 299) return SendClientMessage(playerid, COLOR_GREY, "Koristi:{FFFFFF} Invalid skin!");
		SetPlayerSkin(player, skin);
		PlayerInfo[player][Skin] = skin;
		new string[126];
		format(string, sizeof(string), "AdmWarning: %s je podesio igracu %s skin na %d.", PlayerName(playerid), PlayerName(player), skin);
		AMessage(COLOR_LIGHTRED, string);
		return 1;
	}
	return 1;
}

YCMD:kick(playerid, params[])
{
    if(gPlayerLoggedIn[playerid] == 0) return 1;

	if(PlayerInfo[playerid][Admin] >= 1) {
		new player, reason[126];

		if(sscanf(params, "us[126]", player, reason)) return SendClientMessage(playerid, COLOR_GREY, "Koristi:{FFFFFF} /kick [Deo Imena/Player ID] [Razlog]");

		if(!IsPlayerConnected(player)) return SendClientMessage(playerid, COLOR_GREY, "Igrac nije konektovan.");
		new string[126];

		if(PlayerInfo[playerid][Admin] < PlayerInfo[player][Admin]) {
			format(string, sizeof(string), "AdmWarning: %s je izbacen sa servera jer je pokusao da izbaci admina sa vecim level-om!", PlayerName(playerid));
			SendClientMessageToAll(COLOR_LIGHTRED, string);
		}

		format(string, sizeof(string), "AdmWarning: %s je izbacio sa servera %s, razlog: %s", PlayerName(player), PlayerName(playerid), reason);
		SendClientMessageToAll(COLOR_LIGHTRED, string);
		Kick(player);

	}
	return 1;
}

YCMD:gethere(playerid, params[])
{
    if(gPlayerLoggedIn[playerid] == 0) return 1;

	if(PlayerInfo[playerid][Admin] < 2) return 1;

	new player;

	if(sscanf(params, "u", player)) return SendClientMessage(playerid, COLOR_GREY, "Koristi:{FFFFFF} /gethere [Deo Imena] [Igracev ID]");

	if(!IsPlayerConnected(player)) return SendClientMessage(playerid, COLOR_GREY, "Igrac nije konektovan.");

	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	SetPlayerPos(player, X+1, Y+1, Z+2);

	SendClientMessage(player, COLOR_WHITE, "Teleportovani ste do admina");

	return 1;
}

YCMD:setvw(playerid, params[])
{
    if(gPlayerLoggedIn[playerid] == 0) return 1;

	if(PlayerInfo[playerid][Admin] >= 1) {
		new player, vw, string[126];
		if(sscanf(params, "ud", player, vw)) return SendClientMessage(playerid, COLOR_GREY, "Koristi:{FFFFFF} /setvw [Deo Imena/Player ID] [VW]");

		if(!IsPlayerConnected(player)) return SendClientMessage(playerid, COLOR_GREY, "Igrac nije konektovan.");

		PlayerInfo[player][sVW] = vw;
		SetPlayerVirtualWorld(player, vw);

		format(string, sizeof(string), "%s vam je podesio VW na %d!", PlayerName(playerid), vw);
		SendClientMessage(player, COLOR_WHITE, string);
		format(string, sizeof(string), "Podesili ste igracev %s VW na %d!", PlayerName(player), vw);
		SendClientMessage(playerid, COLOR_LIGHTRED, string);
		format(string, sizeof(string), "/setint ");
		//AdminLog(string, playerid);
	}
	return 1;
}

YCMD:ask(playerid, params[])
{
    if(gPlayerLoggedIn[playerid] == 0) return 1;

	if(PlayerInfo[playerid][Helper] == 0) {
	    new question[128];
	    if(sscanf(params, "s[128]", question)) return SendClientMessage(playerid, COLOR_GREY, "Koristi:{FFFFFF} /pitaj [Pitanje]");
	    if(PlayerInfo[playerid][nMute] == 1) return SendClientMessage(playerid, COLOR_GREY, "Imate zabranu");
	    foreach(Player, i)
	    {
	        if(PlayerInfo[i][Helper] > 0)
	        {
				new string[126];
				format(string, sizeof(string), "[%d] %s pita: %s", playerid, PlayerName(playerid), question);
				SendClientMessage(i, NEWBIE_COLOR, string);
			}
		}
		SendClientMessage(playerid, COLOR_YELLOW, "Postavili ste pitanje molimo sacekajte odgovor.");
	}
	return 1;
}

YCMD:n(playerid, params[])
{
    if(gPlayerLoggedIn[playerid] == 0) return 1;

	if(PlayerInfo[playerid][Helper] == 0) {
	    SendClientMessage(playerid, COLOR_GREY, "Koristi /pitaj da postavis pitanje");
	    return 1;
	}
	new answer[126], string[126];
	if(sscanf(params, "s[126]", answer)) return SendClientMessage(playerid, COLOR_GREY, "Koristi:{FFFFFF} /n [Odgovor]");

	format(string, sizeof(string), "Helper %s kaze: %s", PlayerName(playerid), answer);
	SendClientMessageToAll(NEWBIE_COLOR, string);
	return 1;
}

YCMD:makehelper(playerid, params[])
{
    if(gPlayerLoggedIn[playerid] == 0) return 1;

	if(PlayerInfo[playerid][Admin] == 5 || PlayerInfo[playerid][Helper] == 3)  {
	    new target, level;
	    if(sscanf(params, "ud", target, level)) return SendClientMessage(playerid, COLOR_GREY, "Koristi:{FFFFFF} /makehelper [Deo Imena/Player ID] [0-2]");

		if(level < 0 || level > 3) return 1;

	    PlayerInfo[target][Helper] = level;
	    new string[126];
	    format(string, sizeof(string), "%s je postavljen na helpera level %d", PlayerName(playerid), level);
	    SendClientMessage(target, COLOR_LIGHTBLUE, string);
	    format(string, sizeof(string), "AdmWarning: %s je postavio igracu %s helper level na %d.", PlayerName(playerid), PlayerName(target), level);
	    AMessage(COLOR_LIGHTRED, string);
	}


	return 1;
}

YCMD:makedeveloper(playerid, params[])
{
    if(gPlayerLoggedIn[playerid] == 0) return 1;

	if(PlayerInfo[playerid][Admin] == 5 || PlayerInfo[playerid][Developer] == 3)  {
	    new target, level;
	    if(sscanf(params, "ud", target, level)) return SendClientMessage(playerid, COLOR_GREY, "Koristi:{FFFFFF} /makedeveloper [Deo Imena/Player ID] [0-2]");

		if(level < 0 || level > 3) return 1;

	    PlayerInfo[target][Developer] = level;
	    new string[126];
	    format(string, sizeof(string), "%s je postao level %d Developer!", PlayerName(playerid), level);
	    SendClientMessage(target, COLOR_LIGHTBLUE, string);
	    format(string, sizeof(string), "AdmWarning: %s je podesio %s Level %d Developera.", PlayerName(playerid), PlayerName(target), level);
	    AMessage(COLOR_LIGHTRED, string);
	}


	return 1;
}

YCMD:setint(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] >= 1) {
		new player, interior, string[126];
		if(sscanf(params, "ud", player, interior)) return SendClientMessage(playerid, COLOR_GREY, "Koristi:{FFFFFF} /setint [Deo Imena/Player ID] [Interior]");

		if(!IsPlayerConnected(player)) return SendClientMessage(playerid, COLOR_GREY, "Igrac nije konektovan.");

		PlayerInfo[player][sInterior] = interior;
		SetPlayerInterior(player, interior);

		format(string, sizeof(string), "%s vam je podesio Interior na %d!", PlayerName(playerid), interior);
		SendClientMessage(player, COLOR_WHITE, string);
		format(string, sizeof(string), "Podesili ste igracu %s Interior na %d!", PlayerName(player), interior);
		SendClientMessage(playerid, COLOR_LIGHTRED, string);
		format(string, sizeof(string), "/setint ");
		//AdminLog(string, playerid);
	}
	return 1;
}

YCMD:ahelp(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] == 0) return 1;

	SendClientMessage(playerid, COLOR_GREY, "Level 1: /kick /spec /setint /setvw /pmute");
	SendClientMessage(playerid, COLOR_GREY, "Level 2: /goto /gethere /setskin ");
	SendClientMessage(playerid, COLOR_GREY, "Level 3: /gotoint /setarmour /sethp");
	SendClientMessage(playerid, COLOR_GREY, "Level 4: /veh /givemoney /noooc");
	SendClientMessage(playerid, COLOR_GREY, "Level 5: /makeadmin /makehelper /makedeveloper ");

	return 1;
}

YCMD:noooc(playerid, params[])
{
    if(gPlayerLoggedIn[playerid] == 0) return 1;

    if(PlayerInfo[playerid][Admin] < 4) return 1;

    if(noooc == 1)
    {
        noooc = 0;
        SendClientMessageToAll(COLOR_WHITE, "OOC chat je {#fa0000}onemogucen {#FFFFFF}od strane Administracije!");
        return 1;
	}
	if(noooc == 0)
    {
        noooc = 1;
        SendClientMessageToAll(COLOR_WHITE, "OOC chat je {#0dc314}omogucen {#FFFFFF}od strane Administracije!");
        return 1;
	}
    return 1;
}

YCMD:helperi(playerid, params[])
{
	if(gPlayerLoggedIn[playerid] == 0) return 1;

	SendClientMessage(playerid, COLOR_LIGHTBLUE, "Helperi online:");
	foreach(Player, i)
	{
	    new level[128], string[128];
	    if(IsPlayerConnected(i))
	    {
			if(PlayerInfo[i][Helper] > 0)
			{
                if(PlayerInfo[i][Helper] == 1) { level = "General"; }
				if(PlayerInfo[i][Helper] == 2) { level = "Senior"; }
				if(PlayerInfo[i][Helper] >= 3) { level = "Head"; }
				format(string, sizeof(string), "%s %s", level, PlayerName(i));
				SendClientMessage(playerid, COLOR_GREY, string);
			}
		}
	}
	return 1;
}

YCMD:developers(playerid, params[])
{
	if(gPlayerLoggedIn[playerid] == 0) return 1;

	SendClientMessage(playerid, COLOR_LIGHTORANGE, "Developeri online:");
	foreach(Player, i)
	{
	    new level[128], string[128];

		if(PlayerInfo[i][Developer] > 0)
		{
		  	if(PlayerInfo[i][Developer] == 1) { level = "Junior"; }
		  	if(PlayerInfo[i][Developer] == 2) { level = "Senior"; }
		  	if(PlayerInfo[i][Developer] == 3) { level = "Head"; }
			format(string, sizeof(string), "%s %s", level, PlayerName(i));
			SendClientMessage(playerid, COLOR_GREY, string);
		}
	}
	return 1;
}

YCMD:admini(playerid, params[])
{
	if(gPlayerLoggedIn[playerid] == 0) return 1;

	SendClientMessage(playerid, COLOR_WHITE, "Administratori online:");
	foreach(Player, i)
	{
	    new level[128], string[128];

		if(PlayerInfo[playerid][Admin] == 0 && PlayerInfo[i][Admin] > 1 /*&& AdminDuty[i] == 1*/)
		{
		    switch(PlayerInfo[i][Admin])
		    {
		        case 2: level = "Junior Admin";
		        case 3: level = "General Administrator";
		        case 4: level = "Head Administrator";
		        case 5: level = "Community Owner";
			}
			format(string, sizeof(string), "%s %s", level, PlayerName(i));
			SendClientMessage(playerid, COLOR_GREY, string);
		}
		if(PlayerInfo[playerid][Admin] > 0)
		{
      		switch(PlayerInfo[i][Admin])
		    {
		        case 1: level = "Secret Admin (1)";
		        case 2: level = "Junior Admin (2)";
		        case 3: level = "General Administrator (3)";
		        case 4: level = "Head Administrator (4)";
		        case 5: level = "Community Owner (5)";
			}
			format(string, sizeof(string), "%s %s", level, PlayerName(i));
			SendClientMessage(playerid, COLOR_GREY, string);
		}
	}
	return 1;
}

YCMD:spec(playerid, params[])
{
	if(gPlayerLoggedIn[playerid] == 0) return 1;

	if(PlayerInfo[playerid][Admin] >=1)
	{
	    new player;
	    if(sscanf(params, "u", player)) return SendClientMessage(playerid, COLOR_GREY, "Koristi:{FFFFFF} /spec [Deo Imena/Player ID/off]");

	    if(IsPlayerConnected(player))   {

	    new Float:sX, Float:sY, Float:sZ, Float:sA;
	    GetPlayerPos(playerid, sX, sY, sZ);
		GetPlayerFacingAngle(playerid, sA);

		PlayerInfo[playerid][sPosX] = sX;
		PlayerInfo[playerid][sPosY] = sY;
		PlayerInfo[playerid][sPosZ] = sZ;
		PlayerInfo[playerid][sPosA] = sA;

		PlayerSpectating[playerid] = 1;
		TogglePlayerSpectating(playerid, 1);
    	PlayerSpectatePlayer(playerid, player);

    	SendClientMessage(playerid, COLOR_WHITE, "Sada posmatrate igraca.");

    	return 1;
		}
		else {
		    if(strcmp(params, "off") == 0)
		    {
				if(PlayerSpectating[playerid] == 0) return SendClientMessage(playerid, COLOR_WHITE, "Ne posmatrate nikog.");

				TogglePlayerSpectating(playerid, 0);

				SetPlayerPos(playerid, PlayerInfo[playerid][sPosX], PlayerInfo[playerid][sPosY], PlayerInfo[playerid][sPosZ]);
				SetPlayerSkin(playerid, PlayerInfo[playerid][Skin]);
				SetPlayerArmour(playerid, PlayerInfo[playerid][sArmor]);
				SetPlayerHealth(playerid, PlayerInfo[playerid][sHealth]);
				SetPlayerFacingAngle(playerid, PlayerInfo[playerid][sPosA]);

				SendClientMessage(playerid, COLOR_WHITE, "Vise ne posmatrate ovog igraca.");
				PlayerSpectating[playerid] = 0;
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "Koristi:{FFFFFF} /spec [Deo Imena/Player ID/off]");
			}
	   	 	return 1;
		}
	}



	return 1;
}

// [End of YCMD] //
public OnGameModeInit()
{
    ManualVehicleEngineAndLights();
	SetGameModeText("WW:RP v0.0.1");
	AddPlayerClass(1, 194.485778, 1103.993408, 16.347635, 30.403614, 0, 0, 0, 0, 0, 0);
	DisableInteriorEnterExits();
    SetNameTagDrawDistance(30.0);
    EnableStuntBonusForAll(0);
    LoadHouses();
    print("     public Kuce su ucitane.");
	LoadCar();
	print("     public Vozila su ucitana.");
	LoadDCars();
	print("     public DVozila su ucitana.");

    // Fort Carson Vehicles
	CreateVehicle(598, -216.540618, 986.924926, 19.179603, 359.869995, 55, 1, 1000); // Fort Carson Sheriff 1
	CreateVehicle(598, -214.809951, 972.921569, 19.039310, 268.669799, 55, 1, 1000); // Fort Carson Sheriff 2
	CreateVehicle(598, -210.988510, 999.154357, 19.430624, 179.201477, 55, 1, 1000); // Fort Carson Sheriff 3
	CreateVehicle(523, -226.484573, 990.511108, 19.135032, 0.297363, 0, 0, 1000); // Fort Carson HPV1000 1
	CreateVehicle(523, -228.209152, 990.684814, 19.083906, 0.085315, 0, 0, 1000); // Fort Carson HPV1000 2
	CreateVehicle(416, -335.172210, 1056.877319, 19.879249, 268.443572, 55, 1, 1000); // Fort Carson Amublance 1
	CreateVehicle(438, -137.425415, 1121.553710, 19.753690, 91.173950, 6, 6, 1000); // Fort Carson CAB 1
	CreateVehicle(438, -137.454772, 1125.340209, 19.755273, 89.616706, 6, 6, 1000); // Fort Carson CAB 2
	CreateVehicle(438, -137.426589, 1128.971923, 19.752775, 89.944824, 6, 6, 1000); // Fort Carson CAB 3
	CreateVehicle(408, -158.548385, 1082.870727, 20.287803, 359.132568, 1, 1, 1000); // Fort Carson TRASH 2
	CreateVehicle(408, -152.684982, 1082.929565, 20.250957, 0.835483, 1, 1, 1000); // Fort Carson TRASH 2
	CreateVehicle(582, -87.279441, 1078.153930, 19.801181, 359.860107, 16, 1, 1000); // FC NEWS VAN 1

	// Fort Carson Pickups
	TaxiJob = CreateDynamicPickup(1239, 1, -116.881134, 1132.390014, 19.742187);
	return 1;
}

public OnGameModeExit()
{
	SaveHouses();
	SaveCars();
 	foreach(Player, i)
 	{
 		if(gPlayerLoggedIn[i] == 1)
 		{
 			SavePlayer(i);
 			gPlayerLoggedIn[i] = 0;
		}
	}
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SpawnPlayer(playerid);
	return 1;
}

public OnPlayerConnect(playerid)
{

    if(IsPlayerNPC(playerid)) return 1;

    SetSpawnInfo(playerid, 0, 0, 1722.4423, 1312.0413, 10.8105, 229.5485, 0, 0, 0, 0, 0, 0);

    gPlayerLoggedIn[playerid] = 0;
    PlayerSpectating[playerid] = 0;
    gLastCar[playerid] = 0;
	KnowsIt[playerid] = 0;
	BigEar[playerid] = 0;

	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	gLastCar[playerid] = 0;
	BigEar[playerid] = 0;
	KnowsIt[playerid] = 0;
	if(gPlayerLoggedIn[playerid] == 1)
	{
		SavePlayer(playerid);
		gPlayerLoggedIn[playerid] = 0;
	}
	return 1;
}

public OnPlayerSpawn(playerid)
{
    SetPlayerColor(playerid, TCOLOR_WHITE);

	if(gPlayerLoggedIn[playerid] == 1) {

	    SetCameraBehindPlayer(playerid);
 		SetPlayerPos(playerid, PlayerInfo[playerid][sPosX], PlayerInfo[playerid][sPosY], PlayerInfo[playerid][sPosZ]);
   		SetPlayerFacingAngle(playerid, PlayerInfo[playerid][sPosA]);
		SetPlayerInterior(playerid, PlayerInfo[playerid][sInterior]);
		SetPlayerVirtualWorld(playerid, PlayerInfo[playerid][sVW]);
		SetPlayerSkin(playerid, PlayerInfo[playerid][Skin]);
		SetPlayerHealth(playerid, PlayerInfo[playerid][sHealth]);
		SetPlayerArmour(playerid, PlayerInfo[playerid][sArmor]);
		gPlayerLoggedIn[playerid] = 1;
		SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, 0);
		SetPlayerColor(playerid, TCOLOR_WHITE);

	}
	else
	{
	    ClearScreen(playerid);
	    SetPlayerCameraPos(playerid, 194.485778, 1103.993408, 16.347635);
		SetPlayerCameraLookAt(playerid, 194.485778, 1103.993408, 16.347635);
  		if(fexist(UserPath(playerid)))
    	{
        	SendClientMessage(playerid, COLOR_WHITE, "SERVER: Dobro dosli na Wild West Roleplay, molimo prijavite se!");
        	INI_ParseFile(UserPath(playerid), "LoadUser_%s", .bExtra = true, .extra = playerid);
        	ShowDialog(playerid, 2, DIALOG_PASS, "Dobro dosli na Wild West Roleplay!", "To Ime_Prezime je vec reigstrovano,\nMolimo vas da unesete lozinku!", "Login", "Izlaz");
		}
		else
		{
			SendClientMessage(playerid, COLOR_WHITE, "SERVER: Dobro dosli na Wild West Roleplay, molimo vas da napravite nalog!");
	    	ShowDialog(playerid, 1, DIALOG_PASS, "Zdravo, Dobro dosli u Bone County!", "Zdravo gospodine!\n\nDobro dosli Bone County, gde se zlocin ne isplati.\nMolimo vas da prijavite vas boravak!", "Register", "Exit");
		}
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	SetSpawnInfo(playerid, 0, PlayerInfo[playerid][Skin], PlayerInfo[playerid][sPosX], PlayerInfo[playerid][sPosY], PlayerInfo[playerid][sPosZ], PlayerInfo[playerid][sPosA], 0, 0, 0, 0, 0, 0);
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
	new str[128];
	format(str, sizeof(str), "%s kaze: %s", PlayerName(playerid), text);
    ProxDetector(30.0, playerid, str, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
	return 0;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	new modelid = GetVehicleModel(vehicleid);

	if(modelid == 420 || modelid == 438)
	{
	    if(strcmp("Taksista", PlayerInfo[playerid][Job], true) == 0) return 1;
	    else {
     		ClearAnimations(playerid);
     		SendClientMessage(playerid, COLOR_LIGHTRED, "Error:{FFFFFF} Niste taksista.");
     		return 1;
	    }
	}
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_DRIVER)
	{
	    new newcar = GetPlayerVehicleID(playerid);
 		new modelid = GetVehicleModel(GetPlayerVehicleID(playerid));
	    gLastCar[playerid] = newcar;
	    if(KnowsIt[playerid] == 0)
		{
		    SendClientMessage(playerid, COLOR_GREY, "Koristi /engine da upalis motor vozila.");
		    KnowsIt[playerid] = 1;
		}
		if(modelid == 420 || modelid == 438) // Double check Taxi vehicle in case of exploit
		{
		    if(strcmp("Taxi Driver", PlayerInfo[playerid][Job], true) == 0) return 1;
		    else {
				RemovePlayerFromVehicle(playerid);
				SendClientMessage(playerid, COLOR_LIGHTRED, "Warning:{FFFFFF} Niste taksista");
				return 1;
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

public OnPlayerPickUpDynamicPickup(playerid, pickupid)
{
	new string[256];
    for(new h = 1;h < sizeof(HouseInfo);h++)
	{
		if(pickupid == HouseInfo[h][hOutsideIcon])
		{
			if(HouseInfo[h][hOwned] == 0)
			{
			    new location[MAX_ZONE_NAME];
				Get2DZone(location, MAX_ZONE_NAME, HouseInfo[h][hEntranceX], HouseInfo[h][hEntranceY], HouseInfo[h][hEntranceZ]);
			    format(string, sizeof(string), "~b~%d %s~n~~w~Ova kuca ~g~je na prodaju!~n~~w~Cena: $%d, Level: %d~n~~g~/kupikucu~w~ da je kupite.", h, location, HouseInfo[h][hPrice], HouseInfo[h][hLevel]);
			    GameTextForPlayer(playerid, string, 3000, 3);
				return 1;
			}
			if(HouseInfo[h][hOwned] == 1)
			{
			    if(HouseInfo[h][hRentable] == 0)
			    {
				    new location[MAX_ZONE_NAME];
					Get2DZone(location, MAX_ZONE_NAME, HouseInfo[h][hEntranceX], HouseInfo[h][hEntranceY], HouseInfo[h][hEntranceZ]);
					format(string, sizeof(string), "~b~%d %s~n~~w~Vlasnik:~g~ %s~n~~w~Nije na iznajmljivanje",  h, location, HouseInfo[h][hOwner]);
					GameTextForPlayer(playerid, string, 3000, 3);
					return 1;
				}
				if(HouseInfo[h][hRentable] == 1)
			    {
				    new location[MAX_ZONE_NAME];
					Get2DZone(location, MAX_ZONE_NAME, HouseInfo[h][hEntranceX], HouseInfo[h][hEntranceY], HouseInfo[h][hEntranceZ]);
					if(PlayerInfo[playerid][RentingID] == h)
					{
						format(string, sizeof(string), "~b~%d %s~n~~w~Vlasnik:~g~ %s~n~~w~Cena Renta: $%d~n~vi iznajmljujete ovu kucu.", h, location, HouseInfo[h][hOwner], HouseInfo[h][hRentPrice]);
					}
					else format(string, sizeof(string), "~b~%d %s~n~~w~Vlasnik:~g~ %s~n~~w~Cena renta: $%d~n~/renthouse da iznajmite.", h, location, HouseInfo[h][hOwner], HouseInfo[h][hRentPrice]);
					GameTextForPlayer(playerid, string, 3000, 3);
					return 1;
				}
			}
		}
	}
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
	switch (dialogid)
	{
	    case 1: // Register
	    {
	        if(!response) {
				SendClientMessage(playerid, COLOR_GREY,"    Hvala sto ste dosli...");
				Kick(playerid);
			}
			else if(response) {
			    if(!strlen(inputtext)) return ShowDialog(playerid, 1, DIALOG_PASS, "Zdravo, Dobro dosli u Bone County!", "Zdravo novi clanu zajednice!\n\nDobro dosli u Bone County, gde se zlocin ne isplati.\nMolimo da prijavite vas boravak!", "Register", "Exit");
			    new INI:File = INI_Open(UserPath(playerid));
                INI_SetTag(File,"data");
                INI_WriteInt(File, "Lozinka", udb_hash(inputtext));
			    INI_WriteInt(File, "Admin", 0);
			    INI_WriteInt(File, "Drzava", 0);
			    INI_WriteInt(File, "Pol", 0);
			    INI_WriteInt(File, "Godina", 0);
			    INI_WriteFloat(File, "sPosX", 194.485778);
			    INI_WriteFloat(File, "sPosY", 1103.993408);
			    INI_WriteFloat(File, "sPosZ", 16.347635);
			    INI_WriteFloat(File, "sPosA", 30.403614);
			    INI_WriteFloat(File, "sHealth", 100);
			    INI_WriteFloat(File, "sArmor", 0);
			    INI_WriteInt(File, "Novac", 2000);
			    INI_WriteInt(File, "Banka", 20000);
			    INI_WriteInt(File, "BankPin", 0);
			    INI_WriteInt(File, "Mobilni", 0);
			    INI_WriteInt(File, "KucaID", 0);
			    INI_WriteInt(File, "AutoID", 0);
			    INI_WriteInt(File, "Gun1", 0);
			    INI_WriteInt(File, "Gun2", 0);
			    INI_WriteInt(File, "Gun3", 0);
			    INI_WriteInt(File, "Gun4", 0);
			    INI_WriteInt(File, "Gun5", 0);
			    INI_WriteInt(File, "Gun6", 0);
			    INI_WriteInt(File, "Gun7", 0);
			    INI_WriteInt(File, "Gun8", 0);
			    INI_WriteInt(File, "Gun9", 0);
			    INI_WriteInt(File, "Gun10", 0);
			    INI_WriteInt(File, "Gun11", 0);
			    INI_WriteInt(File, "Gun12", 0);
			    INI_WriteInt(File, "Gun13", 0);
			    INI_WriteInt(File, "WTChannel", 0);
			    INI_WriteInt(File, "Organizacija", 0);
			    INI_WriteInt(File, "Lider", 0);
			    INI_WriteInt(File, "Posao", 0);
			    INI_WriteInt(File, "sInterior", 0);
			    INI_WriteInt(File, "sVW", 0);
			    INI_WriteInt(File, "Skin", 1);
			    INI_WriteInt(File, "Muted", 0);
			    INI_WriteInt(File, "nMute", 0);
			    INI_WriteInt(File, "Helper", 0);
			    INI_WriteInt(File, "Developer", 0);
			    INI_WriteInt(File, "RentingID", 0);
                INI_Close(File);
                INI_ParseFile(UserPath(playerid), "LoadUser_%s", .bExtra = true, .extra = playerid);
				ResetPlayerMoney(playerid);
				GivePlayerMoney(playerid, PlayerInfo[playerid][Money]);
				ClearScreen(playerid);
				SendClientMessage(playerid, COLOR_WHITE, "Bone County: Hvala sto ste se prijavili!");
				SendClientMessage(playerid, COLOR_WHITE, "Morate da popunite jos jedan klasicni formular!");
				SetPlayerCameraPos(playerid, 194.485778, 1103.993408, 16.347635);
				SetPlayerCameraLookAt(playerid, 194.485778, 1103.993408, 16.347635);
				SetPlayerVirtualWorld(playerid, 0);
	    		ShowDialog(playerid, 3, DIALOG_INFO, "Bone County Indentifikaciono Odeljenje", "Da li ste Musko ili Zensko?", "Musko", "Zensko");
			}
			return 1;
	    }
	    case 2: //Login
	    {
	        if(!response) {
	            SendClientMessage(playerid, COLOR_LIGHTRED, "   Vratite se uskoro...");
	            Kick(playerid);
			}
			if(response) {
                if(udb_hash(inputtext) == PlayerInfo[playerid][Password])
                {
                    INI_ParseFile(UserPath(playerid), "LoadUser_%s", .bExtra = true, .extra = playerid);
					SetPlayerHealth(playerid, PlayerInfo[playerid][sHealth]);
	                SetPlayerArmour(playerid, PlayerInfo[playerid][sArmor]);
					ResetPlayerMoney(playerid);
					GivePlayerMoney(playerid, PlayerInfo[playerid][Money]);
					SendClientMessage(playerid, COLOR_WHITE, "SERVER: Prijavili ste se na Wild West Roleplay.");
				    gPlayerLoggedIn[playerid] = 1;
					SpawnPlayer(playerid);

				}
				else {
				    SendClientMessage(playerid, COLOR_LIGHTRED, "SERVER: Pogresna lozinka. Kickovani ste pokusajte ponovo!");
					Kick(playerid);
				}
	        }
	    	return 1;
	    }
	    case 3: // Gender
	    {
	        if(response) {
	            PlayerInfo[playerid][Gender] = 1; // Male
				ShowDialog(playerid, 4, DIALOG_INPUT, "Bone County Indentifikaciono Odeljenje", "Izjasnili ste se kao Musko.\n\nKoliko imate godina?", "Enter", "");
				PlayerInfo[playerid][Skin] = 1;
				SetSpawnInfo(playerid, 0, 1, 194.485778, 1103.993408, 16.347635, 30.403614, 0, 0, 0, 0, 0, 0);
				}
			else {
			    PlayerInfo[playerid][Gender] = 2; // Female
				ShowDialog(playerid, 4, DIALOG_INPUT, "Bone County Indentifikaciono Odeljenje", "Izjasnili ste se kao Zensko.\n\nKoliko imate godina?", "Enter", "");
                PlayerInfo[playerid][Skin] = 12;
                SetSpawnInfo(playerid, 0, 12, 194.485778, 1103.993408, 16.347635, 30.403614, 0, 0, 0, 0, 0, 0);
			}
	    }
	    case 4: // Age
	    {
	        new age = strval(inputtext);
	        if(!strlen(inputtext)) return ShowDialog(playerid, 4, DIALOG_INPUT, "Bone County Indentifikaciono Odeljenje", "Molimo recite koliko imate godina!", "Enter", "");
			//if(!IsNumeric(age)) return ShowDialog(playerid, 4, DIALOG_INPUT, "Fort Carson Identification", "Please tell us how old you are!", "Enter", "");
			if(age < 13 || age > 99) return ShowDialog(playerid, 4, DIALOG_INPUT, "Bone County Indentifikaciono Odeljenje", "Molimo upisite realisticne godine (13-99)", "Enter", "");
   			PlayerInfo[playerid][Age] = age;
   			ShowDialog(playerid, 5, DIALOG_LIST, "Bone County Indentifikaciono Odeljenje - Odakle ste?", "Srbija\nBIH\nHrvatska\nMakedonija\nCrna Gora", "Okay", "");
	    }
	    case 5: // Origin
	    {
	        if(response)
	        {
	            switch(listitem)
	            {
					case 0: //America
					{
						PlayerInfo[playerid][Origin] = 1;
					}
					case 1: //Europe
					{
						PlayerInfo[playerid][Origin] = 2;
					}
					case 2: //Australia
					{
						PlayerInfo[playerid][Origin] = 3;
					}
					case 3: //Africa
					{
						PlayerInfo[playerid][Origin] = 4;
					}
					case 4: //Russia
					{
						PlayerInfo[playerid][Origin] = 5;
					}
	            }
				ShowDialog(playerid, 6, DIALOG_INFO, "Bone County Identifikaciono Odeljenje", "Hvala sto ste popunili formular.\n\nAko vam treba pomoc koristite /help i /pitaj.\nUkoliko ne postujete pravila dobicete odgovarajucu kaznu.\n\nPosetite forum u.izradi.com", "Okay", "");
				gPlayerLoggedIn[playerid] = 1;
				SpawnPlayer(playerid);
			 }
			 else
			 {
			    ShowDialog(playerid, 5, DIALOG_LIST, "Bone County Identifikaciono Odeljenje - Odakle ste?", "Srbija\nBIH\nHrvatska\nMakedonija\nCrna Gora", "Okay", "");
			 }
	    }
	}
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}

public OnPlayerCommandPerformed(playerid, cmdtext[], success)
{
	return 1;
}
