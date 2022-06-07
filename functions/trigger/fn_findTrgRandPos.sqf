_trgPos = _this # 0;
_trgParams = _this # 1;
_rndDir = (random 360); // Рандомный угол
_rndX = cos _rndDir * (random (_trgParams # 0) ); // Рандомная дистанция
_rndY = sin _rndDir * (random (_trgParams # 1) );
_vector = [[ _rndX, _rndY, 1 ], _trgParams # 2 ] call BIS_fnc_rotateVector2D; // Создаём вектор
_pos = _vector vectorAdd _trgPos;  // Размещаем вектор в необходимом месте
_pos;
