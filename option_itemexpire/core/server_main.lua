--[[
  ░█████╗░██████╗░████████╗██╗░█████╗░███╗░░██╗███████╗ ██████╗░███████╗██╗░░░██╗███████╗██╗░░░░░░█████╗░██████╗░███████╗██████╗░
  ██╔══██╗██╔══██╗╚══██╔══╝██║██╔══██╗████╗░██║██╔════╝ ██╔══██╗██╔════╝██║░░░██║██╔════╝██║░░░░░██╔══██╗██╔══██╗██╔════╝██╔══██╗
  ██║░░██║██████╔╝░░░██║░░░██║██║░░██║██╔██╗██║█████╗░░ ██║░░██║█████╗░░╚██╗░██╔╝█████╗░░██║░░░░░██║░░██║██████╔╝█████╗░░██████╔╝
  ██║░░██║██╔═══╝░░░░██║░░░██║██║░░██║██║╚████║██╔══╝░░ ██║░░██║██╔══╝░░░╚████╔╝░██╔══╝░░██║░░░░░██║░░██║██╔═══╝░██╔══╝░░██╔══██╗
  ╚█████╔╝██║░░░░░░░░██║░░░██║╚█████╔╝██║░╚███║███████╗ ██████╔╝███████╗░░╚██╔╝░░███████╗███████╗╚█████╔╝██║░░░░░███████╗██║░░██║
  ░╚════╝░╚═╝░░░░░░░░╚═╝░░░╚═╝░╚════╝░╚═╝░░╚══╝╚══════╝ ╚═════╝░╚══════╝░░░╚═╝░░░╚══════╝╚══════╝░╚════╝░╚═╝░░░░░╚══════╝╚═╝░░╚═╝
  THANK FOR SUPPORT | DISCORD: https://discord.gg/4qvynScvey | FACEBOOK: https://www.facebook.com/profile.php?id=100088344682775
]] 

ESX = nil
TriggerEvent(Global['FRAMEWORK']['SHAREDOBJECT'], function(obj) ESX = obj end)

Global.CreateRentItems = function(data, type_item, xPlayer)
    local this_player   = xPlayer
    local this_source   = source or this_player.source
    local this_data     = data
    local this_information = {}
    this_information[type_item] = {}
    this_information[type_item].item = {}
    this_information[type_item].weapon = {}
    this_information[type_item].vehicle = {}

    for keyname, value in pairs(this_data) do
        if string.upper(value.type) == string.upper('item') then
            if ESX.Items[keyname] then
                table.insert(this_information[type_item].item, {
                    name        = keyname,
                    count       = value.amount,
                    type        = string.lower(value.type),
                    expiration  = value.expiration
                })
            else
                print('(+) Item not found: '..keyname)
            end
        elseif string.upper(value.type) == string.upper('vehicle') then
            table.insert(this_information[type_item].vehicle, {
                name            = keyname,
                count           = 1,
                type            = string.lower(value.type),
                expiration      = value.expiration
            })
        elseif string.upper(value.type) == string.upper('weapon') then
            table.insert(this_information[type_item].weapon, {
                name            = keyname,
                count           = 1,
                type            = string.lower(value.type),
                expiration      = value.expiration
            })
        end
    end
    TriggerClientEvent(GetName('CreateRentItemData'), this_source, this_information)
end

for _item, _data in pairs(Global['ItemExpire']) do
    ESX.RegisterUsableItem(_item, function(source)
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
        Global.CreateRentItems(_data, _item, xPlayer)
    end)
end

Regis(true, GetName('UpdateRent'), function(_data)
    local _source       = source
    local xPlayer       = ESX.GetPlayerFromId(_source)

    for item, value in pairs(_data) do
        local xitem = xPlayer.getInventoryItem(item)
        if xitem.count > 0 then

            local rentItem = 'Items: \n'
            for k,v in pairs(value.item) do
                CreateRentItemSQL(xPlayer, v.name, value.item)
                rentItem = rentItem..'\t['..v.name..']: '..v.count..'\n'
            end
            rentItem = rentItem..''

            local rentWeapon = 'Weapon: \n'
            for k,v in pairs(value.weapon) do
                CreateRentWeaponSQL(xPlayer, string.upper(v.name), value.weapon)
                rentWeapon = rentWeapon..'\t['..v.name..']: '..v.count..'\n'
            end
            rentWeapon = rentWeapon..''

            local rentVehicle = 'Vehicle: \n'
            for k,v in pairs(value.vehicle) do
                CreateRentVehicleSQL(xPlayer, v.plate, value.vehicle)
                rentVehicle = rentVehicle..'\t['..v.name..']: '..v.plate..'\n'
            end
            rentVehicle = rentVehicle..''

            Global['ItemExpireLogs'](rentItem..'\n'..rentVehicle..'\n'..rentWeapon, _source)
            xPlayer.removeInventoryItem(xitem.name, 1)
        end
    end

end)

CreateRentWeaponSQL = function(xPlayer, Name, Data)
    local this_date     = os.date("%Y-%m-%d %X", os.time())
    MySQL.Async.fetchAll("SELECT * FROM ot_itemexpire WHERE identifier = @identifier AND information = @information", { 
        ["@identifier"] = xPlayer.identifier,
        ['@information'] = Name,
    }, function(result)
        if result[1] then
            for i=1, #Data, 1 do
                if string.upper(Data[i].name) == Name then
                    local this_type = ThisType(Data[i].expiration)
                    local DataSQL = "UPDATE ot_itemexpire SET expiration = DATE_ADD(@expiration, INTERVAL @expirationday "..this_type..") WHERE identifier = @identifier and information = @information "
                    local DataJSON = {
                        ["@identifier"]     = xPlayer.identifier, 
                        ["@information"]    = string.upper(Data[i].name),
                        ["@expiration"]     = this_date, 
                        ["@expirationday"]  = Data[i].expiration.count, 
                    }
                    MySQL.Async.execute(DataSQL, DataJSON, function(rowsChanged)
                        -- print(string.upper(Data[i].name), Data[i].count)
                        xPlayer.addWeapon(string.upper(Data[i].name), Data[i].count)
                    end)
                end
            end
        else
            for i=1, #Data, 1 do
                if string.upper(Data[i].name) == Name then
                    MySQL.Async.execute("INSERT INTO ot_itemexpire (identifier, expiration, information, amount, type) VALUES (@identifier, @expiration, @information, @amount, @type)", { 
                        ["@identifier"]     = xPlayer.identifier, 
                        ["@expiration"]     = this_date, 
                        ["@information"]    = string.upper(Data[i].name),
                        ["@amount"]         = Data[i].count,
                        ["@type"]           = Data[i].type,
                    }, function(rowsChanged)
                        local this_type = ThisType(Data[i].expiration)
                        local DataSQL = "UPDATE ot_itemexpire SET expiration = DATE_ADD(@expiration, INTERVAL @expirationday "..this_type..") WHERE identifier = @identifier and information = @information "
                        local DataJSON = {
                            ["@identifier"]     = xPlayer.identifier, 
                            ["@information"]    = string.upper(Data[i].name),
                            ["@expiration"]     = this_date, 
                            ["@expirationday"]  = Data[i].expiration.count, 
                        }
                        MySQL.Async.execute(DataSQL, DataJSON, function(rowsChanged) 
                            -- print(string.upper(Data[i].name), Data[i].expiration.count)
                            xPlayer.addWeapon(string.upper(Data[i].name), Data[i].count)
                        end)
                    end)
                end
            end
        end
    end)
end


CreateRentItemSQL = function(xPlayer, Name, Data)
    local this_date     = os.date("%Y-%m-%d %X", os.time())
    MySQL.Async.fetchAll("SELECT * FROM ot_itemexpire WHERE identifier = @identifier AND information = @information", { 
        ["@identifier"] = xPlayer.identifier,
        ['@information'] = Name,
    }, function(result)
        if result[1] then 
            for i=1, #Data, 1 do
                if Data[i].name == Name then
                    local this_type = ThisType(Data[i].expiration)
                    local DataSQL = "UPDATE ot_itemexpire SET expiration = DATE_ADD(@expiration, INTERVAL @expirationday "..this_type..") WHERE identifier = @identifier and information = @information "
                    local DataJSON = {
                        ["@identifier"]     = xPlayer.identifier, 
                        ["@information"]    = Data[i].name,
                        ["@expiration"]     = this_date, 
                        ["@expirationday"]  = Data[i].expiration.count, 
                    }
                    MySQL.Async.execute(DataSQL, DataJSON, function(rowsChanged)
                        local xItem = xPlayer.getInventoryItem(Data[i].name) 
                        xPlayer.setInventoryItem(xItem.name, Data[i].count)
                    end)
                end
            end
        else
            for i=1, #Data, 1 do
                if Data[i].name == Name then
                    MySQL.Async.execute("INSERT INTO ot_itemexpire (identifier, expiration, information, amount, type) VALUES (@identifier, @expiration, @information, @amount, @type)", { 
                        ["@identifier"]     = xPlayer.identifier, 
                        ["@expiration"]     = this_date, 
                        ["@information"]    = Data[i].name,
                        ["@amount"]         = Data[i].count,
                        ["@type"]           = Data[i].type,
                    }, function(rowsChanged)
                        local this_type = ThisType(Data[i].expiration)
                        local DataSQL = "UPDATE ot_itemexpire SET expiration = DATE_ADD(@expiration, INTERVAL @expirationday "..this_type..") WHERE identifier = @identifier and information = @information "
                        local DataJSON = {
                            ["@identifier"]     = xPlayer.identifier, 
                            ["@information"]    = Data[i].name,
                            ["@expiration"]     = this_date, 
                            ["@expirationday"]  = Data[i].expiration.count, 
                        }
                        MySQL.Async.execute(DataSQL, DataJSON, function(rowsChanged) 
                            local xItem = xPlayer.getInventoryItem(Data[i].name) 
                            -- print(xItem.name, Data[i].count)
                            xPlayer.addInventoryItem(xItem.name, Data[i].count)
                        end)
                    end)
                end
            end
        end
    end)
end

CreateRentVehicleSQL = function(xPlayer, Plate, Data)
    local this_date     = os.date("%Y-%m-%d %X", os.time())
    MySQL.Async.fetchAll("SELECT * FROM ot_itemexpire WHERE identifier = @identifier AND information = @information", { 
        ["@identifier"] = xPlayer.identifier,
        ['@information'] = Plate,
    }, function(result)
        if result[1] then 
            for i=1, #Data, 1 do
                if Data[i].plate == Plate then
                    local this_type = ThisType(Data[i].expiration)
                    local DataSQL = "UPDATE ot_itemexpire SET expiration = DATE_ADD(@expiration, INTERVAL @expirationday "..this_type..") WHERE identifier = @identifier and information = @information "
                    local DataJSON = {
                        ["@identifier"]     = xPlayer.identifier, 
                        ["@information"]    = Data[i].name,
                        ["@expiration"]     = this_date, 
                        ["@expirationday"]  = Data[i].expiration.count, 
                    }
                    MySQL.Async.execute(DataSQL, DataJSON, function(rowsChanged) end)
                end
            end
        else
            for i=1, #Data, 1 do
                if Data[i].plate == Plate then
                    MySQL.Async.execute("INSERT INTO ot_itemexpire (identifier, expiration, information, amount, type, plate) VALUES (@identifier, @expiration, @information, @amount, @type, @plate)", { 
                        ["@identifier"]     = xPlayer.identifier, 
                        ["@expiration"]     = this_date, 
                        ["@information"]    = Data[i].name,
                        ["@amount"]         = Data[i].count,
                        ["@plate"]          = Data[i].plate,
                        ["@type"]           = Data[i].type,
                    }, function(rowsChanged)
                        local this_type = ThisType(Data[i].expiration)
                        local DataSQL = "UPDATE ot_itemexpire SET expiration = DATE_ADD(@expiration, INTERVAL @expirationday "..this_type..") WHERE identifier = @identifier and information = @information "
                        local DataJSON = {
                            ["@identifier"]     = xPlayer.identifier, 
                            ["@information"]    = Data[i].name,
                            ["@expiration"]     = this_date,
                            ["@expirationday"]  = Data[i].expiration.count, 
                        }
                        MySQL.Async.execute(DataSQL, DataJSON, function(rowsChanged)
                        
                        end)
                    end)
                end
            end
        end
    end)
end

ThisType = function(expiration)
    if string.upper(expiration.type) == string.upper('DAY') then
        return "DAY"
    elseif string.upper(expiration.type) == string.upper('MONTH') then
        return "MONTH"
    elseif string.upper(expiration.type) == string.upper('YEAR') then
        return "YEAR"
    elseif string.upper(expiration.type) == string.upper('SECOND') then
        return "SECOND"
    elseif string.upper(expiration.type) == string.upper('MINUTE') then
        return "MINUTE"
    elseif string.upper(expiration.type) == string.upper('HOUR') then
        return "HOUR"
    end
end

ExtractIdentifiers = function(src)
	local identifiers = {
		steam = "",
		ip = "",
		discord = "",
		license = "",
		xbl = "",
		live = ""
	}
	for i = 0, GetNumPlayerIdentifiers(src) - 1 do
		local id = GetPlayerIdentifier(src, i)
		if string.find(id, "steam") then identifiers.steam = id
		elseif string.find(id, "ip") then identifiers.ip = id
		elseif string.find(id, "discord") then identifiers.discord = id
		elseif string.find(id, "license") then identifiers.license = id
		elseif string.find(id, "xbl") then identifiers.xbl = id
		elseif string.find(id, "live") then identifiers.live = id end
	end
	return identifiers
end


Regis(true, GetName('CheckExpire'), function(_data)
    local _source       = source
    local xPlayer       = ESX.GetPlayerFromId(source)

    while xPlayer == nil do
        Wait(1000)
    end

    if xPlayer then
        local this_date     = os.date("%Y-%m-%d %X", os.time())
        local info          = ExtractIdentifiers(_source)

        MySQL.Async.fetchAll("SELECT * FROM ot_itemexpire WHERE identifier = @identifier AND expiration <= @expiration", { 
            ["@identifier"] = xPlayer.identifier or info.steam,
            ["@expiration"] = this_date
        }, function(result)
            for i=1, #result, 1 do
                if result[i].type == 'item' then
                    local xItem = xPlayer.getInventoryItem(result[i].information)
                    if xItem.count >= result[i].amount then
                        MySQL.Async.fetchAll("delete FROM ot_itemexpire WHERE identifier = @identifier AND information = @information", { 
                            ["@identifier"]     = xPlayer.identifier or info.steam,
                            ["@information"]    = xItem.name,
                        }, function(a)
                            xPlayer.removeInventoryItem(xItem.name, result[i].amount)
                        end)
                    else
                        print('Rent time out nothave item'..json.encode({ name = xItem.name, label = xItem.label, count = xItem.count}))
                    end
                elseif result[i].type == 'vehicle' then
                    MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner = @identifier AND plate = @plate", { 
                        ["@identifier"] = xPlayer.identifier or info.steam,
                        ["@plate"]      = result[i].plate
                    }, function(result)
                        MySQL.Async.fetchAll("DELETE FROM owned_vehicles WHERE plate = @plate", { 
                            ["@plate"]     = result[1].plate,
                        }, function(delete) 
                            MySQL.Async.fetchAll("delete FROM ot_itemexpire WHERE plate = @plate", { 
                                ["@plate"]          = result[1].plate,
                            }, function(b)
                                pcall(function()
                                    exports.nc_inventory:RemoveItem(_source, {
                                        name = result[1].plate,
                                        type = 'vehicle_key'
                                    })                                    
                                end)
                            end)
                        end)
                    end)
                end
            end
        end)
    end
end)


Regis(true, GetName('CheckExpireIsUse'), function(_item, source)
    local this_item     =_item
    local _source       = source
    local xPlayer       = ESX.GetPlayerFromId(_source)
    if xPlayer then
        local info          = ExtractIdentifiers(_source)
        local xItem         = xPlayer.getInventoryItem(this_item)
        -- print(ESX.DumpTable(xItem))
        MySQL.Async.fetchAll("delete FROM ot_itemexpire WHERE identifier = @identifier AND information = @information", { 
            ["@identifier"]     = xPlayer.identifier or info.steam,
            ["@information"]    = xItem.name,
        }, function(a)
            print('Use Remove: ', xItem.name)
        end)
    end
end)


MySQL.ready(function()
    local this_date     = os.date("%Y-%m-%d %X", os.time())
    MySQL.Async.fetchAll("SELECT * FROM ot_itemexpire WHERE expiration <= @expiration", { 
        ["@expiration"] = this_date
    }, function(result)
        local this_date = os.date("%Y-%m-%d %X", os.time())
        for k,v in pairs(result) do
            print(v.id, v.identifier, v.information, v.type)
        end
    end)
end)