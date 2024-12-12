
{
	_inventoryId = _x;
	_inventoryObject = _y;

	if (!alive _inventoryObject) exitWith {};

	[_inventoryId, _inventoryObject] call bax_persist_fnc_saveInventory;
} forEach bax_persist_registeredInventoryObjects;
