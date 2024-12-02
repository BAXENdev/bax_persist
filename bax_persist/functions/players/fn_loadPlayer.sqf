

if !(isServer) exitWith {
	// return
	false
};

if !(bax_persist_loadPlayerDatabase) exitWith {
	false;
};

params ["_id", "_player"];

_excludeLoading = _player getVariable ["bax_persist_excludeLoading", false];
if (_excludeLoading) exitWith {
	// return
	false;
};

if (_id isEqualType "") then {
	if (bax_persist_loadPlayerKeySide) then {
		_id = _id + "_" + (str side group _player);
	};
	if (bax_persist_loadPlayerKeyRole) then {
		_id = _id + "_" + (str roleDescription _player);
	};
};

_playerRecord = bax_persist_databasePlayers get _id;
if (isNil "_playerRecord") exitWith {
	// return
	false;
};

_playerRecord params ["_name", "_loadout", "_traits", "_posDir", "_medical", "_variables"];

_player setUnitLoadout _loadout;

_traits params ["_medicalTrait", "_engineerTrait"];
_player setVariable ["ace_medical_medicClass", _medicalTrait, true];
_player setUnitTrait ["Medic", _medicalTrait > 0];
_player setVariable ["ACE_isEngineer", _engineerTrait, true];
_player setUnitTrait ["Engineer", _engineerTrait > 0];

if (bax_persist_loadPlayerPosition) then {
	_posDir params ["_position", "_direction"];
	_player setPosATL _position;
	_player setDir _direction;
};

{
	_variable = _x;
	_defaultValue = _y;

	_player setVariable [_variable, _defaultValue, true];
} forEach bax_persist_registeredPlayerVariables;

{
	_x params ["_variable", "_value"];

	_player setVariable [_variable, _value, true];
} forEach _variables;

if (_medical isEqualTo "dead") then {
	_player setDamage 1;
} else {
	if (bax_persist_loadPlayerMedical) then {
		[_player, _medical] call ace_medical_fnc_deserializeState;
	};
};

// return
true;