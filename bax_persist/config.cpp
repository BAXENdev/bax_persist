
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
				displayName = "Player Persistence Settings";
			};

			class EnableSaving: Checkbox {
				displayName = "Saving Enabled";
				tooltip = "Enables saving the mission. All 3den instances do not allow saving the database.";
				property = "Bax_Persist_EnableSaving";
				defaultValue = "true";
			};

			class AutosaveTimer: Edit {
				displayName = "Autosave Timer";
				tooltip = "How often autosaving occurs. min=15 | max=120 in minutes.";
				property = "Bax_Persist_AutosaveTimer";
				defaultValue = "40";
				typeName = "NUMBER";
			};

			class EnableAutosave: Checkbox {
				displayName = "Enable Autosave";
				tooltip = "Enables Autosaving";
				property = "Bax_Persist_EnableAutosave";
				defaultValue = "true";
			};

			// TODO: Combo box for selecting namespace. Do I offer profileNamespace?

			class SubCategoryPlayer {
				data = "AttributeSystemSubcategory";
				control = "SubCategory";
				displayName = "Player Persistence Settings";
			};

			class EnablePlayerDB: Checkbox {
				displayName = "Player Database";
				tooltip = "Enables loading of player data from previous sessions.";
				property = "Bax_Persist_LoadPlayerDatabase";
				defaultValue = "true";
			};

			class EnablePlayerPosition: Checkbox {
				displayName = "Player Position";
				tooltip = "Whether or not to load player's previous position";
				property = "Bax_Persist_LoadPlayerPosition";
				defaultValue = "true";
			};

			class EnablePlayerMedical: Checkbox {
				displayName = "Player Medical";
				tooltip = "Whether or not to load player's previous medical state. Does not stop loading a dead player.";
				property = "Bax_Persist_LoadPlayerMedical";
				defaultValue = "true";
			};

			class EnablePlayerKeySide: Checkbox {
				displayName = "Side Keying";
				tooltip = "Player data is saved based on their side. Enabling side keying at later date will not load the previous un-sided data.";
				property = "Bax_Persist_LoadPlayerKeySide";
				defaultValue = "false";
			};

			class EnablePlayerKeyRole: Checkbox {
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

			class EnableObjectDB: Checkbox {
				displayName = "Object Database";
				tooltip = "Enables loading of object data from previous sessions.";
				property = "Bax_Persist_LoadObjectDatabase";
				defaultValue = "true";
			};

			class EnableObjectDamage: Checkbox {
				displayName = "Object Damage";
				tooltip = "Whether or not to load an object's damage from previous session.";
				property = "Bax_Persist_LoadObjectDamage";
				defaultValue = "true";
			};

			class EnableObjectFuel: Checkbox {
				displayName = "Object Fuel";
				tooltip = "Whether or not to load an object's fuel from previous session.";
				property = "Bax_Persist_LoadObjectFuel";
				defaultValue = "true";
			};

			class EnableObjectAmmo: Checkbox {
				displayName = "Object Ammo";
				tooltip = "Whether or not to load an object's ammo from previous session.";
				property = "Bax_Persist_LoadObjectAmmo";
				defaultValue = "true";
			};

			class SubCategoryVariables {
				data = "AttributeSystemSubcategory";
				control = "SubCategory";
				displayName = "Variables Persistence Settings";
			};

			class EnableVariablesDB: Checkbox {
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

	class Module_Bax_Persist_RegisterObject: Module_F {
		scope = 2;
		displayName = "Register Object";
		// icon = "";
		category = "Bax_Persist";

		function = "bax_persist_fnc_moduleRegisterObject";
		functionPriority = 20;
		isGlobal = 0;
		isTriggerActivated = 0;
		isDisposable = 0;
		class Attributes: AttributesBase {
			class ObjectID: Edit {
				displayNAme = "Object ID";
				tooltip = "Unique ID that is used for saving and loading an object. If a persistent object with this ID already exists, this ""loads"" the object and prevents it from being loaded a second time.";
				property = "Bax_Persist_ObjectId";
				defaultValue = "''";
			};

			class ResetPosition: Checkbox {
				displayName = "Reset Position";
				tooltip = "Do not load the object's position from the object database.";
				property = "Bax_Persist_ResetPosition";
				defaultValue = "false";
			};

			class ResetInventory: Checkbox {
				displayName = "Reset Inventory";
				tooltip = "Do not load the object's inventory from the object database.";
				property = "Bax_Persist_ResetInventory";
				defaultValue = "false";
			};

			class ResetDamage: Checkbox {
				displayName = "Reset Damage";
				tooltip = "Do not load the object's damage from the object database.";
				property = "Bax_Persist_ResetDamage";
				defaultValue = "false";
			};

			class ResetFuel: Checkbox {
				displayName = "Reset Fuel";
				tooltip = "Do not load the object's fuel from the object database. Does not apply for anything that does not have fuel.";
				property = "Bax_Persist_ResetFuel";
				defaultValue = "false";
			};

			class ResetAmmo: Checkbox {
				displayName = "Reset Ammo";
				tooltip = "Do not load the object's ammo from the object database. Pylons are still loaded, but all default mags are left in the vehicle.";
				property = "Bax_Persist_ResetAmmo";
				defaultValue = "false";
			};

			class ModuleDescription: ModuleDescription {};
		};

		class ModuleDescription: ModuleDescription {
			description = "Register this object for saving. Does not work with units. You can safely reuse this on an added object from a previous mission. The options here allow you adjust some of the recorded data for the object, such as resetting the position can be used to bring a vehicle back to base.";
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
			class InventoryID: Edit {
				displayNAme = "Inventory ID";
				tooltip = "Unique ID that is used for saving and loading an inventory.";
				property = "Bax_Persist_InventoryId";
				defaultValue = "''";
			};

			class ResetInventory: Checkbox {
				displayName = "Reset Inventory";
				tooltip = "Instead of loading the inventory from the database, set the saved inventory to the inventory of the object. Does nothing if there is no record for the given ID yet.";
				property = "Bax_Persist_ResetInventory";
				defaultValue = "false";
			};

			class ModuleDescription: ModuleDescription {};
		};

		class ModuleDescription: ModuleDescription {
			description = "Register this object's inventory for saving under a unique ID. This does not save this object. Useful for saving and loading a player locker or similar systems. This module is included mainly for convenience as the inventory database is designed to be used by scripts rather than this module.";
		};
	};

	class Module_Bax_Persist_RegisterVariable: Module_F {
		scope = 2;
		displayName = "Register Variables";
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
				tooltip = "MissionNamespace Variable to be saved and loaded in the future. If empty, then do nothing.";
				property = "Bax_Persist_Variable1";
				defaultValue = "''";
			};

			class DefaultValue1: Edit {
				displayName = "Default Value 1";
				tooltip = "Default value to be used if the mission namespace variable does not exist. Use 'nil' to disable default value.";
				property = "Bax_Persist_DefaultValue1";
				defaultValue = "'nil'";
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

			class DefaultValue2: Edit {
				displayName = "Default Value 2";
				tooltip = "Default value to be used if the mission namespace variable does not exist. Use 'nil' to disable default value.";
				property = "Bax_Persist_DefaultValue2";
				defaultValue = "'nil'";
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

			class DefaultValue3: Edit {
				displayName = "Default Value 3";
				tooltip = "Default value to be used if the mission namespace variable does not exist. Use 'nil' to disable default value.";
				property = "Bax_Persist_DefaultValue3";
				defaultValue = "'nil'";
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

			class DefaultValue4: Edit {
				displayName = "Default Value 4";
				tooltip = "Default value to be used if the mission namespace variable does not exist. Use 'nil' to disable default value.";
				property = "Bax_Persist_DefaultValue4";
				defaultValue = "'nil'";
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

			class DefaultValue5: Edit {
				displayName = "Default Value 5";
				tooltip = "Default value to be used if the mission namespace variable does not exist. Use 'nil' to disable default value.";
				property = "Bax_Persist_DefaultValue5";
				defaultValue = "'nil'";
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

			class DefaultValue1: Edit {
				displayName = "Default Value 1";
				tooltip = "Default value to be used if the player variable does not exist. Use 'nil' to disable default value.";
				property = "Bax_Persist_DefaultValue1";
				defaultValue = "'nil'";
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

			class DefaultValue2: Edit {
				displayName = "Default Value 2";
				tooltip = "Default value to be used if the player variable does not exist. Use 'nil' to disable default value.";
				property = "Bax_Persist_DefaultValue2";
				defaultValue = "'nil'";
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

			class DefaultValue3: Edit {
				displayName = "Default Value 3";
				tooltip = "Default value to be used if the player variable does not exist. Use 'nil' to disable default value.";
				property = "Bax_Persist_DefaultValue3";
				defaultValue = "'nil'";
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

			class DefaultValue4: Edit {
				displayName = "Default Value 4";
				tooltip = "Default value to be used if the player variable does not exist. Use 'nil' to disable default value.";
				property = "Bax_Persist_DefaultValue4";
				defaultValue = "'nil'";
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

			class DefaultValue5: Edit {
				displayName = "Default Value 5";
				tooltip = "Default value to be used if the player variable does not exist. Use 'nil' to disable default value.";
				property = "Bax_Persist_DefaultValue5";
				defaultValue = "'nil'";
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

			class DefaultValue1: Edit {
				displayName = "Default Value 1";
				tooltip = "Default value to be used if the object variable does not exist. Use 'nil' to disable default value.";
				property = "Bax_Persist_DefaultValue1";
				defaultValue = "'nil'";
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

			class DefaultValue2: Edit {
				displayName = "Default Value 2";
				tooltip = "Default value to be used if the object variable does not exist. Use 'nil' to disable default value.";
				property = "Bax_Persist_DefaultValue2";
				defaultValue = "'nil'";
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

			class DefaultValue3: Edit {
				displayName = "Default Value 3";
				tooltip = "Default value to be used if the object variable does not exist. Use 'nil' to disable default value.";
				property = "Bax_Persist_DefaultValue3";
				defaultValue = "'nil'";
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

			class DefaultValue4: Edit {
				displayName = "Default Value 4";
				tooltip = "Default value to be used if the object variable does not exist. Use 'nil' to disable default value.";
				property = "Bax_Persist_DefaultValue4";
				defaultValue = "'nil'";
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

			class DefaultValue5: Edit {
				displayName = "Default Value 5";
				tooltip = "Default value to be used if the object variable does not exist. Use 'nil' to disable default value.";
				property = "Bax_Persist_DefaultValue5";
				defaultValue = "'nil'";
			};

			class ModuleDescription: ModuleDescription {};
		};

		class ModuleDescription: ModuleDescription {
			description = "Object variables to be saved and loaded on the next mission start. To keep variables being saved, you must define this every mission.";
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
					action = "[] call bax_persist_fnc_load3denPreview";
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
