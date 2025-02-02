
params ["_logic"];

_sliderRadius = [
	"SLIDER:RADIUS",
	"Persistent Radius",
	[
		// 0) Minimum Value
		5,
		// 1) Maximum Value
		100,
		// 2) Default Value
		20,
		// 3) Formatting, NUMBER or CODE.
		0,
		// 4) Radius Center, OBJECT or ARRAY (AGL Position)
		[0, 0, 0],
		// 5) Radius Color RGBA
		[1, 0, 0, 1]
	],
	// 3) Force Default, default: false
	false
];

_checkBoxAllVehicles = [
	"CHECKBOX",
	["Vehicles", "All vehicles."],
	true,
	false
];

_checkBoxReammoBox = [
	"CHECKBOX",
	["Ammo Boxes", "Toggle's reammo box objects for saving. Ammo boxes and inventory objects are their own type of objects."],
	true,
	false
];

_checkBoxWeaponHolder = [
	"CHECKBOX",
	["Weapon Holders", "All ground item holders"],
	true,
	false
];

_checkBoxStatics  = [
	"CHECKBOX",
	["Statics and Things", "This covers most buildings and decorations. Even some unexpected objects, so use with caution."],
	false,
	false
];

[
	"Create Persistent Area",
	[
		_sliderRadius,
		_checkBoxAllVehicles,
		_checkBoxReammoBox,
		_checkBoxWeaponHolder,
		_checkBoxStatics
	],
	// 2) On Confirm, unscheduled
	{
		params ["_dialogValues","_args"];
		_dialogValues params ["_radius", ["_allVehicles", false], ["_reammoBox", false], ["_weaponHolderXX", false], ["_statics", false]];
		_args params ["_logic"];

		[_logic, _radius, _allVehicles, _reammoBox, _weaponHolderXX, _statics] remoteExec ["bax_persist_fnc_addPersistentArea", 2];
	},
	{
		params ["_dialogValues", "_args"];
		_args params ["_logic"];
		deleteVehicle _logic;
	},
	// 4) Arguments, default: []
	[_logic]
] call zen_dialog_fnc_create;
