["AFL", QGVAR(slap), "Slap Keybind", {
    private _player = ACE_player;

    if (!alive _player) exitWith {false};

    private _cursorObject = cursorObject;
    if (_cursorObject isKindOf "CaManBase" && {unitIsUAV _cursorObject}) then { _cursorObject = vehicle _cursorObject };
    
    //Check to see if the player trying is concious
    //Check to see if the target is not self 

    [_player, _cursorObject,"Head","Reorientation"] call ace_medical_treatment_fnc_treatment;

    false
}, {}, [-1, [false, false, false]]] call CBA_fnc_addKeybind; // UNBOUND