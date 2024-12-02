
if !(bax_persist_loadObjectDatabase) exitWith {};

params ["_objectDatabase"];

{
	_objectId = _x;

	[_objectId] call bax_persist_fnc_loadObject;
} forEach bax_persist_databaseObjects;
