/*
  version 1.0
  description: shows the compass with saved settings or default setttings if no settings saved. should only be executed once
*/
systemchat "init UGTX_fnc_showCompass";

disableSerialization;

folder = [] call UGTX_fnc_loadSettings;



_nc_settings = [] call UGTX_fnc_loadSettings;
if (isNil "_nc_settings") then {
  _nc_settings = [0.499889,0.0346965,3.16098,1.86439,0,1.18143,"C0",0.753254,"PuristaLight",0,1,1,-0.0340903,5,1,0,"B1B1","FFFFFF"];
};

ncX                   = _nc_settings select 0;
ncY                   = _nc_settings select 1;
ncW                   = _nc_settings select 2;
ncSpan                = _nc_settings select 3;
ncType                = _nc_settings select 4;
ncFontSize            = _nc_settings select 5;
ncAlpha               = _nc_settings select 6;

ncFontOption          = _nc_settings select 8;
ncInvert              = _nc_settings select 9;
ncShadow              = _nc_settings select 10;
ncMarkerVisibility    = _nc_settings select 11;
ncMarkerY             = _nc_settings select 12;

ncColorOption         = "f9f9f9";

nc_barOffsetX         = (ncX * safezoneW + safezoneX);
nc_barOffsetY         = (ncY * safezoneH + safezoneY);
nc_marker_offset      = ncMarkerY + nc_barOffsetY;


("compassTitle" call BIS_fnc_rscLayer) cutRsc ["RscTitleDisplayEmpty", "PLAIN", -1, false];


switch (ncShadow) do { case (0): { ncShadow = 0; }; case (1): { ncShadow = 2; };};

_comp = [ncType, ncInvert, ncFontSize, ncShadow, ncFontOption, ncAlpha, ncColorOption] call UGTX_fnc_compileCompass;

/// rendering of compass
allUserMarkers = [];
currentMarkers = [];
combMarkers = [];

wayPointMarkerPos = [];

_display = uiNamespace getVariable "RscTitleDisplayEmpty";
wayPointMarker  = _display ctrlCreate ["RscStructuredText", 8554, xxctrlGroup];
wayPointMarker2 = _display ctrlCreate ["RscStructuredText", 8555, xxctrlGroup];
wayPointMarker ctrlSetPosition [-2, -2, 0.05, 0.05];
wayPointMarker2 ctrlSetPosition [-2, -2, 0.05, 0.05];

_img =  "\A3\ui_f\data\map\mapcontrol\CustomMark_CA.paa";
_txt = parseText format ["<img image='%1' align='center'/>", _img];
wayPointMarker ctrlSetStructuredText _txt;
wayPointMarker2 ctrlSetStructuredText _txt;

wayPointMarker  ctrlCommit 0;
wayPointMarker2 ctrlCommit 0;



onMapSingleClick
{
	if (_shift) then
	{
		wayPointMarkerPos = _pos;
	};
	//_shift
};

[] spawn UGTX_fnc_initWaypointSys;


ncWx = 4.6;

["864", "onEachFrame",{



  {
    _ctrl = _x select 0;
    _pos = (_x select 1) / 100;
    _degreeControl = ((uiNamespace getVariable "RscTitleDisplayEmpty") displayCtrl _ctrl);


    _sPos = screenToWorld [0.5,0.5];
  	_pPos = getPos player;
  	_playerDir = (((((_sPos select 0) - (_pPos select 0)) atan2 ((_sPos select 1) - (_pPos select 1))) + 360) % 360)/100;

    //_playerDir = (getDir player)/100;

    _controlPos = (ctrlPosition _degreeControl) select 0;
    if (_controlPos > ((ncWx / 10 * safezoneW + safezoneX)  - ((0.5 * safezoneW + safezoneX) - (ncW  * safezoneW))) && _controlPos < (0.9 - ((ncWx / 10 * safezoneW + safezoneX)) - ((0.5 * safezoneW + safezoneX) - (ncW  * safezoneW)))) then {
      _degreeControl ctrlSetPosition [(nc_barOffsetX + ((_pos - _playerDir) / ncSpan) - (0.1/2)) - ((0.5 * safezoneW + safezoneX) - (ncW  * safezoneW)) ,0,0.1,0.04];

      _degreeText = ctrlText _degreeControl;
      newDgrTxt = [0,1, _degreeText] call UGTX_fnc_removeString;

    }else{
      _degreeControl ctrlSetPosition [(nc_barOffsetX + ((_pos - _playerDir) / ncSpan) - (0.1/2)) - ((0.5 * safezoneW + safezoneX) - (ncW  * safezoneW)),0,0.1,0.4];
      _compassNeedle = ((uiNamespace getVariable "RscTitleDisplayEmpty") displayCtrl 3398);


      _compassNeedle ctrlSetStructuredText parseText format["<t shadow=2><t shadowColor='#ff0000' align='center' size='%1' color='#f9f9f9'>V</t><br /><br /><t shadow=2><t shadowColor='#ff0000' align='center' size='%2' color='#f9f9f9'>%3</t>", 0.85, 1.35, newDgrTxt];
      //_compassNeedle ctrlSetBackgroundColor [1,1,1,1];
      _compassNeedle ctrlCommit 0;
    };
    _degreeControl ctrlCommit 0;
  } forEach compass_pos;


  {
    _ctrl  = _x select 0;
    _marker = _x select 1;
    _ctrl2 = _ctrl + 100;

    _playerDir = (getDir player)/100;
    _relativeDir = ([player, markerPos _marker] call BIS_fnc_relativeDirTo)/100;

    _MarkerControl  = ((uiNamespace getVariable "RscTitleDisplayEmpty") displayCtrl _ctrl);
    _MarkerControl2 = ((uiNamespace getVariable "RscTitleDisplayEmpty") displayCtrl _ctrl2);

    _controlPos = (ctrlPosition _MarkerControl) select 0;
    _controlPos2 = (ctrlPosition _MarkerControl2) select 0;

    if (_controlPos > (((ncW / 10 * safezoneW + safezoneX) - (0.1/2)) * ncMarkerVisibility) && _controlPos < (((0.9 - (ncW / 10 * safezoneW + safezoneX))- (0.1/2)) * ncMarkerVisibility)) then {
      _MarkerControl  ctrlSetPosition [ nc_barOffsetX + (_relativeDir / ncSpan) - ((0.5 * safezoneW + safezoneX) - (ncW  * safezoneW)) - 0.025,nc_marker_offset,0.05,0.09];
    }else{
      _MarkerControl  ctrlSetPosition [ nc_barOffsetX + (_relativeDir / ncSpan) - ((0.5 * safezoneW + safezoneX) - (ncW  * safezoneW)) - 0.025,nc_marker_offset,0.00,0.09];
    };
    //_MarkerControl  ctrlSetPosition [ nc_barOffsetX + (_relativeDir / ncSpan)            - (0.05/2),nc_marker_offset,0.05,0.09];

    if (_controlPos2 > (((ncW / 10 * safezoneW + safezoneX) - (0.1/2)) * ncMarkerVisibility) && _controlPos2 < ((((0.9 - (ncW / 10 * safezoneW + safezoneX))- 0.05)) * ncMarkerVisibility)) then {
      _MarkerControl2 ctrlSetPosition [ nc_barOffsetX + (_relativeDir / ncSpan) - (3.6/ncSpan) - ((0.5 * safezoneW + safezoneX) - (ncW  * safezoneW)) - 0.025,nc_marker_offset,0.05,0.09];
    }else{
      _MarkerControl2 ctrlSetPosition [ nc_barOffsetX + (_relativeDir / ncSpan) - (3.6/ncSpan) - ((0.5 * safezoneW + safezoneX) - (ncW  * safezoneW)) - 0.025,nc_marker_offset,0.00,0.09];
    };
    //_MarkerControl2 ctrlSetPosition [ nc_barOffsetX + (_relativeDir / ncSpan) - (3.6/ncSpan)  - (0.05/2),nc_marker_offset,0.05,0.09];

    _MarkerControl  ctrlCommit 0;
    _MarkerControl2 ctrlCommit 0;
  } forEach combMarkers;







  //hint format ["degr: %1", getDir player];
}] call BIS_fnc_addStackedEventHandler;





///

waitUntil {ncMarkerVisibility == 1;};

while {true} do {
  /// create user array [marker]
  {
    if !(_x in currentMarkers) then {
      _a = toArray _x;
      _a resize 15;
      if (toString _a == "_USER_DEFINED #") then {
        allUserMarkers pushBack _x;
      };
    };
  } forEach allMapMarkers;
  ///
  /// create double array ([marker], [idc,marker])
  {
    if !(_x in currentMarkers) then {
      _display = uiNamespace getVariable "RscTitleDisplayEmpty";
      _index = allUserMarkers find _x;
      _idc = 5500 + _index;

      _edit  = _display ctrlCreate ["RscStructuredText", _idc, xxctrlGroup];
      _edit2 = _display ctrlCreate ["RscStructuredText", _idc + 100, xxctrlGroup];
      _edit ctrlSetPosition [-2, -2, 0.05, 0.05];
      _edit2 ctrlSetPosition [-2, -2, 0.05, 0.05];

      _img =  getText (configfile >> "cfgMarkers" >> markerType _x >> "icon");
      _txt = parseText format ["<img image='%1' align='center'/>", _img];
      _edit ctrlSetStructuredText _txt;
      _edit2 ctrlSetStructuredText _txt;

      _edit  ctrlCommit 0;
      _edit2 ctrlCommit 0;


        currentMarkers pushBack _x;
        combMarkers pushBack [_idc, _x];
      //};
      systemChat format ["created: %1", _x];
    };
  } forEach allUserMarkers;
  ///

  /// delete IF marker from [idc,marker] aint alive anymore
  {
    if !(_x in allMapMarkers) then {
      allUserMarkers = allUserMarkers - [_x];
      currentMarkers = currentMarkers - [_x];
    };
  } forEach allUserMarkers;
  {
    if !((_x select 1) in allUserMarkers) then {
      _display = uiNamespace getVariable "RscTitleDisplayEmpty";
      ctrlDelete (_display displayCtrl (_x select 0));
      ctrlDelete (_display displayCtrl ((_x select 0)+100));
      combMarkers = combMarkers - [_x];
    };
  } forEach combMarkers;
  ///
  sleep 0.2;
};
