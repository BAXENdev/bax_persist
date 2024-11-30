
if !(bax_persist_loadPlayerDatabase) exitWith {};

if !(canSuspend) exitWith { _this spawn bax_persist_fnc_requestPlayerLoad; };

params ["_player"];

waitUntil { isPlayer _player };

_id = getPlayerUID _player;

if (bax_persist_loadPlayerKeySide) then {
	_id = _id + "_" + (str side group _player);
};
if (bax_persist_loadPlayerKeyRole) then {
	_id = _id + "_" + (str roleDescription _player);
};

_playerRecord = bax_persist_databasePlayers get _id;
if (isNil "_playerRecord") then exitWith {};

_playerRecord params ["_loadout", "_traits", "_posDir", "_medical", "_variables"];

_player setUnitLoadout _loadout;

_traits params ["_medicalTrait", "_engineerTrait"];
_player setVariable ["ace_medical_medicClass", _medicalTrait, true];
_player setUnitTrait ["Medic", _medicalTrait > 0];
_player setVariable ["ACE_isEngineer", _engineerTrait, true];
_player setUnitTrait ["Engineer", _engineerTrait > 0];

if (bax_persist_loadPlayerPosition) then {
	_posDir params ["_position", "_direction"];
	_player setPos _position;
	_player setDir _direction;
};

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
