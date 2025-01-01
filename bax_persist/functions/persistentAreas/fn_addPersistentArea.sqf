
if (!isServer) exitWith {};

params ["_object", "_radius", ["_vehicles", false], ["_ammoBoxes", false], ["_weaponHolders", false], ["_statics", false]]; // TODO: Do I allow things?

if (isNil "_object" or { isNull _object }) exitWith {};

_persistentTypes = [];

if (_vehicles) then {
	_persistentTypes append ["LandVehicle", "Air", "Ship"];
};

if (_ammoBoxes) then {
	_persistentTypes append ["ReammoBox_F"];
};

if (_weaponHolders) then {
	_persistentTypes append ["WeaponHolder", "WeaponHolderSimulated"];
};

if (_statics) then {
	_persistentTypes append ["Static", "ThingX"]; // TODO: ThingX might cover too much?
};

// thingX

if (_types isEqualTo []) exitWith {};

_object setVariable ["bax_persist_persistentAreaRadius", _radius];
_object setVariable ["bax_persist_persistentAreaTypes", _persistentTypes];

bax_persist_persistentAreas pushBack _object;

// AllVehicles ReammoBox_F WeaponHolderXX Static ThingX