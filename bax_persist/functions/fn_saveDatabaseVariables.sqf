
private ["_variable", "_defaultValue"];

_databaseVariables = [];

{
	_variable = _x;
	_defaultValue = _y;
	_value = missionNamespace getVariable _variable;
	if (isNil "_value" and isNil "_defaultValue") then {
		bax_persist_databaseVariables set [_variable, nil];
	} else {
		if (isNil "_value") then {
			_value = _defaultValue;
		};
		bax_persist_databaseVariables set [_variable, _value];
	};
} forEach bax_persist_registeredNamespaceVariables;
