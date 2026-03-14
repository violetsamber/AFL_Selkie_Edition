#include "..\script_component.hpp"
/* 
* Author: Stellarynn
* State machine that handles anemia/general red blood cell to plasma ratio in blood
* Only applies to players, does not apply to NPCs
* 
* Arguments:
*  0: The unit <OBJECT>
* 
* Return Value: 
*  None
* 
* Example:
*  [player] call afl_medical_fnc_anemiaStateMachine
* 
*/

params ["_unit"];

EGVAR(medical,anemiaMachine) = [[_unit], true] call CBA_statemachine_fnc_create;

[EGVAR(medical,anemiaMachine), {
	//Code executed while state is active 
	//Nothing major happens :3 Chilling in perfect health with a normalized RBC Count 
}, {
	//Set stamina values to their default here 
	[_unit] call EFUNC(medical,handleAnemia);
}, {}, "default"] call CBA_statemachine_fnc_addState;

[EGVAR(medical,anemiaMachine), {
	//Slight change to performance based on the missing RBC
	[_unit, 1] call EFUNC(medical,handleAnemia);
}, {}, {}, "highRBC"] call CBA_statemachine_fnc_addState;

[EGVAR(medical,anemiaMachine), {
	//Noticeable change to stamina based on the missing RBC
	[_unit, 2] call EFUNC(medical,handleAnemia);
}, {}, {}, "medRBC"] call CBA_statemachine_fnc_addState;

[EGVAR(medical,anemiaMachine), {
	//Extremely noticeable changes to stamina based on the missing RBC, and decreased SpO2 recovery
	[_unit, 3] call EFUNC(medical,handleAnemia);
}, {}, {}, "lowRBC"] call CBA_statemachine_fnc_addState;

[EGVAR(medical,anemiaMachine), {
	[_unit, 4] call EFUNC(medical,handleAnemia);
}, {
	//Set cardiac arrest or whatever is best to simulate organ failure. Not a total death sentence, assuming that the lack of RBC is recognized
	//Figure out how to prevent the heart from starting unless rbc count is increased
	[_this, 0, 1, true] call ace_medical_vitals_fnc_updateHeartRate;
	_unit setVariable [QGVAR(cardiacArrestType), 1, true];
}, {}, "dying"] call CBA_statemachine_fnc_addState;


[EGVAR(medical,anemiaMachine), "default", "highRBC", {(GET_RBC_COUNT(_this) < 44)}, {}, "lostSmallRBC"] call CBA_statemachine_fnc_addTransition;

[EGVAR(medical,anemiaMachine), "highRBC", "default", {(GET_RBC_COUNT(_this) >= 44)}, {}, "normalizedRBC"] call CBA_statemachine_fnc_addTransition;
[EGVAR(medical,anemiaMachine), "highRBC", "medRBC", {(GET_RBC_COUNT(_this) <= 35)}, {}, "lostMediumRBC"] call CBA_statemachine_fnc_addTransition;

[EGVAR(medical,anemiaMachine), "medRBC", "highRBC", {(GET_RBC_COUNT(_this) > 35)}, {}, "gainedSmallRBC"] call CBA_statemachine_fnc_addTransition;
[EGVAR(medical,anemiaMachine), "medRBC", "lowRBC", {(GET_RBC_COUNT(_this) <= 20)}, {}, "lostLargeRBC"] call CBA_statemachine_fnc_addTransition;

[EGVAR(medical,anemiaMachine), "lowRBC", "medRBC", {(GET_RBC_COUNT(_this) > 20)}, {}, "gainedMediumRBC"] call CBA_statemachine_fnc_addTransition;
[EGVAR(medical,anemiaMachine), "lowRBC", "dying", {(GET_RBC_COUNT(_this) <= 10)}, {}, "lostFatalRBC"] call CBA_statemachine_fnc_addTransition;

[EGVAR(medical,anemiaMachine), "dying", "lowRBC", {(GET_RBC_COUNT(_this) > 10)}, {}, "gainedLargeRBC"] call CBA_statemachine_fnc_addTransition;

