
#include "\bax_persist\include.hpp"

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
	_defaultValue1 = call compile (_logic getVariable ["DefaultValue1", ""]);

	_variable2 = _logic getVariable ["Variable2", ""];
	_defaultValue2 = call compile (_logic getVariable ["DefaultValue2", ""]);

	_variable3 = _logic getVariable ["Variable3", ""];
	_defaultValue3 = call compile (_logic getVariable ["DefaultValue3", ""]);

	_variable4 = _logic getVariable ["Variable4", ""];
	_defaultValue4 = call compile (_logic getVariable ["DefaultValue4", ""]);

	_variable5 = _logic getVariable ["Variable5", ""];
	_defaultValue5 = call compile (_logic getVariable ["DefaultValue5", ""]);

	_varArray = switch (typeOf _logic) do {
		case ("Module_Bax_Persist_RegisterVariables"): { bax_persist_registeredNamespaceVariables };
		case ("Module_Bax_Persist_RegisterPlayerVariables"): { bax_persist_registeredPlayerVariables };
		case ("Module_Bax_Persist_RegisterObjectVariables"): { bax_persist_registeredObjectVariables };
	};

	if (_variable1 isNotEqualTo "") then {
		if (isNil "_defaultValue1") then {
			_varArray set [_variable1, nil];
		} else {
			_varArray set [_variable1, _defaultValue1];
		};
		#ifdef DEBUG
		DLOG2("Registering variable: %1 = %2", _variable1, _defaultValue1);
		#endif
	};
	if (_variable2 isNotEqualTo "") then {
		if (isNil "_defaultValue2") then {
			_varArray set [_variable2, nil];
		} else {
			_varArray set [_variable2, _defaultValue2];
		};
		#ifdef DEBUG
		DLOG2("Registering variable: %1 = %2", _variable2, _defaultValue2);
		#endif
	};
	if (_variable3 isNotEqualTo "") then {
		if (isNil "_defaultValue3") then {
			_varArray set [_variable3, nil];
		} else {
			_varArray set [_variable3, _defaultValue3];
		};
		#ifdef DEBUG
		DLOG2("Registering variable: %1 = %2", _variable3, _defaultValue3);
		#endif
	};
	if (_variable4 isNotEqualTo "") then {
		if (isNil "_defaultValue4") then {
			_varArray set [_variable4, nil];
		} else {
			_varArray set [_variable4, _defaultValue4];
		};
		#ifdef DEBUG
		DLOG2("Registering variable: %1 = %2", _variable4, _defaultValue4);
		#endif
	};
	if (_variable5 isNotEqualTo "") then {
		if (isNil "_defaultValue5") then {
			_varArray set [_variable5, nil];
		} else {
			_varArray set [_variable5, _defaultValue5];
		};
		#ifdef DEBUG
		DLOG2("Registering variable: %1 = %2", _variable5, _defaultValue5);
		#endif
	};
};

#ifdef DEBUG
#else
deleteVehicle _logic;
#endif
true;
