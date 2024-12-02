
if (is3DEN) exitWith {};

if !(isServer) exitWith {};

// Multiplayer only
addMissionEventHandler [
	"PlayerConnected",
	{
		// https://community.bistudio.com/wiki/getUserInfo
		params ["_directPlayId", "_steamId", "_name", "_jip", "_owner", "_idstr"];
		
		if !(bax_persist_loadPlayerDatabase) exitWith {};

		_scriptHandle = [str _directPlayId, _steamId] spawn {
			params ["_directPlayId", "_steamId"];

			_playerObject = objNull;
			waitUntil {
				_playerObject = _directPlayId getUserInfo 10;
				if (isNil "_playerObject") exitWith { // player disconnected before getting a player object
					terminate _thisScript;
				};
				!isNull _playerObject and { isPlayer _playerObject };
			};
			
			[_steamId, _playerObject] call bax_persist_fnc_loadPlayer;
		};
	}
];
// Singlerplayer. Player UID is _SP_PLAYER_
if (!isMultiplayer) then {
	[getPlayerUID player, player] call bax_persist_fnc_loadPlayer;
};


addMissionEventHandler [
	"HandleDisconnect",
	{
		params ["_player", "_id", "_steamId", "_name"];
		
		if !(bax_persist_loadPlayerDatabase) exitWith {};
		[_steamId, _player] call bax_persist_fnc_savePlayer;
	}
];

addMissionEventHandler [
	"Ended",
	{
		params ["_endType"];
		if (_endType isNotEqualTo "Bax_Persist_NoSave") then {
			[] call bax_persist_fnc_saveDatabase;
		};
	}
];

if (bax_persist_autosaveEnabled) then {
	[] call bax_persist_fnc_queueSaveDatabase;
};

[] call bax_persist_fnc_loadDatabaseObjects;
[] call bax_persist_fnc_loadDatabaseVariables;

["bax_persist_loadDatabase", []] call CBA_fnc_localEvent;
