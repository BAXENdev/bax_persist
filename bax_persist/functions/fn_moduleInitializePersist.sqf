
_logic = _this param [0,objnull,[objnull]];
_units = _this param [1,[],[[]]];
_activated = _this param [2,true,[true]];

if (_activated) then {
	bax_persist_loadPlayerDatabase = _logic getVariable ["EnablePlayerDB", false];
	bax_persist_loadPlayerVariables = _logic getVariable ["EnablePlayerVars", false];
	bax_persist_loadPlayerMedical = _logic getVariable ["EnablePlayerMedical", false];
	bax_persist_loadObjectDatabase = _logic getVariable ["EnableObjectDB", false];
	bax_persist_loadObjectVariables = _logic getVariable ["EnableObjectVars", false];
	bax_persist_loadVariableDatabase = _logic getVariable ["EnableVariableDB", false];
	// bax_persist_loadInventoriesDatabase = _logic getVariable ["EnableInventoriesDB", false];
};

true;
