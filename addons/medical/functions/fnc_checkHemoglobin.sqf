#include "..\script_component.hpp"
/*
 * Author: Stella
 * Gets the amount of Hemoglobin in the unit's blood and displays it
 *
 * Arguments:
 * 0: _medic <OBJECT>
 * 1: _patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player,cursorObject] call AFL_fnc_checkHemoglobin
 *
 * Public: No
 */

params ["_medic", "_patient"];

private _rbcC = GET_RBC_COUNT(_patient);
private _hemoglobin = 160 * (_rbcC/44);
private _output = [_hemoglobin, 2] call BIS_fnc_cutDecimals;


[_patient, "quick_view", "%1 found %2's hemoglobin levels to be %3g/L", [_medic call ACEFUNC(common,getName),_patient call ACEFUNC(common,getName), _output]] call ACEFUNC(medical_treatment,addToLog);
[QACEGVAR(common,displayTextStructured), [["%1's hemoglobin levels are %2g/L", _patient call ACEFUNC(common,getName), _output], 1.5, _medic], _medic] call CBA_fnc_targetEvent;
