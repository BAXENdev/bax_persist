
#include "\bax_persist\include.hpp"

if (is3DEN) exitWith {};

if !(isServer) exitWith {};

// TODO: Performance/lag issues if this is spawning too many vehicles? Server freezing into desync?

// How many times is this running?
// Multiplayer only
addMissionEventHandler [
	"PlayerConnected",
	{
		#ifdef DEBUG
		DLOG("Postinit-MP Load player");
		#endif
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

			["bax_persist_playerLoaded", [_playerObject]] call CBA_fnc_serverEvent;
		};
	}
];
// How many times is this running?
// Singlerplayer. Player UID is _SP_PLAYER_
if (!isMultiplayer and bax_persist_loadPlayerDatabase) then {
	#ifdef DEBUG
	DLOG("Postinit-SP Load player");
	#endif
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
		if !("persistnosave" in toLower _endType) then {
			[] call bax_persist_fnc_saveDatabase;
		};
	}
];

if (bax_persist_autosaveEnabled) then {
	[] call bax_persist_fnc_queueSaveDatabase;
};

if (bax_persist_cleanObjectDatabase) then {
	[] call bax_persist_fnc_cleanDatabaseObjects;
};
[] call bax_persist_fnc_loadDatabaseObjects;

["bax_persist_databaseLoaded", []] call CBA_fnc_serverEvent;

missionNamespace setVariable ["bax_persist_databaseLoaded", true, true];
