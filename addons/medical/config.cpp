#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "afl_main",
            "afl_misc",
            "ace_medical",
            "ace_medical_damage",
            "ace_medical_treatment",
            "ace_medical_gui",
            "ace_medical_feedback",
            "ace_medical_engine",
            "kat_vitals",
            "kat_circulation",
            "kat_breathing",
            "kat_surgery",
            "kat_misc",
            "kat_gui",
            "kat_airway",
            "kat_pharma",
            "kat_vitals",
            "kat_stretcher",
            "kat_pharma"
        };
        author = "flufflesamy, Stellarynn";
        VERSION_CONFIG;
    };
};

class CfgAmmo {
	class OPTRE_sticky_explosion_base;
	class sel_supercombine_explosive: OPTRE_sticky_explosion_base
	{
		dangerRadiusHit = 50;
		deflecting = -3;
		deflectionSlowDown = 10;
		explosionEffectsRadius = 1.5;
		hit = 50;
		indirectHit = 3;
		indirectHitRange = 3;
		craterShape = "\OPTRE_FC_Weapons\Data\plasma_crater_purple.p3d";
		model = "\OPTRE_FC_Weapons\data\bolt_purple.p3d";
		explosionEffects = "ImpactPlasmaExpPink";
		CraterWaterEffects = "ImpactEffectsWaterExplosion";
	};
};

#include "CfgFunctions.hpp"
#include "CfgEventHandlers.hpp"
#include "ACE_Medical_Treatment_Actions.hpp"
#include "ACE_Medical_Injuries.hpp"
#include "ui\gui.hpp"
