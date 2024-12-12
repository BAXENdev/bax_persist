
{
	_id = _x;
	_y params ["_class", "_posDir", "_damage", "_fuel", "_pylons", "_ammo", "_inventory", "_variables", "_spawned"];

	if (_damage isEqualTo 1) then {
		bax_persist_databaseObjects deleteAt _id;
	};
} forEach bax_persist_databaseObjects;
