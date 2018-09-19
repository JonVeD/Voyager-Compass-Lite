waitUntil {!isNull player};
UGTX_needCompass = true;
UGTX_toggle = true;
UGTX_posTop = true;

UGTX_imgScrollLock = "imgs\key-scrolllock.paa";
UGTX_imgEnd = "imgs\key-end.paa";
UGTX_imgPgUp = "imgs\key-pageup.paa";

[] spawn {
   while {true} do {
     waitUntil {  UGTX_toggle &&
                  (!UGTX_needCompass OR
                  (UGTX_needCompass && ("ItemCompass" in (assignedItems Player))))
               }; _compassInit = [] spawn UGTX_fnc_showCompass;

     waitUntil {  !UGTX_toggle OR
                  (UGTX_needCompass && !("ItemCompass" in (assignedItems Player)))
               }; ["864", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
                  ctrlDelete GTX_grpVg;
                  ctrlDelete GTX_ctrlGrp;
                  ctrlDelete GTX_compNeed;
                  //ctrlDelete GTX_grpBg;
};};

UGTX_fnc_keyDown = {
   switch (_this select 1) do {
   	case 70: {
      UGTX_shift = true;
      _title  = "<t color='#fbfbfb' size='1.3' shadow='1' font='PuristaSemiBold' shadowColor='#000000' align='center'>VoyagerCompass Lite</t><br/><br/><br/>";
      _text   = "<img image='"+ UGTX_imgScrollLock +"' size='2' /> + <img image='"+ UGTX_imgEnd +"' size='2'/>   Toggle Compass<br/><br/>";
      _text2   = "<img image='"+ UGTX_imgScrollLock +"' size='2'/> + <img image='"+ UGTX_imgPgUp +"' size='2'/>   Toggle Position<br/><br/>";
      _needcomp = "";
      if (UGTX_needCompass) then {
        _needcomp = "Compass in inventory required!";
      };
      hint parseText ( _title + _text + _text2 + _needcomp);
   	};
    case 207: {
      if (UGTX_shift) then {
        if (UGTX_toggle) then {
          UGTX_toggle = false;
        }else{
          UGTX_toggle = true;
   	};};};
    case 201: {
      if (UGTX_shift) then {
        if (UGTX_posTop) then {
          { _x ctrlSetPosition [(ctrlPosition _x) select 0, 0.929 * safezoneH + safezoneY, (ctrlPosition _x) select 2, (ctrlPosition _x) select 3];
            _x ctrlCommit 0.1;
          } forEach [GTX_ctrlGrp, GTX_compNeed, GTX_grpVg];//GTX_grpBg,
          UGTX_posTop = false;
        }else{
          { _x ctrlSetPosition [(ctrlPosition _x) select 0, 0.01111 * safezoneH + safezoneY, (ctrlPosition _x) select 2, (ctrlPosition _x) select 3];
            _x ctrlCommit 0.1;
          } forEach [GTX_ctrlGrp, GTX_compNeed, GTX_grpVg];
          UGTX_posTop = true;
};};};};};

UGTX_fnc_keyUp = {
  switch (_this select 1) do {
    case 70: {
      UGTX_shift = false;
};};};
waituntil {!isnull (finddisplay 46)};
(findDisplay 46) displaySetEventHandler ["KeyDown", "_this call UGTX_fnc_keyDown;false;"];//["KeyDown", "hint str _this"];
(findDisplay 46) displaySetEventHandler ["KeyUp","_this call UGTX_fnc_keyUp;false;"];

systemChat "@VoyagerCompass-Lite Addon:: Press [SCROLL LOCK] Key.";
