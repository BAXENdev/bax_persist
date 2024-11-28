
_logic = _this param [0,objnull,[objnull]];
_units = _this param [1,[],[[]]];
_activated = _this param [2,true,[true]];

if (_activated) then {
	private ["_var1", "_var2", "_var3", "_var4", "_var5", "_varArray"];

	_var1 = _logic getVariable ["Var1", ""];
	_var2 = _logic getVariable ["Var2", ""];
	_var3 = _logic getVariable ["Var3", ""];
	_var4 = _logic getVariable ["Var4", ""];
	_var5 = _logic getVariable ["Var5", ""];

	_varArray = switch (typeOf _logic) do {
		case ("Module_Bax_Persist_RegisterVariable"): { bax_persist_registeredNamespaceVariables };
		case ("Module_Bax_Persist_RegisterPlayerVariable"): { bax_persist_registeredPlayerVariables };
		case ("Module_Bax_Persist_RegisterObjectVariable"): { bax_persist_registeredObjectVariables };
	};

	if (_var1 isNotEqualTo "") do { _varArray pushBack _var1 };
	if (_var2 isNotEqualTo "") do { _varArray pushBack _var2 };
	if (_var3 isNotEqualTo "") do { _varArray pushBack _var3 };
	if (_var4 isNotEqualTo "") do { _varArray pushBack _var4 };
	if (_var5 isNotEqualTo "") do { _varArray pushBack _var5 };
};

true;
