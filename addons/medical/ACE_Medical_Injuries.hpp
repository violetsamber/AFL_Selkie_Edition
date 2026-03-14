

class ACE_Medical_Injuries {
	class damageTypes {
		class woundHandlers;
		class AOR_BlamiteBullet {
			class woundHandlers: woundHandlers {
				ADDON = QEFUNC(medical,handleSupercombine);
				ACEGVAR(medical_damage,armorPenetration) = QACEFUNC(medical_damage,woundsHandlerArmorPenetration);
			};
		};
		class AOR_BlamiteDetonated {
			thresholds[] = {{0,1}};
			selectionSpecific = 1;
			class Avulsion {
				weighting[] = {{0,1}};
				sizeMultiplier = 3;
				bleedingMultiplier = 10;
				painMultiplier = 2.5;
			};
		};
	};
};
