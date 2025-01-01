

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

	_
};

true;

