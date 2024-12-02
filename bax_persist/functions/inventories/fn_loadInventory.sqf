
if !(isServer) exitWith {
	// return
	false
};

params ["_id", "_object"];

_inventory = bax_persist_databaseInventories get _id;
if (isNil "_inventory") exitWith {
	// return
	false;
};

[_object, _inventory] call bax_persist_fnc_deserializeInventory;
// return
true;
