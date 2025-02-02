
if (!isServer) exitWith {
	// return
	[false, "Run command on server", nil];
};

params ["_objectId"];

_element = bax_persist_databaseObjects deleteAt _objectId;

if (isNil "_element") exitWith {
	// return
	[false, "Record did not exist", nil];
};

// return
[true, "Record deleted.", _element];
