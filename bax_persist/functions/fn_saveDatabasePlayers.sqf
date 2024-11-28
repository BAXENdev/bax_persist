
private ["_allPlayers", "_player", "_id", "_sideRole", "_loadout", "_posDir", "_medical", "_variables", "_variable", "_value", "_defaultValue"];

_allPlayers = allPlayers - (entities "HeadlessClient_F");
{
	_player = _x;
	_id = getPlayerUID _player;
	
	if !(alive _player) then {
		// TODO: Do something else?
		// Store stuff, but indicate dead?
		// variables are persistant through respawn, so shouldnt they still be saved?
		// Could store _medical as "dead" and check it. If dead, then dont update loadout or pos
		bax_persist_databasePlayers set [_id, false];
		continue;
	};
	
	_sideRole = [side group _player, roleDescription _player];
	_loadout = getUnitLoadout _player;
	_traits = [
		_player getVariable ["ace_medical_medicClass", 0],
		_player getVariable ["ACE_isEngineer", 0]
	];
	_posDir = [getPos _player, getDir _player];
	_medical = [_player] call ace_medical_fnc_serializeState;
	_variables = [];
	{
		_x params ["_variable", "_defaultValue"];
		_value = _player getVariable [_variable, _defaultValue];
		if !(isNil "_value") exitWith {
			_variables pushBack [_variable, _value];
		};
	} forEach bax_persist_registeredPlayerVariables;

	bax_persist_databasePlayers set [
		_id,
		[
			_sideRole,
			_loadout,
			_traits,
			_posDir,
			_medical,
			_variables
		]
	];
} forEach _allPlayers;

// return copy
+bax_persist_databasePlayers;
