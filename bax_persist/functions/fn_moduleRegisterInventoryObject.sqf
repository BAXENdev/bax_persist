
_logic = _this param [0,objnull,[objnull]];
_units = _this param [1,[],[[]]];
_activated = _this param [2,true,[true]];

if (_activated) then {
	private ["_objects", "_id", "_loadOnly"];
	
	_objects = synchronizedObjects _logic;
	_id = _logic getVariable ["InventoryID", ""];
	_loadOnly = _logic getVariable ["LoadOnly", false];

	if (_id isEqualTo "") exitWith {};
	if (_loadOnly) then {
		{
			[_id, _x] call bax_persist_fnc_requestInventoryLoad;
		} forEach _objects;
	} else { // register object
		{
			[_id, _x] call bax_persist_fnc_registerInventoryObject;
		} forEach _objects;
	};
};

true;
