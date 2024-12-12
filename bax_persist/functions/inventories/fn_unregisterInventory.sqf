
params ["_inventoryId", ["_doSave", true]];

_inventoryObject = bax_persist_registeredInventoryObjects get _inventoryId;

if (isNil "_inventoryObject") exitWith {
	// return
	[false, "object is null"];
};

if (_doSave) then {
	[_inventoryId, _inventoryObject] call bax_persist_fnc_saveInventory;
};

_inventoryObject setVariable ["bax_persist_inventoryId", nil, true];

bax_persist_databaseInventories deleteAt _inventoryId;

// return
[true, "Successfully unregistered"];
