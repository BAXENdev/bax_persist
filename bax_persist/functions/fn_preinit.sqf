
[
	"bax_persist_selectedNamespace",
	"LIST",
	["Namespace", "Use MissionProfile combined with setting missionGroup in description.ext for most cases. You can use profile, but excess amounts of data in profile.vars can corrupt the file."],
	"BAX Persist",
	[
		["MProfile", "Profile"],
		["Profile", "Profile"]
	],
	1
] call CBA_fnc_addSetting;

bax_persist_isLoaded = false;

if (!isServer) exitWith {};

private ["_namespace", "_saves"];

bax_persist_databasePlayers = createHashMap;
bax_persist_databaseInventories = createHashMap;

// Variables to be saved
// Elements = [variable name, default value]
bax_persist_registeredNamespaceVariables = [];
bax_persist_registeredPlayerVariables = [];
bax_persist_registeredObjectVariables = [];

bax_persist_registeredObjects = [];
bax_persist_registeredInventoryObjects = [];

// Variables set by the module
bax_persist_loadPlayerDatabase = false;
bax_persist_loadPlayerVariables = false;
bax_persist_loadObjectDatabase = false;
bax_persist_loadObjectsVariables = false;
bax_persist_loadVariableDatabase = false;
// bax_persist_loadInventoriesDatabase = false;
bax_persist_loadPlayerMedical = false;

if (bax_persist_selectedNamespace isEqualTo "MProfile") then {
	if !(isMissionProfileNamespaceLoaded) then {
		saveMissionProfileNamespace;
	};
	_namespace = missionProfileNamespace;
} else { // bax_persist_selectedNamespace == "Profile"
	_namespace = profileNamespace;
};

_saves = _namespace getVariable "bax_persist_saves";
if (isNil "_saves" or { !(_saves isEqualType []) }) then {
	_namespace setVariable ["bax_persist_saves", []];
};
