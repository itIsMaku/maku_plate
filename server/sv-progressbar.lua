COMPLETED_PROGRESSBAR = 'COMPLETED'
ABORTED_PROGRESSBAR = 'ABORTED'
progressBars = {}

RegisterNetEvent('maku_plate:client:progressbar:complete', function()
    local source = source
    progressBars[tostring(source)] = COMPLETED_PROGRESSBAR
end)

RegisterNetEvent('maku_plate:client:progressbar:abort', function()
    local source = source
    progressBars[tostring(source)] = ABORTED_PROGRESSBAR
end)

function startProgressbar(text, duration, client)
    TriggerClientEvent('maku_plate:client:startProgressBar', tonumber(client), text, duration)
    progressBars[tostring(client)] = true
end

function getProgressbarStatus(client)
    return progressBars[tostring(client)]
end

function clearProgressbar(client)
    progressBars[tostring(client)] = nil
end
