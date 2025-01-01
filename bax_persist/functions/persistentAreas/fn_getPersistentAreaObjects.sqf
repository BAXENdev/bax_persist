
if (!isServer) exitWith {
	"Failed because you called it on not-server and this string should probably break your code";
};

params ["_object"];

_types = _object getVariable "bax_persist_persistentAreaTypes";

if (isNil "_types") exitWith {
	[];
};

_radius = _object getVariable ["bax_persist_persistentAreaRadius", 5];

_nearbyObjects = _object nearEntities [_types, _radius];
