_units = ["B_Soldier_TL_F", "B_Medic_F", "B_Soldier_TL_F", "B_HeavyGunner_F", "B_Soldier_AT_F", "B_soldier_TL_F", "B_soldier_AAR_F"];    // Массив пехов
_trgPos = _this # 0;     // Позиция триггера
_trgParams = _this # 1;      // Параметры триггера (пока не используется)
_pos = [];
_houses = nearestObjects [[_trgPos # 0, _trgPos # 1], ["House"], 300];
{
    _c = 0;
    while {(format ["%1",_x buildingPos _c] != "[0,0,0]") && (_c < 2)} do {
        _pos set [(count _pos),[_x,_x buildingPos _c]];
        _c = _c + 1;
    };
} forEach _houses;     // Переделать под овальные триггеры

_unitsCount = 0;    // Счётчик юнитов
_housesCount = (count _houses)*0.6;     // Кол-во домов в триггере, занятых пехами
//hint format ["%1", _housesCount];
_grp = createGroup West;
while {_unitsCount < _housesCount} do   // Проверка на кол-во заспавненных юнитов в домах
{
    _house = selectRandom _pos;      // Выбираем рандомный дом
    //_unit = selectRandom _units;    // Рандомно выбираем юнита из массива
    _unit = _grp createUnit [(selectRandom _units), _house # 1, [], 0, "CAN_COLLIDE"];
    //_unit = _unit setPos (selectRandom _house);     // Ставим пеха в рандомную доступную позицию внутри дома
    _unit disableAI "PATH";     // Вырубаем логику выбора пути
    _unit setUnitPos selectRandom ["UP","UP","MIDDLE"];     // Выбираем позицию пеха в пространстве (2 к 3 положение стоя, 1 к 3 сидя)
    //_unit addEventHandler["Fired",{params ["_unit"];_unit enableAI "PATH";_unit setUnitPos "AUTO";_unit removeEventHandler ["Fired",_thisEventHandler];}];
    _unitsCount = _unitsCount + 1;
};