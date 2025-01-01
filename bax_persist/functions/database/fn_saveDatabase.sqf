
if (!isServer) exitWith {};

params [["_forceSave", false]];

if ((is3DEN or is3DENMultiplayer or is3DENPreview or !bax_persist_savingEnabled) and !_forceSave) exitWith {}; 

[] call bax_persist_fnc_registerPersistentAreas; // register objects in persistent areas for saving

[] call bax_persist_fnc_saveDatabasePlayers;
[] call bax_persist_fnc_saveDatabaseObjects;
[] call bax_persist_fnc_saveDatabaseVariables;
[] call bax_persist_fnc_saveDatabaseInventories;

["bax_persist_saveDatabase", []] call CBA_fnc_localEvent; // server event because this only runs on server

_creationTime = systemTimeUTC joinString "_";
missionNamespace setVariable ["bax_persist_saveDate", bax_persist_saveDate];
missionNamespace setVariable ["bax_persist_databasePlayers", bax_persist_databasePlayers];
missionNamespace setVariable ["bax_persist_databaseObjects", bax_persist_databaseObjects];
missionNamespace setVariable ["bax_persist_databaseVariables", bax_persist_databaseVariables];
missionNamespace setVariable ["bax_persist_databaseInventories", bax_persist_databaseInventories];

// TODO: Send data to clients and call save function
