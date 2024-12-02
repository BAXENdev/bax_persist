
[
	{
		[] call bax_persist_fnc_saveDatabase;
		[] call bax_persist_fnc_queueSaveDatabase;
	},
	[],
	round (bax_persist_autosaveTimer * 60)
] call CBA_fnc_waitAndExecute;
