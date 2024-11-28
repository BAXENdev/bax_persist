
private ["_object", "_id", "_inventory"];

{
	_object = _x;
	_id = _object getVariable "bax_persist_inventoryId";
	if (!alive _object or isNil "_id") then { continue };
	_inventory = [_object] call bax_persist_fnc_serializeObjectInventory;
	bax_persist_databaseInventories set [_id, _inventory];
} forEach bax_persist_registeredInventoryObjects;

+bax_persist_databaseInventories;
