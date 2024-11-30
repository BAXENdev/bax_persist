
if !(bax_persist_loadObjectDatabase) exitWith {};

params ["_objectDatabase"];

{
	_id = _x;
	_y params ["_class", "_posDir", "_damage", "_fuel", "_inventory", "_variables", "_isAlive", "_spawned"];

	if (_spawned or !_isAlive) then { continue };

	_posDir params ["_position", "_direction"];
	_object = createVehicle [_class, _position];
	_object setDir _direction;

	_object setVariable ["bax_persist_objectId", _id, true];
	bax_persist_registeredObjects pushBack _object;

	if (bax_persist_loadObjectDamage) then {
		if (_damage isEqualType 0) then {
			_object setDamage _damage;
		} else {
			{
				_hitPointValue = _x;
				_hitPointIndex = _forEachIndex;
				_object setHitIndex [_hitPointIndex, _hitPointValue];
			} forEach _damage;
		};
	};

	if (bax_persist_loadObjectFuel) then {
		_object setFuel _fuel;
	};

	[_object, _inventory] call bax_persist_fnc_deserializeObjectInventory;

	{
		_x params ["_variable", "_value"];
		_object setVariable [_variable, _value, true];
	} forEach _variables;
} forEach bax_persist_databaseObjects;
