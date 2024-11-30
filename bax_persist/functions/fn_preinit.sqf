
// [
// 	"bax_persist_selectedNamespace",
// 	"LIST",
// 	["Namespace", "Use MissionProfile combined with setting missionGroup in description.ext for most cases. You can use profile, but excess amounts of data in profile.vars can corrupt the file."],
// 	"BAX Persist",
// 	[
// 		["MProfile", "Profile"],
// 		["Profile", "Profile"]
// 	],
// 	2
// ] call CBA_fnc_addSetting;

// [
// 	"bax_persist_autosaveTimer",
// 	"SLIDER",
// 	["Autosave Timer", "How often autosave occurs, in minutes."],
// 	"BAX Persist",
// 	[5, 120, 40, 0, false],
// 	2
// ] call CBA_fnc_addSetting;

bax_persist_isLoaded = false;

if (!isServer) exitWith {};

privateAll;

bax_persist_selectedNamespace = "MProfile";
bax_persist_autosaveTimer = 40;
bax_persist_savingEnabled = true;

// Variables to be saved
// Elements = [variable name, default value]
bax_persist_registeredNamespaceVariables = [];
bax_persist_registeredPlayerVariables = [];
bax_persist_registeredObjectVariables = [];

bax_persist_registeredObjects = [];
bax_persist_registeredInventoryObjects = [];

// Variables set by the init module
// bax_persist_loadPlayerLoadout = false;
// bax_persist_loadPlayerTraits = false;
bax_persist_loadPlayerDatabase = false;
bax_persist_loadPlayerPosition = false;
bax_persist_loadPlayerMedical = false;
// bax_persist_loadPlayerVariables = false;
bax_persist_loadPlayerKeySide = false;
bax_persist_loadPlayerKeyRole = false;

bax_persist_loadObjectDatabase = false;
// bax_persist_loadObjectInventory = false;
bax_persist_loadObjectDamage = false;
bax_persist_loadObjectFuel = false;
// bax_persist_loadObjectVariables = false;

bax_persist_loadVariablesDatabase = false;

// Inventory database is an opt in system, so no need to for toggle

// bax_persist_load = false;
// bax_persist_load = false;
// bax_persist_load = false;
// bax_persist_load = false;
// bax_persist_load = false;

if (bax_persist_selectedNamespace isEqualTo "MProfile") then {
	if !(isMissionProfileNamespaceLoaded) then {
		saveMissionProfileNamespace;
	};
	_namespace = missionProfileNamespace;
} else { // bax_persist_selectedNamespace == "Profile"
	_namespace = profileNamespace;
};

_saveData = _namespace getVariable "bax_persist_saveData";
if (isNil "_saveData") then {
	// saveData, player database, object database, variable database, inventory database
	_saveData = ["2014_1_1_0_0_0_0", createHashMap, createHashMap, createHashMap, createHashMap]
	_namespace setVariable ["bax_persist_saveData", _saveData];
	_namespace setVariable ["bax_persist_saveBackups", []];
	saveMissionProfileNamespace;
};

// _saveData select 0 is save date.
bax_persist_databasePlayers = _saveData select 1;
bax_persist_databaseObjects = _saveData select 2;
bax_persist_databaseVariables = _saveData select 3;
bax_persist_databaseInventories = _saveData select 4;

// Set spawned to false
{
	_y set [7, false];
} forEach bax_persist_databaseObjects;
