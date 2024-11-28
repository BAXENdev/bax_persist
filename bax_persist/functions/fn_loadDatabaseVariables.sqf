
params ["_databaseVariables"];

private ["_variable", "_value"];

{
	_x params ["_variable", "_value"];
	missionNamespace setVariable [_variable, _value, true];
} forEach _databaseVariables;
