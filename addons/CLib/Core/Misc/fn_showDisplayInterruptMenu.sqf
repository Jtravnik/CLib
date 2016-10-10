#include "macros.hpp"
/**
 * Comunity Lib - CLib
 * 
 * Author: Raven
 * 
 * Description:
 * This will open the pause menu that is normally triggered by Esc
 * 
 * Parameter(s):
 * 0: Whether to enable the Respawn button (if the config doesn't prohibit it) <Boolean> (Optional. default: false)
 * 1: Force respawn button even if config prohibits it <Boolean> (Optional. default: false)
 * 
 * Return Value:
 * None <Any>
 * 
 */

disableSerialization;

private ["_display", "_ctrl"];

params [
    ["_allowRespawn", false, [false]],
    ["_force", false, [false]]
];

createDialog (["RscDisplayInterrupt", "RscDisplayMPInterrupt"] select isMultiplayer);

_display = findDisplay 49;

for "_index" from 100 to 2000 do {
    (_display displayCtrl _index) ctrlEnable false;
};

// enable abort-button
_ctrl = _display displayctrl 103;
_ctrl ctrlSetEventHandler ["buttonClick", DFUNC(onButtonClickEndStr)];
_ctrl ctrlEnable true;
_ctrl ctrlSetText "ABORT";
_ctrl ctrlSetTooltip "Abort.";

// enable respawn button if wished
if (_allowRespawn) then {
    _ctrl = _display displayctrl ([104, 1010] select isMultiplayer);
    _ctrl ctrlSetEventHandler ["buttonClick", DFUNC(onButtonClickRespawnStr)];
    _ctrl ctrlEnable (_force || {call {private _config = missionConfigFile >> "respawnButton"; !isNumber _config || {getNumber _config == 1}}});
    _ctrl ctrlSetText "RESPAWN";
    _ctrl ctrlSetTooltip "Respawn.";
};

nil;
