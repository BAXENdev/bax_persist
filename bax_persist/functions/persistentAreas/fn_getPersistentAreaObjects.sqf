
if (!isServer) exitWith {
	"Failed because you called it on not-server and this string should probably break your code";
};

params ["_object"];

_persistentTypes = _object getVariable "bax_persist_persistentAreaTypes";
_radius = _object getVariable ["bax_persist_persistentAreaRadius", 5];
if (isNil "_persistentTypes") exitWith {
	[];
};

_nearbyObjects = [];
{
	_nearbyObjects append (_object nearObjects [_x, _radius]);
} forEach _persistentTypes;
_nearbyObjects = _nearbyObjects - (nearestTerrainObjects [_object, _persistentTypes, _radius, false]);
//return
_nearbyObjects;
