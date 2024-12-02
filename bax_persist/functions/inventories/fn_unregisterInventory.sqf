
params ["_inventoryId", ["_doSave", false]];

_inventoryObject = bax_persist_databaseInventories get _inventoryId;

if (_isNil "_inventoryObject") exitWith {
	// return
	false;
};

if (_doSave) then {
	[_inventoryId, _inventoryObject] call bax_persist_fnc_saveInventory;
};

bax_persist_databaseInventories deleteAt _inventoryId;

// return
true;
