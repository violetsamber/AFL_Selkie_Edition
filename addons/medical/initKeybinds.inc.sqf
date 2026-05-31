["AFL", QGVAR(slap), "Slap Keybind", {
    private _player = ACE_player;
    TRACE_1("Try Reorient Start",_player);
    if (!alive _player) exitWith {false};
    if(IS_UNCONSCIOUS(_player)) exitWith {false};

    private _cursorObject = cursorObject;

    //No Self Reorient
    if(_player == _cursorObject) exitWith {false};
    
    TRACE_2("Try Reorient",_player,_cursorObject);
    
    [_player, _cursorObject,"head","Reorientation"] call ace_medical_treatment_fnc_treatment;

    false
}, {}, [-1, [false, false, false]]] call CBA_fnc_addKeybind; // UNBOUND