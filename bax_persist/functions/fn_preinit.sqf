
bax_persist_isLoaded = false;

if (!isServer) exitWith {};

bax_persist_autosaveTimer = 40;
bax_persist_savingEnabled = true;
bax_persist_autosaveEnabled = true;

// Variables to be saved
// Elements = [variable name, default value]
bax_persist_registeredNamespaceVariables = createHashMap;
bax_persist_registeredPlayerVariables = createHashMap;
bax_persist_registeredObjectVariables = createHashMap;

bax_persist_registeredObjects = createHashMap;
bax_persist_registeredInventoryObjects = createHashMap;
bax_persist_playerWhitelistAreas = [];
// bax_persist_playerBlacklistAreas = [];

// Variables set by the init module
bax_persist_loadPlayerDatabase = false;
bax_persist_resetPlayerPosition = false;
bax_persist_resetPlayerMedical = false;
bax_persist_loadPlayerKeySide = false;
bax_persist_loadPlayerKeyRole = false;

bax_persist_loadObjectDatabase = false;
bax_persist_resetObjectDamage = false;
bax_persist_resetObjectFuel = false;
bax_persist_resetObjectAmmo = false;
bax_persist_cleanObjectDatabase = false;

bax_persist_loadVariablesDatabase = false;

// Inventory database is an opt in system, so no need to for toggle

if !(isMissionProfileNamespaceLoaded) then {
	saveMissionProfileNamespace;
};

private ["_saveData"];
_saveData = missionProfileNamespace getVariable "bax_persist_saveData";
if (isNil "_saveData") then {
	// saveData, player database, object database, variable database, inventory database
	_saveData = ["2014_1_1_0_0_0_0", createHashMap, createHashMap, createHashMap, createHashMap];
	missionProfileNamespace setVariable ["bax_persist_saveData", _saveData];
	missionProfileNamespace setVariable ["bax_persist_saveBackups", []];
	saveMissionProfileNamespace;
};

// _saveData select 0 is save date.
bax_persist_databasePlayers = _saveData select 1;
bax_persist_databaseObjects = _saveData select 2;
bax_persist_databaseVariables = _saveData select 3;
bax_persist_databaseInventories = _saveData select 4;

[] call bax_persist_fnc_loadDatabaseVariables;

// Set spawned to false
{
	_y set [(count _y - 1), false];
} forEach bax_persist_databaseObjects;
// Set firstJoin to true. When set to false, allows players to rejoin without being reset when any reset is enabled
{
	_y set [(count _y) - 1, true];
} forEach bax_persist_databasePlayers;
