
if !(isMissionProfileNamespaceLoaded) exitWith {
	[
		"Mission Profile Namespace is not loaded. If none exists copy the one from the server. All zeuses also get the databases saved." +
		"If one does exist, it will be in your profile and be missionName.vars or missionGroupName.vars. You must start a level and return to editor to load it."
	] call BIS_fnc_3DENShowMessage;
};

_saveDate = missionProfileNamespace getVariable "bax_persist_saveDate";
if (isNil  "_saveDate") exitWith {
	[
		"Save data does exist in missionProfileNamespace"
	] call BIS_fnc_3DENShowMessage;
};

// _saveData params ["_saveData", "_databasePlayers", "_databaseObjects", "_databaseVariables", "_databaseInventories"];
_saveDate = missionProfileNamespace getVariable ["bax_persist_saveDate", "2014_1_1_0_0_0_0"];
_databasePlayers = missionProfileNamespace getVariable ["bax_persist_databasePlayers", createHashmap];
_databaseObjects = missionProfileNamespace getVariable ["bax_persist_databaseObjects", createHashmap];
_databaseVariables = missionProfileNamespace getVariable ["bax_persist_databaseVariables", createHashmap];
_databaseInventories = missionProfileNamespace getVariable ["bax_persist_databaseInventories", createHashmap];


all3DENEntities params ["_objects", "_groups", "_triggers", "_systems", "_waypoints", "_markers", "_layers", "_comments"];
// check for persistence layer

_persistLayerId = -1 add3DENLayer "Persistence"; // -1 means create in root
_playerLayerId = _persistLayerId add3DENLayer "Players (Presence=false)";
_objectLayerId = _persistLayerId add3DENLayer "Objects (Presence=true)";

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
	_player = create3DENEntity ["Object", _soldierClass, (ASLToATL _position)];
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

	[_player, _loadout] call CBA_fnc_setLoadout;
	save3DENInventory [_player];
} forEach _databasePlayers;

{
	_objectId = _x;
	_y params ["_class", "_posDir", "_damage", "_fuel", "_pylons", "_ammo", "_inventory", "_variables", "_spawned"];

	_posDir params ["_position", "_vectorDir", "_vectorUp"];

	_object = create3DENEntity ["Object", _class, (ASLToATL _position), true];
	_object set3DENLayer _objectLayerId;
	_dirY = +_vectorDir;
	_dirZ = +_vectorUp;
	_dirX = _dirY vectorCrossProduct _dirZ;
	_angleY = -1 * (asin (_dirZ select 0));
	_angleZ = (_dirY select 0) atan2 (_dirX select 0);
	_angleX = (_dirZ select 1) atan2 (_dirZ select 2);
	_object set3DENAttribute ["rotation", [rad _angleX, rad _angleZ, rad _angleY]];
	_object setVectorDirAndUp [_vectorDir, _vectorUp];

	// cant add explicit damage. Do I add an average damage value? Set to health to 0 if not alive?
	_object set3DENAttribute ["fuel", _fuel];
	// TODO: pylons
	// attribute structure ["PylonRack_12Rnd_missiles;PylonRack_12Rnd_missiles;"]

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
			_pylonAttribute = _pylonAttribute + (_magClass + ";");
		} forEach _pylons;
		_pylonAttribute = "[" + _pylonAttribute + "]";
		_object set3DENAttribute ["Pylons", _pylonAttribute];
	};

	_pos = (ASLToATL _position) vectorAdd [0, -10, 0];
	// _pos set [2, 0];
	_logic = create3DENEntity ["Logic", "Module_Bax_Persist_RegisterObject", _pos];
	_logic set3DENLayer _objectLayerId;
	add3DENConnection ["Sync", [_logic], _object];
	// TODO: This does not work here?
	_logic set3DENAttribute ["Bax_Persist_ObjectId", _objectId];
} forEach _databaseObjects;
