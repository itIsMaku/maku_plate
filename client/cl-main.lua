local inventory = exports.ox_inventory

function getClosestVehicleToPlayer(plyPos, radius)
    local retval, statusCode = nil, 'unk'

    if GetClosestVehicle(plyPos.x, plyPos.y, plyPos.z, radius and radius or CLOSEST_VEHICLE_RANGE, 0, 23) then
        retval = GetClosestVehicle(plyPos.x, plyPos.y, plyPos.z, radius and radius or CLOSEST_VEHICLE_RANGE, 0, 23)
        statusCode = 'found_vehicle'
    end

    return retval, statusCode
end

local function takeOff(vehicle)
    local netId = NetworkGetNetworkIdFromEntity(vehicle)
    TriggerServerEvent('maku_plate:server:takeoff', netId)
end

AddEventHandler('maku_plate:client:takeoff', takeOff)
exports('takeOff', takeOff)

local function putOn(vehicle, plate)
    local netId = NetworkGetNetworkIdFromEntity(vehicle)
    TriggerServerEvent('maku_plate:server:puton', netId, plate)
end

AddEventHandler('maku_plate:client:puton', putOn)
exports('putOn', putOn)

exports('itemUsage', function(data, slot)
    local vehicle, statusCode = getClosestVehicleToPlayer(GetEntityCoords(PlayerPedId()))
    if DoesEntityExist(vehicle) then
        if statusCode == 'found_vehicle' then
            putOn(vehicle, slot.metadata.plate)
        end
    else
        print('^1[error]^0 no vehicle found (itemUsage)')
    end
end)

local function isResourcePresent(resourceName)
    local state = GetResourceState(resourceName)
    return state == 'started' or state == 'starting'
end

if isResourcePresent('ox_target') then
    local target = exports.ox_target

    Citizen.CreateThread(function()
        target:addGlobalVehicle({
            {
                label = TARGET_TAKE_OFF,
                name = 'takeoffplate',
                icon = 'fa-solid fa-tarp',
                distance = 3.0,
                canInteract = function(vehicle, distance, coords, name, bone)
                    local plate = GetVehicleNumberPlateText(vehicle)
                    return plate ~= '' and plate ~= EMPTY_PLATE
                end,
                onSelect = function(data)
                    takeOff(data.entity)
                end
            }
        })
    end)

    AddEventHandler('onResourceStop', function(resoure)
        if resource ~= GetCurrentResourceName() then return end
        target:removeGlobalVehicle('takeoffplate')
    end)
else
    RegisterCommand('plate', function(source, args, raw)
        local plyPed = PlayerPedId()
        local plyPos = GetEntityCoords(plyPed)
        local vehicle, statusCode = getClosestVehicleToPlayer(plyPos)

        if DoesEntityExist(vehicle) then
            local plate = GetVehicleNumberPlateText(vehicle)
            takeOff(vehicle)
        else
            print('^1[error]^0 no vehicle found (command)')
        end
    end, false)
end
