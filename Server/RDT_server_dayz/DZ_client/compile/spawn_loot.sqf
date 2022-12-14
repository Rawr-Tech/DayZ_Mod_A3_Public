private["_iItem","_iClass","_iPos","_radius","_itemTypes","_index","_item","_qty","_max","_tQty","_canType","_weights","_cntWeights","_dateNow"];
_iItem = 	_this select 0;
_iClass = 	_this select 1;
_iPos =	_this select 2;
_radius =	_this select 3;

switch (_iClass) do {
	default {
		//Item is food, add random quantity of cans along with an item (if exists)
		_item = createVehicle ["groundWeaponHolder", _iPos, [], _radius, "CAN_COLLIDE"];

		_itemTypes = [] + ((getArray (configFile >> "cfgLoot" >> _iClass)) select 0);
		_index = dayz_CLBase find _iClass;
		_weights = dayz_CLChances select _index;
		_cntWeights = count _weights;
		_qty = 0;
		_max = ceil(random 2) + 1;
		while {_qty < _max} do {
			_tQty = round(random 1) + 1;
			_index = floor(random _cntWeights);
			_index = _weights select _index;
			_canType = _itemTypes select _index;
			_item addMagazineCargoGlobal [_canType,_tQty];
			_qty = _qty + _tQty;
		};
		if (_iItem != "") then {
			_item addWeaponCargoGlobal [_iItem,1];
		};
	};
	case "weapon": {
		//Item is a weapon, add it and a random quantity of magazines
		_item = createVehicle ["groundWeaponHolder", _iPos, [], _radius, "CAN_COLLIDE"];
		_item addWeaponCargoGlobal [_iItem,1];
		_mags = [] + getArray (configFile >> "cfgWeapons" >> _iItem >> "magazines");
		if ((count _mags) > 0) then {
			_MuzzleSlot = getArray (configFile >> "cfgWeapons" >> _iItem >> "WeaponSlotsInfo" >> "MuzzleSlot" >> "compatibleItems");
			_CowsSlot = getArray (configFile >> "cfgWeapons" >> _iItem >> "WeaponSlotsInfo" >> "CowsSlot" >> "compatibleItems");
			_PointerSlot = getArray (configFile >> "cfgWeapons" >> _iItem >> "WeaponSlotsInfo" >> "PointerSlot" >> "compatibleItems");
			_UnderBarrelSlot = getArray (configFile >> "cfgWeapons" >> _iItem >> "WeaponSlotsInfo" >> "UnderBarrelSlot" >> "compatibleItems");
			_attachments = _MuzzleSlot + _CowsSlot + _PointerSlot + _UnderBarrelSlot;
			_item additemCargoGlobal [(selectrandom _attachments), (round(random 1))];
			_item addMagazineCargoGlobal [(_mags select 0), (round(random 2))];
			
		};
	};
	case "magazine": {
		//Item is one magazine
		_item = createVehicle ["groundWeaponHolder", _iPos, [], _radius, "CAN_COLLIDE"];
		_item addMagazineCargoGlobal [_iItem,1];
	};
	case "item": {
		//Item is one magazine
		_item = createVehicle ["groundWeaponHolder", _iPos, [], _radius, "CAN_COLLIDE"];
		_item additemCargoGlobal [_iItem,1];
	};	
	case "uniform": {
		//Item is one magazine
		_item = createVehicle ["groundWeaponHolder", _iPos, [], _radius, "CAN_COLLIDE"];
		_item addbackpackCargoGlobal [_iItem,1];
	};		
	case "object": {
		//Item is one magazine
		_item = createVehicle [_iItem, _iPos, [], _radius, "CAN_COLLIDE"];
	};
};

// timestamp for later clearing
_dateNow = (DateToNumber date);
_item setVariable ["looted",_dateNow,true];

if ((count _iPos) > 2) then {
	_item setPosATL _iPos;
};