
Profile = {}

local name, mct = ...
local L = mct.L 

-- Instanciação das bibliotecas necessárias via LibStub
local LibSerialize = LibStub:GetLibrary("LibSerialize")
local LibDeflate = LibStub:GetLibrary("LibDeflate")

function Profile:SaveToGlobalProfile(databaseTable, variableToSave)
    if type(databaseTable) ~= "table" then
        print(L["exportFail"])
        return
    end
    
    -- 1. Serializa a tabela Lua em uma string binária
    local serializedData = LibSerialize:Serialize(databaseTable)
    
    -- 2. Compacta os dados binários usando Deflate
    local compressedData = LibDeflate:CompressDeflate(serializedData)
    
    -- 3. Codifica o resultado em formato seguro
    local exportString = LibDeflate:EncodeForPrint(compressedData)
    
    if variableToSave.GlobalProfile == nil then
        variableToSave.GlobalProfile = {}
    end

    variableToSave.GlobalProfile = exportString

    print(L["AddonName"] .. " - " .. L["GlobalExportSuccess"])
    ChromieTimeTrackerUtil:ExtendedFlashMessage(L["GlobalExportSuccess"], 5, 1.5, 2, 39516)

end


function Profile:LoadFromGlobalProfile(databaseCallback, variableToLoad, silent)

        local luaTable = nil

        local success, result = pcall(function()
            local compressedData = LibDeflate:DecodeForPrint(variableToLoad.GlobalProfile)
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
            if((ChromieTimeTrackerDB.WelcomeMessageVisibility == nil) or (ChromieTimeTrackerDB.WelcomeMessageVisibility == 1) or (ChromieTimeTrackerDB.WelcomeMessageVisibility == 2 and currentExpansionName ~= L['currentExpansionLabel'])) then
                print(L["AddonName"] .. " - " .. L["GlobalImportSuccess"])
            end
            if not silent then
                ChromieTimeTrackerUtil:ExtendedFlashMessage(L["GlobalImportSuccess"], 5, 1.5, 2, 39516)
            end
        else
            ChromieTimeTrackerUtil:FlashMessage(L["GlobalImportFail"], 5, 1.5)
            print(L["AddonName"] .. " - " .. L["GlobalImportFail"])
        end
end