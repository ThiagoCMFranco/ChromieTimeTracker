ExportModule = {}

local name, mct = ...
local L = mct.L 

-- Instanciação das bibliotecas necessárias via LibStub
local LibSerialize = LibStub:GetLibrary("LibSerialize")
local LibDeflate = LibStub:GetLibrary("LibDeflate")

-------------------------------------------------------------------------------
-- CRIAÇÃO DA INTERFACE GRÁFICA (UI)
-------------------------------------------------------------------------------
local frame = nil

local function CreateExportWindow()
    if frame then return frame end -- Evita criar mais de uma janela

    -- Janela Principal
    frame = CreateFrame("Frame", "WoWAddonExportFrame", UIParent, "BackdropTemplate")
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
    frame:SetBackdropColor(0.05, 0.05, 0.05, 0.8) -- Deixa o fundo quase preto e semi-transparente

    -- Título
    local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOP", frame, "TOP", 0, -10)
    title:SetText(L["buttonExportSettings"])

    -- Botão Fechar
    local closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -5, -5)

    -- Container de Rolagem (ScrollFrame)
    local scrollFrame = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 15, -35)
    scrollFrame:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -35, 15)

    -- Campo de Texto (EditBox)
    local editBox = CreateFrame("EditBox", nil, scrollFrame)
    editBox:SetMultiLine(true)
    editBox:SetMaxLetters(999999) -- Limite alto para suportar DBs grandes
    editBox:SetFontObject("GameFontHighlightSmall")
    editBox:SetWidth(380)
    
    -- Scripts do EditBox para facilitar a cópia
    editBox:SetScript("OnEscapePressed", function() frame:Hide() end)
    
    scrollFrame:SetScrollChild(editBox)
    
    -- Guarda a referência do editbox no frame principal para atualizar depois
    frame.editBox = editBox

    return frame
end

-------------------------------------------------------------------------------
-- FUNÇÃO PÚBLICA PARA EXPORTAR
-------------------------------------------------------------------------------
-- Use esta função passando a tabela do seu DB como argumento
function ExportModule:ShowExportWindow(databaseTable)
    if type(databaseTable) ~= "table" then
        print(L["exportFail"])
        return
    end

    -- Garante que a janela foi criada
    local f = CreateExportWindow()
    
    -- 1. Serializa a tabela Lua em uma string binária
    local serializedData = LibSerialize:Serialize(databaseTable)
    
    -- 2. Compacta os dados binários usando Deflate
    local compressedData = LibDeflate:CompressDeflate(serializedData)
    
    -- 3. Codifica o resultado em formato seguro para impressão/cópia no WoW
    local exportString = LibDeflate:EncodeForPrint(compressedData)
    
    -- Injeta o texto na caixa e exibe a janela
    f.editBox:SetText(exportString)
    f:Show()
    
    -- Auto-seleciona o texto para o usuário apenas dar Ctrl+C
    f.editBox:HighlightText()
    f.editBox:SetFocus()
end