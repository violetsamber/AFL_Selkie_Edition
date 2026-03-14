#include "..\script_component.hpp"
/* 
* Author: Stellarynn
* State machine that handles anemia/general red blood cell to plasma ratio in blood
* Only applies to players, does not apply to NPCs
* 
* Arguments:
*  0: The unit <OBJECT>
*  1: Anemia Level <NUMBER>
* 
* Return Value: 
*  None
* 
* Example:
*  [player] call afl_medical_fnc_handleAnemia
* 
* Public:
*  No
*/

params ["_unit",["_anemiaLevel",0]];

//Avoid calling this function unnecessarily often since RBC changes aren't that severe 
private _lastTimeUpdated = _unit getVariable [QEGVAR(medical,lastAnemiaUpdate), 0];
private _deltaT = (CBA_missionTime - _lastTimeUpdated) min 10;
if (_deltaT < 3) exitWith {}; 

private _rbcCount = GET_RBC_COUNT(_unit);
private _dutyModifier = 1;
private _breathingModifier = 1;

switch _anemiaLevel do 
{
	case default {	//No Anemia, unit is sooooo full of red blood cells
		["SEL_Anemia"] call ACEFUNC(advanced_fatigue,removeDutyFactor);
		_unit setVariable [QEGVAR(medical,breathingEffectiveness),1];
		_unit setCustomAimCoef 1;
		if (true) exitWith {};
	};
	case 1 : {	//Small Anemia, unit is missing some red blood cells 
		_dutyModifier = 2;
		_breathingModifier = 1;
		_unit setCustomAimCoef 1.5;
		_unit setUnitRecoilCoefficient 1;
	};
	case 2 : {	//Medium Anemia, unit is missing a serious amount of red blood cells 
		_dutyModifier = 5;
		_breathingModifier = 0.75;
		_unit setCustomAimCoef 2;
		_unit setUnitRecoilCoefficient 1.8;
	};
	case 3 : {	//Large Anemia, unit is missing a near-fatal amount of red blood cells 
		_dutyModifier = 100;
		_breathingModifier = -1.5;
		_unit setCustomAimCoef 5;
		_unit setUnitRecoilCoefficient 3;
	};
	case 4 : {	//Deadly Anemia, unit is missing a fatal amount of red blood cells and is entering organ failure
		_dutyModifier = 1000;
		_breathingModifier = -5;
		_unit setCustomAimCoef 10;
		_unit setUnitRecoilCoefficient 10;
	};
};

["SEL_Anemia", (((1 - _rbcCount / DEFAULT_RBC_COUNT) * _dutyModifier) min 1)] call ACEFUNC(advanced_fatigue,addDutyFactor);
_unit setVariable [QEGVAR(medical,breathingEffectiveness),(_rbcCount / DEFAULT_RBC_COUNT + (1 - rbcCount / DEFAULT_RBC_COUNT) * _breathingModifier)];


