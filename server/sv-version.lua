Citizen.CreateThread(function()
    local resource = GetCurrentResourceName()
    local repository = GetResourceMetadata(GetCurrentResourceName(), 'repository', 0)
    local version = GetResourceMetadata(GetCurrentResourceName(), 'version', 0)
    PerformHttpRequest(string.format('https://raw.githubusercontent.com/%s/master/fxmanifest.lua', repository),
        function(error, data, headers)
            if error ~= 200 then
                print('^1[error]^0 could not fetch version info')
                return
            end

            local newestVersion = nil
            for line in data:gmatch("[^\r\n]+") do
                if line:find('^version') then
                    newestVersion = line:match('(%d+%.%d+)')
                    break
                end
            end
            if newestVersion == version then
                print(string.format('^2[success]^0 you are running the newest version of ^2%s^0 (^2v%s^0)', resource,
                    version))
                return
            end
            print(string.format('^3[warn]^0 there is a new version of ^3%s^0 (^3v%s^0), you are running ^3v%s^0',
                resource, newestVersion, version))
            print(string.format('^3[warn]^0 please update the resource from ^3https://github.com/%s^0', repository))
        end)
end)
