
if !(bax_persist_loadObjectDatabase) exitWith {};

params ["_objectDatabase"];

{
	_objectId = _x;

	if (_objectId in bax_persist_registeredObjects) then {
		continue;
	};

	_return = [_objectId] call bax_persist_fnc_loadObject;
	_return params ["_didSpawned", "_reason", "_object"];
	if (_didSpawned) then {
		[_objectId] call bax_persist_fnc_registerObject;
	};
} forEach bax_persist_databaseObjects;
