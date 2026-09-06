local name, mct = ...
local L = mct.L 

ProgressMonitor = {}


englishFaction, localizedFaction = UnitFactionGroup("player")

local PlayerInfo = {}
PlayerInfo["Name"] = ""
PlayerInfo["Class"] = englishClass
PlayerInfo["Faction"] = englishFaction
PlayerInfo["Timeline"] = ""


-- ============================================================================
-- CRIAÇÃO DA INTERFACE GRÁFICA (UI)
-- ============================================================================

-- 1. Janela Principal (Utiliza o template moderno de painéis da Blizzard)
local MainFrame = CreateFrame("Frame", "MyCampaignTrackerMainFrame", UIParent, "PortraitFrameTemplate")
MainFrame.PortraitContainer.portrait:SetTexture("Interface\\AddOns\\ChromieTimeTracker\\Chromie.png");
--local MainFrame = CreateFrame("Frame", "MyCampaignTrackerMainFrame", UIParent, "DefaultPanelTemplate")
MainFrame:SetSize(800, 500) 
MainFrame:SetPoint("CENTER", UIParent, "CENTER") 
MainFrame:SetMovable(true)
MainFrame:EnableMouse(true)
MainFrame:RegisterForDrag("LeftButton")
MainFrame:SetScript("OnDragStart", MainFrame.StartMoving)
MainFrame:SetScript("OnDragStop", MainFrame.StopMovingOrSizing)

MainFrame:SetTitle(L["AddonName"] .. " - " .. "Guia de Campanha")

local CloseButton = CreateFrame("Button", nil, MainFrame, "UIPanelCloseButton")
CloseButton:SetPoint("TOPRIGHT", MainFrame, "TOPRIGHT", 0, 0)
--CloseButton:SetSize(18, 18)
CloseButton:SetScript("OnClick", function() MainFrame:Hide() PlaySound(170568) end)

local ScrollContainer = CreateFrame("ScrollFrame", "$parentScrollFrame", MainFrame, "UIPanelScrollFrameTemplate")
--ScrollContainer:SetPoint("TOPLEFT", MainFrame, "TOPLEFT", 15, -35)
ScrollContainer:SetPoint("TOPLEFT", MainFrame, "TOPLEFT", 15, -55)
ScrollContainer:SetPoint("BOTTOMRIGHT", MainFrame, "BOTTOMRIGHT", -30, 15)

local ScrollContent = CreateFrame("Frame", nil, ScrollContainer)
ScrollContent:SetSize(740, 1) -- Define a largura útil interna com base no tamanho da janela
ScrollContainer:SetScrollChild(ScrollContent)

-- ============================================================================
-- FUNÇÃO DE RENDERIZAÇÃO E ATUALIZAÇÃO DINÂMICA
-- ============================================================================
local function PopulateTracker()

    local collapsedExpansions = {}

    if not ChromieTimeTrackerDB.collapsedExpansions then
        ChromieTimeTrackerDB.collapsedExpansions = collapsedExpansions
    end

    if ScrollContent.DisplayFrames then
        for _, frame in ipairs(ScrollContent.DisplayFrames) do
            frame:Hide()
            frame:SetParent(nil)
        end
    end
    ScrollContent.DisplayFrames = {}

    local yOffset = -10 
    local paddingLeft = 10 
    local contentWidth = 740 

    -- --- ORDENAÇÃO DAS EXPANSÕES ---
    local orderedExpansions = {}
    for expId, expData in pairs(CTTCampaignData) do
        table.insert(orderedExpansions, {
            id = expId,
            data = expData
        })
    end

    table.sort(orderedExpansions, function(a, b)
        return (a.data.expansionOrder or 0) < (b.data.expansionOrder or 0)
    end)

    for _, expItem in ipairs(orderedExpansions) do
        local expId = expItem.id
        local expData = expItem.data
        
        -- --- CÁLCULO DE PROGRESSO DA EXPANSÃO ---
        local totalChains = 0
        local completedChains = 0

        for _, campData in pairs(expData.campaigns) do
            for _, questData in pairs(campData.keyMissions) do
                if campData.faction == PlayerInfo["Faction"] or campData.faction == "" then
                    totalChains = totalChains + 1
                    if C_QuestLog.IsQuestFlaggedCompleted(questData.endMissionId) then
                        completedChains = completedChains + 1
                    end
                end
            end
        end

        -- --- A. LINHA DA EXPANSÃO ---
        local expButton = CreateFrame("Button", nil, ScrollContent)
        expButton:SetSize(contentWidth, 26)
        expButton:SetPoint("TOPLEFT", ScrollContent, "TOPLEFT", paddingLeft, yOffset)
        table.insert(ScrollContent.DisplayFrames, expButton)
        
                local btnBgBorderFrame = CreateFrame("Frame", nil, expButton, "BackdropTemplate")
btnBgBorderFrame:SetPoint("TOPLEFT", expButton, "TOPLEFT", -2, 2)
btnBgBorderFrame:SetPoint("BOTTOMRIGHT", expButton, "BOTTOMRIGHT", 2, -2)

local bgTex = btnBgBorderFrame:CreateTexture(nil, "BACKGROUND", nil, -8)
bgTex:SetAtlas("activities-complete")
bgTex:SetPoint("TOPLEFT", btnBgBorderFrame, "TOPLEFT", -6, 1)
bgTex:SetPoint("BOTTOMRIGHT", btnBgBorderFrame, "BOTTOMRIGHT", 8, -1)

btnBgBorderFrame:SetFrameLevel(expButton:GetFrameLevel())

        local isCollapsed = ChromieTimeTrackerDB.collapsedExpansions[expId]
        local prefix = isCollapsed and "|cFFFFD100[+]|r " or "|cFFFFD100[-]|r "
        
        local expLabel = expButton:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        expLabel:SetPoint("LEFT", expButton, "LEFT", 8, 0)
        expLabel:SetText(prefix .. string.format("%s", expData.expansionName))
        
        --expButton:SetScript("OnEnter", function(self) self.bg:SetColorTexture(0.3, 0.3, 0.3, 0.9) end)
        --expButton:SetScript("OnLeave", function(self) self.bg:SetColorTexture(0.15, 0.15, 0.15, 0.8) end)
        
-- --- BARRA DE PROGRESSO ---
        local progressBar = CreateFrame("StatusBar", nil, expButton)
        progressBar:SetSize(150, 14) 
        progressBar:SetPoint("RIGHT", expButton, "RIGHT", -10, 0) 
        progressBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar") 
        progressBar:SetStatusBarColor(0, 0.7, 0, 1) 
        
        local bgBar = progressBar:CreateTexture(nil, "BACKGROUND")
        bgBar:SetAllPoints(progressBar)
        bgBar:SetColorTexture(0, 0, 0, 0.6)

        -- --- MOLDURA DE BORDA ---
        local borderFrame = CreateFrame("Frame", nil, progressBar, "BackdropTemplate")
        borderFrame:SetPoint("TOPLEFT", progressBar, "TOPLEFT", -2, 2)
        borderFrame:SetPoint("BOTTOMRIGHT", progressBar, "BOTTOMRIGHT", 2, -2)
        borderFrame:SetBackdrop({
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", -- Textura de borda fina universal do WoW
            edgeSize = 10,
            insets = { left = 1, right = 1, top = 1, bottom = 1 }
        })
        borderFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 0.8) -- Cor cinza estilo reputação

        local percentage = totalChains > 0 and math.floor((completedChains / totalChains) * 100) or 0

        local progressText = progressBar:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        progressText:SetPoint("CENTER", progressBar, "CENTER", 0, 0)
        progressText:SetText(string.format("%d%% (%d/%d)", percentage, completedChains, totalChains))

        progressBar:SetMinMaxValues(0, totalChains > 0 and totalChains or 1)
        progressBar:SetValue(completedChains)

        expButton:SetScript("OnClick", function()
            ChromieTimeTrackerDB.collapsedExpansions[expId] = not ChromieTimeTrackerDB.collapsedExpansions[expId]
            PopulateTracker() 
        end)

        yOffset = yOffset - 30

        -- --- B. CONTEÚDO DA EXPANSÃO ---
        if not isCollapsed then
            
            local orderedCampaigns = {}
            for campId, campData in pairs(expData.campaigns) do
                table.insert(orderedCampaigns, {
                    id = campId,
                    data = campData
                })
            end
            
            table.sort(orderedCampaigns, function(a, b)
                return (a.data.recomendedOrder or 0) < (b.data.recomendedOrder or 0)
            end)

            for _, item in ipairs(orderedCampaigns) do
                local campData = item.data
                
                if campData.faction == PlayerInfo["Faction"] or campData.faction == "" then
                
                local campFrame = CreateFrame("Frame", nil, ScrollContent)
                campFrame:SetSize(contentWidth, 18)
                campFrame:SetPoint("TOPLEFT", ScrollContent, "TOPLEFT", paddingLeft + 15, yOffset)
                table.insert(ScrollContent.DisplayFrames, campFrame)

                local campLabel = campFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
                campLabel:SetPoint("LEFT", campFrame, "LEFT", 0, 0)
                if campData.category == "" then
                    campLabel:SetText(string.format("• %s", campData.campaignName))
                else
                    campLabel:SetText(string.format("• %s [%s]", campData.campaignName, campData.category))
                end
                
                yOffset = yOffset - 18

                for startQuestId, questData in pairs(campData.keyMissions) do
                    
                    local questFrame = CreateFrame("Frame", nil, ScrollContent)
                    questFrame:SetSize(contentWidth, 15)
                    questFrame:SetPoint("TOPLEFT", ScrollContent, "TOPLEFT", paddingLeft + 35, yOffset)
                    table.insert(ScrollContent.DisplayFrames, questFrame)

                    local isStartInQuestLog = IsQuestInProgress(startQuestId)
                    local isStartCompleted = C_QuestLog.IsQuestFlaggedCompleted(startQuestId)
                    local isEndCompleted = C_QuestLog.IsQuestFlaggedCompleted(questData.endMissionId)
                    
                    local statusColor = isEndCompleted and "|cFF00FF00Concluído|r" 
                                     or (isStartCompleted and "|cFFFFFF00Em Andamento|r" 
                                     or (isStartInQuestLog and "|cFFFFFF00Em Andamento|r" or "|cFF999999Não Iniciado|r"))

                    local questLabel = questFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
                    questLabel:SetPoint("LEFT", questFrame, "LEFT", 0, 0)
                    
                    local questText = string.format(
                        "Inicia com: '%s' || Termina com '%s' - %s", 
                        questData.startMissionName, 
                        questData.endMissionName, 
                        statusColor
                    )
                    questLabel:SetText(questText)
                    
                    yOffset = yOffset - 15
                end
                yOffset = yOffset - 4
                end
            end
            yOffset = yOffset - 6
        end
        yOffset = yOffset - 4
    end

    ScrollContent:SetHeight(math.abs(yOffset))
end

MainFrame:Hide()

function ProgressMonitor:CampaignGuide()
    if MainFrame:IsShown() then
        PlaySound(170568)
        MainFrame:Hide()
    else
        PopulateTracker()
        PlaySound(170567)
        MainFrame:Show()
    end
end
