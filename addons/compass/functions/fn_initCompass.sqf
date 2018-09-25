disableSerialization;
waitUntil {!isNull player};
UGTX_needCompass = true;
UGTX_toggle = true;
UGTX_posTop = true;

UGTX_imgCompImg = "imgs\default-sfp.paa";
UGTX_imgScrollLock = "imgs\key-scrolllock.paa";
UGTX_imgEnd = "imgs\key-end.paa";
UGTX_imgPgUp = "imgs\key-pageup.paa";

[] spawn {
   while {true} do {
     waitUntil {  UGTX_toggle &&
                  (!isNull player) &&
                  (!UGTX_needCompass OR
                  (UGTX_needCompass && ("ItemCompass" in (assignedItems Player))))
               }; _comp = [] spawn UGTX_fnc_compileCompass;
                  _compassInit = [] spawn UGTX_fnc_showCompass;

     waitUntil {  !UGTX_toggle OR
                  (UGTX_needCompass && !("ItemCompass" in (assignedItems Player))) OR
                  (isNull player)
               }; ["864", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
                  ctrlDelete (GTX_ctrlGrp#0);
                  ctrlDelete (GTX_compNeed#0);
                  ctrlDelete (GTX_grpBg#0);
                  terminate _comp;
                  terminate _compassInit;
};};

[] spawn {
  waituntil {!isnull (finddisplay 46)};
  (findDisplay 46) displayAddEventHandler ["KeyDown", "_this call UGTX_fnc_keyDown;false;"];
  (findDisplay 46) displayAddEventHandler ["KeyUp","_this call UGTX_fnc_keyUp;false;"];

};

systemChat "@VoyagerCompass-Lite 3.2 Addon:: Press [SCROLL LOCK] Key.";
