#include "..\script_component.hpp"

/*
 * Author: Stellarynn, LinkIsGrim
 * Custom wounds handler for blamite and armor penetration. Calculates damage based on round material penetration and unit armor
 *
 * Arguments:
 * 0: Unit that was hit <OBJECT>
 * 1: Damage done to each body part <ARRAY>
 *    0: Engine damage <NUMBER>
 *    1: Body part <STRING>
 *    2: Real damage <NUMBER>
 * 2: Type of the damage done <STRING>
 * 3: Ammo <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, [[0.5, "Body", 1]], "bullet"] call ace_medical_damage_fnc_woundsHandlerArmorPenetration
 *
 * Public: No
 */

params ["_unit", "_allDamages", "_typeOfDamage", "_ammo"];

#define BLAMITE_LARGE 5
#define BLAMITE_MEDIUM 3
#define BLAMITE_SMALL 1

// This gets close to vanilla values on FMJ ammo
#define DAMAGE_SCALING_FACTOR 10
#define UNSCALED_BASE_ARMOR 2


private _blamiteTotal = 0;
{
	{
		_x params ["_woundClassID", "_amountOf"];

		private _classIndex = _woundClassID / 10;
		private _className = ACEGVAR(medical_damage,woundClassNames) select _classIndex;

		if (_className == "AOR_BlamiteWound") then {
			private _category = _woundClassID % 10;
			switch _category do {
				case 2 : {
					_blamiteTotal = _blamiteTotal + BLAMITE_LARGE * _amountOf;
				};
				case 1 : {
					_blamiteTotal = _blamiteTotal + BLAMITE_MEDIUM * _amountOf;
				};
				case default {
					_blamiteTotal = _blamiteTotal + BLAMITE_SMALL * _amountOf;
				};
			};
		};
	} forEach (GET_OPEN_WOUNDS(_unit) getOrDefault [_x, []]);
} forEach ALL_BODY_PARTS;



if (_blamiteTotal > 10) then {
	private _wounds = GET_OPEN_WOUNDS(_unit);
	{
		private _part = _wounds get _x;
		private _index = _part findIf {
			_x params ["_woundClassID"];
			private _classIndex = _woundClassID / 10;
			private _className = ACEGVAR(medical_damage,woundClassNames) select _classIndex;
			_className == "AOR_BlamiteWound"
		};

		private _wound = _part select _index;
		_wound params ["","_amountof","", "_damage"];
		private _damageToAdd = _damage;
		private _amountToAdd = _amountOf;
		while {_index isNotEqualTo -1} do {
			_part deleteAt _index;
			_index = _part findIf {
				_x params ["_woundClassID"];
				private _classIndex = _woundClassID / 10;
				private _className = ACEGVAR(medical_damage,woundClassNames) select _classIndex;
				_className == "AOR_BlamiteWound"
			};
		};
		for "_i" from 1 to _amountToAdd do {
			// Only applies to a unit that is alive
			[_unit, _damageToAdd, _x, "AOR_BlamiteDetonated"] call ACEFUNC(medical,addDamageToUnit);
		};
	} forEach ALL_BODY_PARTS;
	_explosiveObj = createVehicle ["sel_supercombine_explosive", getPosATL  _unit, [], 0, "CAN_COLLIDE"];
	_explosiveObj attachTo [_unit,[0,1,0]];
	_explosiveObj setDamage 1;
};

_this
