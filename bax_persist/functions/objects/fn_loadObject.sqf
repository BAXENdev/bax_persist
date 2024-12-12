
if !(isServer) exitWith {
	// return
	[false, "Must be called on server"];
};

params [
	"_objectId",
	["_object", objNull],
	["_resetPosition", false],
	["_resetInventory", false],
	["_resetDamage", false],
	["_resetFuel", false],
	["_resetAmmo", false]
];

_resetPosition = _resetPosition or (_object getVariable ["Bax_Persist_ResetObjectPosition", false]);
_resetInventory = _resetInventory or (_object getVariable ["Bax_Persist_ResetObjectInventory", false]);
_resetDamage = _resetDamage or bax_persist_resetObjectDamage or (_object getVariable ["Bax_Persist_ResetObjectDamage", false]);
_resetFuel = _resetFuel or bax_persist_resetObjectFuel or (_object getVariable ["Bax_Persist_ResetObjectFuel", false]);
_resetAmmo = _resetAmmo or bax_persist_resetObjectAmmo or (_object getVariable ["Bax_Persist_ResetObjectAmmo", false]);

_objectRecord = bax_persist_databaseObjects get _objectId;
if (isNil "_objectRecord") exitWith {
	// return
	[false, "No record exists in database"];
};

_objectRecord params ["_class", "_posDir", "_damage", "_fuel", "_pylons", "_ammo", "_inventory", "_variables", "_isSpawned"];

if (_isSpawned) exitWith {
	// return
	[false, "The record has already been spawned"];
};

_posDir params ["_position", "_direction"];
if (isNull _object) then {
	_object = createVehicle [_class, ASLToATL _position];
	_object setDir _direction;
} else {
	if (!_resetPosition) then {
		// _object setPosATL _position;
		_object setPosASL _position;
		_object setDir _direction;
	};
};

if (!_resetDamage and { typeOf _object isEqualTo _class }) then {
	if (_damage isEqualType 0) then {
		_object setDamage [_damage, false];
	} else {
		{
			_hitPointValue = _x;
			_hitPointIndex = _forEachIndex;
			_object setHitIndex [_hitPointIndex, _hitPointValue];
		} forEach _damage;
	};
};

if (!_resetFuel) then {
	_object setFuel _fuel;
};

if (_object isKindOf "AllVehicles") then {
	{
		_x params ["_pylonIndex", "_pylonName", "_turretPath"];
		_object setPylonLoadout [_pylonIndex, "", false, _turretPath];
	} forEach (getAllPylonsInfo _object);

	// TODO: Turret weapons

	if (_resetAmmo) exitWith {};

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
[_objectId, _object] call bax_persist_fnc_registerObject;

// return
[true, "Successfully spawned"];
