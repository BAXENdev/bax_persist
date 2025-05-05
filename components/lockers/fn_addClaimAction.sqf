
_this spawn {
	waitUntil { bax_persist_databaseLoaded };

	params ["_locker"];

	_locker addAction [
		"Claim Locker",
		{
			params ["_locker", "_player", "_actionId", "_args"];

			[_locker, _actionId] remoteExec ["removeAction", 0, true];

			// clearMagazineCargoGlobal _locker;
			// clearItemCargoGlobal _locker;
			// clearBackpackCargoGlobal _locker;
			// clearWeaponCargoGlobal _locker;

			_lockerId = format ["Locker ID: %1", getPlayerUID _player];
			[_lockerId, _locker] remoteExec ["bax_persist_fnc_loadInventory", 2];
			[_lockerId, _locker] remoteExec ["bax_persist_fnc_registerInventory", 2];

			[
				_locker,
				[
					format ["<t size=""2.0"">%1's Locker</t>", name _player],
					{},
					[],
					6
				]
			] remoteExec ["addAction", 0, true];
		}
	]
}
