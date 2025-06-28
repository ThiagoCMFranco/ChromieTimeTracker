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
mct.C_ExpansionGarrisonID = {}
mct.C_ExpansionGarrisonMiddleClickOptions = {}
mct.C_ExpansionSummaries = {}
mct.C_ClassTextures = {}
mct.C_GarrisonTextures = {}
mct.C_WarCampaignTextures = {}
mct.C_CovenantChoicesTextures = {}
mct.C_LandingPagesTextures = {}
mct.C_ClassTabTextures = {}
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
C_ExpansionColors[11] = "FF7F27" --TWW


local C_ExpansionGarrisonID = mct.C_ExpansionGarrisonID

C_ExpansionGarrisonID[2] = 0 --BC
C_ExpansionGarrisonID[3] = 0 --WotLK
C_ExpansionGarrisonID[4] = 0 --Cata
C_ExpansionGarrisonID[5] = 0 --MoP
C_ExpansionGarrisonID[6] = 2 --WoD
C_ExpansionGarrisonID[7] = 3 --Legion
C_ExpansionGarrisonID[8] = 9 --BfA
C_ExpansionGarrisonID[9] = 111 --SL
C_ExpansionGarrisonID[10] = "DF" --DF
C_ExpansionGarrisonID[11] = "TWW" --TWW

local C_ExpansionGarrisonMiddleClickOptions = mct.C_ExpansionGarrisonMiddleClickOptions

C_ExpansionGarrisonMiddleClickOptions[1] = 6 --WoD
C_ExpansionGarrisonMiddleClickOptions[2] = 7 --Legion
C_ExpansionGarrisonMiddleClickOptions[3] = 8 --Missions
C_ExpansionGarrisonMiddleClickOptions[4] = 9 --Covenant
C_ExpansionGarrisonMiddleClickOptions[5] = 10 --Dragon Isles
C_ExpansionGarrisonMiddleClickOptions[6] = 11 --Khaz Algar

local C_ExpansionSummaries = mct.C_ExpansionSummaries

C_ExpansionSummaries[1] = L["MiddleClickOption_Warlords"] --WoD
C_ExpansionSummaries[2] = L["MiddleClickOption_Legion"] --Legion
C_ExpansionSummaries[3] = L["MiddleClickOption_Missions"] --Missions
C_ExpansionSummaries[4] = L["MiddleClickOption_Covenant"] --Covenant
C_ExpansionSummaries[5] = L["MiddleClickOption_DragonIsles"] --Dragon Isles
C_ExpansionSummaries[6] = L["MiddleClickOption_KhazAlgar"] --Khaz Algar

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
}

mct.C_ButtonFrames =
{
    [2] = "ChromieTimeTrackerGarrisonIconFrame",
    [3] = "ChromieTimeTrackerClassHallIconFrame",
    [9] = "ChromieTimeTrackerMissionsIconFrame",
    [111] = "ChromieTimeTrackerCovenantIconFrame",
    ["DF"] = "ChromieTimeTrackerDragonIslesIconFrame",
    ["TWW"] = "ChromieTimeTrackerKhazAlgarIconFrame",
}

mct.C_CurrencyId =
{
    ["Garrison_Resources"] = 824,
    ["Garrison_Oil"] = 1101,
    ["Order_Resources"] = 1220,
    ["War_Resources"] = 1560,
    ["Reservoir_Anima"] = 1813,
}