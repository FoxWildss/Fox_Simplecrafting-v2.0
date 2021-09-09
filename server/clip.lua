ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('fox_simplecrafting:CraftingClip')
AddEventHandler('fox_simplecrafting:CraftingClip', function(CraftItem)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local item = Crafting.Clip[CraftItem]
    local xClip = xPlayer.getInventoryItem('clip')

    if xClip.limit ~= -1 and (xClip.count + 1) > xClip.limit then
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
ESX.RegisterServerCallback('fox_simplecrafting:CekClip', function(source, cb, CraftItem)
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = Crafting.Clip[CraftItem]
    for itemname, v in pairs(item.needs) do
        if xPlayer.getInventoryItem(itemname).count < v.count then
            cb(false)
        end
    end
    cb(true)
end)