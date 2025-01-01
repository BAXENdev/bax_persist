
params ["_object"];

[_object] remoteExec ["bax_persist_fnc_registerObjectRandom", 2];

// _editBoxObjectId = [
// 	"EDIT",
// 	["Object ID", "The ID that the object is saved under. Must be unique."],
// 	[
// 		"",
// 		{ params ["_inputText"]; _inputText; }
// 	],
// 	true
// ];

// _checkBoxRandomId = [
// 	"CHECKBOX",
// 	["Use Random ID", "Creates a unique random ID"],
// 	false,
// 	false
// ];

// [
// 	"Register Object",
// 	[_editBoxObjectId, _checkBoxRandomId],
// 	{
// 		params ["_dialogValues","_args"];
// 		_dialogValues params ["_objectId", "_useRandomId"];
// 		_args params ["_object"];

		

		
// 	},
// 	{}, 
// 	[_object]
// ] call zen_dialog_fnc_create;
