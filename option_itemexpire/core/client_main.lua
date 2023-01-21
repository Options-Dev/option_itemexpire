--[[
  ░█████╗░██████╗░████████╗██╗░█████╗░███╗░░██╗███████╗ ██████╗░███████╗██╗░░░██╗███████╗██╗░░░░░░█████╗░██████╗░███████╗██████╗░
  ██╔══██╗██╔══██╗╚══██╔══╝██║██╔══██╗████╗░██║██╔════╝ ██╔══██╗██╔════╝██║░░░██║██╔════╝██║░░░░░██╔══██╗██╔══██╗██╔════╝██╔══██╗
  ██║░░██║██████╔╝░░░██║░░░██║██║░░██║██╔██╗██║█████╗░░ ██║░░██║█████╗░░╚██╗░██╔╝█████╗░░██║░░░░░██║░░██║██████╔╝█████╗░░██████╔╝
  ██║░░██║██╔═══╝░░░░██║░░░██║██║░░██║██║╚████║██╔══╝░░ ██║░░██║██╔══╝░░░╚████╔╝░██╔══╝░░██║░░░░░██║░░██║██╔═══╝░██╔══╝░░██╔══██╗
  ╚█████╔╝██║░░░░░░░░██║░░░██║╚█████╔╝██║░╚███║███████╗ ██████╔╝███████╗░░╚██╔╝░░███████╗███████╗╚█████╔╝██║░░░░░███████╗██║░░██║
  ░╚════╝░╚═╝░░░░░░░░╚═╝░░░╚═╝░╚════╝░╚═╝░░╚══╝╚══════╝ ╚═════╝░╚══════╝░░░╚═╝░░░╚══════╝╚══════╝░╚════╝░╚═╝░░░░░╚══════╝╚═╝░░╚═╝
  THANK FOR SUPPORT | DISCORD: https://discord.gg/4qvynScvey | FACEBOOK: https://www.facebook.com/profile.php?id=100088344682775
]]

ESX  = nil;
CreateThread(function()                                                            
    while ESX == nil do                                                                    
        TriggerEvent(Global['FRAMEWORK']['SHAREDOBJECT'], function(obj) ESX = obj end)        
        Wait(0)                                                                    
    end
end)

Regis(true, GetName('CreateRentItemData'), function(_data)
    local data = _data
    for key, v in pairs(data) do
        for veh, value in pairs(v.vehicle) do
            data[key].vehicle[veh].plate = CreateVehicleData(value.name)
            Wait(100)
        end
    end
    TriggerServerEvent(GetName('UpdateRent'), data)
end)

CreateVehicleData = function(VehicleName)
    local this_entity   = PlayerPedId()
    local this_plate    = exports.esx_vehicleshop:GeneratePlate()
    local this_vehicle  = (type(VehicleName) == 'number' and VehicleName or GetHashKey(VehicleName))
    local this_heading  = GetEntityHeading(this_entity)
    local thsi_coord    = GetEntityCoords(this_entity)
    if IsModelInCdimage(this_vehicle) then
        ESX.Game.SpawnLocalVehicle(this_vehicle, thsi_coord, this_heading, function(this_hash)
           local this_model = ESX.Game.GetVehicleProperties(this_hash)
           this_model.plate = this_plate
           SetVehicleNumberPlateText(this_hash, this_plate)
           SetEntityCollision(this_hash, false, false)
		   FreezeEntityPosition(this_hash, true)
		   SetEntityAlpha(this_hash, 0)
           DeleteVehicle(this_hash)
           TriggerServerEvent('esx_vehicleshop:setVehicleOwned', this_model)
        end)
        return this_plate
    end
end


CreateThread(function()
    while true do
        TriggerServerEvent(GetName('CheckExpire'))
        Wait(Global['CheckExpire'])
    end
end)