
privateAll;

_allPlayers = allPlayers - (entities "HeadlessClient_F");
{
	_player = _x;
	_id = getPlayerUID _player;
	
	[_id, _player] call bax_persist_fnc_savePlayerToDatabase;
} forEach _allPlayers;