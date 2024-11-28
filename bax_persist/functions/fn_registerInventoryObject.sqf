
if !(isServer) exitWith {};

params ["_id", "_object"];

_object setVariable ["bax_persist_inventoryId", _id, true];
bax_persist_registeredInventoryObjects pushBack _object;

_this call bax_persist_fnc_requestInventoryLoad;
