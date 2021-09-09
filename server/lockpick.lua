ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('fox_simplecrafting:CraftingLockpick')
AddEventHandler('fox_simplecrafting:CraftingLockpick', function(CraftItem)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local item = Crafting.Lockpick[CraftItem]
    local xLockpick = xPlayer.getInventoryItem('lockpick')

    if xLockpick.limit ~= -1 and (xLockpick.count + 1) > xLockpick.limit then
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
ESX.RegisterServerCallback('fox_simplecrafting:CekLockpick', function(source, cb, CraftItem)
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = Crafting.Lockpick[CraftItem]
    for itemname, v in pairs(item.needs) do
        if xPlayer.getInventoryItem(itemname).count < v.count then
            cb(false)
        end
    end
    cb(true)
end)