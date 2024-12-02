
if !(isServer) exitWith {
	// return
	false;
};

params ["_inventoryId", "_inventoryObject"];

bax_persist_registeredInventoryObjects set [_inventoryId, _inventoryObject];
