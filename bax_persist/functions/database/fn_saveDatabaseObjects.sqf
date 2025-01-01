
{
	_id = _x;
	_object = _y;
	
	_return = [_id, _object] call bax_persist_fnc_saveObject;
	_return params ["_result", "_reason"];
	if (!_result) then {
		// If a object is registered but no longer exists, delete from database.
		bax_persist_databaseObjects deleteAt _id;
	};
} forEach bax_persist_registeredObjects;
