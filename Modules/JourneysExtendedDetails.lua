local name, mct = ...

-- ============================================================================
-- ENCOUNTER JOURNAL: CRIAÇÃO DA INTERFACE (EJDetailsFrame)
-- ============================================================================

EJDetailsFrame = CreateFrame("Frame", "ChromieTimeEJDetailsFrame", ChromieTimeTrackerRootFrame, "InsetFrameTemplate")
EJDetailsFrame:SetSize(360, 435)
EJDetailsFrame:EnableMouse(true)
EJDetailsFrame:Hide()

-- Métodos de exibição específicos
function EJDetailsFrame:DetailsShow()
    if EncounterJournal then
        self:ClearAllPoints()
        self:SetPoint("TOPLEFT", EncounterJournalJourneysFrame, "TOPRIGHT", 2, 25)
        self:SetParent(EncounterJournalJourneysFrame)
        self:Show()
    end
end

function EJDetailsFrame:DetailsHide()
    self:Hide()
end

EJDetailsFrame.DetailsClose = EJDetailsFrame.DetailsHide

-- Camadas de Texturas (Layers)
local BackgroundOverlay = EJDetailsFrame:CreateTexture(nil, "BACKGROUND")
BackgroundOverlay:SetAtlas("Professions-Recipe-Background")
BackgroundOverlay:SetTexCoord(0.4, 1.0, 0, 1.0)
BackgroundOverlay:SetAllPoints(EJDetailsFrame)

local TopCornerConnection = EJDetailsFrame:CreateTexture(nil, "ARTWORK")
TopCornerConnection:SetAtlas("collections-background-corner")
TopCornerConnection:SetDesaturated(true)
TopCornerConnection:SetSize(30, 22)
TopCornerConnection:SetPoint("TOPLEFT", EJDetailsFrame, "TOPLEFT", 0, 20)
TopCornerConnection:SetTexCoord(0, 1.0, 1.0, 0)

local BottomCornerConnection = EJDetailsFrame:CreateTexture(nil, "ARTWORK")
BottomCornerConnection:SetAtlas("collections-background-corner")
BottomCornerConnection:SetDesaturated(true)
BottomCornerConnection:SetSize(30, 22)
BottomCornerConnection:SetPoint("BOTTOMLEFT", EJDetailsFrame, "BOTTOMLEFT", 0, -20)

-- Sistema de Scroll
local ScrollFrame = CreateFrame("ScrollFrame", "ChromieTimeEJScrollFrame", EJDetailsFrame, "UIPanelScrollFrameTemplate")
ScrollFrame:SetSize(315, 410)
ScrollFrame:SetPoint("TOPLEFT", EJDetailsFrame, "TOPLEFT", 15, -15)

local ScrollChild = CreateFrame("Frame", nil, ScrollFrame)
ScrollChild:SetSize(315, 395)
ScrollFrame:SetScrollChild(ScrollChild)

local ScrollText = ScrollChild:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
ScrollText:SetPoint("TOPLEFT", ScrollChild, "TOPLEFT", 0, 0)
ScrollText:SetWidth(315)
ScrollText:SetJustifyH("LEFT")

-- ============================================================================
-- ENCOUNTER JOURNAL: LOGICA DE ATUALIZAÇÃO E EVENTOS
-- ============================================================================

local function UpdateEJData(tierID)
    if not tierID then return end
    local _dataToShow = ""

    if (_dataToShow ~= "") then
        ScrollText:SetText(_dataToShow)
        EJDetailsFrame:DetailsShow()
    else
        ScrollText:SetText("")
        EJDetailsFrame:DetailsHide()
    end
end

local function SincronizarEJ(janelaPai)
    if not janelaPai then return end

    janelaPai:HookScript("OnShow", function()
        EJDetailsFrame:DetailsShow()
        if EJ_GetCurrentTier then
            UpdateEJData(EJ_GetCurrentTier())
        end
    end)

    janelaPai:HookScript("OnHide", function()
        EJDetailsFrame:DetailsHide()
    end)
end

-- Monitoramento do carregamento do Addon da Blizzard
local EJEventListener = CreateFrame("Frame")
EJEventListener:RegisterEvent("ADDON_LOADED")
EJEventListener:SetScript("OnEvent", function(self, event, addonName)
    if addonName == "Blizzard_EncounterJournal" then
        SincronizarEJ(EncounterJournal)
        self:UnregisterEvent("ADDON_LOADED")
    end
end)

if EncounterJournal then SincronizarEJ(EncounterJournal) end

-- Listener da CVAR específica de troca de Tier do Encounter Journal
local CVarFrame = CreateFrame("Frame")
CVarFrame:RegisterEvent("CVAR_UPDATE")
CVarFrame:SetScript("OnEvent", function(self, event, cvarName, value)
    if cvarName == "EJSelectedTier" and EncounterJournal and EncounterJournal:IsShown() then
        if EJ_GetCurrentTier then
            UpdateEJData(EJ_GetCurrentTier())
        end
    end
end)

-- ============================================================================
-- COMANDOS DE CHAT (Para Alternar Ambas de forma Global/Desenvolvimento)
-- ============================================================================

SLASH_EXTENDEDDETAILS1 = "/edf"
SLASH_EXTENDEDDETAILS2 = "/extendeddetails"

SlashCmdList["EXTENDEDDETAILS"] = function(msg)
    if GarrisonDetailsFrame:IsShown() or EJDetailsFrame:IsShown() then
        GarrisonDetailsFrame:DetailsHide()
        EJDetailsFrame:DetailsHide()
    else
        if GarrisonLandingPage and GarrisonLandingPage:IsShown() then
            GarrisonDetailsFrame:DetailsShow()
        elseif EncounterJournal and EncounterJournal:IsShown() then
            EJDetailsFrame:DetailsShow()
        else
            print("Abra a janela do Garrison ou Encounter Journal primeiro.")
        end
    end
end