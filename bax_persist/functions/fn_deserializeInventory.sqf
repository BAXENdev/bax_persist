
params ["_object", "_inventory"];

clearItemCargoGlobal _object;
clearMagazineCargoGlobal _object;
clearWeaponCargoGlobal _object;
clearBackpackCargoGlobal _object;

_inventory params ["_items", "_magazines", "_weapons", "_backpacks", "_inventories"];

{
	_object addItemCargoGlobal _x;
} forEach _items;

{
	_x params ["_magClass", "_fullMags", "_overflow"];
	_object addMagazineCargoGlobal [_magClass, _fullMags];
	if (_overflow > 0) then {
		_object addMagazineAmmoCargo [_magClass, 1, _overflow];
	};
} forEach _magazines;

{
	_object addWeaponWithAttachmentsCargoGlobal _x;
} forEach _weapons;

{
	_object addBackpackCargoGlobal _x;
} forEach _backpacks;

private ["_sortedInventories", "_sortedContainers"];
_sortedContainers = [everyContainer _object, [], { _x select 0 }] call BIS_fnc_sortBy;
_sortedInventories = [_inventories, [], { _x select 0 }] call BIS_fnc_sortBy;

{
	_container = _x select 1;
	_inventory = _sortedInventories select _forEachIndex select 1;
	[_container, _inventory] call bax_persist_fnc_deserializeInventory;
} forEach _sortedContainers;
