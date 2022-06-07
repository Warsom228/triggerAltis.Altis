[]spawn {player addAction ["Выбросить десант",	"jumpAll.sqf",	nil, 1.5, true,	true, "",
"(assignedDriver (vehicle player) == player) and (count (fullCrew [vehicle player, 'cargo']) != 0) and (getposATL (vehicle player) select 2 > 75)"];};
