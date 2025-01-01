
#include "\bax_persist\include.hpp"

_logic = _this param [0,objnull,[objnull]];
_units = _this param [1,[],[[]]];
_activated = _this param [2,true,[true]];

if (_activated) then {
	#ifdef DEBUG
	DLOG("Running Register Object Module");
	#endif

	_attachedObject = attachedTo _logic;
	if (!isNull _attachedObject) exitWith {
		[_attachedObject] call bax_persist_fnc_dialogRegisterObject;
		#ifdef DEBUG
		DLOG("Running Register Object Module - Zeus");
		#endif
	};

	_syncedObjects = synchronizedObjects _logic;
	if (_syncedObjects isNotEqualTo []) exitWith {
		#ifdef DEBUG
		DLOG("Running Register Object Module - 3den");
		#endif

		_object = _syncedObjects select 0;
		if (_object isKindOf "Man") exitWith {
			#ifdef DEBUG
			DLOG("Exiting due to object being man");
			#endif
		};

		_objectId = _logic getVariable ["Bax_Persist_ObjectId", ""];
		if (_objectId isEqualTo "") exitWith {
			#ifdef DEBUG
			DLOG("Exiting due to no id given");
			#endif
		};

		_resetPosition = _logic getVariable ["Bax_Persist_ResetObjectPosition", false];
		_resetInventory = _logic getVariable ["Bax_Persist_ResetObjectInventory", false];
		_resetDamage = _logic getVariable ["Bax_Persist_ResetObjectDamage", false];
		_resetFuel = _logic getVariable ["Bax_Persist_ResetObjectFuel", false];
		_resetAmmo = _logic getVariable ["Bax_Persist_ResetObjectAmmo", false];
		[
			_objectId,
			_object,
			_resetPosition,
			_resetInventory,
			_resetDamage,
			_resetFuel,
			_resetAmmo
		] call bax_persist_fnc_loadObject;
			// load object registers, but if there is nothing to load, we still need to register
		[_objectId, _object] call bax_persist_fnc_registerObject;
	};
};

#ifdef DEBUG
#else
deleteVehicle _logic;
#endif
true;

