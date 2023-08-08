GetVehicleNumberPlateText = function(vehicle)
    local plate = GetVehicleNumberPlateText(vehicle)
    if plate:gsub('%s+', '') == '' then
        local statebag = Entity(vehicle).state.plate
        if statebag ~= nil then
            plate = statebag
        end
    end
    return plate
end
