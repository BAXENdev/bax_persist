

#include "\bax_persist\include.hpp"

_logic = _this param [0,objnull,[objnull]];
_units = _this param [1,[],[[]]];
_activated = _this param [2,true,[true]];

if (_activated) then {
	#ifdef DEBUG
	DLOG("Running Persist Area Module");
	#endif

	_syncedObjects = synchronizedObjects _logic;
	if (_syncedObjects isNotEqualTo []) then {
		_object = _syncedObjects select 0;
		_logic attachTo _object;
	};

	_radius = _logic getVariable ["Bax_Persist_Radius", false];
	_saveVehicles = _logic getVariable ["Bax_Persist_Vehicles", false];
	_saveReammoBoxes = _logic getVariable ["Bax_Persist_ReammoBox", false];
	_saveWeaponHolders = _logic getVariable ["Bax_Persist_WeaponHolders", false];
	_saveStatics = _logic getVariable ["Bax_Persist_Statics", false];

	if !(_saveVehicles or _saveReammoBoxes or _saveWeaponHolders or _saveStatics) exitWith {
		deleteVehicle _logic;
	};

	[_logic, _radius, _saveVehicles, _saveReammoBoxes, _saveReammoBoxes, _saveWeaponHolders, _saveStatics] call bax_persist_fnc_addPersistentArea;
};

true;

