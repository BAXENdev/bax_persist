
# Baxen's Persist

Baxen's Persist is an API that allows players and objects to be saved and loaded from different missions.
It also features multiple 3den and zeus modules for basic persistence functionality.

To enable saving and loading between different missions, place this into each the `description.ext` of each mission file:
```hpp
// in description.ext of a mission
missionGroup = "campaignName";
```
To explain, the `fileName.vars` file that holds the data is named after the mission name. If you played the same mission again, the old database would be loaded. If you set the `missionGroup` config, this specifies the name of the `.vars` file, and as such if multiple missions have the same `missionGroup` config, they will use the same `.vars` file allowing for cross mission saving and loading.

The `.vars` is always created regardless. If you do not set the missionGroup but still want to save and load the databases, make sure you rename the final mission file to be the same as the first mission on the server. You may need to delete the old mission file.

## Mission Variables
| Variables | Type | Description |
|-|-|-|
| bax_persist_databasePlayers | HashMap | All player records are stored here |
| bax_persist_databaseObjects | Hashmap | All saved objects are stored here |
| bax_persist_databaseVariables | Hashmap | All saved mission variables are stored here |
| bax_persist_databaseInventories | Hashmap | All saved inventory records are stored here |
| bax_persist_registeredObjects | HashMap | Registered objects to be saved |
| bax_persist_registeredInventoryObjects | HashMap | Hashmap of object's inventories to be saved |
| bax_persist_registeredNamespaceVariables | HashMap | Registered variables to be saved from the namespace |
| bax_persist_registeredPlayerVariables | HashMap | Registered variables to be saved from players |
| bax_persist_registeredObjectVariables | HashMap | Registered variables to be saved from objects |

## CBA Events
| Event Name | Params | Description |
|-|-|-|
| "Bax_Persist_DatabaseLoaded" | params []; | Called after all databases are fully loaded |
| "Bax_Persist_DatabaseSaved" | params []; | Called after all databases are fully saved, but before missionProfileNamespace is saved |
| "Bax_Persist_PlayerLoading" | params ["_playerId", "_player"]; | Called before a player is loaded |
| "Bax_Persist_PlayerLoaded" | params ["_playerId", "_player"]; | Called after a player is loaded |
| "Bax_Persist_PlayerSaved" | params ["_playerId", "_player"]; | Called after a player is saved |
| "Bax_Persist_ObjectLoading" | params ["_objectId", "_object"]; | Called before a object is loaded |
| "Bax_Persist_ObjectLoaded" | params ["_objectId", "_object"]; | Called after a object is loaded |
| "Bax_Persist_ObjectSaved" | params ["_objectId", "_object"]; | Called after a object is saved |
| "Bax_Persist_InventoryLoaded" | params ["_inventoryId", "_object"]; | Called after a inventory is loaded |
| "Bax_Persist_InventorySaved" | params ["_inventoryId", "_object"]; | Called after a inventory is saved |

## Systems
### Object Database Functions
Object loading is enabled by the `Initialize Persist` module. The `Register Object` module can also manually handle registering and loading objects without enabling the Object Loading. These two options should cover most basic uses of persistent vehicles and objects.

The functions below offer the base of building custom systems. Below are the functions for accessing the object dababase.

```sqf
// Loads an object from database
_return = [_objectId] call bax_persist_fnc_loadObject;
_return params ["_success", "_reason", "_object"];

// Loads an object using a prespawned object. If the object types do not match, only transferable data such as inventory is loaded
_return = [_objectId, _object] call bax_persist_fnc_loadObject;
_return params ["_success", "_reason", "_object"];

// Load an object with reset values. All reset values are bool.
_return = [_objectId, _object, _resetPosition, _resetInventory, _resetDamage, _resetFuel, _resetAmmo] call bax_persist_fnc_loadObject;
_return params ["_success", "_reason", "_object"];

// Register an object to be automatically saved. Loading an object does not register it for saving, so both of these must be called on an object.
_return = [_objectId, _object] call bax_persist_fnc_registerObject;
_return params ["_success", "_reason"];

// Unregister an object from being saved
// Params: _objectId, _deleteRecord
// If delete record is true, then the objectId is also removed from the database
_return = [_objectId, false] call bax_persist_fnc_unregisterObject;
_return params ["_success", "_reason"];

// Save an object. The object does not need to be registered to be saved. This also does not register the object to be saved automatically in the future either.
_return = [_objectId, _object] call bax_persist_fnc_saveObject;
_return params ["_success", "_reason"];

// Delete an object record.
// RETURN: Success: bool, Reason: String, Element: database entry
_return = [_objectId] call bax_persist_fnc_deleteObject;
_return params ["_success", "_reason", "_element"];
_element params ["_class", "_posDir", "_damage", "_fuel", "_pylons", "_ammo", "_inventory", "_variables", "_spawned"];

// Create a persistent area. Default for each bool is false.
[_object, _radius, _boolSaveVehicle, _boolSaveAmmoBoxes, _boolSaveWeaponHolders, _boolSaveStaticObjects] call bax_persist_fnc_addPersistentArea;

// ---------------------------------------------------

// EXAMPLE: Properly load an object
_return1 = [_objectId] call bax_persist_fnc_loadObject;
_return1 params ["_success", "_reason", "_object"];
if (_success) then {
    _return2 = [_objectId, _object] call bax_persist_fnc_registerObject;
    _return2 params ["_success", "_reason"];
};

// EXAMPLE: check for id in database
_boolInDb = _objectId in bax_persist_fnc_databaseObjects;

// Parse element from database
_objectData = bax_persist_fnc_databaseObjects get _objectId;
_objectData params ["_class", "_posDir", "_damage", "_fuel", "_pylons", "_ammo", "_inventory", "_variables", "_spawned"];

```

### Player Database
* Players are saved whenever they leave, the system autosaves, or the game ends
* If a player leaves and rejoins mid-mission, their previous position from when left will always be loaded.
```sqf
// Load Player
_return = [_playerId, _player] call bax_persist_fnc_loadPlayer;
_return params ["_success", "_reason"];

// Load player with reset values. All reset values are bool
[_playerId, _player, _resetLoadout, _resetPosition, _resetMedical] call bax_persist_fnc_loadPlayer;
_return params ["_success", "_reason"];

// Save Player
_return = [_playerId, _player] call bax_persist_fnc_savePlayer;
_return params ["_success", "_reason"];

// Exclude player from being saved during autosaves and mission end saving
// Place this into the object init of player's for player roles that shouldn't be saved such as RP roles.
[_player] call bax_persist_fnc_excludePlayer;
```

### Inventory Database Functions
```sqf
// Load Inventory. This does not register the inventory to be saved.
_return = [_inventoryId, _object] call bax_persist_fnc_loadInventory;
_return params ["_success", "_reason"];

// Register Inventory for saving
_return = [_inventoryId, _object] call bax_persist_fnc_registerInventory;
_return params ["_success", "_reason"];

// Save an inventory
_return = [_inventoryId, _object] call bax_persist_fnc_saveInventory;
_return params ["_success", "_reason"];

// Unregister an inventory
_return = [_inventoryId, _object] call bax_persist_fnc_unregisterInventory;
_return params ["_success", "_reason"];

// Delete an inventory
_return = [_inventoryId, _object] call bax_persist_fnc_deleteInventory;
_return params ["_success", "_reason", "_element"];
_element params ["_items", "_magazines", "_weapons", "_backpacks", "_subInventories"];
{
    _x params ["_backpackClass", "_subInventory"];
    // Recursive sub inventory structure... :)
    _subInventory params ["_items", "_magazines", "_weapons", "_backpacks", "_subInventories"];
} forEach _subInventories;

```

