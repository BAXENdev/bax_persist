
_logic = _this param [0,objnull,[objnull]];
_units = _this param [1,[],[[]]];
_activated = _this param [2,true,[true]];

if (_activated) then {
	if (is3DEN or is3DENMultiplayer or is3denPreview) exitWith {
		[] spawn {
			if (["Saving in 3den Context: Are you sure?"] call BIS_fnc_guiMessage) then {
				[true] remoteExec ["bax_persist_fnc_saveDatabase", 2];
			};
		};
	};
	[] remoteExec ["bax_persist_fnc_saveDatabase", 2];
};

#ifdef DEBUG
#else
deleteVehicle _logic;
#endif
true;
