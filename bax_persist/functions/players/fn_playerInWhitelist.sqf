
// returns [bool, new_teleport_pos]

#include "\bax_persist\include.hpp"

params ["_player"];

if (bax_persist_playerWhitelistAreas isEqualTo []) exitWith {
	// return
	[true, [0, 0, 0]];
};

_inWhitelist = false;
_closestWhitelist = objNull;
_closestDistance = 9999999;
{
	_whitelistLogic = _x;
	_center = getPosATL _whitelistLogic;
	_area = [_center] + (_whitelistLogic getVariable "objectArea");
	if (count ([_player] inAreaArray _area) > 0) exitWith { // break for loop
		_inWhitelist = true;
	};

	_distance = _player distance2D _whitelistLogic;
	if (_distance < _closestDistance) then {
		_closestWhitelist = _whitelistLogic;
	};
} forEach (bax_persist_playerWhitelistAreas select {
	(_x getVariable ["bax_persist_whitelistTeleports", []]) isNotEqualTo []
});

if (_inWhitelist) exitWith {
	// return
	[true, [0, 0, 0]];
};

_syncedTeleports = _closestWhitelist getVariable ["bax_persist_whitelistTeleports", []];
if (_syncedTeleports isEqualTo []) exitWith {
	// return
	[true, [0, 0, 0]];
};

_whitelistTeleport = selectRandom _syncedTeleports;
_posASL = getPosASL _whitelistTeleport;
_radius = _whitelistTeleport getVariable "Bax_Persist_Radius";
_finalPosASL = [
	(_posASL select 0) + ((random (_radius * 2)) - _radius),
	(_posASL select 1) + ((random (_radius * 2)) - _radius),
	_posASL select 2
];

// return
[false, _finalPosASL];
