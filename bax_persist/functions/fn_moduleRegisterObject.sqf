
_logic = _this param [0,objnull,[objnull]];
_units = _this param [1,[],[[]]];
_activated = _this param [2,true,[true]];

if (_activated) then {
	privateAll;

	_objectID = _logic getVariable ["ObjectID", ""];
	if (_objectID isEqualTo "") exitWith {};
	
	_syncedObjects = synchronizedObjects _logic;
	if (count _syncedObjects > 0) exitWith {};
	
	_object = _syncedObjects select 0;
	if (_object isKindOf "Man") exitWith {};

	_objectRecord = bax_persist_databaseObjects get _objectID;
	if !(isNil "_objectRecord") then {
		_objectRecord params ["_class", "_posDir", "_damage", "_fuel", "_inventory", "_variables", "_isAlive", "_spawned"];
		
		if (_isSpawned or !_isAlive) exitWith {
			deleteVehicle _object;
		} else {
			// set isSpawned to true
			_objectRecord set [7, true];
			_object setVariable ["bax_persist_objectId", _id, true];
			bax_persist_registeredObjects pushBack _object;
		};

		_resetPosition = _logic getVariable ["ResetPosition", false];
		_resetInventory = _logic getVariable ["ResetInventory", false];
		_resetDamage = _logic getVariable ["ResetDamage", false];
		_resetFuel = _logic getVariable ["ResetFuel", false];
		_reviveObject = _logic getVariable ["ReviveObject", false];

		if !(_resetPosition) then {
			_posDir params ["_position", "_direction"];
			_object setPos _position;
			_object setDir _direction;
		};

		if !(_resetInventory) then {
			[_object, _inventory] call bax_persist_fnc_deserializeObjectInventory;
		};

		if (!_resetDamage and bax_persist_loadObjectDamage) then {
			if (_damage isEqualType 0) then {
				_object setDamage _damage;
			} else {
				{
					_hitPointValue = _x;
					_hitPointIndex = _forEachIndex;
					_object setHitIndex [_hitPointIndex, _hitPointValue];
				} forEach _damage;
			};
		};

		if (!resetFuel and bax_persist_loadObjectFuel) then {
			_object setFuel _fuel;
		};

		{
			_x params ["_variable", "_value"];
			_object setVariable [_variable, _value, true];
		} forEach _variables;
	} else { // isNil record == true, just put in array to be saved
		_object setVariable ["bax_persist_objectId", _id, true];
		bax_persist_registeredObjects pushBack _object;
	};
};

true;
