
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
    class loadInventory {};
    class registerInventory {};
    class saveInventory {};
    class unregisterInventory {};
};

class Modules {
    file = "bax_persist\functions\modules";
    class moduleInitializePersist {};
    class moduleRegisterInventoryObject {};
    class moduleRegisterObject {};
    class moduleRegisterVariable {};
};

class Objects {
    file = "bax_persist\functions\objects";
    class loadObject {};
    class registerObject {};
    class saveObject {};
};

class Players {
    file = "bax_persist\functions\players";
    class excludePlayer {};
    class loadPlayer {};
    class savePlayer {};
};
