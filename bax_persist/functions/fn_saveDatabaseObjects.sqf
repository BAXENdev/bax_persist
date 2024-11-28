
private ["_object", "_class", "_posDir", "_damage", "_hitpoints", "_inventory", "_variables", "_variable", "_value", "_defaultValue"];

_databaseObjects = [];

{
	_object = _x;

	if !(alive _object) then {
		continue;
	};

	_class = typeOf _object;
	_posDir = [getPos _object, getDir _object];
	_hitpoints = getAllHitPointsDamage _object;
	if (_hitpoints isEqualTo []) then {
		_damage = damage _object;
	} else {
		_damage = _hitpoints select 2;
	};
	_inventory = [_object] call bax_persist_fnc_serializeObjectInventory;
	_variables = [];
	{
		_x params ["_variable", "_defaultValue"];
		_value = _object getVariable [_variable, _defaultValue];
		if !(isNil "_value") then {
			_variables pushBack [_variable, _value];
		};
	} forEach bax_persist_registeredObjectVariables;

	_databaseObjects pushBack [_class, _posDir, _damage, _inventory, _variables];
} forEach bax_persist_registeredObjects;

_databaseObjects;
