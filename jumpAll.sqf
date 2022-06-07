_crew = crew (vehicle player);
{if (_x in assignedCargo(vehicle player)) then {moveOut _x; sleep 1.5;};} foreach _crew;