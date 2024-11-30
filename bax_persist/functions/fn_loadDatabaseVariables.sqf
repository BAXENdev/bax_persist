
if !(bax_persist_loadVariablesDatabase) exitWith {};

params ["_databaseVariables"];

private ["_variable", "_value"];

{
	_variable = _x;
	_value = _y;
	if (isNil "_value") then {
		missionNamespace setVariable [_variable, nil];
	} else {
		missionNamespace setVariable [_variable, _value];
	};
} forEach _databaseVariables;
