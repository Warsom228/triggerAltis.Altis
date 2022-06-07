_trgPos = _this # 0;    // Позиция триггера
_trgParams = _this # 1;     // Параметры триггера


_controlPoints = [];    // Массив заспавненных контрольных точек
for [ { _i = 0 }, { _i < 3 }, { _i } ] do {      // Спавним 2 точки
    _pos = [ _trgPos, _trgParams ] call trg_fnc_findTrgRandPos;     // Находим позицию в точке для спавна
    if !( _pos isFlatEmpty [20, -1, 60 * (pi / 180), 20, 0, false, objNull] isEqualTo [] && ( _pos distance _trgPos ) < 100 && !( isOnRoad _pos ) ) exitWith { // Условие проверки
        private ["_newObjs"];
        _controlPointMap = [_i] call trg_fnc_compositionsMap;
        _newObjs = [random 360, _pos,_controlPointMap] spawn trg_fnc_objectMapper;
        _i = _i + 1;     // След. итерация
    };
};
_controlPoints;     // Возвращаем массив в конце

//TODO: сделать спавн НЕСКОЛЬКИХ триггеров
