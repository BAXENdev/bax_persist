
if !(isServer) exitWith {
	// return
	[false, "Must call on server"];
};

params ["_object"];

_objectId = _object getVariable ["bax_persist_objectId", ""];

if (_objectId in bax_persist_registeredObjects) exitWith {
	[false, "Object is already registered"];
};

_objectName = getText (configFile >> "CfgVehicles" >> (typeOf _object) >> "displayName");

while { _objectId isEqualTo "" or _objectId in bax_persist_registeredObjects } do {
	_objectId = format [
		"%1_%2",
		_objectName,
		round random 1000000
	];
};

// [_objectId, _object] call bax_persist_fnc_loadObject;
[_objectId, _object] call bax_persist_fnc_registerObject;
