
class Root {
    file = "bax_persist\functions";
    class deserializeInventory {};
    class postinit {};
    class preinit {};
    class serializeInventory {};
};

class 3den {
    file = "bax_persist\functions\3den";
    class load3denPreview {};
    class openDBManager {};
};

class Database {
    file = "bax_persist\functions\database";
    class cleanDatabaseObjects {};
    class loadDatabaseObjects {};
    class loadDatabaseVariables {};
    class queueSaveDatabase {};
    class saveDatabase {};
    class saveDatabaseInventories {};
    class saveDatabaseObjects {};
    class saveDatabasePlayers {};
    class saveDatabaseVariables {};
    class zeusSaveDatabase {};
};

class Inventories {
    file = "bax_persist\functions\inventories";
    class deleteInventory {};
    class initInventory {};
    class loadInventory {};
    class registerInventory {};
    class saveInventory {};
    class unregisterInventory {};
};

class Modules {
    file = "bax_persist\functions\modules";
    class curatorPersistentArea {};
    class moduleInitializePersist {};
    class modulePersistentArea {};
    class moduleRegisterInventory {};
    class moduleRegisterObject {};
    class moduleRegisterVariables {};
    class moduleSaveDatabase {};
    class moduleSpawnAreaTeleport {};
    class moduleSpawnAreaWhitelist {};
};

class Objects {
    file = "bax_persist\functions\objects";
    class deleteObject {};
    class loadObject {};
    class registerObject {};
    class registerObjectRandom {};
    class saveObject {};
    class unregisterObject {};
};

class PersistentAreas {
    file = "bax_persist\functions\persistentAreas";
    class addPersistentArea {};
    class getPersistentAreaObjects {};
    class registerPersistentAreas {};
};

class Players {
    file = "bax_persist\functions\players";
    class excludePlayer {};
    class loadPlayer {};
    class playerInWhitelist {};
    class savePlayer {};
};

class Zen {
    file = "bax_persist\functions\zen";
    class dialogPersistentArea {};
    class dialogRegisterObject {};
};
