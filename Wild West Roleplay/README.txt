SA-MP Streamer Plugin v2.7.2
============================

Preface
-------

This plugin streams objects, pickups, checkpoints, race checkpoints,
map icons, and 3D text labels at user-defined server ticks. Basic
area detection is also included. Because it is written entirely in
C++, much of the overhead from PAWN is avoided. This streamer, as a
result, is quite a bit faster than any other implementation currently
available in PAWN.

Definitions
-----------

#define STREAMER_TYPE_OBJECT (0)
#define STREAMER_TYPE_PICKUP (1)
#define STREAMER_TYPE_CP (2)
#define STREAMER_TYPE_RACE_CP (3)
#define STREAMER_TYPE_MAP_ICON (4)
#define STREAMER_TYPE_3D_TEXT_LABEL (5)
#define STREAMER_TYPE_AREA (6)

#define STREAMER_AREA_TYPE_CIRCLE (0)
#define STREAMER_AREA_TYPE_RECTANGLE (1)
#define STREAMER_AREA_TYPE_SPHERE (2)
#define STREAMER_AREA_TYPE_CUBE (3)
#define STREAMER_AREA_TYPE_POLYGON (4)

#define STREAMER_OBJECT_TYPE_GLOBAL (0)
#define STREAMER_OBJECT_TYPE_PLAYER (1)
#define STREAMER_OBJECT_TYPE_DYNAMIC (2)

Enumerator
----------

enum
{
	E_STREAMER_ATTACHED_OBJECT,
	E_STREAMER_ATTACHED_PLAYER,
	E_STREAMER_ATTACHED_VEHICLE,
	E_STREAMER_ATTACH_OFFSET_X,
	E_STREAMER_ATTACH_OFFSET_Y,
	E_STREAMER_ATTACH_OFFSET_Z,
	E_STREAMER_ATTACH_R_X,
	E_STREAMER_ATTACH_R_Y,
	E_STREAMER_ATTACH_R_Z,
	E_STREAMER_ATTACH_X,
	E_STREAMER_ATTACH_Y,
	E_STREAMER_ATTACH_Z,
	E_STREAMER_COLOR,
	E_STREAMER_DRAW_DISTANCE,
	E_STREAMER_EXTRA_ID,
	E_STREAMER_INTERIOR_ID,
	E_STREAMER_MAX_X,
	E_STREAMER_MAX_Y,
	E_STREAMER_MAX_Z,
	E_STREAMER_MIN_X,
	E_STREAMER_MIN_Y,
	E_STREAMER_MIN_Z,
	E_STREAMER_MODEL_ID,
	E_STREAMER_MOVE_R_X,
	E_STREAMER_MOVE_R_Y,
	E_STREAMER_MOVE_R_Z,
	E_STREAMER_MOVE_SPEED,
	E_STREAMER_MOVE_X,
	E_STREAMER_MOVE_Y,
	E_STREAMER_MOVE_Z,
	E_STREAMER_NEXT_X,
	E_STREAMER_NEXT_Y,
	E_STREAMER_NEXT_Z,
	E_STREAMER_PLAYER_ID,
	E_STREAMER_R_X,
	E_STREAMER_R_Y,
	E_STREAMER_R_Z,
	E_STREAMER_SIZE,
	E_STREAMER_STREAM_DISTANCE,
	E_STREAMER_STYLE,
	E_STREAMER_TEST_LOS,
	E_STREAMER_TYPE,
	E_STREAMER_WORLD_ID,
	E_STREAMER_X,
	E_STREAMER_Y,
	E_STREAMER_Z
}

Natives (Settings)
------------------

native Streamer_GetTickRate();
native Streamer_SetTickRate(rate);
native Streamer_GetMaxItems(type);
native Streamer_SetMaxItems(type, items);
native Streamer_GetVisibleItems(type);
native Streamer_SetVisibleItems(type, items);
native Streamer_GetCellDistance(&Float:distance);
native Streamer_SetCellDistance(Float:distance);
native Streamer_GetCellSize(&Float:size);
native Streamer_SetCellSize(Float:size);

Natives (Updates)
-----------------

native Streamer_ProcessActiveItems();
native Streamer_ToggleIdleUpdate(playerid, toggle);
native Streamer_IsToggleIdleUpdate(playerid);
native Streamer_ToggleItemUpdate(playerid, type, toggle);
native Streamer_IsToggleItemUpdate(playerid, type);
native Streamer_Update(playerid);
native Streamer_UpdateEx(playerid, Float:x, Float:y, Float:z, worldid = -1, interiorid = -1);

Natives (Data Manipulation)
---------------------------

native Streamer_GetFloatData(type, {Text3D,_}:id, data, &Float:result);
native Streamer_SetFloatData(type, {Text3D,_}:id, data, Float:value);
native Streamer_GetIntData(type, {Text3D,_}:id, data);
native Streamer_SetIntData(type, {Text3D,_}:id, data, value);
native Streamer_GetArrayData(type, {Text3D,_}:id, data, dest[], maxlength = sizeof dest);
native Streamer_SetArrayData(type, {Text3D,_}:id, data, const src[], maxlength = sizeof src);
native Streamer_IsInArrayData(type, {Text3D,_}:id, data, value);
native Streamer_AppendArrayData(type, {Text3D,_}:id, data, value);
native Streamer_RemoveArrayData(type, {Text3D,_}:id, data, value);
native Streamer_GetUpperBound(type);

Natives (Miscellaneous)
-----------------------

native Streamer_GetDistanceToItem(Float:x, Float:y, Float:z, type, {Text3D,_}:id, &Float:distance, dimensions = 3);
native Streamer_GetItemInternalID(playerid, type, {Text3D,_}:streamerid);
native Streamer_GetItemStreamerID(playerid, type, {Text3D,_}:internalid);
native Streamer_IsItemVisible(playerid, type, {Text3D,_}:id);
native Streamer_DestroyAllVisibleItems(playerid, type, serverwide = 1);
native Streamer_CountVisibleItems(playerid, type, serverwide = 1);
native Streamer_DestroyAllItems(type, serverwide = 1);
native Streamer_CountItems(type, serverwide = 1);

Natives (Objects)
-----------------

native CreateDynamicObject(modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, worldid = -1, interiorid = -1, playerid = -1, Float:streamdistance = 200.0, Float:drawdistance = 0.0);
native DestroyDynamicObject(objectid);
native IsValidDynamicObject(objectid);
native SetDynamicObjectPos(objectid, Float:x, Float:y, Float:z);
native GetDynamicObjectPos(objectid, &Float:x, &Float:y, &Float:z);
native SetDynamicObjectRot(objectid, Float:rx, Float:ry, Float:rz);
native GetDynamicObjectRot(objectid, &Float:rx, &Float:ry, &Float:rz);
native MoveDynamicObject(objectid, Float:x, Float:y, Float:z, Float:speed, Float:rx = -1000.0, Float:ry = -1000.0, Float:rz = -1000.0);
native StopDynamicObject(objectid);
native IsDynamicObjectMoving(objectid);
native AttachCameraToDynamicObject(playerid, objectid);
native AttachDynamicObjectToVehicle(objectid, vehicleid, Float:offsetx, Float:offsety, Float:offsetz, Float:rx, Float:ry, Float:rz);
native EditDynamicObject(playerid, objectid);
native GetDynamicObjectMaterial(objectid, materialindex, &modelid, txdname[], texturename[], &materialcolor, maxtxdname = sizeof txdname, maxtexturename = sizeof texturename);
native SetDynamicObjectMaterial(objectid, materialindex, modelid, const txdname[], const texturename[], materialcolor = 0);
native GetDynamicObjectMaterialText(objectid, materialindex, text[], &materialsize, fontface[], &fontsize, &bold, &fontcolor, &backcolor, &textalignment, maxtext = sizeof text, maxfontface = sizeof fontface);
native SetDynamicObjectMaterialText(objectid, materialindex, const text[], materialsize = OBJECT_MATERIAL_SIZE_256x128, const fontface[] = "Arial", fontsize = 24, bold = 1, fontcolor = 0xFFFFFFFF, backcolor = 0, textalignment = 0);

Natives (Pickups)
-----------------

native CreateDynamicPickup(modelid, type, Float:x, Float:y, Float:z, worldid = -1, interiorid = -1, playerid = -1, Float:streamdistance = 100.0);
native DestroyDynamicPickup(pickupid);
native IsValidDynamicPickup(pickupid);

Natives (Checkpoints)
---------------------

native CreateDynamicCP(Float:x, Float:y, Float:z, Float:size, worldid = -1, interiorid = -1, playerid = -1, Float:streamdistance = 100.0);
native DestroyDynamicCP(checkpointid);
native IsValidDynamicCP(checkpointid);
native TogglePlayerDynamicCP(playerid, checkpointid, toggle);
native TogglePlayerAllDynamicCPs(playerid, toggle);
native IsPlayerInDynamicCP(playerid, checkpointid);
native GetPlayerVisibleDynamicCP(playerid);

Natives (Race Checkpoints)
--------------------------

native CreateDynamicRaceCP(type, Float:x, Float:y, Float:z, Float:nextx, Float:nexty, Float:nextz, Float:size, worldid = -1, interiorid = -1, playerid = -1, Float:streamdistance = 100.0);
native DestroyDynamicRaceCP(checkpointid);
native IsValidDynamicRaceCP(checkpointid);
native TogglePlayerDynamicRaceCP(playerid, checkpointid, toggle);
native TogglePlayerAllDynamicRaceCPs(playerid, toggle);
native IsPlayerInDynamicRaceCP(playerid, checkpointid);
native GetPlayerVisibleDynamicRaceCP(playerid);

Natives (Map Icons)
-------------------

native CreateDynamicMapIcon(Float:x, Float:y, Float:z, type, color, worldid = -1, interiorid = -1, playerid = -1, Float:streamdistance = 100.0, style = MAPICON_LOCAL);
native DestroyDynamicMapIcon(iconid);
native IsValidDynamicMapIcon(iconid);

Natives (3D Text Labels)
------------------------

native Text3D:CreateDynamic3DTextLabel(const text[], color, Float:x, Float:y, Float:z, Float:drawdistance, attachedplayer = INVALID_PLAYER_ID, attachedvehicle = INVALID_VEHICLE_ID, testlos = 0, worldid = -1, interiorid = -1, playerid = -1, Float:streamdistance = 100.0);
native DestroyDynamic3DTextLabel(Text3D:id);
native IsValidDynamic3DTextLabel(Text3D:id);
native GetDynamic3DTextLabelText(Text3D:id, text[], maxlength = sizeof text);
native UpdateDynamic3DTextLabelText(Text3D:id, color, const text[]);

Natives (Areas)
---------------

native CreateDynamicCircle(Float:x, Float:y, Float:size, worldid = -1, interiorid = -1, playerid = -1);
native CreateDynamicRectangle(Float:minx, Float:miny, Float:maxx, Float:maxy, worldid = -1, interiorid = -1, playerid = -1);
native CreateDynamicSphere(Float:x, Float:y, Float:z, Float:size, worldid = -1, interiorid = -1, playerid = -1);
native CreateDynamicCube(Float:minx, Float:miny, Float:minz, Float:maxx, Float:maxy, Float:maxz, worldid = -1, interiorid = -1, playerid = -1);
native CreateDynamicPolygon(Float:points[], Float:minz = -FLOAT_INFINITY, Float:maxz = FLOAT_INFINITY, maxpoints = sizeof points, worldid = -1, interiorid = -1, playerid = -1);
native DestroyDynamicArea(areaid);
native IsValidDynamicArea(areaid);
native GetDynamicPolygonPoints(areaid, Float:points[], maxlength = sizeof points);
native GetDynamicPolygonNumberPoints(areaid);
native TogglePlayerDynamicArea(playerid, areaid, toggle);
native TogglePlayerAllDynamicAreas(playerid, toggle);
native IsPlayerInDynamicArea(playerid, areaid, recheck = 0);
native IsPlayerInAnyDynamicArea(playerid, recheck = 0);
native IsAnyPlayerInDynamicArea(areaid, recheck = 0);
native IsAnyPlayerInAnyDynamicArea(recheck = 0);
native GetPlayerDynamicAreas(playerid, areas[], maxlength = sizeof areas);
native GetPlayerNumberDynamicAreas(playerid);
native IsPointInDynamicArea(areaid, Float:x, Float:y, Float:z);
native IsPointInAnyDynamicArea(Float:x, Float:y, Float:z);
native AttachDynamicAreaToObject(areaid, objectid, type = STREAMER_OBJECT_TYPE_DYNAMIC, playerid = INVALID_PLAYER_ID);
native AttachDynamicAreaToPlayer(areaid, playerid);
native AttachDynamicAreaToVehicle(areaid, vehicleid);

Natives (Extended)
------------------

native CreateDynamicObjectEx(modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, Float:drawdistance = 0.0, Float:streamdistance = 200.0, worlds[] = { -1 }, interiors[] = { -1 }, players[] = { -1 }, maxworlds = sizeof worlds, maxinteriors = sizeof interiors, maxplayers = sizeof players);
native CreateDynamicPickupEx(modelid, type, Float:x, Float:y, Float:z, Float:streamdistance = 100.0, worlds[] = { -1 }, interiors[] = { -1 }, players[] = { -1 }, maxworlds = sizeof worlds, maxinteriors = sizeof interiors, maxplayers = sizeof players);
native CreateDynamicCPEx(Float:x, Float:y, Float:z, Float:size, Float:streamdistance = 100.0, worlds[] = { -1 }, interiors[] = { -1 }, players[] = { -1 }, maxworlds = sizeof worlds, maxinteriors = sizeof interiors, maxplayers = sizeof players);
native CreateDynamicRaceCPEx(type, Float:x, Float:y, Float:z, Float:nextx, Float:nexty, Float:nextz, Float:size, Float:streamdistance = 100.0, worlds[] = { -1 }, interiors[] = { -1 }, players[] = { -1 }, maxworlds = sizeof worlds, maxinteriors = sizeof interiors, maxplayers = sizeof players);
native CreateDynamicMapIconEx(Float:x, Float:y, Float:z, type, color, style, Float:streamdistance = 100.0, worlds[] = { -1 }, interiors[] = { -1 }, players[] = { -1 }, maxworlds = sizeof worlds, maxinteriors = sizeof interiors, maxplayers = sizeof players);
native Text3D:CreateDynamic3DTextLabelEx(const text[], color, Float:x, Float:y, Float:z, Float:drawdistance, attachedplayer = INVALID_PLAYER_ID, attachedvehicle = INVALID_VEHICLE_ID, testlos = 0, Float:streamdistance = 100.0, worlds[] = { -1 }, interiors[] = { -1 }, players[] = { -1 }, maxworlds = sizeof worlds, maxinteriors = sizeof interiors, maxplayers = sizeof players);
native CreateDynamicCircleEx(Float:x, Float:y, Float:size, worlds[] = { -1 }, interiors[] = { -1 }, players[] = { -1 }, maxworlds = sizeof worlds, maxinteriors = sizeof interiors, maxplayers = sizeof players);
native CreateDynamicRectangleEx(Float:minx, Float:miny, Float:maxx, Float:maxy, worlds[] = { -1 }, interiors[] = { -1 }, players[] = { -1 }, maxworlds = sizeof worlds, maxinteriors = sizeof interiors, maxplayers = sizeof players);
native CreateDynamicSphereEx(Float:x, Float:y, Float:z, Float:size, worlds[] = { -1 }, interiors[] = { -1 }, players[] = { -1 }, maxworlds = sizeof worlds, maxinteriors = sizeof interiors, maxplayers = sizeof players);
native CreateDynamicCubeEx(Float:minx, Float:miny, Float:minz, Float:maxx, Float:maxy, Float:maxz, worlds[] = { -1 }, interiors[] = { -1 }, players[] = { -1 }, maxworlds = sizeof worlds, maxinteriors = sizeof interiors, maxplayers = sizeof players);
native CreateDynamicPolygonEx(Float:points[], Float:minz = -FLOAT_INFINITY, Float:maxz = FLOAT_INFINITY, maxpoints = sizeof points, worlds[] = { -1 }, interiors[] = { -1 }, players[] = { -1 }, maxworlds = sizeof worlds, maxinteriors = sizeof interiors, maxplayers = sizeof players);

Callbacks
---------

forward OnDynamicObjectMoved(objectid);
forward OnPlayerEditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz);
forward OnPlayerSelectDynamicObject(playerid, objectid, modelid, Float:x, Float:y, Float:z);
forward OnPlayerShootDynamicObject(playerid, weaponid, objectid, Float:x, Float:y, Float:z);
forward OnPlayerPickUpDynamicPickup(playerid, pickupid);
forward OnPlayerEnterDynamicCP(playerid, checkpointid);
forward OnPlayerLeaveDynamicCP(playerid, checkpointid);
forward OnPlayerEnterDynamicRaceCP(playerid, checkpointid);
forward OnPlayerLeaveDynamicRaceCP(playerid, checkpointid);
forward OnPlayerEnterDynamicArea(playerid, areaid);
forward OnPlayerLeaveDynamicArea(playerid, areaid);

Instructions
------------

Create a directory called "plugins" inside of the server directory if
one does not already exist. Place the plugin file (streamer.dll or
streamer.so) inside of this directory.

Add the following line to server.cfg so that the plugin will load the
next time the server starts: 

Windows:
plugins streamer.dll

Linux:
plugins streamer.so

On Windows, add streamer.inc to the pawno\include folder. Include
this file in any of the scripts the server is running:

#include <streamer>

Recompile the scripts with any desired natives and callbacks provided
by the include file. Start the server.

General Notes
-------------

- Default tick rate: 50
- Default maximum items: none (unlimited)
- Default visible items: 500 (objects); 4096 (pickups); 1024 (3D text
  labels)
- If -1 is specified for any of the optional parameters (worldid,
  interiorid, or playerid), then the items will be streamed for all
  virtual worlds, interiors, or players.
- The tick rate does not represent any specific measurement of time
  and varies depending on the server's processing power. If items
  stream too slowly, lower the tick rate; if CPU usage gets too high,
  raise the tick rate.
- If some items are not appearing, there may be too many in one area.
  Lower the streaming distance by decreasing the "streamdistance"
  parameter on each native.
- Not all types of items have to be streamed. If the plugin is only
  used to stream objects, for example, then every other native can be
  safely ignored.
- Be careful when using streamed items with non-streamed items.
  Conflicts can sometimes arise.
- Because there are no per-player pickups, a pickup that is streamed
  for one player will be visible for all other players as well,
  provided that those players are all in the same virtual world.
- A maximum of 1000 player IDs (0-999) can be assigned per item.
- The maximum amount of visible objects may be increased to 999 as of
  SA-MP 0.3d, though it is not recommended for all of these objects
  to be in one area due to game engine limits. By default, the number
  of visible objects is set to 500 to avoid conflicts.
- Ensure that all scripts are compiled with the latest include file.

Native Notes
------------

- Use Streamer_UpdateEx to preload items before setting a player's
  position or to stream items under OnPlayerRequestClass.
- Virtual worlds, interiors, and players can be modified or read
  through the array data manipulation natives (Streamer_GetArrayData
  and Streamer_SetArrayData, for example).
- Here is an example of using the data manipulation natives (note the
  use of the definitions and the enumerator above):

  Streamer_SetIntData(STREAMER_TYPE_OBJECT, objectid, E_STREAMER_MODEL_ID, 1225);

- Here is another example for data stored as arrays (virtual worlds,
  interiors, and players):

  Streamer_AppendArrayData(STREAMER_TYPE_OBJECT, objectid, E_STREAMER_PLAYER_ID, playerid);

- To adjust an object's draw distance (added in SA-MP 0.3b), use
  Streamer_SetFloatData with E_STREAMER_DRAW_DISTANCE. Alternatively,
  use CreateDynamicObject(Ex). An object's default draw distance can
  be set by specifying 0.0.
- To adjust a map icon's style (added in SA-MP 0.3c), use
  Streamer_SetIntData with E_STREAMER_STYLE. Alternatively, use
  CreateDynamicMapIcon(Ex). Valid styles range from 0 to 3, and each
  map icon's default style is 0.
- Only circles and spheres may be used with the attach area natives.
- The points in CreateDynamicPolygon and CreateDynamicPolygonEx need
  to be specified as a sequence of ordered pairs (x1, y1, x2, y2,
  ..., xn, yn). The number of elements in the array must be divisible
  by two for this reason. The first point must also be equal to the
  last point to form a closed path.
- The number configurable in Streamer_CellDistance is used to
  determine whether or not an item needs to be put in a cell for
  spatial indexing purposes. The default value is 600.0. If an item's
  streaming distance (or, in the case of areas, an item's size)
  exceeds that of the cell distance, it will be streamed from any
  point on the map. For example, if a map icon's streaming distance
  is set to 100.0, it will only be visible if the player is in the
  same cell as the map icon or in an adjacent cell (assuming the
  default cell distance of 600.0 has not been changed). However, if
  the map icon's streaming distance is set to 1000.0, it will be
  visible no matter where the player is.
- The number configurable in Streamer_CellSize is used to determine
  the size of each cell in the grid. The default value is 300.0.
- Note that Streamer_CellDistance and Streamer_CellSize rebuild the
  grid each time they are called, so use them only when necessary.
  The default values are also considered optimal, so in most cases,
  it is recommended to simply leave these natives alone unless a
  specific need arises.
- Items can be grouped together using y_groups, which is part of the
  YSI library.

Performance Notes
-----------------

- It is not recommended to use a high streaming distance for every
  item. This can drastically impact performance because it leads to
  more items being checked on each update. If an item's streaming
  distance exceeds that of the cell distance (600.0 by default), it
  also does not benefit from spatial indexing, which can lead to even
  worse performance. Only set high streaming distances for items
  which need to be visible from very far away (global map icons, for
  example).
- Adding too many virtual worlds and interiors to items can lead to
  increased memory usage and decreased performance. Specifying -1
  (all virtual worlds and interiors) actually ensures the best
  performance, because it eliminates the need to do a lookup when
  that item is checked on each update. Note that this does not apply
  to players since only a finite amount can be added.

Dependencies
------------

The Windows version requires the Microsoft .NET Framework 4.0 or
higher.
