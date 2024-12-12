
if !(isServer) exitWith {
	// return
	[false, "Call on server"];
};

params ["_id", "_player"];

_excludeSaving = _player getVariable ["bax_persist_excludePlayer", false];
if (_excludeSaving) exitWith {
	// return
	[false, "Player excluded from saving."];
};

if (_id isEqualType "") then {
	if (bax_persist_loadPlayerKeySide) then {
		_id = _id + "_" + (str side group _player);
	};
	if (bax_persist_loadPlayerKeyRole) then {
		_id = _id + "_" + (str roleDescription _player);
	};
};

_name = name _player;
_loadout = getUnitLoadout _player;
_traits = [
	_player getVariable ["ace_medical_medicClass", 0],
	_player getVariable ["ACE_isEngineer", 0]
];
// _posDir = [getPosATL _player, getDir _player];
_posDir = [getPosASL _player, getDir _player];
_medical = [_player] call ace_medical_fnc_serializeState;
if !(alive _player) then {
	_medical = "dead";
};

_variables = [];
{
	_x params ["_variable", "_defaultValue"];
	_value = _player getVariable _variable;
	if (isNil "_value" and isNil "_defaultValue") then {
		continue;
	};
	if (isNil "_value") exitWith {
		_value = _defaultValue;
	};
	_variables pushBack [_variable, _value];
} forEach bax_persist_registeredPlayerVariables;

bax_persist_databasePlayers set [
	_id,
	[
		_name,
		_loadout,
		_traits,
		_posDir,
		_medical,
		_variables,
		false // FirstJoin = false; used to indicate when a player has rejoined during the same session
	]
];

// return
[true, "Player successfully saved"];
