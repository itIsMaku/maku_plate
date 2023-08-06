RegisterNetEvent('maku_plate:client:startProgressBar', function(text, duration)
    if not isResourcePresent('ox_lib') then
        TriggerServerEvent('maku_plate:client:progressbar:complete')
        return
    end
    if lib.progressBar({
            duration = duration,
            label = text,
            useWhileDead = false,
            canCancel = true,
            anim = {
                dict = 'mini@repair',
                clip = 'fixing_a_player'
            },
            disable = {
                move = true,
                mouse = true,
                car = true,
                combat = true
            }
        }) then
        TriggerServerEvent('maku_plate:client:progressbar:complete')
    else
        TriggerServerEvent('maku_plate:client:progressbar:abort')
    end
end)
