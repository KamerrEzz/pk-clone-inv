local ox_inventory = exports.ox_inventory

RegisterCommand('getinventory', function(src, args, raw)
    -- local _, identifier = src, ESX.GetPlayerFromId(src).identifier
    local asd = ESX.GetPlayerFromId(src).getInventory()
    -- local inventory = exports.ox_inventory:GetInventory(identifier)
    -- print("inventory", json.encode(inventory, {indent = true}))
    print("asd", json.encode(asd, {
        indent = true
    }))

end)

RegisterCommand('cloneinv', function(src, args, raw)
    local _, identifier = src, ESX.GetPlayerFromId(src).identifier
    local data = ESX.GetPlayerFromId(src).getInventory()

    local getClone = MySQL.query.await('SELECT inventory FROM `pk-clone-inv` WHERE identifier = ? ', {identifier})
    if #getClone > 0 then

        MySQL.update.await('UPDATE `pk-clone-inv` SET inventory = ? WHERE identifier = ?',
            {json.encode(data), identifier})

        for i, v in pairs(data) do
            ox_inventory:RemoveItem(src, v.name, v.count)
        end
    else
        local id = MySQL.insert.await('INSERT INTO `pk-clone-inv` (identifier, inventory) VALUES (?, ?)',
            {identifier, json.encode(data)})
        for i, v in pairs(data) do
            ox_inventory:RemoveItem(src, v.name, v.count)
        end
    end
end)

RegisterCommand('addinve', function(src, args, raw)
    local _, identifier = src, ESX.GetPlayerFromId(src).identifier
    local getClone = MySQL.query.await('SELECT inventory FROM `pk-clone-inv` WHERE identifier = ? ', {identifier})
    if #getClone == 0 then return end
    for i, v in pairs(json.decode(getClone[1].inventory)) do
        ox_inventory:AddItem(src, v.name, v.count)
    end

end)

RegisterCommand('clearinve', function(src, args, raw)
    local _, identifier = src, ESX.GetPlayerFromId(src)
    identifier.ClearInventory()
end)


RegisterCommand('pk-clone', function (src, args, raw)
    TriggerEvent('pk-inventory:server:clone')
end)

RegisterCommand('pk-add', function (src, args, raw)
    TriggerEvent('pk-inventory:server:add')
end)