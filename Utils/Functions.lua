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

function CreateInlineIcon(atlasNameOrTexID, sizeX, sizeY, xOffset, yOffset)
	sizeX = sizeX or 16;
	sizeY = sizeY or sizeX;
	xOffset = xOffset or 0;
	yOffset = yOffset or 0;

	if (type(atlasNameOrTexID) == "number") then
		-- REF.: CreateTextureMarkup(file, fileWidth, fileHeight, width, height, left, right, top, bottom, xOffset, yOffset)
		return CreateTextureMarkup(atlasNameOrTexID, 0, 0, sizeX, sizeY, 0, 0, 0, 0, xOffset, yOffset);  --> keep original color
		-- return string.format("|T%d:%d:%d:%d:%d|t", atlasNameOrTexID, size, size, xOffset, yOffset);
	end
	-- if ( type(atlasNameOrTexID) == "string" or tonumber(atlasNameOrTexID) ~= nil ) then
	if (type(atlasNameOrTexID) == "string") then
		-- REF.: CreateAtlasMarkup(atlasName, width, height, offsetX, offsetY, rVertexColor, gVertexColor, bVertexColor)
		return CreateAtlasMarkup(atlasNameOrTexID, sizeX, sizeY, xOffset, yOffset);  --> keep original color
	end

	return ''
end

function getCovenantData()
    local l_Covenant = "Not_Selected"
    local l_CovenantID = C_Covenants.GetActiveCovenantID()
    local _CovenantData = {}
    local _ActiveCovenantName = "-"
	
        if l_CovenantID == 1 then
            l_Covenant = "Kyrian"
            _CovenantData = C_Covenants.GetCovenantData(l_CovenantID)
            _ActiveCovenantName = "- ".. _CovenantData.name .. " -"
        end
        if l_CovenantID == 2 then
            l_Covenant = "Venthyr"
            _CovenantData = C_Covenants.GetCovenantData(l_CovenantID)
            _ActiveCovenantName = "- ".. _CovenantData.name .. " -"
        end
        if l_CovenantID == 3 then
            l_Covenant = "NightFae"
            _CovenantData = C_Covenants.GetCovenantData(l_CovenantID)
            _ActiveCovenantName = "- ".. _CovenantData.name .. " -"
        end
        if l_CovenantID == 4 then
            l_Covenant = "Necrolord"
            _CovenantData = C_Covenants.GetCovenantData(l_CovenantID)
            _ActiveCovenantName = "- ".. _CovenantData.name .. " -"
        end

    local L_CovenantData = {
        l_Covenant, l_CovenantID, _ActiveCovenantName, _CovenantData
    }
    return L_CovenantData
end

--getFormatedCurrencyById
function getCurrencyById(_currencyId, _showCurrencyName) 
    local warband = ""
    local _currency = {}
    _currency = C_CurrencyInfo.GetCurrencyInfo(_currencyId)
    if(_currency.isAccountWide) then
        warband = CreateInlineIcon("warbands-icon")
    end

    local iconString = CreateInlineIcon(_currency.iconFileID)
    if(_showCurrencyName) then
        return _currency.name .. ": |cFFFFFFFF" .. _currency.quantity .. "|r " .. iconString .. warband
    else
        return "|cFFFFFFFF" .. _currency.quantity .. "|r " .. iconString .. warband
    end
end

function CTT_OpenWorldMap(mapId)

    --627 - Legion - Dalaran
    --1161 - BFA - Estreito Tiragarde
    --862 - BFA - Zuldazar

    local mId = mapId

    if(mapId == 627) then --Legion
        mId = 619
    elseif(mapId == 1161) then --Alliance Battle for Azeroth
        mId = 876
    elseif(mapId == 862) then --Horde Battle for Azeroth
        mId = 875
    else
        mId = mapId
    end

    C_Map.OpenWorldMap(mId)
end