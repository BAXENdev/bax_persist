
# Bax Persist Docs

## System Variables
| Variables | Type | Description |
|-|-|-|
| bax_persist_databaseLoaded | bool | Whether loading of the database has finished |

## Mission Variables
| Variables | Type | Description |
|-|-|-|
| bax_persist_registeredObjects | HashMap | Array of objects to be saved |
| bax_persist_registeredInventoryObjects | HashMap | Array of object's inventories to be saved |
| bax_persist_registeredNamespaceVariables | HashMap | Registered variables to be saved from the namespace |
| bax_persist_registeredPlayerVariables | HashMap | Registered variables to be saved from players |
| bax_persist_registeredObjectVariables | HashMap | Registered variables to be saved from objects |

## CBA Events
| Event Name | Params | Description |
|-|-|-|
| bax_persist_databaseLoaded | params []; | Called when all databases are fully loaded |
| bax_persist_databaseSaved | params []; | Called when all databases are fully saved, but before the missionProfileNamespace is saved. |
| bax_persist_playerLoaded | params ["_playerId", "_player"]; | Called when a player is loaded |
| bax_persist_playerSaved | params ["_playerId", "_player"]; | Called when a player is saved |
| bax_persist_ObjectLoaded | params ["_objectId", "_object"]; | Called when a object is loaded |
| bax_persist_ObjectSaved | params ["_objectId", "_object"]; | Called when a object is saved |
| bax_persist_InventoryLoaded | params ["_inventoryId", "_object"]; | Called when a inventory is loaded |
| bax_persist_InventorySaved | params ["_inventoryId", "_object"]; | Called when a inventory is saved |
