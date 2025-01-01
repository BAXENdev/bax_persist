
_logic = _this param [0,objnull,[objnull]];
_units = _this param [1,[],[[]]];
_activated = _this param [2,true,[true]];

if (_activated) then {
	[] remoteExec ["bax_persist_fnc_saveDatabase", 2];
};

#ifdef DEBUG
#else
deleteVehicle _logic;
#endif
true;
