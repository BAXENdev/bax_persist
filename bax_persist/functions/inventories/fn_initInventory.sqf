
params ["_object"];

if (_object isEqualType "Man") exitWith {};

inventoryId = _object getVariable ["bax_persist_inventoryId", ""];
if (inventoryId isEqualTo "") exitWith {};
[inventoryId, _object] call bax_persist_fnc_loadInventory;
[inventoryId, _object] call bax_persist_fnc_registerInventory;
