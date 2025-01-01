
if (!local _logic) exitWith {};

_logic = _this param [0, objnull, [objnull]];

[_logic] call bax_persist_fnc_dialogPersistentArea;
