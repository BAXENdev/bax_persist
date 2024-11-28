
_logic = _this param [0,objnull,[objnull]];
_units = _this param [1,[],[[]]];
_activated = _this param [2,true,[true]];

if (_activated) then {
	_objects = synchronizedObjects _logic;
	bax_persist_registeredObjects append _objects;
};

true;
