
_logic = _this param [0,objnull,[objnull]];
_units = _this param [1,[],[[]]];
_activated = _this param [2,true,[true]];

if (_activated) then {
	bax_persist_playerWhitelistAreas pushBack _logic;
	_syncedTeleports = (synchronizedObjects _logic) select { _x isKindOf "Module_Bax_Persist_SpawnAreaTeleport" };
	_logic setVariable ["bax_persist_whitelistTeleports", _syncedTeleports, true];
};

// #ifdef DEBUG
// #else
// deleteVehicle _logic;
// #endif
true;
