
params ["_player", ["_excludeLoading", false], ["_excludeSaving", false]];

if (_excludeLoading) then {
	_player setVariable ["bax_persist_excludeLoading", true, true];
};
if (_excludeSaving) then {
	_player setVariable ["bax_persist_excludeSaving", true, true];
};
