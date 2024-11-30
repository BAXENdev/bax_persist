
if !(isServer) exitWith {};

if !(bax_persist_isLoaded) exitWith {
	[
		{ bax_persist_isLoaded },
		{ _this call bax_persist_fnc_requestInventorySave; },
		_this
	] call cba_fnc_waitUntilAndExecute;
};

params ["_id", "_object"];

_inventory = [_object] call bax_persist_fnc_deserializeObjectInventory;
bax_persist_databaseInventories set [_id, _inventory];
