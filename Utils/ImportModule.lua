ImportModule = {}

local name, mct = ...
local L = mct.L 

-- Instanciação das bibliotecas necessárias via LibStub
local LibSerialize = LibStub:GetLibrary("LibSerialize")
local LibDeflate = LibStub:GetLibrary("LibDeflate")

-------------------------------------------------------------------------------
-- CRIAÇÃO DA INTERFACE GRÁFICA (UI)
-------------------------------------------------------------------------------
local frame = nil

local function CreateImportWindow()
    if frame then return frame end

    -- Janela Principal
    frame = CreateFrame("Frame", "WoWAddonImportFrame", UIParent, "BackdropTemplate")
    frame:SetSize(450, 350)
    frame:SetPoint("CENTER")
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
    frame:SetClampedToScreen(true)
    frame:SetFrameStrata("TOOLTIP")
    frame:SetFrameLevel(100)

    -- Fundo
    frame:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    })
    frame:SetBackdropColor(0.05, 0.05, 0.05, 0.8)

    -- Título
    local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOP", frame, "TOP", 0, -10)
    title:SetText(L["buttonImportSettings"])

    -- Botão Fechar
    local closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -5, -5)

    -- Caixa de Rolagem
    local scrollFrame = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 15, -35)
    scrollFrame:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -35, 50)

    -- Campo de Texto (EditBox) vazia para colar
    local editBox = CreateFrame("EditBox", nil, scrollFrame)
    editBox:SetMultiLine(true)
    editBox:SetMaxLetters(999999)
    editBox:SetFontObject("GameFontHighlightSmall")
    editBox:SetWidth(380)
    editBox:SetScript("OnEscapePressed", function() frame:Hide() end)
    scrollFrame:SetScrollChild(editBox)
    frame.editBox = editBox

    -- Botão Salvar / Importar / Recarregar
    local importButton = CreateFrame("Button", nil, frame, "GameMenuButtonTemplate")
    importButton:SetSize(160, 25)
    importButton:SetPoint("BOTTOM", frame, "BOTTOM", 0, 15)
    importButton:SetText(L["buttonSaveApply"])
    
    frame.importButton = importButton

    importButton:SetScript("OnClick", function(self)
        if self.isReadyToReload then
            frame:Hide()
            ReloadUI()
            return
        end

        -- CASO CONTRÁRIIO: Processa a importação do texto
        local text = frame.editBox:GetText()
        if text then text = text:trim() end 
        
        if text and text ~= "" then
            if frame.callback then
                frame.callback(text)
            end
        else
            frame:Hide()
        end
    end)

    return frame
end

-------------------------------------------------------------------------------
-- FUNÇÃO PÚBLICA PARA IMPORTAR
-------------------------------------------------------------------------------
function ImportModule:ShowImportWindow(databaseCallback)
    
    local f = CreateImportWindow()
    f:Show()
    f.editBox:SetText("") 
    f.editBox:SetFocus()  
    
    f.importButton.isReadyToReload = false
    f.importButton:SetText(L["buttonSaveApply"])
    f.editBox:SetEnabled(true)
    
    f.callback = function(encodedText)
        local luaTable = nil

        local success, result = pcall(function()
            local compressedData = LibDeflate:DecodeForPrint(encodedText)
            if not compressedData then return nil end

            local serializedData = LibDeflate:DecompressDeflate(compressedData)
            if not serializedData then return nil end

            local successDeserialize, decodedTable = LibSerialize:Deserialize(serializedData)
            if successDeserialize then
                return decodedTable
            end
            return nil
        end)

        if success and result then
            luaTable = result
        end
        
        if luaTable and type(luaTable) == "table" then
            -- Passa os dados salvos para o seu Core
            databaseCallback(luaTable)
            
            -- Feedback Visual de Sucesso
            print(L["importSuccess"])
            
            f.editBox:SetEnabled(false)
            f.importButton.isReadyToReload = true
            f.importButton:SetText(L["buttonReloadUI"])
        else
            print(L["importFail"])
            f:Hide()
        end
    end
end