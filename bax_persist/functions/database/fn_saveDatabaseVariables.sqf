
private ["_variable", "_defaultValue"];

_databaseVariables = [];

{
	_variable = _x;
	_value = missionNamespace getVariable _variable;
	if (isNil "_value") then {
		if (_variable in bax_persist_databaseVariables) then {
			bax_persist_databaseVariables deleteAt _variable;
		};
		continue;
	};
	bax_persist_databaseVariables set [_variable, _value];
} forEach bax_persist_registeredNamespaceVariables;
