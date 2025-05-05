
#include "\bax_persist\include.hpp"

#ifdef DEBUG2
DLOG1("Postinit Load Objects: %1", bax_persist_loadObjectDatabase);
#endif

if !(bax_persist_loadObjectDatabase) exitWith {};

params ["_objectDatabase"];

{
	_objectId = _x;

	#ifdef DEBUG2
	DLOG1("Loading object: %1", _objectId);
	#endif

	if (_objectId in bax_persist_registeredObjects) then {
		continue;
	};

	_return = [_objectId] call bax_persist_fnc_loadObject;
	_return params ["_didSpawned", "_reason", "_object"];
	if (_didSpawned) then {
		[_objectId, _object] call bax_persist_fnc_registerObject;
	};
} forEach bax_persist_databaseObjects;
