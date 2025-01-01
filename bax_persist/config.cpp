
class CfgPatches {
	class Bax_Persist {
		name = "BAXEN's Persist";
		author = "BAXENATOR";
		units[] = {
			"Module_Bax_Persist_InitializePersist",
			"Module_Bax_Persist_RegisterObject",
			"Module_Bax_Persist_RegisterInventory",
			"Module_Bax_Persist_RegisterVariable",
			"Module_Bax_Persist_RegisterPlayerVariable",
			"Module_Bax_Persist_RegisterObjectVariable",
			"Module_Bax_Persist_WhitelistSpawnArea",
			"Module_Bax_Persist_WhitelistTeleport"
		};
		requiredVersion = 1.0;
		requiredAddons[] = {"ace_medical", "cba_main"};
		skipWhenMissingDependencies = 1;
	};
};

class CfgFunctions {
	class Bax_Persist {
		#include "\bax_persist\functions\categories.hpp"
	};
};

class Extended_Preinit_EventHandlers {
	class Bax_Persist {
		init = "[] call bax_persist_fnc_preinit";
	};
};

class Extended_Postinit_EventHandlers {
	class Bax_Persist {
		init = "[] call bax_persist_fnc_postinit";
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
		functionPriority = 10;
		isGlobal = 0;
		isTriggerActivated = 0;
		isDisposable = 0;
		class Attributes: AttributesBase {
			class SubCategorySaving {
				data = "AttributeSystemSubcategory";
				control = "SubCategory";
				displayName = "Save Settings";
			};

			class Bax_Persist_EnableSaving: Checkbox {
				displayName = "Saving Enabled";
				tooltip = "Enables saving the mission. All 3den instances do not allow saving the database.";
				property = "Bax_Persist_EnableSaving";
				defaultValue = "true";
			};

			class Bax_Persist_AutosaveTimer: Edit {
				displayName = "Autosave Timer";
				tooltip = "How often autosaving occurs. min=15 | max=120 in minutes.";
				property = "Bax_Persist_AutosaveTimer";
				defaultValue = "40";
				typeName = "NUMBER";
			};

			class Bax_Persist_EnableAutosave: Checkbox {
				displayName = "Enable Autosave";
				tooltip = "Enables Autosaving";
				property = "Bax_Persist_EnableAutosave";
				defaultValue = "true";
			};

			class SubCategoryPlayer {
				data = "AttributeSystemSubcategory";
				control = "SubCategory";
				displayName = "Player Persistence Settings";
			};

			class Bax_Persist_LoadPlayerDatabase: Checkbox {
				displayName = "Player Database";
				tooltip = "Enables loading of player data from previous sessions.";
				property = "Bax_Persist_LoadPlayerDatabase";
				defaultValue = "true";
			};

			class Bax_Persist_ResetPlayerLoadout: Checkbox {
				displayName = "Reset Player Loadout";
				tooltip = "Reset the player's loadout to the current loadout of the player object.";
				property = "Bax_Persist_ResetPlayerLoadout";
				defaultValue = "false";
			};

			class Bax_Persist_ResetPlayerPosition: Checkbox {
				displayName = "Reset Player Position";
				tooltip = "Reset the player's position to the current position of the player object.";
				property = "Bax_Persist_ResetPlayerPosition";
				defaultValue = "false";
			};

			class Bax_Persist_ResetPlayerMedical: Checkbox {
				displayName = "Reset Player Medical";
				tooltip = "Reset the player's medical when loading in.";
				property = "Bax_Persist_ResetPlayerMedical";
				defaultValue = "false";
			};

			class Bax_Persist_LoadPlayerKeySide: Checkbox {
				displayName = "Side Keying";
				tooltip = "Player data is saved based on their side. Enabling side keying at later date will not load the previous un-sided data.";
				property = "Bax_Persist_LoadPlayerKeySide";
				defaultValue = "false";
			};

			class Bax_Persist_LoadPlayerKeyRole: Checkbox {
				displayName = "Role Keying";
				tooltip = "Player data is saved based on their role. Enabling role keying at later date will not load the previous un-roled data.";
				property = "Bax_Persist_LoadPlayerKeyRole";
				defaultValue = "false";
			};

			class SubCategoryObject {
				data = "AttributeSystemSubcategory";
				control = "SubCategory";
				displayName = "Object Persistence Settings";
			};

			class Bax_Persist_LoadObjectDatabase: Checkbox {
				displayName = "Object Database";
				tooltip = "Enables loading of object data from previous sessions.";
				property = "Bax_Persist_LoadObjectDatabase";
				defaultValue = "true";
			};

			class Bax_Persist_ResetObjectDamage: Checkbox {
				displayName = "Reset Object Damage";
				tooltip = "Reset the objects damage when loading in.";
				property = "Bax_Persist_ResetObjectDamage";
				defaultValue = "false";
			};

			class Bax_Persist_ResetObjectFuel: Checkbox {
				displayName = "Reset Object Fuel";
				tooltip = "Reset the objects fuel levels when loading in.";
				property = "Bax_Persist_ResetObjectFuel";
				defaultValue = "false";
			};

			class Bax_Persist_ResetObjectAmmo: Checkbox {
				displayName = "Reset Object Ammo";
				tooltip = "Reset the objects ammo when loading. This does not reset pylons.";
				property = "Bax_Persist_ResetObjectAmmo";
				defaultValue = "false";
			};

			class Bax_Persist_RemoveDeadObjects: Checkbox {
				displayName = "Remove Dead Objects";
				tooltip = "Remove objects that are dead from the database before spawning everything if object database is loaded.";
				property = "Bax_Persist_RemoveDeadObjects";
				defaultValue = "false";
			};

			class SubCategoryVariables {
				data = "AttributeSystemSubcategory";
				control = "SubCategory";
				displayName = "Variables Persistence Settings";
			};

			class Bax_Persist_LoadVariablesDatabase: Checkbox {
				displayName = "Variables Database";
				tooltip = "Enables loading of mission namespace variables from previous sessions.";
				property = "Bax_Persist_LoadVariablesDatabase";
				defaultValue = "true";
			};

			class ModuleDescription: ModuleDescription {};
		};

		class ModuleDescription: ModuleDescription {
			description = "Initializes persistence.";
		};
	};

	class Module_Bax_Persist_RegisterVariables: Module_F {
		scope = 2;
		displayName = "Register Variables";
		// icon = "";
		category = "Bax_Persist";

		function = "BAX_PERSIST_fnc_moduleRegisterVariables";
		functionPriority = 20;
		isGlobal = 0;
		isTriggerActivated = 0;
		isDisposable = 0;
		class Attributes: AttributesBase {
			class SubCategoryVariable1 {
				data = "AttributeSystemSubcategory";
				control = "SubCategory";
				displayName = "Entry 1";
			};

			class Variable1: Edit {
				displayName = "Variable 1";
				tooltip = "MissionNamespace Variable to be saved and loaded in the future. If empty, then do nothing.";
				property = "Bax_Persist_Variable1";
				defaultValue = "''";
			};

			class Bax_Persist_DefaultValue1 {
				control = "EditCodeMulti5";
                expression = "_this setVariable ['%s',_value,true];";
				displayName = "Default Value 1";
				tooltip = "Default value to be used if the mission namespace variable does not exist. This is a block of code, but does not need to return a value. NIL is a valid return value.";
				property = "Bax_Persist_DefaultValue1";
				defaultValue = "''";
			};

			class SubCategoryVariable2 {
				data = "AttributeSystemSubcategory";
				control = "SubCategory";
				displayName = "Entry 2";
			};

			class Variable2: Edit {
				displayName = "Variable 2";
				tooltip = "MissionNamespace Variable to be saved and loaded in the future. If empty, then do nothing.";
				property = "Bax_Persist_Variable2";
				defaultValue = "''";
			};

			class Bax_Persist_DefaultValue2 {
				control = "EditCodeMulti5";
                expression = "_this setVariable ['%s',_value,true];";
				displayName = "Default Value 2";
				tooltip = "Default value to be used if the mission namespace variable does not exist. This is a block of code, but does not need to return a value. NIL is a valid return value.";
				property = "Bax_Persist_DefaultValue2";
				defaultValue = "''";
			};

			class SubCategoryVariable3 {
				data = "AttributeSystemSubcategory";
				control = "SubCategory";
				displayName = "Entry 3";
			};

			class Variable3: Edit {
				displayName = "Variable 3";
				tooltip = "MissionNamespace Variable to be saved and loaded in the future. If empty, then do nothing.";
				property = "Bax_Persist_Variable3";
				defaultValue = "''";
			};

			class Bax_Persist_DefaultValue3 {
				control = "EditCodeMulti5";
                expression = "_this setVariable ['%s',_value,true];";
				displayName = "Default Value 3";
				tooltip = "Default value to be used if the mission namespace variable does not exist. This is a block of code, but does not need to return a value. NIL is a valid return value.";
				property = "Bax_Persist_DefaultValue3";
				defaultValue = "''";
			};

			class SubCategoryVariable4 {
				data = "AttributeSystemSubcategory";
				control = "SubCategory";
				displayName = "Entry 4";
			};

			class Variable4: Edit {
				displayName = "Variable 4";
				tooltip = "MissionNamespace Variable to be saved and loaded in the future. If empty, then do nothing.";
				property = "Bax_Persist_Variable4";
				defaultValue = "''";
			};

			class Bax_Persist_DefaultValue4 {
				control = "EditCodeMulti5";
                expression = "_this setVariable ['%s',_value,true];";
				displayName = "Default Value 4";
				tooltip = "Default value to be used if the mission namespace variable does not exist. This is a block of code, but does not need to return a value. NIL is a valid return value.";
				property = "Bax_Persist_DefaultValue4";
				defaultValue = "''";
			};

			class SubCategoryVariable5 {
				data = "AttributeSystemSubcategory";
				control = "SubCategory";
				displayName = "Entry 5";
			};

			class Variable5: Edit {
				displayName = "Variable 5";
				tooltip = "MissionNamespace Variable to be saved and loaded in the future. If empty, then do nothing.";
				property = "Bax_Persist_Variable5";
				defaultValue = "''";
			};

			class Bax_Persist_DefaultValue5 {
				control = "EditCodeMulti5";
                expression = "_this setVariable ['%s',_value,true];";
				displayName = "Default Value 5";
				tooltip = "Default value to be used if the mission namespace variable does not exist. This is a block of code, but does not need to return a value. NIL is a valid return value.";
				property = "Bax_Persist_DefaultValue5";
				defaultValue = "''";
			};

			class ModuleDescription: ModuleDescription {};
		};

		class ModuleDescription: ModuleDescription {
			description = "Mission variables to be saved and loaded on the next mission start. To keep variables being saved, you must define this every mission.";
		};
	};

	class Module_Bax_Persist_RegisterPlayerVariables: Module_F {
		scope = 2;
		displayName = "Register Player Variables";
		// icon = "";
		category = "Bax_Persist";

		function = "bax_persist_fnc_moduleRegisterVariables";
		functionPriority = 20;
		isGlobal = 0;
		isTriggerActivated = 0;
		isDisposable = 0;
		class Attributes: AttributesBase {
			class SubCategoryVariable1 {
				data = "AttributeSystemSubcategory";
				control = "SubCategory";
				displayName = "Entry 1";
			};

			class Variable1: Edit {
				displayName = "Variable 1";
				tooltip = "Player Variable to be saved and loaded in the future. If empty, then do nothing.";
				property = "Bax_Persist_Variable1";
				defaultValue = "''";
			};

			class Bax_Persist_DefaultValue1 {
				control = "EditCodeMulti5";
                expression = "_this setVariable ['%s',_value,true];";
				displayName = "Default Value 1";
				tooltip = "Default value to be used if the player variable does not exist. This is a block of code, but does not need to return a value. NIL is a valid return value.";
				property = "Bax_Persist_DefaultValue1";
				defaultValue = "''";
			};

			class SubCategoryVariable2 {
				data = "AttributeSystemSubcategory";
				control = "SubCategory";
				displayName = "Entry 2";
			};

			class Variable2: Edit {
				displayName = "Variable 2";
				tooltip = "Player Variable to be saved and loaded in the future. If empty, then do nothing.";
				property = "Bax_Persist_Variable2";
				defaultValue = "''";
			};

			class Bax_Persist_DefaultValue2 {
				control = "EditCodeMulti5";
                expression = "_this setVariable ['%s',_value,true];";
				displayName = "Default Value 2";
				tooltip = "Default value to be used if the player variable does not exist. This is a block of code, but does not need to return a value. NIL is a valid return value.";
				property = "Bax_Persist_DefaultValue2";
				defaultValue = "''";
			};

			class SubCategoryVariable3 {
				data = "AttributeSystemSubcategory";
				control = "SubCategory";
				displayName = "Entry 3";
			};

			class Variable3: Edit {
				displayName = "Variable 3";
				tooltip = "Player Variable to be saved and loaded in the future. If empty, then do nothing.";
				property = "Bax_Persist_Variable3";
				defaultValue = "''";
			};

			class Bax_Persist_DefaultValue3 {
				control = "EditCodeMulti5";
                expression = "_this setVariable ['%s',_value,true];";
				displayName = "Default Value 3";
				tooltip = "Default value to be used if the player variable does not exist. This is a block of code, but does not need to return a value. NIL is a valid return value.";
				property = "Bax_Persist_DefaultValue3";
				defaultValue = "''";
			};

			class SubCategoryVariable4 {
				data = "AttributeSystemSubcategory";
				control = "SubCategory";
				displayName = "Entry 4";
			};

			class Variable4: Edit {
				displayName = "Variable 4";
				tooltip = "Player Variable to be saved and loaded in the future. If empty, then do nothing.";
				property = "Bax_Persist_Variable4";
				defaultValue = "''";
			};

			class Bax_Persist_DefaultValue4 {
				control = "EditCodeMulti5";
                expression = "_this setVariable ['%s',_value,true];";
				displayName = "Default Value 4";
				tooltip = "Default value to be used if the player variable does not exist. This is a block of code, but does not need to return a value. NIL is a valid return value.";
				property = "Bax_Persist_DefaultValue4";
				defaultValue = "''";
			};

			class SubCategoryVariable5 {
				data = "AttributeSystemSubcategory";
				control = "SubCategory";
				displayName = "Entry 5";
			};

			class Variable5: Edit {
				displayName = "Variable 5";
				tooltip = "Player Variable to be saved and loaded in the future. If empty, then do nothing.";
				property = "Bax_Persist_Variable5";
				defaultValue = "''";
			};

			class Bax_Persist_DefaultValue5 {
				control = "EditCodeMulti5";
                expression = "_this setVariable ['%s',_value,true];";
				displayName = "Default Value 5";
				tooltip = "Default value to be used if the player variable does not exist. This is a block of code, but does not need to return a value. NIL is a valid return value.";
				property = "Bax_Persist_DefaultValue5";
				defaultValue = "''";
			};

			class ModuleDescription: ModuleDescription {};
		};

		class ModuleDescription: ModuleDescription {
			description = "Player variables to be saved and loaded on the next mission start. To keep variables being saved, you must define this every mission.";
		};
	};

	class Module_Bax_Persist_RegisterObjectVariables: Module_F {
		scope = 2;
		displayName = "Register Object Variables";
		// icon = "";
		category = "Bax_Persist";

		function = "bax_persist_fnc_moduleRegisterVariables";
		functionPriority = 20;
		isGlobal = 0;
		isTriggerActivated = 0;
		isDisposable = 0;
		class Attributes: AttributesBase {
			class SubCategoryVariable1 {
				data = "AttributeSystemSubcategory";
				control = "SubCategory";
				displayName = "Entry 1";
			};

			class Variable1: Edit {
				displayName = "Variable 1";
				tooltip = "Object Variable to be saved and loaded in the future. If empty, then do nothing.";
				property = "Bax_Persist_Variable1";
				defaultValue = "''";
			};

			class Bax_Persist_DefaultValue1 {
				control = "EditCodeMulti5";
                expression = "_this setVariable ['%s',_value,true];";
				displayName = "Default Value 1";
				tooltip = "Default value to be used if the object variable does not exist. This is a block of code, but does not need to return a value. NIL is a valid return value.";
				property = "Bax_Persist_DefaultValue1";
				defaultValue = "''";
			};

			class SubCategoryVariable2 {
				data = "AttributeSystemSubcategory";
				control = "SubCategory";
				displayName = "Entry 2";
			};

			class Variable2: Edit {
				displayName = "Variable 2";
				tooltip = "Object Variable to be saved and loaded in the future. If empty, then do nothing.";
				property = "Bax_Persist_Variable2";
				defaultValue = "''";
			};

			class Bax_Persist_DefaultValue2 {
				control = "EditCodeMulti5";
                expression = "_this setVariable ['%s',_value,true];";
				displayName = "Default Value 2";
				tooltip = "Default value to be used if the object variable does not exist. This is a block of code, but does not need to return a value. NIL is a valid return value.";
				property = "Bax_Persist_DefaultValue2";
				defaultValue = "''";
			};

			class SubCategoryVariable3 {
				data = "AttributeSystemSubcategory";
				control = "SubCategory";
				displayName = "Entry 3";
			};

			class Variable3: Edit {
				displayName = "Variable 3";
				tooltip = "Object Variable to be saved and loaded in the future. If empty, then do nothing.";
				property = "Bax_Persist_Variable3";
				defaultValue = "''";
			};

			class Bax_Persist_DefaultValue3 {
				control = "EditCodeMulti5";
                expression = "_this setVariable ['%s',_value,true];";
				displayName = "Default Value 3";
				tooltip = "Default value to be used if the object variable does not exist. This is a block of code, but does not need to return a value. NIL is a valid return value.";
				property = "Bax_Persist_DefaultValue3";
				defaultValue = "''";
			};

			class SubCategoryVariable4 {
				data = "AttributeSystemSubcategory";
				control = "SubCategory";
				displayName = "Entry 4";
			};

			class Variable4: Edit {
				displayName = "Variable 4";
				tooltip = "Object Variable to be saved and loaded in the future. If empty, then do nothing.";
				property = "Bax_Persist_Variable4";
				defaultValue = "''";
			};

			class Bax_Persist_DefaultValue4 {
				control = "EditCodeMulti5";
                expression = "_this setVariable ['%s',_value,true];";
				displayName = "Default Value 4";
				tooltip = "Default value to be used if the object variable does not exist. This is a block of code, but does not need to return a value. NIL is a valid return value.";
				property = "Bax_Persist_DefaultValue4";
				defaultValue = "''";
			};

			class SubCategoryVariable5 {
				data = "AttributeSystemSubcategory";
				control = "SubCategory";
				displayName = "Entry 5";
			};

			class Variable5: Edit {
				displayName = "Variable 5";
				tooltip = "Object Variable to be saved and loaded in the future. If empty, then do nothing.";
				property = "Bax_Persist_Variable5";
				defaultValue = "''";
			};

			class Bax_Persist_DefaultValue5 {
				control = "EditCodeMulti5";
                expression = "_this setVariable ['%s',_value,true];";
				displayName = "Default Value 5";
				tooltip = "Default value to be used if the object variable does not exist. This is a block of code, but does not need to return a value. NIL is a valid return value.";
				property = "Bax_Persist_DefaultValue5";
				defaultValue = "''";
			};

			class ModuleDescription: ModuleDescription {};
		};

		class ModuleDescription: ModuleDescription {
			description = "Object variables to be saved and loaded on the next mission start. To keep variables being saved, you must define this every mission.";
		};
	};

	class Module_Bax_Persist_SpawnAreaWhitelist: Module_F {
		scope = 2;
		displayName = "Spawn Area: Whitelist";
		// icon = "";
		category = "Bax_Persist";

		function = "bax_persist_fnc_moduleSpawnAreaWhitelist";
		functionPriority = 20;
		isGlobal = 0;
		isTriggerActivated = 0;
		isDisposable = 0;

		canSetArea = 1;
		canSetAreaShape = 1;
		camSetAreaHeight = 1;
		class AttributeValues {
			size3[] = { 100, 100, -1 };
			isRectangle = 0;
		};

		class Attributes: AttributesBase {

			class ModuleDescription: ModuleDescription {};
		};

		class ModuleDescription: ModuleDescription {
			description = "Whitelists an area for players to spawn back into. If they are not in this area when they load their persistence data, teleport them to any synced objects or whitelist teleport areas. If no teleport areas exist, the module is used instead. Multiple of these can be used.";
		};
	};

	class Module_Bax_Persist_SpawnAreaTeleport: Module_F {
		scope = 2;
		displayName = "Spawn Area: Teleport";
		// icon = "";
		category = "Bax_Persist";

		function = "bax_persist_fnc_moduleSpawnAreaTeleport";
		functionPriority = 20;
		isGlobal = 0;
		isTriggerActivated = 0;
		isDisposable = 0;

		class Attributes: AttributesBase {
			class Bax_Persist_Radius: Edit {
				displayName = "Teleport Radius";
				tooltip = "Radius of area that player can be moved to. Min: 5 | Max: 100";
				property = "Bax_Persist_Radius";
				defaultValue = "5";
				typeName = "NUMBER";
			};

			class ModuleDescription: ModuleDescription {};
		};

		class ModuleDescription: ModuleDescription {
			description = "Areas to be teleported to when a player is not in a whitelist or is in a black list zone.";
		};
	};

	class Module_Bax_Persist_PersistentArea: Module_F {
		scope = 2;
		displayName = "Persistent Area";
		// icon = "";
		category = "Bax_Persist";

		function = "bax_persist_fnc_modulePersistentArea";
		functionPriority = 20;
		isGlobal = 0;
		isTriggerActivated = 0;
		isDisposable = 0;

		class Attributes: AttributesBase {
			
			class Bax_Persist_Radius: Edit {
				displayName = "Capture Radius";
				tooltip = "Radius of area that objects must be in to be saved. Min: 5 | Max: 100";
				property = "Bax_Persist_Radius";
				defaultValue = "25";
				typeName = "NUMBER";
			};

			class Bax_Persist_Vehicles: Checkbox {
				displayName = "Player Database";
				tooltip = "Enables loading of player data from previous sessions.";
				property = "Bax_Persist_LoadPlayerDatabase";
				defaultValue = "true";
			};

			class ModuleDescription: ModuleDescription {};
		};

		class ModuleDescription: ModuleDescription {
			description = "Creates an area where any objects in the zone will be saved.";
		};
	};

	class Curator_Bax_Persist_PersistentArea: Module_F {
		scope = 0;
		scopeCurator = 2;
		displayName = "Create Persistent Area";
		// icon = "";
		category = "Bax_Persist";

		function = "bax_persist_fnc_curatorPersistentArea";
		functionPriority = 20;
		isGlobal = 0;
		isTriggerActivated = 0;
		isDisposable = 0;

		class Attributes: AttributesBase {
			class ModuleDescription: ModuleDescription {};
		};

		class ModuleDescription: ModuleDescription {
			description = "Creates an area where any objects in the zone will be saved.";
		};
	}

	class Module_Bax_Persist_RegisterObject: Module_F {
		scope = 2;
		scopeCurator = 2;
		displayName = "Register Object";
		// icon = "";
		category = "Bax_Persist";

		function = "bax_persist_fnc_moduleRegisterObject";
		functionPriority = 20;
		isGlobal = 0;
		isTriggerActivated = 0;
		isDisposable = 0;

		class Attributes: AttributesBase {
			class Bax_Persist_ObjectDescription {
				title = "Object Persistence";
				property = "Bax_Persist_ObjectDescription";
				control = "SubCategoryDesc2";
				description = "Use this to override the data for a vehicle in the database. The object class will be overriden if the new object is different from the saved object. Damage also will not apply to the new object.";
				condition = "1 - objectControllable";
			};

			class Bax_Persist_ObjectId {
				displayName = "Object ID";
				tooltip = "The ID used to store and load the object information. If the object ID is already saved, this object is used. If the object is different from the original, everything besides damage and ammo is loaded.";
				property = "Bax_Persist_ObjectId";
				control = "Edit";
				expression = "_this setVariable ['%s', _value];";
				defaultValue = "''";
				unique = 1;
				validate = "none";
				condition = "1 - objectControllable";
				typeName = "STRING";
			};

			class Bax_Persist_ResetObjectPosition {
				displayName = "Reset Position";
				tooltip = "Resets the object's Position with the current position.";
				property = "Bax_Persist_ResetObjectPosition";
				control = "Checkbox";
				expression = "_this setVariable ['%s', _value];";
				defaultValue = "false";
				unique = 0;
				validate = "none";
				condition = "1 - objectControllable";
				typeName = "BOOL";
			};

			class Bax_Persist_ResetObjectInventory {
				displayName = "Reset Inventory";
				tooltip = "Resets the objects Inventory.";
				property = "Bax_Persist_ResetObjectInventory";
				control = "Checkbox";
				expression = "_this setVariable ['%s', _value];";
				defaultValue = "false";
				unique = 0;
				validate = "none";
				condition = "1 - objectControllable";
				typeName = "BOOL";
			};

			class Bax_Persist_ResetObjectDamage {
				displayName = "Reset Damage";
				tooltip = "Resets the object's Damage.";
				property = "Bax_Persist_ResetObjectDamage";
				control = "Checkbox";
				expression = "_this setVariable ['%s', _value];";
				defaultValue = "false";
				unique = 0;
				validate = "none";
				condition = "1 - objectControllable";
				typeName = "BOOL";
			};

			class Bax_Persist_ResetObjectFuel {
				displayName = "Reset Fuel";
				tooltip = "Resets the object's Fuel.";
				property = "Bax_Persist_ResetObjectFuel";
				control = "Checkbox";
				expression = "_this setVariable ['%s', _value];";
				defaultValue = "false";
				unique = 0;
				validate = "none";
				condition = "1 - objectControllable";
				typeName = "BOOL";
			};

			class Bax_Persist_ResetObjectAmmo {
				displayName = "Reset Ammo";
				tooltip = "Resets the object's Ammo.";
				property = "Bax_Persist_ResetObjectAmmo";
				control = "Checkbox";
				expression = "_this setVariable ['%s', _value];";
				defaultValue = "false";
				unique = 0;
				validate = "none";
				condition = "1 - objectControllable";
				typeName = "BOOL";
			};

			class ModuleDescription: ModuleDescription {};
		};

		class ModuleDescription: ModuleDescription {
			description = "Registers the synced object to be saved. Will load a saved object if one exists under the given ID. If the saved object is a different object type, then damage and ammo are not loaded. The primary purpose of this module is to reset the position or damage of a persisted object, but other options exist.";
		};
	};

	class Module_Bax_Persist_RegisterInventory: Module_F {
		scope = 2;
		displayName = "Register Inventory";
		// icon = "";
		category = "Bax_Persist";

		function = "bax_persist_fnc_moduleRegisterInventory";
		functionPriority = 20;
		isGlobal = 0;
		isTriggerActivated = 0;
		isDisposable = 0;

		class Attributes: AttributesBase {
			class Bax_Persist_InventoryDescription {
				title = "Inventory Persistence";
				property = "Bax_Persist_InventoryDescription";
				control = "SubCategoryDesc2";
				description = "The ID used to load and save an inventory. While you can use objects for storage, this is the ideal solution for player lockers or consistent storages that do not need extensive object persistence.";
				condition = "1 - objectControllable";
			};

			class Bax_Persist_InventoryId {
				displayName = "Inventory ID";
				tooltip = "The ID used to store and load the inventory information. The inventory is separate from the object, and only the inventory is saved when using inventory persistence.";
				property = "Bax_Persist_InventoryId";
				control = "Edit";
				expression = "_this setVariable ['%s', _value];";
				defaultValue = "''";
				unique = 1;
				validate = "none";
				condition = "1 - objectControllable";
				typeName = "STRING";
			};

			class Bax_Persist_ResetInventory {
				displayName = "Reset Inventory";
				tooltip = "Resets the saved inventory to the inventory of this object instead of loading a saved inventory.";
				property = "Bax_Persist_ResetInventory";
				control = "Checkbox";
				expression = "_this setVariable ['%s', _value];";
				defaultValue = "false";
				unique = 0;
				validate = "none";
				condition = "1 - objectControllable";
				typeName = "BOOL";
			};

			class ModuleDescription: ModuleDescription {};
		};

		class ModuleDescription: ModuleDescription {
			description = "Registers the synced object's inventory to be saved. Will load a saved inventory if one exists under the given ID.";
		};
	};

	class Module_Bax_Persist_SaveDatabse: Module_F {
		scope = 2;
		scopeCurator = 2;
		displayName = "Save Database";
		// icon = "";
		category = "Bax_Persist";

		function = "bax_persist_fnc_moduleSaveDatabase";
		functionPriority = 20;
		isGlobal = 0;
		isTriggerActivated = 1;
		isDisposable = 0;

		class Attributes: AttributesBase {
			class ModuleDescription: ModuleDescription {};
		};

		class ModuleDescription: ModuleDescription {
			description = "When placed in zeus, triggers a database save. The module can be placed in 3den, and synced to a trigger.";
		};
	};
};

class ctrlMenuStrip;
class display3DEN {
	class Controls {
		class MenuStrip: ctrlMenuStrip {
			class Items {
				class Tools {
					items[] += { "Bax_Persist_Folder" };
				};
				class Bax_Persist_Folder {
					text = "Persistence";
					items[] += { "Bax_Persist_LoadPreview", "Bax_Persist_OpenDBManager" };
				};
				class Bax_Persist_LoadPreview {
					text = "Load Saved Objects";
					picture = "";
					action = "['Load Persist Database Preview'] collect3DENHistory bax_persist_fnc_load3denPreview";
					opensNewWindow = 0;
				};
				class Bax_Persist_OpenDBManager {
					text = "Open Database Manager [TBD]";
					picture = "";
					action = "[] call bax_persist_fnc_openDBManager";
					opensNewWindow = 0;
				};
			};
		};
	};
};

class Cfg3DEN {
	class Object {
		class AttributeCategories {
			class Bax_Persist_Category {
				displayName = "Persist Options";
				collapsed = 1;
				class Attributes {
					class Bax_Persist_ExcludePlayer {
						displayName = "Exclude Player from Persist";
						tooltip = "If toggled, this player object will not load data on join and will not be saved. Useful for temporary roles like RP roles or mission specific roles.";
						property = "Bax_Persist_ExcludePlayer";
						control = "Checkbox";
						expression = "_this setVariable ['%s', _value, true];";
						defaultValue = "false";
						unique = 0;
						validate = "none";
						condition = "objectControllable";
						typeName = "BOOL";
					};
				};
			};
		};
	};
};
