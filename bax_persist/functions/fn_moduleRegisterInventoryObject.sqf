
_logic = _this param [0,objnull,[objnull]];
_units = _this param [1,[],[[]]];
_activated = _this param [2,true,[true]];

if (_activated) then {
	_inventoryId = _logic getVariable ["InventoryId", ""];
	if (_inventoryId isEqualTo "") exitWith {};
	_resetInventory = _logic getVariable ["ResetInventory", false];

	_syncedObjects = synchronizedObjects _logic;
	if (_syncedObjects isEqualTo []) exitWith {};
	_object = _syncedObjects select 0;

	_inventory = bax_persist_databaseinventory get _inventory;
	if (!_resetInventory and !isNil "_inventory") then {
		[_object, _inventory] call bax_persist_fnc_deserializeObjectInventory;
	};
	_object setVariable ["bax_persist_inventoryId", _inventoryId];
	bax_persist_registeredInventoryObjects pushBack _object;
};

true;
