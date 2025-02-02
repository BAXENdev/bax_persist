
if !(isServer) exitWith {
	// return
	[false, "Must call on server"];
};

params ["_id", "_object"];

["Bax_Persist_InventoryLoading", [_inventoryId, _object]] call CBA_fnc_localEvent; // server event since only ran on server

_inventory = bax_persist_databaseInventories get _id;
if (isNil "_inventory") exitWith {
	// return
	[false, "No record exists in the database"];
};

[_object, _inventory] call bax_persist_fnc_deserializeInventory;

["Bax_Persist_InventoryLoaded", [_inventoryId, _object]] call CBA_fnc_localEvent; // server event since only ran on server

// return
[true, "Successfully loaded"];
