
if !(isServer) exitWith {
	// return
	[false, "Must call on server"];
};

params ["_inventoryId", "_object"];

_inventory = [_object] call bax_persist_fnc_serializeInventory;
bax_persist_databaseInventories set [_inventoryId, _inventory];

["Bax_Persist_InventorySaved", [_inventoryId, _object]] call CBA_fnc_localEvent; // server event since only ran on server

// return
[true, "Succuessfully saved"];
