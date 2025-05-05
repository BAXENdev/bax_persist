
#include "\bax_persist\include.hpp"

#ifdef DEBUG2
DLOG(str _this);
#endif

if !(isServer) exitWith {
	// return
	[false, "Must call on server"];
};

params ["_objectId", "_object"];

if (_objectId isEqualTo "") exitWith {};

if (_objectId in bax_persist_registeredObjects) exitWith {
	// return
	[false, "Object is already registered"];
};

bax_persist_registeredObjects set [_objectId, _object];
_object setVariable ["bax_persist_objectId", _objectId, true];

// return
[true, "Object successfully registered"];
