
#include "\bax_persist\include.hpp"

#ifdef DEBUG2
DLOG(str _this);
#endif

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

#ifdef DEBUG
DLOG1("Loading player: %1", name _player);
#endif

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
	[false, "No player record"];
};

["Bax_Persist_LoadingPlayer", [_player]] call CBA_fnc_localEvent; // server event since only called on server

_playerRecord params ["_name", "_loadout", "_traits", "_posDir", "_medical", "_variables", "_firstJoin"];

// If it is not their first time joining this session, do not reset. Allows mid match rejoins to keep their data.
_resetLoadout = (_resetLoadout or bax_persist_resetPlayerLoadout) and _firstJoin;
_resetPosition = (_resetPosition or bax_persist_resetPlayerPosition) and _firstJoin;
_resetMedical = (_resetMedical or bax_persist_resetPlayerMedical) and _firstJoin;

if (!_resetLoadout) then {
	// _player setUnitLoadout _loadout; // vanilla
	[_player, _loadout] call CBA_fnc_setLoadout; // cba
	#ifdef DEBUG2
	DLOG1("Setting loadout: %1", name _player);
	#endif
};

_traits params ["_medicalTrait", "_engineerTrait"];
_player setVariable ["ace_medical_medicClass", _medicalTrait, true];
_player setUnitTrait ["Medic", _medicalTrait > 0];
_player setVariable ["ACE_isEngineer", _engineerTrait, true];
_player setUnitTrait ["Engineer", _engineerTrait > 0];

if (!_resetPosition) then {
	_posDir params ["_position", "_direction"];

	if (_firstJoin) then {
		_whitelistCheck = [_player] call bax_persist_fnc_playerInWhitelist;
		_whitelistCheck params ["_inWhitelist", "_newPosition"];
		if (!_inWhitelist) then {
			
			#ifdef DEBUG
			DLOG1("Outside whitelist. Updating position: %1", _newPosition);
			#endif
			_position = _newPosition;
			_direction = getDir _player;
		};
	};

	_player setPosASL _position;
	_player setDir _direction;
};

{
	_variable = _x;
	_defaultValue = _y;
	_currentValue = _player getVariable _variable;
	if !(isNil "_currentValue") then {
		continue;
	};

	_player setVariable [_variable, _defaultValue, true];
} forEach bax_persist_registeredPlayerVariables;

{
	_x params ["_variable", "_value"];

	_player setVariable [_variable, _value, true];
} forEach _variables;

if (_medical isEqualTo "dead") then {
	_player setDamage 1;
} else {
	if (!bax_persist_resetPlayerMedical) then {
		[_player, _medical] call ace_medical_fnc_deserializeState;
	};
};

// OLD SYSTEM. Above is better
// if (!_resetMedical) then {
// 	if (_medical isEqualTo "dead") exitWith { _player setDamage 1; };
// 	[_player, _medical] call ace_medical_fnc_deserializeState;
// };

// set firstJoin to false to disable resetting
_playerRecord set [(count _playerRecord - 1), false];

["Bax_Persist_PlayerLoaded", [_id, _player]] call CBA_fnc_localEvent; // server event since only ran on server

// return
[true, "Successfully loaded"];
