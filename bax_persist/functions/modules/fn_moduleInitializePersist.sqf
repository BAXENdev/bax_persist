
_logic = _this param [0, objnull, [objnull]];
_units = _this param [1, [], [[]]];
_activated = _this param [2, true, [true]];

if (_activated) then {
	bax_persist_savingEnabled = _logic getVariable ["Bax_Persist_EnableSaving", true];
	_autosaveTimer = _logic getVariable ["Bax_Persist_AutosaveTimer", 40];
	bax_persist_autosaveTimer = (_autosaveTimer min 120) max 15;
	bax_persist_autosaveEnabled = _logic getVariable ["Bax_Persist_EnableAutosave", true];

	bax_persist_loadPlayerDatabase = _logic getVariable ["Bax_Persist_LoadPlayerDatabase", true];
	bax_persist_resetPlayerLoadout = _logic getVariable ["Bax_Persist_ResetPlayerLoadout", true];
	bax_persist_resetPlayerPosition = _logic getVariable ["Bax_Persist_ResetPlayerPosition", true];
	bax_persist_resetPlayerMedical = _logic getVariable ["Bax_Persist_ResetPlayerMedical", true];
	bax_persist_loadPlayerKeySide = _logic getVariable ["Bax_Persist_LoadPlayerKeySide", true];
	bax_persist_loadPlayerKeyRole = _logic getVariable ["Bax_Persist_LoadPlayerKeyRole", true];

	bax_persist_loadObjectDatabase = _logic getVariable ["Bax_Persist_LoadObjectDatabase", true];
	// bax_persist_resetObjectPosition = _logic getVariable ["ResetObjectPosition", true];
	// bax_persist_resetObjectInventory = _logic getVariable ["ResetObjectInventory", true]; // Should I allow this as a global setting?
	bax_persist_resetObjectDamage = _logic getVariable ["Bax_Persist_ResetObjectDamage", true];
	bax_persist_resetObjectFuel = _logic getVariable ["Bax_Persist_ResetObjectFuel", true];
	bax_persist_resetObjectAmmo = _logic getVariable ["Bax_Persist_ResetObjectAmmo", true];
	bax_persist_cleanObjectDatabase = _logic getVariable ["Bax_Persist_RemoveDeadObjects", true];

	bax_persist_loadVariablesDatabase = _logic getVariable ["Bax_Persist_LoadVariablesDatabase", true];
};

true;
