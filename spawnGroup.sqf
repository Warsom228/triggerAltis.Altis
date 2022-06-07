_Spawntarget = player;
_Spawndistance = 400;
_Deletedistance = 2000;
_Spawngroups = [(configfile >> "CfgGroups" >> "West" >> "BLU_CTRG_F" >> "Infantry" >> "CTRG_InfSquad"),
(configfile >> "CfgGroups" >> "West" >> "BLU_CTRG_F" >> "Infantry" >> "CTRG_InfTeam"),
(configfile >> "CfgGroups" >> "West" >> "BLU_CTRG_F" >> "Motorized" >> "CTRG_MotInf_ReconTeam")
];

_Spawnmaxdelay =40;
_Spawnmindelay =60;
_Spawnside = OPFOR;


_AISkills1 = [["aimingAccuracy", 0.5],
 ["aimingShake", 0.5],
 ["aimingSpeed", 0.5],
 ["endurance", 0.5],
 ["spotDistance", 0.5],
 ["spotTime", 0.5],
 ["courage", 1],
 ["reloadSpeed", 0.5],
 ["commanding", 1],
 ["general", 0.7]
];

_AISkills2 = [["aimingAccuracy", 1],
 ["aimingShake", 1],
 ["aimingSpeed", 1],
 ["endurance", 1],
 ["spotDistance", 1],
 ["spotTime", 1],
 ["courage", 1],
 ["reloadSpeed", 1],
 ["commanding", 1],
 ["general", 1]
];

_AISkills3 = [["aimingAccuracy", 0.2],
 ["aimingShake", 0.2],
 ["aimingSpeed", 0.2],
 ["endurance", 0.5],
 ["spotDistance", 0.5],
 ["spotTime", 0.5],
 ["courage", 1],
 ["reloadSpeed", 0.5],
 ["commanding", 1],
 ["general", 0.5]
];

while {true} do {
 sleep 10;
 _AISkills = selectrandom([_AISkills1,_AISkills2,_AISkills3]);
 _SpawnPosistion = _Spawntarget getRelPos [_Spawndistance, round random 360];
 _NewGroup = [_SpawnPosistion, _Spawnside , _Spawngroups select (floor (random (count _Spawngroups)))] call BIS_fnc_spawnGroup;

 _NewGroup setVariable ["spawned",true];

 {
  _EditUnit = _x;
  {_EditUnit setSkill _x;} forEach _AISkills;
 } forEach units _NewGroup;

 _NewGroup setBehaviour "AWARE";
 _NewGroup setSpeedMode "FULL";
 _NewGroup setCombatMode "RED";

 _GroupWayPoint = _NewGroup addWaypoint [position _Spawntarget, 0];
 _GroupWayPoint setWaypointType "MOVE";

 {
  _EditGroup = _x;
  for "_i" from count waypoints _EditGroup - 1 to 0 step -1 do  { deleteWaypoint [_EditGroup, _i];};
  _NewGroupWayPoint = _EditGroup addWaypoint [position _Spawntarget, 0];
  _NewGroupWayPoint setWaypointType "MOVE";
  {
   if ((_Spawntarget distance _x)> _Deletedistance) then {deleteVehicle _x;};
  } forEach units _EditGroup;
 } foreach (allGroups select {side _x == _Spawnside && (_x getVariable ["spawned",true])});
 sleep selectrandom([_Spawnmaxdelay,_Spawnmindelay]);
};
