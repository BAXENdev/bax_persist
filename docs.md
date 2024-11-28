
# Bax Persist Docs

## Systeem Variables
| Variables | Type | Description |
|-|-|-|
| bax_persist_databasePlayers | Hashmap | Player records |
| bax_persist_isLoaded | bool | Whether loading of the database has finished |

## Mission Variables
| Variables | Type | Description |
|-|-|-|
| bax_persist_registeredNamespaceVariables | Array | Registered variables to be saved from the namespace |
| bax_persist_registeredPlayerVariables | Array | Registered variables to be saved from players |
| bax_persist_registeredObjectVariables | Array | Registered variables to be saved from objects |
| bax_persist_registeredObjects | Array | Array of objects to be saved |

## Module Variables
These variables are initialized by the module. If none are set, then no loading is done as if this mod was not used.
| Variables | Type | Description |
|-|-|-|
| bax_persist_loadPlayerDatabase | bool | Whether to load player database |
| bax_persist_loadPlayerVariables | bool | Whether to load player variables when loading player database |
| bax_persist_loadObjectDatabase | bool | Whether to load object database |
| bax_persist_loadObjectVariables | bool | Whether to load object variables when loading object database |
| bax_persist_loadVariableDatabase | bool | Whether to load mission namespace variable database |
| bax_persist_loadInventoryDatabase | bool | Whether to load object inventories database |
