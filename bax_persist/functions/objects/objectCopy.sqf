// for copy a set of objects from one point to another

_ents = getMissionLayerEntities "set1" select 0;
_offsets = [];
{
	_pos = getPosASL point2 vectorAdd (getPosASL _x vectorDiff getPosASL point1);
	_dir = vectorDir _x;
	_up = vectorUp _x;
	_type = typeOf _x;
	_obj = createVehicle [_type, ASLToATL _pos];
	// _obj = createVehicle [_type, ASLToATL _pos, [], 0, "CAN_COLLIDE"];
	// Set pos required because create vehicle will sometimes offset an object even with can collide enabled for create vehicle
	_obj setPosASL _pos;
	_obj setVectorDirAndUp [_dir, _up];
	_obj enableSimulation (simulationEnabled _x);
	
	_offsets pushBack [
		typeOf _x,
		(getPosATL _x vectorDiff getPosATL point1) vectorDiff
		(getPosATL _obj vectorDiff getPosATL point2)
	];
} forEach _ents;
_offsets;


// sorting
// AllVehicle and ReammoBox vs Static and Thing
// Weapon Holders are their own thing: WeaponHolderSimulated & GroundWeaponHolder + variants?


