
params ["_inventoryId", ["_doSave", true], ["_clearInventory", true]];

if (!_inventoryId in bax_persist_registeredInventoryObjects) exitWith {
	// return
	[false, "No object registered"];
};

_inventoryObject = bax_persist_registeredInventoryObjects get _inventoryId;
_inventoryObject setVariable ["bax_persist_inventoryId", nil, true];

if (_doSave) then {
	[_inventoryId, _inventoryObject] call bax_persist_fnc_saveInventory;
};

if (_clearInventory) then {
	clearItemCargoGlobal _inventoryObject;
	clearMagazineCargoGlobal _inventoryObject;
	clearWeaponCargoGlobal _inventoryObject;
	clearBackpackCargoGlobal _inventoryObject;
};

bax_persist_databaseInventories deleteAt _inventoryId;

// return
[true, "Successfully unregistered"];
