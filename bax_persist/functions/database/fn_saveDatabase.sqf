
if (!isServer) exitWith {};

params [["_forceSave", false]];

if ((is3DEN or is3DENMultiplayer or is3DENPreview or !bax_persist_savingEnabled) and !_forceSave) exitWith {}; 

// TODO: Performance impact?
// Add save warning?
[] call bax_persist_fnc_registerPersistentAreas; // register objects in persistent areas for saving

[] call bax_persist_fnc_saveDatabasePlayers;
[] call bax_persist_fnc_saveDatabaseObjects;
[] call bax_persist_fnc_saveDatabaseVariables;
[] call bax_persist_fnc_saveDatabaseInventories;

["bax_persist_saveDatabase", []] call CBA_fnc_localEvent; // server event because this only runs on server

_creationTime = systemTimeUTC joinString "_";
missionProfileNamespace setVariable ["bax_persist_saveDate", bax_persist_saveDate];
missionProfileNamespace setVariable ["bax_persist_databasePlayers", bax_persist_databasePlayers];
missionProfileNamespace setVariable ["bax_persist_databaseObjects", bax_persist_databaseObjects];
missionProfileNamespace setVariable ["bax_persist_databaseVariables", bax_persist_databaseVariables];
missionProfileNamespace setVariable ["bax_persist_databaseInventories", bax_persist_databaseInventories];

saveMissionProfileNamespace;

// transfer data to clients
if (!isMultiplayer) exitWith {};
{
	_curatorUnit = getAssignedCuratorUnit _x;
	if (isNull _curatorUnit) then { continue };
	if (hasInterface and { _curatorUnit isEqualTo player }) then { continue }; // skip self hosted zeus
	// _netId = netId _curatorUnit;
	_netId = owner _curatorUnit;
	_netId publicVariableClient "bax_persist_saveDate";
	_netId publicVariableClient "bax_persist_databasePlayers";
	_netId publicVariableClient "bax_persist_databaseObjects";
	_netId publicVariableClient "bax_persist_databaseVariables";
	_netId publicVariableClient "bax_persist_databaseInventories";
	[] remoteExec ["bax_persist_fnc_zeusSaveDatabase", _netId]; // net id or unit reference would work here
} forEach allCurators;
