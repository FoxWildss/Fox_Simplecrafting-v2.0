ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('fox_simplecrafting:CraftingVest')
AddEventHandler('fox_simplecrafting:CraftingVest', function(CraftItem)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local item = Crafting.Vest[CraftItem]
    local xVest = xPlayer.getInventoryItem('bulletproof')

    if xVest.limit ~= -1 and (xVest.count + 1) > xVest.limit then
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'No Enough Space'})
    else
        for itemname, v in pairs(item.needs) do
            xPlayer.removeInventoryItem(itemname, v.count)
        end
        xPlayer.addInventoryItem(CraftItem, 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = ('Success Crafted 1x ' ..item.label..'')})
    end
end)

-- Cek apakah memiliki item
ESX.RegisterServerCallback('fox_simplecrafting:CekVest', function(source, cb, CraftItem)
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = Crafting.Vest[CraftItem]
    for itemname, v in pairs(item.needs) do
        if xPlayer.getInventoryItem(itemname).count < v.count then
            cb(false)
        end
    end
    cb(true)
end)