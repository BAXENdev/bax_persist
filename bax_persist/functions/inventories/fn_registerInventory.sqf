
if !(isServer) exitWith {
	// return
	[false, "Must call on server"];
};

params ["_inventoryId", "_inventoryObject"];


_object = bax_persist_registeredInventoryObjects get _inventoryId;
if (!isNil "_object") exitWith {
	// return
	[false, "Object is already registered"];
};

bax_persist_registeredInventoryObjects set [_inventoryId, _inventoryObject];
_inventoryObject setVariable ["bax_persist_inventoryId", _inventoryId, true];

// return
[true, "Successfully registered"];
