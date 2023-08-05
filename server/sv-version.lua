Citizen.CreateThread(function()
    local resource = GetCurrentResourceName()
    local repository = GetResourceMetadata(GetCurrentResourceName(), 'repository', 0)
    local version = GetResourceMetadata(GetCurrentResourceName(), 'version', 0)

    PerformHttpRequest(string.format('https://raw.githubusercontent.com/%s/fxmanifest.lua', repository),
        function(error, data, headers)
            if error ~= 200 then
                print('^1[error]^0 could not fetch version info')
                return
            end

            local fxmanifest = load(data)()
            if fxmanifest.version ~= version then
                print('^1[error]^0 version mismatch, local: ' .. version .. ', remote: ' .. fxmanifest.version)
                print('^1[error]^0 please update the resource from ' .. repository)
            end
            print(fxmanifest.version)
        end)
end)
