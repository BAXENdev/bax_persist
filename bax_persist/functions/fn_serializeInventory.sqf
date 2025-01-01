
// TODO: Mag packing breaks items that uses mag counts to store an "ID" for that item, such as ace intel items.

params ["_object"];

private ["_inventory", "_items", "_magazines", "_weapons", "_backpacks", "_inventories"];

_items = [];
_magazines = [];
_weapons = [];
_backpacks = [];
_inventories = [];
_inventory = [_items, _magazines, _weapons, _backpacks, _inventories];

// Items
(getItemCargo _object) params ["_itemList", "_itemCount"];
{
	_item = _x;
	_count = _itemCount select _forEachIndex;
	_items pushBack [_item, _count];
} forEach _itemList;

// Weapons
_weaponList = weaponsItemsCargo _object;
_weaponList sort true;
_weaponIndex = 0;
_weaponList apply {
	_x set [7, 1];
};
while { (((count _weaponList) - _weaponIndex) > 1) and (count _weaponList > 1) } do {
	_currentWeapon = _weaponList select _weaponIndex;
	_nextWeapon = _weaponList select (_weaponIndex + 1);

	_currentWeaponArray = _currentWeapon select [0, 7];
	_nextWeaponArray = _nextWeapon select [0, 7];
	if (_currentWeaponArray isEqualTo _nextWeaponArray) then {
		_weaponCount = _currentWeapon select 7;
		_currentWeapon set [7, _weaponCount + 1];
		_weaponList deleteAt (_weaponIndex + 1);
	} else {
		_weaponIndex = _weaponIndex + 1;
	};
};
_weaponList = _weaponList apply {
	[_x select [0, 7], _x select 7];
};
_weapons append _weaponList;

// Magazines
_magList = magazinesAmmoCargo _object;
_magClasses = _magList apply { _x select 0 };
_magClasses = _magClasses arrayIntersect _magClasses;
_magListTotals = _magClasses apply {
	_magClass = _x;
	_magMaxAmmo = getNumber (configFile >> "CfgMagazines" >> _magClass >> "count");
	_magAmmoCounts = _magList select { (_x select 0) isEqualTo _magClass } apply { _x select 1 };
	_magAmmoTotal = 0;
	{ _magAmmoTotal = _magAmmoTotal + _x } forEach _magAmmoCounts;
	_fullMags = floor (_magAmmoTotal / _magMaxAmmo);
	_overflow = _magAmmoTotal % _magMaxAmmo;
	// return
	[_magClass, _fullMags, _overflow];
};
_magazines append _magListTotals;

// Backpacks
(getBackpackCargo _object) params ["_itemList", "_itemCount"];
{
	_item = _x;
	_count = _itemCount select _forEachIndex;
	_backpacks pushBack [_item, _count];
} forEach _itemList;

private ["_containers", "_objectInventory"];
_containers = everyContainer _object;

_containers apply {
	_x params ["_class", "_object"];
	_objectInventory = [_object] call bax_persist_fnc_serializeInventory;
	_inventories pushBack [_class, _objectInventory];
};

// return
_inventory;
