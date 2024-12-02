
{
	_inventoryId = _x;
	_inventoryObject = _y;

	_inventory = [_object] call bax_persist_fnc_deserializeInventory;
	bax_persist_databaseInventories set [_inventoryId, _inventory];
} forEach bax_persist_registeredInventoryObjects;
