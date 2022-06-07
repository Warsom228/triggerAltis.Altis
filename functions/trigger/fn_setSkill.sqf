/*
        УСТАНОВКА СКИЛА БОТУ
*/

    private _unit = _this # 0;
    private _type = _this # 1;

    private _AimSpeed = 1;        // Скорость прицеливания
    private _AimAcc = 1;        // Точность прицеливание
    private _AimShake = 1;        // Тряска прицела
    private _SpotDist = 1;        // Дистанция реагирования
    private _SpotTime = 1;        // Время реагирования
    private _Courage = 1;        // Мужество
    private _ReloadSpeed = 1;    // Скорость перезарядки
    private _Commanding = 1;    // Командование
    private _General = 1;        // Общее

    if(_type > 0) then {
        _AimSpeed = _type;        // Скорость прицеливания
        _AimAcc = _type;        // Точность прицеливание
        _AimShake = _type;        // Тряска прицела
        _SpotDist = _type;        // Дистанция реагирования
        _SpotTime = _type;        // Время реагирования
        _Courage = _type;        // Мужество
        _ReloadSpeed = _type;    // Скорость перезарядки
        _Commanding = _type;    // Командование
        _General = _type;        // Общее
    };

    _unit setskill ["aimingspeed",_AimSpeed];
    _unit setskill ["aimingaccuracy",_AimAcc];
    _unit setskill ["aimingshake",_AimShake];
    _unit setskill ["spotdistance",_SpotDist];
    _unit setskill ["spottime",_SpotTime];
    _unit setskill ["commanding",_Commanding];
    _unit setskill ["courage",_Courage];
    _unit setskill ["reloadSpeed",_ReloadSpeed];
    _unit setskill ["general",_General];

    _unit setCombatMode "RED";
    _unit setUnitCombatMode "RED";

    _unit setBehaviour "COMBAT";
    _unit setBehaviourStrong "COMBAT";
    _unit setCombatBehaviour "COMBAT";
