
#include "\bax_persist\include.hpp"

_logic = _this param [0,objnull,[objnull]];
_units = _this param [1,[],[[]]];
_activated = _this param [2,true,[true]];

if (_activated) then {
	#ifdef DEBUG
	DLOG("Running Init Persist Module");
	#endif

	_syncedObjects = synchronizedObjects _logic;
	if (_syncedObjects isEqualTo []) exitWith {
		#ifdef DEBUG
		DLOG("Exiting due to no synced objects");
		#endif
	};
	_object = _syncedObjects select 0;
	if (_object isKindOf "Man") exitWith {
		#ifdef DEBUG
		DLOG("Exiting due to synced object being type MAN");
		#endif
	};

	_inventoryId = _logic getVariable ["bax_persist_inventoryId", ""];
	if (_inventoryId isEqualTo "") exitWith {
		#ifdef DEBUG
		DLOG("Exiting due to empty inventory Id");
		#endif
	};
	_resetInventory = _logic getVariable ["Bax_Persist_ResetInventory", false];

	[
		_inventoryId,
		_object
	] call bax_persist_fnc_loadInventory;

	[_inventoryId, _object] call bax_persist_fnc_registerInventory;
	if (!_resetInventory) then {
		[_inventoryId, _object] call bax_persist_fnc_loadInventory;
	};
};

#ifdef DEBUG
#else
deleteVehicle _logic;
#endif
true;
