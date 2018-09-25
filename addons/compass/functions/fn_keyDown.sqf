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
       { _x ctrlSetPosition [(ctrlPosition _x) select 0, 0.93 * safezoneH + safezoneY, (ctrlPosition _x) select 2, (ctrlPosition _x) select 3];
         _x ctrlCommit 0.1;
       } forEach [(GTX_ctrlGrp#0), (GTX_compNeed#0), (GTX_grpBg#0)];
       UGTX_posTop = false;
     }else{
       { _x ctrlSetPosition [(ctrlPosition _x) select 0, 0.01111 * safezoneH + safezoneY, (ctrlPosition _x) select 2, (ctrlPosition _x) select 3];
         _x ctrlCommit 0.1;
       } forEach [(GTX_ctrlGrp#0), (GTX_compNeed#0), (GTX_grpBg#0)];
       UGTX_posTop = true;
};};};};
