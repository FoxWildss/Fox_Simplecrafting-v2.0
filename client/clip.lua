local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}

local CurrentCraft = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
	end
	
    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, Config.CraftZones.Clip.coords, true) < 1 then
			ESX.ShowHelpNotification(_U('crafting_prompt'))
			
			if IsControlJustReleased(0, Keys['E']) then
                if Config.WhitelistOnly then
                    if PlayerData.job and (PlayerData.job.name == Config.Whitelist1 or PlayerData.job.name == Config.Whitelist2 or PlayerData.job.name == Config.Whitelist3 or PlayerData.job.name == Config.Whitelist4 or PlayerData.job.name == Config.Whitelist5) then
                    BukaMenuClip()
                    else
                        exports['mythic_notify']:SendAlert('error', _U('no_allow'))
                    end
                else
                    BukaMenuClip()
                end
			end
		else
			Citizen.Wait(500)
		end
	end
end)

function BukaMenuClip()
    local elements = {}
    for item, v in pairs(Crafting.Clip) do
        local elementlabel = v.label .. " "
        local somecount = 1
        for k, need in pairs(v.needs) do
            if somecount == 1 then
                somecount = somecount + 1
                elementlabel = elementlabel
            else
                elementlabel = elementlabel
            end
        end
        table.insert(elements, {value = item, label = elementlabel})
    end
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'crafting_actions', {
		title    = _U('crafting_item'),
		align    = 'bottom-right',
		elements = elements
    }, function(data, menu)
        menu.close()
        CurrentCraft = data.current.value
        ESX.TriggerServerCallback('fox_simplecrafting:CekClip', function(result)
            if result then
                TriggerEvent("mythic_progbar:client:progress", {
                    name = "fox_simplecrafting",
                    duration = 35000,
                    label = 'Crafting Item',
                    useWhileDead = true,
                    canCancel = false,
                    controlDisables = {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    },
                    animation = {
                        animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                        anim = "machinic_loop_mechandplayer",
                        flags = 49,
                    },
                }, function(status)
                    if not status then
                        -- Do Something If Event Wasn't Cancelled
                    end
                end)
                Citizen.Wait(35000)
                TriggerServerEvent("fox_simplecrafting:CraftingClip", CurrentCraft)
            else
                exports['mythic_notify']:SendAlert('error', _U('no_enough'))
            end
        end, CurrentCraft)

    end, function(data, menu)
        menu.close()
    end)
end