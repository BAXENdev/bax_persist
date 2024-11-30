
if (hasInterface) then {
	[
		{ !isNull player and bax_persist_isLoaded },
		{ _this remoteExec ["bax_persist_fnc_requestPlayerLoad", 2] },
		[player]
	] call CBA_fnc_waitUntilAndExecute;
};

if !(isServer) exitWith {};

addMissionEventHandler [
	"HandleDisconnect",
	{
		params ["_unit", "_id", "_uid", "_name"];
		// TODO: Does getPlayerUID still work on a disconnecting unit?
		// If so, remove ID param...
		[_uid, _unit] call bax_persist_fnc_savePlayerToDatabase;
	}
];

addMissionEventHandler [
	"Ended",
	{
		params ["_endType"];
		if (_endType isNotEqualTo "Bax_Persist_NoSave") then {
			[] call bax_persist_fnc_saveDatabase;
		};
	}
];

[] call bax_persist_fnc_queueSaveDatabase;

missionNamespace setVariable ["bax_persist_isLoaded", true, true];
