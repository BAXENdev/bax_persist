
params ["_inventoryId"];

_element = bax_persist_databaseInventories deleteAt _inventoryId;
if (isNil "_element") then {
	// return
	[false, "Inventory did not exist", _element];
} else {
	// return
	[true, "Inventory deleted", element];
};
