
private ["_variable", "_defaultValue"];

_databaseVariables = [];

{
	_x params ["_variable", "_defaultValue"];
	_value = missionNamespace getVariable [_variable, _defaultValue];
	if (isNil "_value") then { continue; };
	if !(_value isEqualTypeAny [[], 0, "", false, {}]) then { continue; };
	_databaseVariables pushBack [_variable, _value];
} forEach bax_persist_registeredNamespaceVariables;

// return
_databaseVariables;
