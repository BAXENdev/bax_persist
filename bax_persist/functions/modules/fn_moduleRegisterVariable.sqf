
_logic = _this param [0,objnull,[objnull]];
_units = _this param [1,[],[[]]];
_activated = _this param [2,true,[true]];

if (_activated) then {
	private [
		"_variable1", "_defaultValue1",
		"_variable2", "_defaultValue2",
		"_variable3", "_defaultValue3",
		"_variable4", "_defaultValue4",
		"_variable5", "_defaultValue5",
		"_varArray"
	];

	_variable1 = _logic getVariable ["Variable1", ""];
	_defaultValue1 = call compile (_logic getVariable ["DefaultValue1", "nil"]);

	_variable2 = _logic getVariable ["Variable2", ""];
	_defaultValue2 = call compile (_logic getVariable ["DefaultValue2", "nil"]);

	_variable3 = _logic getVariable ["Variable3", ""];
	_defaultValue3 = call compile (_logic getVariable ["DefaultValue3", "nil"]);

	_variable4 = _logic getVariable ["Variable4", ""];
	_defaultValue4 = call compile (_logic getVariable ["DefaultValue4", "nil"]);

	_variable5 = _logic getVariable ["Variable5", ""];
	_defaultValue5 = call compile (_logic getVariable ["DefaultValue5", "nil"]);

	_varArray = switch (typeOf _logic) do {
		case ("Module_Bax_Persist_RegisterVariable"): { bax_persist_registeredNamespaceVariables };
		case ("Module_Bax_Persist_RegisterPlayerVariable"): { bax_persist_registeredPlayerVariables };
		case ("Module_Bax_Persist_RegisterObjectVariable"): { bax_persist_registeredObjectVariables };
	};

	if (_variable1 isNotEqualTo "") then {
		if (isNil "_defaultValue1") then {
			_varArray set [_variable1, nil];
		} else {
			_varArray set [_variable1, _defaultValue1];
		};
	};
	if (_variable2 isNotEqualTo "") then {
		if (isNil "_defaultValue2") then {
			_varArray set [_variable2, nil];
		} else {
			_varArray set [_variable2, _defaultValue2];
		};
	};
	if (_variable3 isNotEqualTo "") then {
		if (isNil "_defaultValue3") then {
			_varArray set [_variable3, nil];
		} else {
			_varArray set [_variable3, _defaultValue3];
		};
	};
	if (_variable4 isNotEqualTo "") then {
		if (isNil "_defaultValue4") then {
			_varArray set [_variable4, nil];
		} else {
			_varArray set [_variable4, _defaultValue4];
		};
	};
	if (_variable5 isNotEqualTo "") then {
		if (isNil "_defaultValue5") then {
			_varArray set [_variable5, nil];
		} else {
			_varArray set [_variable5, _defaultValue5];
		};
	};
};

true;
