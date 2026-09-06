local name, mct = ...
local L = mct.L 
local C_ExpansionGarrisonID = mct.C_ExpansionGarrisonID

-- ============================================================================
-- GARRISON: CRIAÇÃO DA INTERFACE (GarrisonDetailsFrame)
-- ============================================================================

GarrisonDetailsFrame = CreateFrame("Frame", "ChromieTimeGarrisonDetailsFrame", ChromieTimeTrackerRootFrame, "InsetFrameTemplate")
GarrisonDetailsFrame:SetSize(360, 435)
GarrisonDetailsFrame:EnableMouse(true)
GarrisonDetailsFrame:Hide()

-- Métodos de exibição específicos
function GarrisonDetailsFrame:DetailsShow()
    if GarrisonLandingPage then
        self:ClearAllPoints()
        self:SetPoint("TOPLEFT", GarrisonLandingPage, "TOPRIGHT", -12, -52)
        self:SetParent(GarrisonLandingPage)
        self:Show()
    end
end

function GarrisonDetailsFrame:DetailsHide()
    self:Hide()
end

GarrisonDetailsFrame.DetailsClose = GarrisonDetailsFrame.DetailsHide

-- Camadas de Texturas (Layers)
local BackgroundOverlay = GarrisonDetailsFrame:CreateTexture(nil, "BACKGROUND")
BackgroundOverlay:SetAtlas("Professions-Recipe-Background")
BackgroundOverlay:SetTexCoord(0.4, 1.0, 0, 1.0)
BackgroundOverlay:SetAllPoints(GarrisonDetailsFrame)

local TopCornerConnection = GarrisonDetailsFrame:CreateTexture(nil, "ARTWORK")
TopCornerConnection:SetAtlas("collections-background-corner")
TopCornerConnection:SetDesaturated(true)
TopCornerConnection:SetSize(30, 22)
TopCornerConnection:SetPoint("TOPLEFT", GarrisonDetailsFrame, "TOPLEFT", 0, 20)
TopCornerConnection:SetTexCoord(0, 1.0, 1.0, 0)

local BottomCornerConnection = GarrisonDetailsFrame:CreateTexture(nil, "ARTWORK")
BottomCornerConnection:SetAtlas("collections-background-corner")
BottomCornerConnection:SetDesaturated(true)
BottomCornerConnection:SetSize(30, 22)
BottomCornerConnection:SetPoint("BOTTOMLEFT", GarrisonDetailsFrame, "BOTTOMLEFT", 0, -20)

-- Sistema de Scroll
local ScrollFrame = CreateFrame("ScrollFrame", "ChromieTimeGarrisonScrollFrame", GarrisonDetailsFrame, "UIPanelScrollFrameTemplate")
ScrollFrame:SetSize(315, 410)
ScrollFrame:SetPoint("TOPLEFT", GarrisonDetailsFrame, "TOPLEFT", 15, -15)

local ScrollChild = CreateFrame("Frame", nil, ScrollFrame)
ScrollChild:SetSize(315, 395)
ScrollFrame:SetScrollChild(ScrollChild)

local ScrollText = ScrollChild:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
ScrollText:SetPoint("TOPLEFT", ScrollChild, "TOPLEFT", 0, 0)
ScrollText:SetWidth(315)
ScrollText:SetJustifyH("LEFT")

-- ============================================================================
-- GARRISON: LOGICA DE ATUALIZAÇÃO E SINCRONIZAÇÃO
-- ============================================================================

local function UpdateGarrisonData(_LandingPageId)
    if (_LandingPageId == 3) then
        local _LegionRemixExtraData = ""
        local showInvasionHeader = true

        if (ChromieTimeTrackerDB.ShowLegionArgusInvasionTracker) then
            local LegionArgusInvasionLine = LegionArgusInvasionTooltipLine(true)

            if (LegionArgusInvasionLine ~= "") then
                if (showInvasionHeader) then
                    _LegionRemixExtraData = _LegionRemixExtraData .. "\n\n" .. L["Legion_Invasion_Header"]
                else
                    _LegionRemixExtraData = _LegionRemixExtraData .. "\n"
                end
                _LegionRemixExtraData = _LegionRemixExtraData .. LegionArgusInvasionLine
            end
        end

        if (ChromieTimeTrackerDB.ShowWorldBosses) then
            local showWorldBossesHeader = true
            
            for _, TaskQuestId in pairs(C_WORLD_BOSSES_QUEST_IDS["LEGION"]) do
                local _LegionWorldBossQuestData = CTT_VerifyQuestCompleted(TaskQuestId)
                if (_LegionWorldBossQuestData[3]) then
                    if (showWorldBossesHeader) then
                        _LegionRemixExtraData = _LegionRemixExtraData .. "\n\n" .. L["World_Bosses_Header"]    
                        showWorldBossesHeader = false
                    end
                    if (_LegionWorldBossQuestData[2]) then
                        _LegionRemixExtraData = _LegionRemixExtraData .. "\n|cFF00FF00" .. CreateInlineIcon("vignettekillboss", 20, 20) .. _LegionWorldBossQuestData[1] .. "|r" .. " - " .. _LegionWorldBossQuestData[4]
                    else
                        _LegionRemixExtraData = _LegionRemixExtraData .. "\n|cFFFFFFFF" .. CreateInlineIcon("vignettekillboss", 20, 20) .. _LegionWorldBossQuestData[1] .. "|r" .. " - " .. _LegionWorldBossQuestData[4]
                    end
                end
            end
        end

        ScrollText:SetText(_LegionRemixExtraData)

        if (_LegionRemixExtraData == "") then
            GarrisonDetailsFrame:DetailsHide()
        else
            GarrisonDetailsFrame:DetailsShow()
        end
    else
        -- Caso seja outra Landing Page, limpa e oculta
        ScrollText:SetText("")
        GarrisonDetailsFrame:DetailsHide()
    end
end

local function SincronizarGarrison(janelaPai)
    if not janelaPai then return end
    
    janelaPai:HookScript("OnShow", function()
        -- Quando a interface abre, valida o ID atual da Garrison aberta
        if GarrisonLandingPage.garrisonType then
            UpdateGarrisonData(GarrisonLandingPage.garrisonType)
        end
    end)

    janelaPai:HookScript("OnHide", function()
        GarrisonDetailsFrame:DetailsHide()
    end)
end

-- Monitoramento do carregamento do Addon da Blizzard
local GarrisonEventListener = CreateFrame("Frame")
GarrisonEventListener:RegisterEvent("ADDON_LOADED")
GarrisonEventListener:SetScript("OnEvent", function(self, event, addonName)
    if addonName == "Blizzard_GarrisonUI" then
        SincronizarGarrison(GarrisonLandingPage)
        self:UnregisterEvent("ADDON_LOADED")
    end
end)

if GarrisonLandingPage then SincronizarGarrison(GarrisonLandingPage) end

-- Hook seguro para interceptar a troca de abas/páginas na interface do Garrison
hooksecurefunc("ShowGarrisonLandingPage", function(_LandingPageId)
    UpdateGarrisonData(_LandingPageId)
end)