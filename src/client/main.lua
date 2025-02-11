QBCore = exports['qb-core']:GetCoreObject()

--- should be moved to the server side
RegisterNetEvent("report:fill", function(catagories, reason)
    local input = lib.inputDialog('Report a player', {
        { type = 'input',    label = 'Title',    description = 'explain briefly why your making a report.', required = true, default = reason },
        { type = 'select',   label = 'Catagory', description = 'catagory the report belongs to.',           required = true, options = catagories },
        { type = 'textarea', label = 'Reason',   description = 'describe your complain in more detail.',    required = true }
    })

    if input ~= nil then
        TriggerServerEvent("report:send", input[1], input[2], input[3])
    end
end, false)
