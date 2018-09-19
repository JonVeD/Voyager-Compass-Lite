waitUntil {!isNull player};
UGTX_needCompass = false;
UGTX_allowInVehicle = false;
UGTX_toggle = false;

[] spawn
 {
   while {true} do {
     waitUntil {
                  UGTX_toggle &&
                  (!UGTX_needCompass OR
                  (UGTX_needCompass && ("ItemCompass" in (assignedItems Player))))
               };
     _compassInit = [] spawn UGTX_fnc_showCompass;

     waitUntil {
                  !UGTX_toggle OR
                  (UGTX_needCompass && !("ItemCompass" in (assignedItems Player)))
               };

     ["864", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
     ctrlDelete GTX_grpBg;
     ctrlDelete GTX_ctrlGrp;
     ctrlDelete GTX_compNeed;
   };
 };
