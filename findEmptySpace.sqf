_spawnLocation = ["markerTestName",[19403.5,13248.1,0],500];
if(_spawnLocation#1 findEmptyPositionReady [0,_spawnLocation#2]) then //проверяет можно ли вообще такую позицию найти, только потом создается триггер вообще
        {
        _markertest = createMarker[_spawnLocation#0,_spawnLocation#1];
        _markertest setMarkerShape "ELLIPSE";
        _markertest setMarkerSize[_spawnLocation#2,_spawnLocation#2];
        _markertest setMarkerDir -30;
        _emptyLocation = [_spawnLocation#1,1,_spawnLocation#2,15,0,0.065,0,[],[]] call BIS_fnc_findSafePos; //надо поставить позицию, если такую точку не найти
        if(!(_emptyLocation isEqualTo []) and !(isOnRoad _emptyLocation)) then
         {
            _controlPoint = "Land_i_Barracks_V1_F" createVehicle _emptyLocation;
         };
        };
