_spawnLocation = _this select 0;
_triggerPoint = _this select 1;
_radiusSearch = 15;

_dropMethod = selectRandom ["Air","Ground"];
_spawnPoint =[_spawnLocation#1,3000,5000,5,0,0.065,0,[],[]] call BIS_fnc_findSafePos;
if (_dropMethod isEqualTo "Ground") then
{
    _landingPoint =[_spawnLocation#1,1,_spawnLocation#2+100,_radiusSearch,0,0.3,0,[],[]] call BIS_fnc_findSafePos;
    while {(_landingPoint isEqualTo []) && (_radiusSearch > 0)} do
    {
        _radiusSearch = _radiusSearch - 1;
        _landingPoint =[_spawnLocation#1,1,_spawnLocation#2+100,_radiusSearch,0,0.3,0,[],[]] call BIS_fnc_findSafePos;
    };
    private _helipad = "Land_HelipadEmpty_F" createVehicle  _landingPoint;
    private _supgroup = [_spawnPoint,West,(configfile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> "BUS_InfSquad")] call BIS_fnc_spawnGroup;
    private _unitsCargo = units _supgroup;
    private _heli = createVehicle ["B_Heli_Transport_03_F",_spawnPoint, [], 0, "FLY"];
    createVehicleCrew _heli;
    _markerPoint = createMarker["Heli",_landingPoint];
    _markerPoint setMarkerShape "ELLIPSE";
    _markerPoint setMarkerSize[100,100];

    private _flares = {
        while {alive driver _this && {!(isTouchingGround _this)}} do {
            sleep 2;
            _this action ["useWeapon", _this, driver _this, 0];
        };
    };
    private _group = group driver _heli;
    _group addVehicle _heli;
    {_x setSkill ["courage", 1]} forEach units _group;
    _dir = _heli getDir _helipad;
    _heli setDir _dir;
    {_x moveInCargo _heli} forEach _unitsCargo;
    sleep 10;
    _heli domove _landingPoint;
    _heli flyinheight 100;
    waitUntil {
    sleep 1;
    (_heli distance _landingPoint) < 1700
    };
    _heli flyinheight 30;
    _heli spawn _flares;
    waitUntil {
    (_heli distance _landingPoint) < 200
    };
    dostop _heli;
    _heli flyinheight 7;
    _heli land "get out";
    _heli flyInHeight 0;
    waitUntil {isTouchingGround _heli};
    _supgroup leaveVehicle _heli;
    waitUntil {
    sleep 5;
    count (_unitsCargo select {alive _x && (!isNull objectParent _x)}) == 0
    };
    [_supgroup,_spawnLocation#1, triggerArea _triggerPoint select 0] call BIS_fnc_taskPatrol;
    _heli domove _spawnPoint;
    _heli flyinheight 50;
    waitUntil {
    (_heli distance _spawnLocation#1) > 1500
    };
    {deleteVehicle _x} forEach ((units group _heli) + [_heli]);
}
else
{
    private _supgroup = [_spawnPoint,West,(configfile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> "BUS_InfSquad")] call BIS_fnc_spawnGroup;
    private _unitsCargo = units _supgroup;
    private _heli = createVehicle ["B_Heli_Transport_03_F",_spawnPoint, [], 0, "FLY"];
    createVehicleCrew _heli;
    private _flares = {
        while {alive driver _this && {!(isTouchingGround _this)}} do {
            sleep 2;
            _this action ["useWeapon", _this, driver _this, 0];
        };
    };
    private _group = group driver _heli;
    _group addVehicle _heli;
    {_x setSkill ["courage", 1]} forEach units _group;
    _dir = _heli getDir _spawnLocation#1;
    _heli setDir _dir;
    {_x moveInCargo _heli} forEach _unitsCargo;
    sleep 10;
    _coords = _spawnLocation#1;

    _heli domove _coords;
    _waypointUpTrigger = _group addWaypoint [[_coords#0,_coords#1,_coords#2 + 50],0];
    _waypointUpTrigger setWaypointType "MOVE";
    _waypointExitTrigger = _group addWaypoint [[_coords#0 - (_spawnPoint#0 - _coords#0),_coords#1 - (_spawnPoint#1 - _coords#1),_coords#2],0];
    _waypointExitTrigger setWaypointType "MOVE";
    _heli flyinheight 200;
    waitUntil {
    sleep 1;
    (_heli distance _spawnLocation#1) < 1700
    };
    _heli spawn _flares;
    waitUntil {
    (_heli distance _spawnLocation#1) < 400
    };
    _heli domove [_coords#0 - (_spawnPoint#0 - _coords#0),_coords#1 - (_spawnPoint#1 - _coords#1),_coords#2];
    sleep 5;
    {
      removeBackpack _x;
      _x addBackpack "B_Parachute";
      [_x] ordergetin false;
      [_x] allowGetIn false;
      unassignvehicle _x;
      moveout _x;
      sleep 0.3;
    } forEach(units _supgroup);
    sleep 10;
    [_supgroup, _spawnLocation, triggerArea _triggerPoint # 0] call BIS_fnc_taskPatrol;
    _heli flyinheight 150;
    waitUntil {
    (_heli distance _spawnLocation#1) > 1500
    };
    {deleteVehicle _x} forEach ((units group _heli) + [_heli]);
};
