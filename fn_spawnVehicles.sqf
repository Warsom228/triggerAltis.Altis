_trgPos = _this # 0;
_trgParams = _this # 1;
_triggerPoint = _this # 2;

_tanks = 0; // Счётчики
_AA = 0;
_hunters = 0;
_prowlers = 0;
_carriers = 0;

_arrDrivers = [];
_arrGroups = []; // Массив групп
for [{ _i = 0 }, { _i < 6 }, { _i }] do // Спавним до 6 техники
    {switch (selectRandom [ "tanks", "AA", "hunters", "prowlers", "carriers" ]) do { // Выбираем рандомный класс техники
        case "tanks": {
            if (_tanks < 3) then { // Проверка на количество техники одного класса
                _type = selectRandom ["B_MBT_01_cannon_F", "B_MBT_01_TUSK_F"]; // Выбираем рандомную технику данного класса
                for [{ _j = 0 }, { _j < 1000 }, { _j = _j + 1 }] do { // 360 итераций
                    _pos = [ _trgPos, _trgParams ] call trg_fnc_findTrgRandPos;     // Находим рандомную точку в триггере
                    if !( _pos isFlatEmpty [4, -1, 60 * (pi / 180), 5, 0, false, objNull] isEqualTo [] )
                        exitWith {
                            _veh = [_pos, random 360, _type, blufor] call BIS_fnc_spawnVehicle;
                            _arrGroups pushBack (_veh # 2);
                            _arrDrivers pushBack (group driver (_veh # 0));
                            _tanks = _tanks + 1;
                            _i = _i + 1;
                    };
                };
            };
        };
        case "AA": {
            if (_AA < 3) then {
                for [{ _j = 0 }, { _j < 1000 }, { _j = _j + 1 }] do {

                    _pos = [ _trgPos, _trgParams ] call trg_fnc_findTrgRandPos;

                    if !( _pos isFlatEmpty [4, -1, 60 * (pi / 180), 5, 0, false, objNull] isEqualTo [] )
                        exitWith {
                            _veh = [_pos, random 360, "B_APC_Tracked_01_AA_F", blufor] call BIS_fnc_spawnVehicle;
                            _arrGroups pushBack (_veh # 2);
                            _arrDrivers pushBack (group driver (_veh # 0));
                            _AA = _AA + 1;
                            _i = _i + 1;
                    };
                };
            };
        };
        case "hunters": {
            if (_hunters < 3) then {
                _type = selectRandom ["B_MRAP_01_gmg_F", "B_MRAP_01_hmg_F"];
                for [{ _j = 0 }, { _j < 1000 }, { _j = _j + 1 }] do {

                    _pos = [ _trgPos, _trgParams ] call trg_fnc_findTrgRandPos;

                    if !( _pos isFlatEmpty [4, -1, 60 * (pi / 180), 5, 0, false, objNull] isEqualTo [] )
                        exitWith {
                            _veh = [_pos, random 360, _type, blufor] call BIS_fnc_spawnVehicle;
                            _arrGroups pushBack (_veh # 2);
                            _arrDrivers pushBack (group driver (_veh # 0));
                            _hunters = _hunters + 1;
                            _i = _i + 1;
                    };
                };
            };
        };
        case "prowlers": {
            if (_prowlers < 3) then {
                _type = selectRandom ["B_LSV_01_AT_F", "B_LSV_01_armed_F"];
                for [{ _j = 0 }, { _j < 1000 }, { _j = _j + 1 }] do {

                    _pos = [ _trgPos, _trgParams ] call trg_fnc_findTrgRandPos;

                    if !( _pos isFlatEmpty [4, -1, 60 * (pi / 180), 5, 0, false, objNull] isEqualTo [] )
                        exitWith {
                            _veh = [_pos, random 360, _type, blufor] call BIS_fnc_spawnVehicle;
                            _arrGroups pushBack (_veh # 2);
                            _arrDrivers pushBack (group driver (_veh # 0));
                            _prowlers = _prowlers + 1;
                            _i = _i + 1;
                    };
                };
            };
        };
        case "carriers": {
            if (_carriers < 3) then {
                _type = selectRandom ["B_APC_Wheeled_01_cannon_F", "B_APC_Tracked_01_rcws_F", "B_APC_Tracked_01_CRV_F"];
                for [{ _j = 0 }, { _j < 1000 }, { _j = _j + 1 }] do {

                    _pos = [ _trgPos, _trgParams ] call trg_fnc_findTrgRandPos;

                    if !( _pos isFlatEmpty [4, -1, 60 * (pi / 180), 5, 0, false, objNull] isEqualTo [] )
                        exitWith {
                            _veh = [_pos, random 360, _type, blufor] call BIS_fnc_spawnVehicle;
                            _arrGroups pushBack (_veh # 2);
                            _arrDrivers pushBack (group driver (_veh # 0));
                            _carriers = _carriers + 1;
                            _i = _i + 1;
                    };
                };
            };
        };
    };
};
{ { [ _x, 0,8 ] call trg_fnc_setSkill; } forEach (units (_arrGroups # _forEachIndex)) } forEach _arrGroups;      // Задаём скилл группам
{ [_x, _trgPos, triggerArea _triggerPoint # 0] call BIS_fnc_taskPatrol;} forEach  _arrDrivers;   // Задаём вейпоинты группам
_arrGroups;
