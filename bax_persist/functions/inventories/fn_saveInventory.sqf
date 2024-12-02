
if !(isServer) exitWith {
	// return
	false;
};

params ["_id", "_object"];

_inventory = [_object] call bax_persist_fnc_serializeInventory;
bax_persist_databaseInventories set [_id, _inventory];

// return
true;
