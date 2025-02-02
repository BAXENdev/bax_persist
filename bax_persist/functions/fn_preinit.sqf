
bax_persist_databaseLoaded = false;

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
bax_persist_persistentAreas = [];
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

// if !(isMissionProfileNamespaceLoaded) then {
// 	saveMissionProfileNamespace;
// };

bax_persist_saveDate = missionProfileNamespace getVariable ["bax_persist_saveDate", "2014_1_1_0_0_0_0"];
bax_persist_databasePlayers = missionProfileNamespace getVariable ["bax_persist_databasePlayers", createHashmap];
bax_persist_databaseObjects = missionProfileNamespace getVariable ["bax_persist_databaseObjects", createHashmap];
bax_persist_databaseVariables = missionProfileNamespace getVariable ["bax_persist_databaseVariables", createHashmap];
bax_persist_databaseInventories = missionProfileNamespace getVariable ["bax_persist_databaseInventories", createHashmap];

[] call bax_persist_fnc_loadDatabaseVariables;

{
	_y set [(count _y) - 1, true];
} forEach bax_persist_databasePlayers;
