
if !(isServer) exitWith {
	// return
	false
};

params [["_id", ""], ["_object", objNull]];

if !(alive _object) exitWith {
	if (_id in bax_persist_databaseObjects) then {
		bax_persist_databaseObjects deleteAt _id;
	};
	// return
	false;
};

if (_id isEqualTo "") then {
	_id = _object getVariable "bax_persist_objectId";
};

if (isNil "_id" or { _id isEqualTo "" }) exitwith {
	// return
	false;
};

_class = typeOf _object;
_posDir = [getPosATL _object, getDir _object];
_hitpoints = getAllHitPointsDamage _object;
_damage = 0;
if (_hitpoints isEqualTo []) then {
	_damage = damage _object;
} else {
	_damage = _hitpoints select 2;
};

_inventory = [_object] call bax_persist_fnc_serializeInventory;

_fuel = fuel _object;
_pylons = [];
_ammo = [];

if (_object isKindOf "AllVehicles") then {
	_pylons = getAllPylonsInfo _object apply {
		[
			_x select 0, // index. Can this be gotten from _forEachIndex + 1?
			_x select 2, // turret path
			_x select 3, // Mag Class
			_x select 4  // Ammo count
		]
	};
	_ammo = magazinesAllTurrets _object apply {
		[
			_x select 0, // Mag Class
			_x select 1, // Turret Path
			_x select 2  // Ammo Count
		]
	};

	{
		_x params ["_index", "_turretPath", "_magClass", "_magCount"];
		_index = _ammo findIf {
			_x params ["_magClass2", "_turretPath2", "_magCount2"];
			// return
			(_magClass isEqualTo _magClass2) and (_magcount isEqualTo _magCount2);
		};
		if (_index != -1) then {
			_ammo deleteAt _index;
		};
	} forEach _pylons;
};

_variables = [];
{
	_variable = _x;
	_value = _object getVariable _variable;
	if (isNil "_value") then { continue; };
	_variables pushBack [_variable, _value];
} forEach bax_persist_registeredObjectVariables;

bax_persist_databaseObjects set [
	_id,
	[
		_class,
		_posDir,
		_damage,
		_fuel,
		_pylons,
		_ammo,
		_inventory,
		_variables,
		true // has been spawned, default true. Is reset upon mission start
	]
];

// return
true;