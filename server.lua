local ox_inventory = exports.ox_inventory

RegisterNetEvent('pk-inventory:server:clone', function(src)
    print('pk-inventory:server:clone', src)

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

RegisterNetEvent('pk-inventory:server:add', function(src)
    print('pk-inventory:server:add', src)
    local _, identifier = src, ESX.GetPlayerFromId(src).identifier
    local getClone = MySQL.query.await('SELECT inventory FROM `pk-clone-inv` WHERE identifier = ? ', {identifier})
    if #getClone == 0 then
        return
    end
    for i, v in pairs(json.decode(getClone[1].inventory)) do
        ox_inventory:AddItem(src, v.name, v.count)
    end
end)
