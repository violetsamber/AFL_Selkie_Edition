#include "..\script_component.hpp"
/*
 * Author: Stella
 * 
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 
 * 
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call afl_medical_fnc_resetAnemiaStateDefault
 *
 * Public: No
 */

params ["_unit"];

[_unit, EGVAR(medical,anemiaMachine), "dying", "default"] call CBA_statemachine_fnc_manualTransition;
