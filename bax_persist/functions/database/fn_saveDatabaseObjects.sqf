
{
	_id = _x;
	_object = _y;
	
	[_id, _object] call bax_persist_fnc_saveObject;
} forEach bax_persist_registeredObjects;
