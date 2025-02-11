QBCore = exports['qb-core']:GetCoreObject()

--- should be moved to the server side
RegisterNetEvent("report:fill", function(catagories, reason)
    print(reason)

    local input = lib.inputDialog('Report a player', {
        { type = 'input',    label = 'Title',    description = 'explain briefly why your making a report.', required = true, default = reason },
        { type = 'select',   label = 'Catagory', description = 'catagory the report belongs to.',           required = true, options = catagories },
        { type = 'textarea', label = 'Reason',   description = 'describe your complain in more detail.',    required = true }
    })

    if input ~= nil then
        TriggerServerEvent("report:send", input[1], input[2], input[3])
    end


    -- if input then
    --     local target = tonumber(input[1])
    --     local reason = input[2]

    --     if target == nil then
    --         TriggerEvent('chatMessage', '', { 255, 255, 255 }, Config.Prefix .. '^1ERROR: Be sure to include an ID.')
    --     elseif reason == nil then
    --         TriggerEvent('chatMessage', '', { 255, 255, 255 }, Config.Prefix .. '^1ERROR: Be sure to include a reason.')
    --     else
    --         TriggerServerEvent("HP-Reports:Server", target, reason)
    --     end
    -- end
end, false)
