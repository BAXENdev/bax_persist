
if !(isServer) exitWith {
	// return
	[false, "Must be called on server", objNull];
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

// _resetPosition = _resetPosition;
// _resetInventory = _resetInventory;
_resetDamage = _resetDamage or bax_persist_resetObjectDamage;
_resetFuel = _resetFuel or bax_persist_resetObjectFuel;
_resetAmmo = _resetAmmo or bax_persist_resetObjectAmmo;

_objectRecord = bax_persist_databaseObjects get _objectId;
if (isNil "_objectRecord") exitWith {
	// return
	[false, "No record exists in database", objNull];
};

_objectRecord params ["_class", "_posDir", "_damage", "_fuel", "_pylons", "_ammo", "_inventory", "_variables"];

_posDir params ["_position", "_vectorDir", "_vectorUp"];
if (isNull _object) then {
	// _object = createVehicle [_class, [0, 0, 0]];
	_object = _class createVehicle [0, 0, 0];
	_object setVariable ["BIS_enableRandomization", false];
	_object setPosASL _position;
	_object setVectorDirAndUp [_vectorDir, _vectorUp];
} else {
	if (!_resetPosition) then {
		// _object setPosATL _position;
		_object setPosASL _position;
		_object setVectorDirAndUp [_vectorDir, _vectorUp];
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

if (!alive _object) exitWith {
	// return
	[true, "Object successfully spawned; Object is dead.", _object];
};

if (!_resetFuel) then {
	_object setFuel _fuel;
};

if (_object isKindOf "AllVehicles" and typeOf _object isEqualTo _class) then {
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
	_currentValue = _object getVariable _variable;
	if !(isNil "_currentValue") then {
		continue;
	};

	_object setVariable [_variable, _defaultValue, true];
} forEach bax_persist_registeredObjectVariables;

{
	_x params ["_variable", "_value"];

	_object setVariable [_variable, _value, true];
} forEach _variables;

["Bax_Persist_ObjectLoaded", [_objectId, _object]] call CBA_fnc_localEvent; // server event since only ran on server

// return
[true, "Successfully spawned", _object];
