
if !(bax_persist_loadPlayerDatabase) exitWith {};

if !(canSuspend) exitWith { _this spawn bax_persist_fnc_requestPlayerLoad; };

params ["_player"];

waitUntil { isPlayer _player };

_id = getPlayerUID _player;
_playerRecord = bax_persist_databasePlayers getOrDefault [_id, false];

if (_playerRecord isEqualType false) exitWith {};

_playerRecord params ["_sideRole", "_loadout", "_traits", "_posDir", "_medical", "_variables"];

// TODO: Side role keying
_player setUnitLoadout _loadout;
_traits params ["_medicalTrait", "_engineerTrait"];
_unit setVariable ["ace_medical_medicClass", _medicalTrait, true];
_unit setUnitTrait ["Medic", _medicalTrait > 0];
_unit setVariable ["ACE_isEngineer", _engineerTrait, true];
_unit setUnitTrait ["Engineer", _engineerTrait > 0];
_posDir params ["_position", "_direction"];
_player setPos _position;
_player setDir _direction;
if (bax_persist_loadPlayerMedical) then {
	[_player, _medical] call ace_medical_fnc_deserializeState;
};
if (bax_persist_loadPlayerVariables) then {
	{
		_x params ["_variable", "_value"];
		_player setVariable [_variable, _value, true];
	} forEach _variables;
};
