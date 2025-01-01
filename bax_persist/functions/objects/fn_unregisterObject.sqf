// TODO: Remove object from registered objects
// TODO: Delete record

params ["_objectID", ["_deleteRecord", true]];

if (!_objectId in bax_persist_registeredObjects) exitWith {
	// return
	[false, "No object registered"];
};

_object = bax_persist_registeredObjects get _objectId;
_object setVariable ["bax_persist_objectId", nil, true];

bax_persist_registeredObjects deleteAt _objectId;

if (_deleteRecord) then {
	bax_persist_databaseObjects deleteAt _objectId;
};

// return
[true, "Successfully unregistered"];
