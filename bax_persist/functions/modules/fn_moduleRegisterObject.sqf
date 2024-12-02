
_logic = _this param [0,objnull,[objnull]];
_units = _this param [1,[],[[]]];
_activated = _this param [2,true,[true]];

if (_activated) then {
	_objectId = _logic getVariable ["ObjectID", ""];
	_resetPosition = _logic getVariable ["ResetPosition", false];
	_resetInventory = _logic getVariable ["ResetInventory", false];
	_resetDamage = _logic getVariable ["ResetDamage", false];
	_resetFuel = _logic getVariable ["ResetFuel", false];
	_resetAmmo = _logic getVariable ["ResetAmmo", false];

	_objects = synchronizedObjects _logic;
	if (_objects isEqualTo []) exitWith {};

	_object = _objects select 0;
	[_objectId, _object, _resetPosition, _resetInventory, _resetDamage, _resetFuel, _resetAmmo] call bax_persist_fnc_loadObject; 
	[_objectId, _object] call bax_persist_fnc_registerObject;
};

true;
