disableSerialization;
_display = uiNamespace getVariable "RscTitleDisplayEmpty";
GTX_ctrlGrp = _display ctrlCreate ["RscControlsGroup", 8583];
GTX_ctrlGrp ctrlSetPosition [0.4 * safezoneW + safezoneX,0.01111 * safezoneH + safezoneY,0.2 * safezoneW,10 * safezoneH];
GTX_ctrlGrp ctrlCommit 0;

UGTX_compImg = _display ctrlCreate ["RscPicture", 5432, GTX_ctrlGrp];
UGTX_compImg ctrlSetText "imgs\default-puristax2.paa";
UGTX_compImg ctrlCommit 0;

GTX_grpVg = _display ctrlCreate ["RscPicture", 1658];
GTX_grpVg ctrlSetText "imgs\vignette-20.paa";
GTX_grpVg ctrlSetPosition [0.4 * safezoneW + safezoneX,0.01111 * safezoneH + safezoneY,0.2 * safezoneW,0.066 * safezoneH];
GTX_grpVg ctrlCommit 0;

GTX_compNeed = _display ctrlCreate ["RscStructuredText", 3398];
GTX_compNeed ctrlSetPosition [(0.5 * safezoneW + safezoneX)- 0.05,-0.01 * safezoneH + safezoneY + 0.01,0.1,0.09 * safezoneH];
GTX_compNeed ctrlSetStructuredText parseText ("<t shadow=1><t align='center' size='1' font='PuristaLight'>V");
GTX_compNeed ctrlCommit 0;
/*
GTX_grpBg = _display ctrlCreate ["RscStructuredText", 1656];
GTX_grpBg ctrlSetBackgroundColor [0, 0, 0, 0.0];
GTX_grpBg ctrlSetPosition [0.4 * safezoneW + safezoneX,0.01111 * safezoneH + safezoneY,0.2 * safezoneW,0.066 * safezoneH];
GTX_grpBg ctrlCommit 0;
*/
