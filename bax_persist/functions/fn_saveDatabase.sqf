
private ["_namespace"];

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
_databaseSave = [
	_creationTime,
	_databasePlayers,
	_databaseObjects,
	_databaseVariables,
	_databaseInventories
];

_saves = _namespace getVariable ["bax_persist_saves", []];
_saves pushBack _databaseSave;
_namespace setVariable ["bax_persist_saves", _saves];
saveMissionProfileNamespace;

// TODO: Forward to zeuses to save in their database

