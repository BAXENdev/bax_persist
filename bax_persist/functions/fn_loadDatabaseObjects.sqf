
params ["_objectDatabase"];

{
	_x params ["_class", "_posDir", "_damage", "_inventory", "_variables"];
	_posDir params ["_position", "_direction"];
	_object = createVehicle [_class, _position];
	_object setDir _direction;
	if (_damage isEqualType 0) then {
		_object setDamage _damage;
	} else {
		{
			_hitPointValue = _x;
			_object setHitIndex [_forEachIndex, _hitPointValue];
		} forEach _damage;
	};

	[_object, _inventory] call bax_persist_fnc_deserializeObjectInventory;

	if (bax_persist_loadObjectVariables) then {
		{
			_x params ["_variable", "_value"];
			_object setVariable [_variable, _value, true];
		} forEach _variables;
	};

	bax_persist_registeredObjects pushBack _object;
} forEach _objectDatabase;
