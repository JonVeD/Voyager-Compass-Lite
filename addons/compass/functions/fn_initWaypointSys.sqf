/*
  version 1.0
  description:
*/


 waitUntil {!(count wayPointMarkerPos == 0)};
 ["865", "onEachFrame",{
   //WAYPOINT MARKER
   _playerDir = (getDir player)/100;
   _relativeDir = ([player, wayPointMarkerPos] call BIS_fnc_relativeDirTo)/100;

   wayPointMarker  ctrlSetPosition [ nc_barOffsetX + (_relativeDir / ncSpan)            - ((0.5 * safezoneW + safezoneX) - (ncW  * safezoneW)) - 0.025,nc_marker_offset,0.05,0.09];
   wayPointMarker2 ctrlSetPosition [ nc_barOffsetX + (_relativeDir / ncSpan) - (3.6/ncSpan)  - ((0.5 * safezoneW + safezoneX) - (ncW  * safezoneW)) - 0.025,nc_marker_offset,0.05,0.09];
   wayPointMarker  ctrlCommit 0;
   wayPointMarker2 ctrlCommit 0;
 }] call BIS_fnc_addStackedEventHandler;
