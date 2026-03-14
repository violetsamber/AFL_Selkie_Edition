#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = QUOTE(COMPONENT);
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "cba_main",
            "ace_main",
            "kat_main"
        };
        author = "flufflesamy, Stella";
        url = CSTRING(url);
        VERSION_CONFIG;
    };
};

class CfgMods {
    class PREFIX {
        dir = "@afl_selkie_edition";
        name = "AFL Selkie Edition";
        picture = "\z\afl\addons\main\data\selkie_medical_128.paa";
        hidePicture = "true";
        hideName = "true";
        actionName = "Website";
        action = CSTRING(URL);
        description = "Issue Tracker: https://github.com/DalynSteps/AFL_Selkie_Edition/issues";
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgSettings.hpp"
