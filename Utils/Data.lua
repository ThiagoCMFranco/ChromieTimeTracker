--------------------------------------------------------------------------------
--[[ Chromie Time Tracker ]]--
--
-- by ThiagoCMFranco <https://github.com/ThiagoCMFranco>
--
--Copyright (C) 2025  Thiago de C. M. Franco
--
--This program is free software: you can redistribute it and/or modify
--it under the terms of the GNU General Public License as published by
--the Free Software Foundation, either version 3 of the License, or
--(at your option) any later version.
--
--This program is distributed in the hope that it will be useful,
--but WITHOUT ANY WARRANTY; without even the implied warranty of
--MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--GNU General Public License for more details.
--
--You should have received a copy of the GNU General Public License
--along with this program.  If not, see <https://www.gnu.org/licenses/>.
--
--------------------------------------------------------------------------------

local _, mct = ...
mct.C_ExpansionColors = {}
mct.C_RemixColors = {}
mct.C_ExpansionGarrisonID = {}
mct.C_ExpansionGarrisonMiddleClickOptions = {}
mct.C_ExpansionSummaries = {}
mct.C_ClassTextures = {}
mct.C_GarrisonTextures = {}
mct.C_WarCampaignTextures = {}
mct.C_CovenantChoicesTextures = {}
mct.C_LandingPagesTextures = {}
mct.C_ClassTabTextures = {}
mct.C_PandariaTabTextures = {}
mct.C_GarrisonTabTextures = {}
mct.C_WarCampaignTabTextures = {}
mct.C_CovenantChoicesTabTextures = {}
mct.C_ButtonFrames = {}
mct.C_CurrencyId = {}

local L = mct.L

local C_ExpansionColors = mct.C_ExpansionColors

C_ExpansionColors[2] = "FF00AA00" --BC
C_ExpansionColors[3] = "FF07DAF7" --WotLK
C_ExpansionColors[4] = "FFEB8A0E" --Cata
C_ExpansionColors[5] = "FF00FF98" --MoP
C_ExpansionColors[6] = "FFA1481D" --WoD
C_ExpansionColors[7] = "FF00FF00" --Legion
C_ExpansionColors[8] = "FF056AC4" --BfA
C_ExpansionColors[9] = "FF888888" --SL
C_ExpansionColors[10] = "FFC90A67" --DF
C_ExpansionColors[11] = "FFFF7F27" --TWW
C_ExpansionColors[12] = "FF5C1FEA" --Midnight


local C_RemixColors = mct.C_RemixColors

C_RemixColors["MoP"] = "FF00FF98" --MoP
C_RemixColors["Legion"] = "FF00FF00" --Legion


local C_ExpansionGarrisonID = mct.C_ExpansionGarrisonID

C_ExpansionGarrisonID[2] = 0 --BC
C_ExpansionGarrisonID[3] = 0 --WotLK
C_ExpansionGarrisonID[4] = 0 --Cata
C_ExpansionGarrisonID[5] = "MoPReport" --MoP
C_ExpansionGarrisonID[6] = 2 --WoD
C_ExpansionGarrisonID[7] = 3 --Legion
C_ExpansionGarrisonID[8] = 9 --BfA
C_ExpansionGarrisonID[9] = 111 --SL
C_ExpansionGarrisonID[10] = "DF" --DF
C_ExpansionGarrisonID[11] = "TWW" --TWW
C_ExpansionGarrisonID[12] = "MN" --TWW

local C_ExpansionGarrisonMiddleClickOptions = mct.C_ExpansionGarrisonMiddleClickOptions

C_ExpansionGarrisonMiddleClickOptions["MoPReport"] = 5 --MoP
C_ExpansionGarrisonMiddleClickOptions[1] = 6 --WoD
C_ExpansionGarrisonMiddleClickOptions[2] = 7 --Legion
C_ExpansionGarrisonMiddleClickOptions[3] = 8 --Missions
C_ExpansionGarrisonMiddleClickOptions[4] = 9 --Covenant
C_ExpansionGarrisonMiddleClickOptions[5] = 10 --Dragon Isles
C_ExpansionGarrisonMiddleClickOptions[6] = 11 --Khaz Algar
C_ExpansionGarrisonMiddleClickOptions[7] = 12 --Khaz Algar

local C_ExpansionSummaries = mct.C_ExpansionSummaries

C_ExpansionSummaries["MoPReport"] = L["MiddleClickOption_Mists"] --MoP
C_ExpansionSummaries[1] = L["MiddleClickOption_Warlords"] --WoD
C_ExpansionSummaries[2] = L["MiddleClickOption_Legion"] --Legion
C_ExpansionSummaries[3] = L["MiddleClickOption_Missions"] --Missions
C_ExpansionSummaries[4] = L["MiddleClickOption_Covenant"] --Covenant
C_ExpansionSummaries[5] = L["MiddleClickOption_DragonIsles"] --Dragon Isles
C_ExpansionSummaries[6] = L["MiddleClickOption_KhazAlgar"] --Khaz Algar
C_ExpansionSummaries[7] = L["MiddleClickOption_Midnight"] --Midnight

mct.C_ClassTextures =
{
  ["DRUID"] = "Classhall-Circle-Druid",
  ["SHAMAN"] = "Classhall-Circle-Shaman",
  ["DEATHKNIGHT"] = "Classhall-Circle-DeathKnight",
  ["PALADIN"] = "Classhall-Circle-Paladin",
  ["WARRIOR"] = "Classhall-Circle-Warrior",
  ["HUNTER"] = "Classhall-Circle-Hunter",
  ["ROGUE"] = "Classhall-Circle-Rogue",
  ["PRIEST"] = "Classhall-Circle-Priest",
  ["MAGE"] = "Classhall-Circle-Mage",
  ["WARLOCK"] = "Classhall-Circle-Warlock",
  ["MONK"] = "Classhall-Circle-Monk",
  ["DEMONHUNTER"] = "Classhall-Circle-DemonHunter"
}

mct.C_GarrisonTextures =
{
  ["Alliance"] = "GarrLanding-MinimapIcon-Alliance-Up",
  ["Horde"] = "GarrLanding-MinimapIcon-Horde-Up",
}

mct.C_WarCampaignTextures =
{
  ["Alliance"] = "bfa-landingbutton-alliance-up",
  ["Horde"] = "bfa-landingbutton-horde-up",
}

mct.C_CovenantChoicesTextures =
{
    ["Necrolord"] = "shadowlands-landingbutton-Necrolord-up",
    ["NightFae"] = "shadowlands-landingbutton-NightFae-up",
    ["Venthyr"] = "shadowlands-landingbutton-Venthyr-up",
    ["Kyrian"] = "shadowlands-landingbutton-Kyrian-up",
    ["Not_Selected"] = "covenantsanctum-renown-icon-available-nightfae",
}

mct.C_LandingPagesTextures =
{
    ["DragonIsles"] = "dragonflight-landingbutton-up",
    ["KhazAlgar"] = "warwithin-landingbutton-up",
    ["Midnight"] = "UI-EventPoi-stormarionassault",
}

mct.C_ClassTabTextures =
{
  ["DRUID"] = "Interface\\Icons\\Classicon_druid",
  ["SHAMAN"] = "Interface\\Icons\\Classicon_shaman",
  ["DEATHKNIGHT"] = "Interface\\Icons\\Classicon_deathknight",
  ["PALADIN"] = "Interface\\Icons\\Classicon_paladin",
  ["WARRIOR"] = "Interface\\Icons\\Classicon_warrior",
  ["HUNTER"] = "Interface\\Icons\\Classicon_hunter",
  ["ROGUE"] = "Interface\\Icons\\Classicon_rogue",
  ["PRIEST"] = "Interface\\Icons\\Classicon_priest",
  ["MAGE"] = "Interface\\Icons\\Classicon_mage",
  ["WARLOCK"] = "Interface\\Icons\\Classicon_warlock",
  ["MONK"] = "Interface\\Icons\\Classicon_monk",
  ["DEMONHUNTER"] = "Interface\\Icons\\Classicon_demonhunter",
  ["EVOKER"] = "Interface\\Icons\\Classicon_evoker",
}

mct.C_PandariaTabTextures =
{
  ["Alliance"] = "Interface\\Icons\\inv_misc_tournaments_tabard_human",
  ["Horde"] = "Interface\\Icons\\inv_misc_tournaments_tabard_orc",
  ["Alliance_Map"] = "AllianceSymbol",
  ["Horde_Map"] = "HordeSymbol",
}

mct.C_GarrisonTabTextures =
{
  ["Alliance"] = "Interface\\Icons\\achievement_garrison_tier01_alliance",
  ["Horde"] = "Interface\\Icons\\achievement_garrison_tier01_horde",
}

mct.C_WarCampaignTabTextures =
{
  ["Alliance"] = "Interface\\Icons\\ui_allianceicon",
  ["Horde"] = "Interface\\Icons\\ui_hordeicon",
}

mct.C_CovenantChoicesTabTextures =
{
    ["Necrolord"] = "Interface\\Icons\\ui_sigil_necrolord",
    ["NightFae"] = "Interface\\Icons\\ui_sigil_nightfae",
    ["Venthyr"] = "Interface\\Icons\\ui_sigil_vanthyr",
    ["Kyrian"] = "Interface\\Icons\\ui_sigil_kyrian",
    ["Not_Selected"] = "Interface\\Icons\\inv_misc_covenant_renown",
}

mct.C_LandingPagesTabTextures =
{
    ["DragonIsles"] = "Interface\\Icons\\spell_arcane_teleportvaldrakken",
    ["KhazAlgar"] = "Interface\\Icons\\inv_achievement_alliedrace_earthen",
    ["Midnight"] = "Interface\\Icons\\inv_ability_voidweaverpriest_entropicrift",
}

mct.C_ButtonFrames =
{
    ["MoPReport"] = "ChromieTimeTrackerMoPReportIconFrame",
    [2] = "ChromieTimeTrackerGarrisonIconFrame",
    [3] = "ChromieTimeTrackerClassHallIconFrame",
    [9] = "ChromieTimeTrackerMissionsIconFrame",
    [111] = "ChromieTimeTrackerCovenantIconFrame",
    ["DF"] = "ChromieTimeTrackerDragonIslesIconFrame",
    ["TWW"] = "ChromieTimeTrackerKhazAlgarIconFrame",
    ["MN"] = "ChromieTimeTrackerMidnightIconFrame",
}

mct.C_CurrencyId =
{
    ["Garrison_Resources"] = 824,
    ["Garrison_Oil"] = 1101,
    ["Order_Resources"] = 1220,
    ["War_Resources"] = 1560,
    ["Reservoir_Anima"] = 1813,
    ["Bronze"] = 3252,
    ["Infinite_Knowledge"] = 3292,
    ["Infinite_Power"] = 3268,
}

C_SpecialTrackPinCoordinates = 
{
    ["Alliance_Chromie"] = {uiMapID = 84,
    position =
        {
            x = 0.5625,
            y = 0.1734
        },
	name = ""
    },
    ["Horde_Chromie"] = {uiMapID = 85,
        position = {
            x = 0.4082,
            y = 0.8018
        },
	name = ""
    },
    ["Alliance_Exp_Lock"] = {uiMapID = 84,
    position =
        {
            x = 0.8765,
            y = 0.3580
        },
	name = ""
    },
    ["Horde_Exp_Lock"] = {uiMapID = 85,
        position = {
            x = 0.7425,
            y = 0.4440
        },
	name = ""
    }
}

C_SUMARY_UNLOCK_QUEST_IDS = {
    [9] = {76326, 72973, 65806, 65849, 69911, 70122, 65452, 66114},
    [10] = {78536, 84967, 92031, 85005, 83096, 80082, 78671, 78393},
    [11] = {},
}

C_WORLD_BOSSES_QUEST_IDS = {
    ["LEGION"] = {43985, 42779, 42269, 42270, 43513, 43512, 43192, 43448, 44287, 43193, 42819, 91790, 91791, 91789},
}

C_WORLD_BOSSES_QUESTS_DATA = {
    [43985] = {uiMapID = 650, position = {x = 00, y = 00}},
    [42779] = {uiMapID = 641, position = {x = 00, y = 00}},
    [42269] = {uiMapID = 634, position = {x = 00, y = 00}},
    [42270] = {uiMapID = 634, position = {x = 00, y = 00}},
    [43513] = {uiMapID = 680, position = {x = 00, y = 00}},
    [43512] = {uiMapID = 680, position = {x = 00, y = 00}},
    [43192] = {uiMapID = 630, position = {x = 00, y = 00}},
    [43448] = {uiMapID = 650, position = {x = 00, y = 00}},
    [44287] = {uiMapID = 630, position = {x = 00, y = 00}},
    [43193] = {uiMapID = 630, position = {x = 00, y = 00}},
    [42819] = {uiMapID = 641, position = {x = 00, y = 00}},
    [91790] = {uiMapID = 646, position = {x = 00, y = 00}},
    [91791] = {uiMapID = 646, position = {x = 00, y = 00}},
    [91789] = {uiMapID = 646, position = {x = 00, y = 00}},
    [91792] = {uiMapID = 646, position = {x = 89.6, y = 33.0}},

}

C_LEGION_INVASION_POINTS = {
    [830] = "Krokuun",
    [885] = "Ermos Antoranos",
    [882] = "Eredath"
}