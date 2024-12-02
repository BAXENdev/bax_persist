
if !(isServer) exitWith {
	// return
	false
};

params [
	"_objectId", ["_object", objNull], ["_resetPosition", false], ["_resetInventory", false],
	["_resetDamage", false], ["_resetFuel", false], ["_resetAmmo", false]
];

_objectRecord = bax_persist_databaseObjects get _objectId;
if (isNil "_objectRecord") exitWith {
	// return
	false;
};

_objectRecord params [
	"_class", "_posDir", "_damage", "_fuel", "_pylons", "_ammo",
	"_inventory", "_variables", "_isSpawned"
];

if (_isSpawned) exitWith {
	// return
	false;
};

_posDir params ["_position", "_direction"];
if (isNull _object) then {
	_object = createVehicle [_class, _position];
	_object setDir _direction;
} else {
	if (!_resetPosition) then {
		_object setPosATL _position;
		_object setDir _direction;
	};
};

if (bax_persist_loadObjectDamage and { typeOf _object isEqualTo _class }) then {
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

if (!bax_persist_loadObjectFuel and _resetFuel) then {
	_object setFuel _fuel;
};

if (_object isKindOf "AllVehicles") then {
	if (_resetAmmo or !bax_persist_loadObjectAmmo) exitWith {};
	
	{
		_x params ["_pylonIndex", "_pylonName", "_turretPath"];
		_object setPylonLoadout [_pylonIndex, "", false, _turretPath];
	} forEach (getAllPylonsInfo _object);

	// TODO: Turret weapons

	{
		_x params ["_magClass", "_turretPath"];
		_object removeMagazinesTurret [_magClass, _turretPath];
	} forEach (magazinesAllTurrets _object);

	{
		_x params ["_pylonIndex", "_turretPath", "_magClass", "_ammoCount"];
		_object setPylonLoadout [_pylonIndex, _magClass, false, _turretPath];
		_object setAmmoOnPylon [_pylonIndex, _ammoCount];
	} forEach _pylons;

	{
		_x params ["_magClass", "_turretPath", "_ammoCount"];
		_object addMagazineTurret [_magClass, _turretPath, _ammoCount];
	} forEach _ammo;
};

[_object, _inventory] call bax_persist_fnc_deserializeInventory;

{
	_variable = _x;
	_defaultValue = _y;

	_object setVariable [_variable, _defaultValue, true];
} forEach bax_persist_registeredObjectVariables;

{
	_x params ["_variable", "_value"];

	_object setVariable [_variable, _value, true];
} forEach _variables;

_objectRecord set [(count _objectRecord - 1), true];

// return
true;
