
params [["_forceSave", false]];

private ["_namespace"];

if ((is3DEN or is3DENMultiplayer or is3DENPreview or !bax_persist_savingEnabled) and !_forceSave) exitWith {}; 

if (bax_persist_selectedNamespace isEqualTo "MProfile") then {
	_namespace = missionProfileNamespace;
} else { // bax_persist_selectedNamespace == "Profile"
	_namespace = profileNamespace;
};

_databasePlayers = [] call bax_persist_fnc_saveDatabasePlayers;
_databaseObjects = [] call bax_persist_fnc_saveDatabaseObjects;
_databaseVariables = [] call bax_persist_fnc_saveDatabaseVariables;
_databaseInventories = [] call bax_persist_fnc_saveDatabaseInventories;

_creationTime = systemTimeUTC joinString "_";
_saveData = _namespace setVariable ["bax_persist_saveData", _saveData];
_saveData set [0, _creationTime];
_namespace setVariable ["bax_persist_saveData", _saveData];
saveMissionProfileNamespace;

{
	// TODO: can I create a manual save?
	if (hasInterface and { player isEqualTo _x }) then { continue }; // skip self hosted zeus
	_this remoteExec ["bax_persist_fnc_zeusSaveDatabase", _x];
} forEach (allCurators apply { getAssignedCuratorUnit _x });
