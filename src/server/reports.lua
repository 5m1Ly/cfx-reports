local reports = {}

reports.store = {}
reports.active = 0

function Server.reports.create(src)
    ---@type ReportData
    local report = {
        id = string.uuid(),
        sender = Server.players.single(src),
        status = "pending",
        created_on = os.time(),
        claimed_on = 0,
        closed_on = 0
    }
    reports.store[report.id] = report
    reports.active += 1
    return report.id
end

---comment
---@param id string
---@return Report
function Server.reports.single(id)
    local obj = { data = reports.store[id] }

    -- getters
    function obj.getSender()
        return obj.data.sender
    end

    function obj.getStatus()
        return obj.data.status
    end

    function obj.getCreatedTime()
        return obj.data.timestamp
    end

    function obj.getClaimedTime()
        return obj.data.timestamp
    end

    function obj.getClosedTime()
        return obj.data.timestamp
    end

    function obj.isActive()
        return obj.data.status ~= "closed"
    end

    -- setters
    function obj.update(data)
        for key, value in next, data do
            obj.data[key] = value
        end
        reports.store[id] = obj.data
        return obj
    end

    function obj.claim()
        return obj.update({
            status = "claimed",
            claimed_on = os.time()
        })
    end

    function obj.unclaim()
        return obj.update({
            status = "pending",
            claimed_on = 0
        })
    end

    function obj.close()
        if obj.data.status == "closed" then return end
        reports.active -= 1
        return obj.update({
            status = "closed",
            closed_on = os.time()
        })
    end

    function obj.reopen()
        if obj.data.status ~= "closed" then return end
        reports.active -= 1
        return obj.update({
            status = "pending",
            closed_on = 0
        })
    end

    return obj
end

function Server.reports.map(callback)
    local output = {}
    for id in next, reports.store do
        local report = Server.reports.single(id)
        table.insert(output, callback and callback(report, id, reports.store) or report)
    end
    return output
end

function Server.reports.filter(callback)
    local output = {}
    Server.reports.map(function(report)
        if callback(report) then
            table.insert(output, report)
        end
    end)
    return output
end

function Server.reports.allReports()
    return Server.reports.map()
end

function Server.reports.activeReports()
    return reports.filter(function(report)
        return report.isActive()
    end)
end

function Server.reports.pendingReports()
    return reports.filter(function(report)
        return report.data.status == "pending"
    end)
end

function Server.reports.claimedReports()
    return reports.filter(function(report)
        return report.data.status == "claimed"
    end)
end

function Server.reports.closedReports()
    return reports.filter(function(report)
        return report.data.status == "closed"
    end)
end
