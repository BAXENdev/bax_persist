
if !(isServer) exitWith {
	// return
	[false, "Must call on server"];
};

params ["_objectId", "_object"];

if (_objectId isEqualTo "") exitWith {};

_object = bax_persist_registeredObjects get _objectId;
if (!isNil "_object") exitWith {
	// return
	[false, "Object is already registered"];
};

bax_persist_registeredObjects set [_objectId, _object];
_object setVariable ["bax_persist_objectId", _objectId, true];

// return
[true, "Object successfully registered"];
