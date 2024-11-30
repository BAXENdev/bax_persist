
if !(isServer) exitWith {};

if !(bax_persist_isLoaded) exitWith {
	[
		{ bax_persist_isLoaded },
		{ _this call bax_persist_fnc_requestInventoryLoad; },
		_this
	] call cba_fnc_waitUntilAndExecute;
};

params ["_id", "_object"];

privateAll

_inventory = bax_persist_databaseInventories get _id;
if !(isNil "_inventory") exitWith {
	[_object, _inventory] call bax_persist_fnc_deserializeObjectInventory;
};
