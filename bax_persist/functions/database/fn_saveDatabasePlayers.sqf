
_allPlayers = allPlayers - (entities "HeadlessClient_F");
{
	_player = _x;
	_steamId = getPlayerUID _player;
	
	[_steamId, _player] call bax_persist_fnc_savePlayer;
} forEach _allPlayers;