
_logic = _this param [0,objnull,[objnull]];
_units = _this param [1,[],[[]]];
_activated = _this param [2,true,[true]];

if (_activated) then {
	bax_persist_savingEnabled = _logic getVariable ["EnableSaving", true];
	_autosaveTimer = _logic getVariable ["AutosaveTimer", 40];
	bax_persist_autosaveTimer = (_autosaveTimer min 120) max 15;
	bax_persist_autosaveEnabled = _logic getVariable ["EnableAutosave", true];

	bax_persist_loadPlayerDatabase = _logic getVariable ["EnablePlayerDB", true];
	bax_persist_loadPlayerPosition = _logic getVariable ["EnablePlayerPosition", true];
	bax_persist_loadPlayerMedical = _logic getVariable ["EnablePlayerMedical", true];
	bax_persist_loadPlayerKeySide = _logic getVariable ["EnablePlayerKeySide", true];
	bax_persist_loadPlayerKeyRole = _logic getVariable ["EnablePlayerKeyRole", true];

	bax_persist_loadObjectDatabase = _logic getVariable ["EnableObjectDB", true];
	bax_persist_loadObjectDamage = _logic getVariable ["EnableObjectDamage", true];
	bax_persist_loadObjectFuel = _logic getVariable ["EnableObjectFuel", true];
	bax_persist_loadObjectAmmo = _logic getVariable ["EnableObjectAmmo", true];

	bax_persist_loadVariablesDatabase = _logic getVariable ["EnableVariablesDB", true];
};

true;
