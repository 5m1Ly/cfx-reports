RegisterNetEvent("report:send", function(title, catagory, reason)
    -- generate report
    local src = source
    local reportId = Server.reports.create(src)
    local report = Server.reports.single(reportId)

    -- set report details
    report.setTitle(title)
    report.setCatagory(catagory)
    report.setDescription(reason)

    -- send report
    local sender = report.getSender()

    local players = Server.players.all(false)
    local opcount = #players.filterOperators()
    local opnearby = #players.filterNearbyOperators(src, sender.coords, 100)

    local activeReports = Server.reports.activeReports()

    -- if 0 admins online, then send to discord and return
    -- if 1 admin online, then send to the admin
    -- if 1 admin online, and admin is nearby, send to the admin and discord with request for direct help
    -- if 1 admin online, and admin is not nearby, and active reports smaller then 3 send to the admin
    -- if 1 admin online, and admin is not nearby, and active reports bigger then 3 send to the admin and discord
    -- if 1+ admins online, and 1+ admins are nearby, send to all admins and discord with request for direct help
    -- if 1+ admins online, and 1 admin is nearby, send to the admin with request for direct help
    -- if 1+ admins online, and no admins are nearby, and active reports smaller then 150% of admins online send to all admins
    -- if 1+ admins online, and no admins are nearby, and active reports bigger then 150% of admins online send to all admins and discord
    if opcount == 0 or (opcount == 1 and (opnearby == 1 or activeReports >= 3)) or (opcount > 1 and (opnearby > 1 or math.floor(opcount * 1.5) > activeReports)) then
        Server.discord.send(report)
    end
    if opcount >= 1 then
        -- send to online admins
    end
    return
end)

QBCore.Commands.Add(
    "report",
    "Report a player, bug, or issue you encountered",
    { { name = "subject", help = "what is the report about" } },
    true,
    function(src, args)
        local select = {}

        for i = 1, #Config.catagories do
            table.insert(select, { value = i, label = Config.catagories[i] })
        end

        QBCore.Debug(args)

        TriggerClientEvent(
            "report:fill",
            src,
            select,
            table.concat(args, " ")
        )
    end,
    "user"
)

-- komt nog
QBCore.Commands.Add("rpanel", "Moderation panel that lets you manage reports", {}, false, function(src, args) end, "mod")
