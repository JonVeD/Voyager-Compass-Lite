UGTX_imgCompImg = "imgs\default-sf.paa";

disableSerialization;
("compassTitle" call BIS_fnc_rscLayer) cutRsc ["RscTitleDisplayEmpty", "PLAIN", -1, false];
_comp = [] call UGTX_fnc_compileCompass;

["864", "onEachFrame",{
  _sPos = screenToWorld [0.5,0.5];
	_pPos = getPos player;
	_dir = (((((_sPos select 0) - (_pPos select 0)) atan2 ((_sPos select 1) - (_pPos select 1))) + 360) % 360)/100;
  _stripe = 0.96 * safezoneW;
  _calc = ((_stripe/570) * _dir)* 100 + (_stripe/570) * 45;

  UGTX_compImg ctrlSetPosition [_calc - _calc*2,-0.01,_stripe,1.8 * safezoneH];
  UGTX_compImg ctrlSetText UGTX_imgCompImg;
  UGTX_compImg ctrlCommit 0;
}] call BIS_fnc_addStackedEventHandler;
