private["_unit","_selection","_strH","_damage","_total"];
_unit =			_this select 0;
_selection =	_this select 1;
_damage =		_this select 2;

if (_selection != "" and local _unit) then {
	_strH = "hit_" + (_selection);
	_unit setHit[_selection,_damage];
	//player sidechat str _damage;
	_unit setVariable [_strH,_damage,true];
	if (_damage == 0) then {
		//["dayzUpdateVehicle",[_unit,"repair"]] call callRpcProcedure;
		[_unit,"repair"] remoteexec ["server_updateObject",2];
	} else {
		//["dayzUpdateVehicle",[_unit,"damage"]] call callRpcProcedure;
		[_unit,"damage"] remoteexec ["server_updateObject",2];
	};
};