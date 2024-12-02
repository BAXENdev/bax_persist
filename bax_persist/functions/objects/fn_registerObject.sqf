
if !(isServer) exitWith {
	// return
	false
};

params ["_id", "_object"];

if (_id isEqualTo "") exitWith {
	// return
	false;
};

bax_persist_registeredObjects set [_id, _object];

// return
true;
