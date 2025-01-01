
if (!isServer) exitWith {};

{
	_areaObject = _x;
	_objects = [_areaObject] call bax_persist_fnc_getPersistentAreaObjects;
	{
		_object = _x;
		[_object] call bax_persist_fnc_registerObjectRandom;
	} forEach _objects; 
} forEach bax_persist_persistentAreas;
