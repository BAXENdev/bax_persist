
private ["_object", "_class", "_posDir", "_damage", "_hitpoints", "_inventory", "_variables", "_variable", "_value", "_defaultValue"];

{
	_object = _x;

	_id = _object getVariable "bax_persist_objectId";

	if (isNil "_id") then { continue; };

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
	_fuel = fuel _object;
	_variables = [];
	{
		_x params ["_variable", "_defaultValue"];
		_value = _object getVariable [_variable, _defaultValue];
		if !(isNil "_value") then {
			_variables pushBack [_variable, _value];
		};
	} forEach bax_persist_registeredObjectVariables;
	_isAlive = alive _object;

	bax_persist_databaseObjects set [
		_id,
		[
			_class,
			_posDir,
			_damage,
			_fuel,
			_inventory,
			_variables,
			_isAlive, // saved to indicate that the vehicle should no longer be spawned
			true // has been spawned, default true. Is reset upon loading the save
		]
	];
} forEach bax_persist_registeredObjects;
