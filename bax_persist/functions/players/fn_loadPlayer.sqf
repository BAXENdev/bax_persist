

if !(isServer) exitWith {
	// return
	[false, "Call on server"];
};

if !(bax_persist_loadPlayerDatabase) exitWith {
	false;
};

params [
	"_id",
	"_player",
	["_resetLoadout", false],
	["_resetPosition", false],
	["_resetMedical", false]
];

_excludeLoading = _player getVariable ["bax_persist_excludePlayer", false];
if (_excludeLoading) exitWith {
	// return
	[false, "Player object is excluded from loading"];
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

_playerRecord params ["_name", "_loadout", "_traits", "_posDir", "_medical", "_variables", "_firstJoin"];

_resetLoadout = (_resetLoadout or bax_persist_resetPlayerPosition) and _firstJoin;
_resetPosition = (_resetPosition or bax_persist_resetPlayerPosition) and _firstJoin;
_resetMedical = (_resetMedical or bax_persist_resetPlayerMedical) and _firstJoin;

_player setUnitLoadout _loadout;

_traits params ["_medicalTrait", "_engineerTrait"];
_player setVariable ["ace_medical_medicClass", _medicalTrait, true];
_player setUnitTrait ["Medic", _medicalTrait > 0];
_player setVariable ["ACE_isEngineer", _engineerTrait, true];
_player setUnitTrait ["Engineer", _engineerTrait > 0];

if (!_resetPosition) then {
	_posDir params ["_position", "_direction"];

	_whitelistCheck = [_player] call bax_persist_fnc_playerInWhiteliste;
	_whitelistCheck params ["_inWhitelist", "_newPosition"];
	if (!_inWhitelist) then {
		_position = _newPosition;
	};
	_player setPosASL _position;
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

// if (!_resetMedical) then {
// 	if (_medical isEqualTo "dead") exitWith { _player setDamage 1; };
// 	[_player, _medical] call ace_medical_fnc_deserializeState;
// };

// set firstJoin to false to disable resetting
_playerRecord set [(count _playerRecord - 1), false];

// return
[true, "Successfully loaded"];
