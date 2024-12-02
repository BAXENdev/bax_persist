
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
	_soldierClass = "B_Survivor_F";
	if (count _key > 1 and { (_key select 1) in [str west, str east, str independent, str civilian] }) then {
		switch (_key select 1) do {
			case (str west): { _soldierClass = "B_Survivor_F" };
			case (str east): { _soldierClass = "O_Survivor_F" };
			case (str independent): { _soldierClass = "I_Survivor_F" };
			case (str civilian): { _soldierClass = "C_Man_1" };
		};
	};
	_player = create3DENEntity ["Object", _soldierClass, _position];
	_player set3DENLayer _playerLayerId;
	_player set3DENAttribute ["rotation", [0 ,0, _direction]];
	if (count _key > 1) then {
		_name = format ["[%1, %2]", _name, (_key select [1, count _key - 1]) joinString ","];
	} else {
		_name = format ["[%1]", _name];
	};
	_player set3DENAttribute ["description", _name];
	_player set3DENAttribute ["presenceCondition", "false"];
	_traits params ["_medicalTrait", "_engineerTrait"];
	_player set3DENAttribute ["ace_isMedic", _medicalTrait];
	_player set3DENAttribute ["ace_isEngineer", _engineerTrait];

	_player setUnitLoadout _loadout;
	save3DENInventory [_player];

	// tODO: Test setting custom attributes and adding a diaply to show them?
	
} forEach _databasePlayers;

{
	_y params ["_class", "_posDir", "_damage", "_fuel", "_pylons", "_ammo", "_inventory", "_variables", "_spawned"];

	_posDir params ["_position", "_direction"];
	_object = create3DENEntity ["Object", _class, _position, true];
	_object set3DENLayer _objectLayerId;
	_object set3DENAttribute ["rotation", [0 ,0, _direction]];

	// cant add explicit damage. Do I add an average damage value? Set to health to 0 if not alive?
	_object set3DENAttribute ["fuel", _fuel];
	// pylons?
	// ["PylonRack_12Rnd_missiles;PylonRack_12Rnd_missiles;"]

	// [[weapons, magazines, items, backpacks], false=storage] // cant show subcontainers?
	// ammobox sample structure: ["[[[[""arifle_TRG21_GL_F""],[1]],[[""30Rnd_45ACP_Mag_SMG_01""],[1]],[[""V_PlateCarrierGL_tna_F""],[1]],[[""B_AssaultPack_blk""],[1]]],false]"]
	_ammoBoxWeapons = [[], []];
	_ammoBoxMagazines = [[], []];
	_ammoBoxItems = [[], []];
	_ammoBoxBackpacks = [[], []];
	_ammoBox = [[_weapons, _magazines, _items, _backpacks], false];
	_inventory params ["_items", "_magazines", "_weapons", "_backpacks", "_inventories"];
	// TODO: Recursive inventory? Add all sub-inventory items to vehicle too. move this to a function?
	{
		_x params ["_item", "_count"];
		(_ammoBoxWeapons select 0) pushBack _item;
		(_ammoBoxWeapons select 1) pushBack _count;
	} forEach _weapons;
	{
		_x params ["_item", "_count"];
		(_ammoBoxMagazines select 0) pushBack _item;
		(_ammoBoxMagazines select 1) pushBack _count;
	} forEach _magazines;
	{
		_x params ["_item", "_count"];
		(_ammoBoxItems select 0) pushBack _item;
		(_ammoBoxItems select 1) pushBack _count;
	} forEach _items;
	{
		_x params ["_item", "_count"];
		(_ammoBoxBackpacks select 0) pushBack _item;
		(_ammoBoxBackpacks select 1) pushBack _count;
	} forEach _backpacks;
	_object set3DENAttribute ["ammoBox", _ammoBox];

	if (_object isKindOf "AllVehicles") then {
		_pylonAttribute = "";
		{
			_magClass = _x select 2;
			_pylonAttribute = format ["%1%2;", _pylonAttribute, _magClass];
		} forEach _pylons;
		_object set3DENAttribute ["Pylons", _pylonAttribute];
	};

	// TODO: Add module
} forEach _databaseObjects;
