
if !(isServer) exitWith {};

if !(bax_persist_isLoaded) exitWith {
	[
		{ bax_persist_isLoaded },
		{ _this call bax_persist_fnc_requestInventoryLoad; },
		_this
	] call cba_fnc_waitUntilAndExecute;
};

params ["_id", "_object"];

private ["_inventory"];

_inventory = bax_persist_databaseInventories getOrDefault [_id, [[], [], [], [], []]];
[_object, _inventory] call bax_persist_fnc_deserializeObjectInventory;
