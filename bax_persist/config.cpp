
class CfgPatches {
	class Bax_Persist {
		name = "BAXEN's Persist";
		author = "BAXENATOR";
		units[] = {

		};
		requiredVersion = 1.0;
		requiredAddons[] = {"ace_medical", "cba_main"};
		skipWhenMissingDependencies = 1;
	};
};

class CfgFunctions {
	class Bax_Persist {
		class functions {
			file = "\bax_persist\functions";
			class deserializeObjectInventory {};
			class loadDatabaseObjects {};
			class loadDatabaseVariables {};
			class moduleInitializePersist {};
			class moduleRegisterInventoryObject {};
			class moduleRegisterObject {};
			class moduleRegisterVariable {};
			class postinit {};
			class preinit {};
			class registerInventoryObject {};
			class requestInventoryLoad {};
			class requestInventorySave {};
			class requestPlayerLoad {};
			class saveDatabase {};
			class saveDatabaseInventories {};
			class saveDatabaseObjects {};
			class saveDatabasePlayers {};
			class saveDatabaseVariables {};
			class serializeObjectInventory {};
		};
	};
};

class Extended_Preinit_EventHandlers {
	class Bax_Persist {
		init = "call bax_persist_fnc_preinit";
	};
};

class Extended_Postinit_EventHandlers {
	class Bax_Persist {
		init = "call bax_persist_fnc_postinit";
	};
};

class CfgFactionClasses {
	class NO_CATEGORY;
	class Bax_Persist: NO_CATEGORY {
		displayName = "Persistence";
	};
};

class CfgVehicles {
	class Logic;
	class Module_F: Logic {
		class AttributesBase {
			class Default;
			class Edit;
			class EditMulti5;
			class Combo;
			class Checkbox;
			class ModuleDescription;
		};

		// Description base classes (for more information see below):
		class ModuleDescription {
			class AnyBrain;
		};
	};

	class Module_Bax_Persist_InitializePersist: Module_F {
		scope = 2;
		displayName = "Initialize Persistance";
		// icon = "";
		category = "Bax_Persist";

		function = "bax_persist_fnc_moduleInitializePersist";
		functionPriority = 0;
		isGlobal = 0;
		isTriggerActivated = 0;
		isDisposable = 0;
		class Attributes: AttributesBase {
			class EnablePlayerDB: Checkbox {
				displayName = "Load Player Database";
				tooltip = "";
				property = "Bax_Persist_LoadPlayerDatabase";
				defaultValue = "true";
			};

			class EnableObjectDB: Checkbox {
				displayName = "Load Object Database";
				tooltip = "";
				property = "Bax_Persist_LoadObjectDatabase";
				defaultValue = "true";
			};

			class EnableVariableDB: Checkbox {
				displayName = "Load Variable Database";
				tooltip = "";
				property = "Bax_Persist_LoadVariableDatabase";
				defaultValue = "true";
			};

			// class EnableInventoriesDB: Checkbox {
			// 	displayName = "Load Object Inventories Database";
			// 	tooltip = "";
			// 	property = "Bax_Persist_LoadInventoriesDatabase";
			// 	defaultValue = "true";
			// };

			class EnablePlayerVars: Checkbox {
				displayName = "Load Player Variables";
				tooltip = "When player data is loaded, whether to load any stored variables.";
				property = "Bax_Persist_LoadPlayerVariables";
				defaultValue = "true";
			};
			
			class EnablePlayerMedical: Checkbox {
				displayName = "Load Player Medical";
				tooltip = "When players are loaded, whether to load the saved medical state.";
				property = "Bax_Persist_LoadPlayerMedical";
				defaultValue = "true";
			};

			class EnableObjectVars: Checkbox {
				displayName = "Load Object Variables";
				tooltip = "When objects are loaded, whether to load any stored variables.";
				property = "Bax_Persist_LoadObjectVariables";
				defaultValue = "true";
			};

			class ModuleDescription: ModuleDescription {};
		};

		class ModuleDescription: ModuleDescription {
			description = "Initializes persistence.";
		};
	};

	class Module_Bax_Persist_RegisterInventoryObject: Module_F {
		scope = 2;
		displayName = "Register Inventory Object";
		// icon = "";
		category = "Bax_Persist";

		function = "bax_persist_fnc_moduleRegisterInventoryObject";
		functionPriority = 0;
		isGlobal = 0;
		isTriggerActivated = 0;
		isDisposable = 0;
		class Attributes: AttributesBase {
			class InventoryID: Edit {
				displayNAme = "Inventory ID";
				tooltip = "Unique ID that is used for saving and loading an inventory.";
				property = "Bax_Persist_InventoryId";
				defaultValue = "''";
			};

			class LoadOnly: Checkbox {
				displayName = "Only Load/Disable Register";
				tooltip = "Do not register object for saving the inventory. Useful for loading saved inventories meant to be repeatedly loaded.";
				property = "Bax_Persist_LoadOnly";
				defaultValue = "true";
			};

			class ModuleDescription: ModuleDescription {};
		};

		class ModuleDescription: ModuleDescription {
			description = "Register this object's inventory for saving under a unique ID. This does not save this object.";
		};
	};

	class Module_Bax_Persist_RegisterObject: Module_F {
		scope = 2;
		displayName = "Register Object";
		// icon = "";
		category = "Bax_Persist";

		function = "bax_persist_fnc_moduleRegisterObject";
		functionPriority = 0;
		isGlobal = 0;
		isTriggerActivated = 0;
		isDisposable = 0;
		class Attributes: AttributesBase {
			class ModuleDescription: ModuleDescription {};
		};

		class ModuleDescription: ModuleDescription {
			description = "Register this object for saving.";
		};
	};

	class Module_Bax_Persist_RegisterVariable: Module_F {
		scope = 2;
		displayName = "Register Variables";
		// icon = "";
		category = "Bax_Persist";

		function = "bax_persist_fnc_moduleRegisterVariables";
		functionPriority = 0;
		isGlobal = 0;
		isTriggerActivated = 0;
		isDisposable = 0;
		class Attributes: AttributesBase {
			class Var1: Edit {
				displayName = "Variable";
				tooltip = "MissionNamespace Variable to be saved and loaded in the future. If empty, then do nothing.";
				property = "Bax_Persist_Var1";
				defaultValue = "''";
			};

			class Var2: Edit {
				displayName = "Variable";
				tooltip = "MissionNamespace Variable to be saved and loaded in the future. If empty, then do nothing.";
				property = "Bax_Persist_Var2";
				defaultValue = "''";
			};

			class Var3: Edit {
				displayName = "Variable";
				tooltip = "MissionNamespace Variable to be saved and loaded in the future. If empty, then do nothing.";
				property = "Bax_Persist_Var3";
				defaultValue = "''";
			};

			class Var4: Edit {
				displayName = "Variable";
				tooltip = "MissionNamespace Variable to be saved and loaded in the future. If empty, then do nothing.";
				property = "Bax_Persist_Var4";
				defaultValue = "''";
			};

			class Var5: Edit {
				displayName = "Variable";
				tooltip = "MissionNamespace Variable to be saved and loaded in the future. If empty, then do nothing.";
				property = "Bax_Persist_Var5";
				defaultValue = "''";
			};

			class ModuleDescription: ModuleDescription {};
		};

		class ModuleDescription: ModuleDescription {
			description = "Mission variables to be saved and loaded on the next mission start. To keep variables being saved, you must define this every mission.";
		};
	};

	class Module_Bax_Persist_RegisterPlayerVariable: Module_F {
		scope = 2;
		displayName = "Register Player Variables";
		// icon = "";
		category = "Bax_Persist";

		function = "bax_persist_fnc_moduleRegisterVariable";
		functionPriority = 0;
		isGlobal = 0;
		isTriggerActivated = 0;
		isDisposable = 0;
		class Attributes: AttributesBase {
			class Var1: Edit {
				displayName = "Variable";
				tooltip = "Player Variable to be saved and loaded in the future. If empty, then do nothing.";
				property = "Bax_Persist_Var1";
				defaultValue = "''";
			};

			class Var2: Edit {
				displayName = "Variable";
				tooltip = "Player Variable to be saved and loaded in the future. If empty, then do nothing.";
				property = "Bax_Persist_Var2";
				defaultValue = "''";
			};

			class Var3: Edit {
				displayName = "Variable";
				tooltip = "Player Variable to be saved and loaded in the future. If empty, then do nothing.";
				property = "Bax_Persist_Var3";
				defaultValue = "''";
			};

			class Var4: Edit {
				displayName = "Variable";
				tooltip = "Player Variable to be saved and loaded in the future. If empty, then do nothing.";
				property = "Bax_Persist_Var4";
				defaultValue = "''";
			};

			class Var5: Edit {
				displayName = "Variable";
				tooltip = "Player Variable to be saved and loaded in the future. If empty, then do nothing.";
				property = "Bax_Persist_Var5";
				defaultValue = "''";
			};

			class ModuleDescription: ModuleDescription {};
		};

		class ModuleDescription: ModuleDescription {
			description = "Player variables to be saved and loaded on the next mission start. To keep variables being saved, you must define this every mission.";
		};
	};

	class Module_Bax_Persist_RegisterObjectVariable: Module_F {
		scope = 2;
		displayName = "Register Object Variables";
		// icon = "";
		category = "Bax_Persist";

		function = "bax_persist_fnc_moduleRegisterVariable";
		functionPriority = 0;
		isGlobal = 0;
		isTriggerActivated = 0;
		isDisposable = 0;
		class Attributes: AttributesBase {
			class Var1: Edit {
				displayName = "Variable";
				tooltip = "Object Variable to be saved and loaded in the future. If empty, then do nothing.";
				property = "Bax_Persist_Var1";
				defaultValue = "''";
			};

			class Var2: Edit {
				displayName = "Variable";
				tooltip = "Object Variable to be saved and loaded in the future. If empty, then do nothing.";
				property = "Bax_Persist_Var2";
				defaultValue = "''";
			};

			class Var3: Edit {
				displayName = "Variable";
				tooltip = "Object Variable to be saved and loaded in the future. If empty, then do nothing.";
				property = "Bax_Persist_Var3";
				defaultValue = "''";
			};

			class Var4: Edit {
				displayName = "Variable";
				tooltip = "Object Variable to be saved and loaded in the future. If empty, then do nothing.";
				property = "Bax_Persist_Var4";
				defaultValue = "''";
			};

			class Var5: Edit {
				displayName = "Variable";
				tooltip = "Object Variable to be saved and loaded in the future. If empty, then do nothing.";
				property = "Bax_Persist_Var5";
				defaultValue = "''";
			};

			class ModuleDescription: ModuleDescription {};
		};

		class ModuleDescription: ModuleDescription {
			description = "Object variables to be saved and loaded on the next mission start. To keep variables being saved, you must define this every mission.";
		};
	};
};
