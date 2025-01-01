
_logic = _this param [0,objnull,[objnull]];
_units = _this param [1,[],[[]]];
_activated = _this param [2,true,[true]];

if (_activated) then {
	_radius = _logic getVariable ["Bax_Persist_Radius", 5];
	_radius = (_radius max 5) min 100;
	_logic setVariable ["Bax_Persist_Radius", _radius, true];
};

// #ifdef DEBUG
// #else
// deleteVehicle _logic;
// #endif
true;
