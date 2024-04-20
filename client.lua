------------------------------------

local player = ESX.GetPlayerData()
print(json.encode(player, {indent = true}))