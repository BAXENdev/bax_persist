
if !(isMissionProfileNamespaceLoaded) exitWith {};

_saveData = missionProfileNamespace getVariable "bax_persist_saveData";
if (isNil  "_saveData") exitWith {};

_saveData params ["_saveData", "_databasePlayers", "_databaseObjects", "_databaseVariables", "_databaseInventories"];

all3DENEntities params ["_objects", "_groups", "_triggers", "_systems", "_waypoints", "_markers", "_layers", "_comments"];
// check for persistence layer

_persistLayerId = -1 add3DENLayer "Persistence"; // -1 means create in root
_playerLayerId = _persistLayerId add3DENLayer "Players (Presence=false)";
_objectLayerId = _persistLayerId add3DENLayer "Objects (Presence=true)";

// https://community.bistudio.com/wiki/set3DENAttribute
// https://community.bistudio.com/wiki/get3DENAttribute/
// TODO: Check object inventory

{
	_key = _x splitString "_";
	_y params ["_name", "_loadout", "_traits", "_posDir", "_medical", "_variables"];
	
	_posDir params ["_position", "_direction"];

	// get side and change unit spawned
	_player = create3DENEntity ["Object", "B_Soldier_F", _position];
	_player set3DENAttribute ["rotation", [0 ,0, _direction]];
	if (count _key > 1) then {
		_name = format ["[%1, %2]", _name, (_key select [1, count _key - 1]) joinString ","];
	} else {
		_name = format ["[%1]", _name];
	};
	_player set3DENAttribute ["description", _name];



	// TODO: set player inventory

	// traits
	// TODO: Set init of comments that state players medical?
	// add variables

	// tODO: Test setting custom attributes and adding a diaply to show them?
	
} forEach _databasePlayers;

{
	// TODO: Create vehicles
	// TODO: Attach modules that inits them
} forEach _databaseObjects;
