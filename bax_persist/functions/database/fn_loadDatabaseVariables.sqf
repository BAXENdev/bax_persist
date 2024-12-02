
if !(bax_persist_loadVariablesDatabase) exitWith {};

// Load newly registered variables
// Then load stored variables
// If a registered and stored variable both exist, the stored overwrites the default.

{
	_variable = _x;
	_defaultValue = _y;

	missionNamespace setVariable [_variable, _defaultValue, true];
} forEach bax_persist_registeredNamespaceVariables;

{
	_variable = _x;
	_value = _y;

	missionNamespace setVariable [_variable, _value, true];
} forEach bax_persist_databaseVariables;
