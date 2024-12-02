
_logic = _this param [0,objnull,[objnull]];
_units = _this param [1,[],[[]]];
_activated = _this param [2,true,[true]];

if (_activated) then {
	_inventoryId = _logic getVariable ["InventoryID", ""];
	_resetInventory = _logic getVariable ["ResetInventory", false];

	if (_inventoryId isEqualTo "") exitWith {};
	
	_objects = synchronizedObjects _logic;
	if (_objects isEqualTo []) exitWith {};

	_object = _objects select 0;
	[_inventoryId, _object] call bax_persist_fnc_registerInventory;

	if (_resetInventory) exitWith {};
	[_inventoryId, _object] call bax_persist_fnc_loadInventory;
};

true;
