
params ["_object"];

if (_object isEqualType "Man") exitWith {};

_objectId = _object getVariable ["bax_persist_objectId", ""];
if (_objectId isEqualTo "") exitWith {};
[_objectId, _object] call bax_persist_fnc_loadObject;
[_objectId, _object] call bax_persist_fnc_registerObject;
