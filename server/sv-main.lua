local inventory = exports.ox_inventory

RegisterNetEvent('maku_plate:server:takeoff', function(netId)
    local source = source

    if not inventory:CanCarryItem(source, PLATE_ITEM) then
        print('^1[error]^0 inventory full, cannot take off plate')
        return
    end

    local vehicle = NetworkGetEntityFromNetworkId(netId)
    local plate = GetVehicleNumberPlateText(vehicle)
    if plate == '' or plate == EMPTY_PLATE then
        print('^1[error]^0 plate not found on vehicle')
        return
    end

    local playerPed = GetPlayerPed(source)
    if DoesEntityExist(GetVehiclePedIsIn(playerPed)) then
        print('^1[error]^0 player is in vehicle')
        return
    end

    local vehicleType = GetVehicleType(vehicle)
    if not ALLOWED_TYPES[vehicleType] then
        print('^1[error]^0 vehicle type not allowed')
        return
    end

    startProgressbar('Taking off plate', 5000, source)
    while getProgressbarStatus(source) == true do
        Citizen.Wait(500)
    end

    local status = getProgressbarStatus(source)
    if status == ABORTED_PROGRESSBAR then
        print('^1[error]^0 progressbar aborted')
        return
    end
    clearProgressbar(source)

    Entity(vehicle).state.plate = plate
    SetVehicleNumberPlateText(vehicle, '')

    inventory:AddItem(source, PLATE_ITEM, 1, {
        plate = plate,
        description = plate
    })
end)

RegisterNetEvent('maku_plate:server:puton', function(netId, plate)
    local source = source

    local vehicle = NetworkGetEntityFromNetworkId(netId)
    if not DoesEntityExist(vehicle) then return end
    local statebagPlate = Entity(vehicle).state.plate
    if statebagPlate ~= plate then
        print('^1[error]^0 plate mismatch, statebag: ' .. statebagPlate .. ', plate: ' .. plate)
        return
    end

    local items = inventory:GetInventoryItems(source)
    local found = false
    for _, item in pairs(items) do
        if item.name == PLATE_ITEM and item.metadata ~= nil and item.metadata.plate == plate then
            found = true
            break
        end
    end
    if not found then
        print('^1[error]^0 item not found in inventory')
        return
    end


    startProgressbar('Putting on plate', 5000, source)
    while getProgressbarStatus(source) == true do
        Citizen.Wait(500)
    end

    local status = getProgressbarStatus(source)
    if status == ABORTED_PROGRESSBAR then
        print('^1[error]^0 progressbar aborted')
        return
    end
    clearProgressbar(source)

    local success = inventory:RemoveItem(source, PLATE_ITEM, 1, {
        plate = plate,
        description = plate
    })
    if success then
        SetVehicleNumberPlateText(vehicle, plate)
    else
        print('^1[error]^0 failed to remove item from inventory')
    end
end)
