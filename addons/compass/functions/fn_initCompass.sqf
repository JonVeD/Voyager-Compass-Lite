/*
  version 1.0
  description:
*/

 waitUntil {!isNull player};




[] spawn
{
  while {true} do
  {
    waitUntil {!isNull (findDisplay 49)};

    disableSerialization;
    _display = findDisplay 49;
    _ctrl = _display ctrlCreate ["RscButton", 3389];
    _ctrl ctrlSetPosition [
    (1 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX)),
    (2.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + safezoneY),
    (15 * (((safezoneW / safezoneH) min 1.2) / 40)),
    (1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))];
    _ctrl ctrlSetActiveColor [0.204,0.286,0.369,1];
    _ctrl ctrlSetText "COMPASS OPTIONS";
    _ctrl ctrlCommit 0;
    _ctrl buttonSetAction "(findDisplay 49) closeDisplay 1; [] call UGTX_fnc_showSettings;";

    waitUntil{isNull (findDisplay 49)};
  };
};




/*[] spawn
{
  while {true} do {
    waitUntil {!("ItemCompass" in (assignedItems Player))};
    ["0", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
    _display = uiNamespace getVariable "RscTitleDisplayEmpty";
    ctrlDelete (_display displayCtrl 1656);
    ctrlDelete (_display displayCtrl 8583);
    sleep 1;
  };
};*/

[] spawn
{
  while {true} do {
    if (("ItemCompass" in (assignedItems Player))) then {
      _compassInit = [] spawn UGTX_fnc_showCompass;
      waitUntil {!("ItemCompass" in (assignedItems Player))};
      ["0", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
      _display = uiNamespace getVariable "RscTitleDisplayEmpty";
      ctrlDelete (_display displayCtrl 1656);
      ctrlDelete (_display displayCtrl 8583);
      ctrlDelete (_display displayCtrl 3398);
    };
    sleep 3;
  };
};
