
params [["_forceSave", false]];

if ((is3DEN or is3DENMultiplayer or is3DENPreview or !bax_persist_savingEnabled) and !_forceSave) exitWith {}; 

["bax_persist_saveDatabase", []] call CBA_fnc_localEvent;

[] call bax_persist_fnc_saveDatabasePlayers;
[] call bax_persist_fnc_saveDatabaseObjects;
[] call bax_persist_fnc_saveDatabaseVariables;
[] call bax_persist_fnc_saveDatabaseInventories;

_creationTime = systemTimeUTC joinString "_";
_saveData = missionProfileNamespace getVariable "bax_persist_saveData";
_saveData set [0, _creationTime];
missionProfileNamespace setVariable ["bax_persist_saveData", _saveData];
saveMissionProfileNamespace;

{
	if (hasInterface and { player isEqualTo _x }) then { continue; }; // skip self hosted zeus
	if (isNull _x) then { continue };
	_saveData remoteExec ["bax_persist_fnc_zeusSaveDatabase", _x];
} forEach (allCurators apply { getAssignedCuratorUnit _x });
