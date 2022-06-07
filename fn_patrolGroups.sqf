_trgPos = _this # 0;	// Параметр позиции триггера
_trgParams = _this # 1;		// Параметры триггера
_grpCount = _this # 2;		// Кол-во групп для спавна
_triggerPoint = _this # 3;

_Spawngroups = [(configfile >> "CfgGroups" >> "West" >> "BLU_CTRG_F" >> "Infantry" >> "CTRG_InfSquad"),
(configfile >> "CfgGroups" >> "West" >> "BLU_CTRG_F" >> "Infantry" >> "CTRG_InfTeam")
]; 		// Массив групп для спавна

_i = 0;		// Счётчик
while { _i < _grpCount } do 	// Выполняется пока не заспавнит нужное кол-во групп
{
	_pos = [ _trgPos, _trgParams ] call trg_fnc_findTrgRandPos;		// Находим пустую область для спавна
	if (_pos isFlatEmpty [4, -1, 60 * (pi / 180), 5, 0, false, objNull] isEqualTo []) then 		// Проверка, нашлась ли такая область
	{
		_NewGroup = [_pos, BLUFOR, _Spawngroups select (floor (random (count _Spawngroups)))] call BIS_fnc_spawnGroup;	// Если да, спавним группу
		{ [ _x, 0,8 ] call trg_fnc_setSkill; } forEach (units _NewGroup);	// Установка скилла
		[_NewGroup, _trgPos, triggerArea _triggerPoint # 0] call BIS_fnc_taskPatrol;	// Прописываем группе вейпоинты
		_i = _i + 1;	// След. итерация
	};
};
