
if (hasInterface) then {
	[
		{ !isNull player and bax_persist_isLoaded },
		{ _this remoteExec ["bax_persist_fnc_requestPlayerLoad", 2] },
		[player]
	] call CBA_fnc_waitUntilAndExecute;
};

if !(isServer) exitWith {};

private ["_namespace"];
if (bax_persist_selectedNamespace isEqualTo "MProfile") then {
	_namespace = missionProfileNamespace;
} else { // bax_persist_selectedNamespace == "Profile"
	_namespace = profileNamespace;
};
_saves = _namespace getVariable "bax_persist_saves";

if (count _saves == 0) exitwith {
	missionNamespace setVariable ["bax_persist_isLoaded", true, true];
};

_databaseSave = _saves select -1;
_databaseSave params ["_time", "_playerDatabase", "_objectDatabase", "_variableDatabase", "_inventoryDatabase"];
bax_persist_databasePlayers = +_playerDatabase;

// load player data is handled through remote execs

if (bax_persist_loadObjectDatabase) then {
	[_objectDatabase] call bax_persist_fnc_loadDatabaseObjects;
};

if (bax_persist_loadVariableDatabase) then {
	[_variableDatabase] call bax_persist_fnc_loadDatabaseVariables;
};

if (bax_persist_loadInventoriesDatabase) then {
	bax_persist_registeredInventories = _inventoryDatabase;
};

missionNamespace setVariable ["bax_persist_isLoaded", true, true];
