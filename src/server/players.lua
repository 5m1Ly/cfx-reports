--- ### player functions ### ---

---get a table with identifiers of a player by their network id
---@param netid number|string
---@return Identifiers
local function getPlayerIdentifiers(netid)
    local raw = GetPlayerIdentifiers(netid)
    local identifiers = {}
    for i = 1, #raw do
        local id = string.split(raw[i], ":")
        local type, value = id[1], id[2]
        identifiers[type] = value
    end
    return identifiers
end

---generates steam hexadecimal identifier
---@param steamid string
---@return string
local function steamProfileId(steamid)
    if steamid == nil then return "" end
    return ("%s"):format(tostring(tonumber(steamid, 16)))
end

---generates steam profile url
---@param steamid string
---@return string
local function steamProfileUrl(steamid)
    return ("https://steamcommunity.com/profiles/%s"):format(steamProfileId(steamid))
end

function Server.players.all(details)
    local obj = {}

    local netids = GetPlayers()

    obj.store = {}
    obj.count = #netids

    for i = 1, obj.count do
        local netid = netids[i]
        obj.store[i] = Server.players.single(netid, details)
    end

    function obj.map(callback)
        local output = {}
        for index = 1, #obj.store do
            table.insert(output, callback(obj.store[index], index, obj.store))
        end
        return output
    end

    ---comment
    ---@param callback fun(player: Player): boolean
    ---@return table
    function obj.filter(callback)
        local output = {}
        for i = 1, #obj.store do
            if callback(obj.store[i]) then
                table.insert(output, obj.store[i])
            end
        end
        return output
    end

    function obj.filterByDistance(coords, range)
        return obj.filter(function(player)
            return math.in_range(player.coords, coords, range)
        end)
    end

    function obj.filterOperators()
        return obj.filter(function(player)
            return QBCore.Functions.HasPermission(player, "mod")
        end)
    end

    function obj.filterNearbyOperators(coords, range)
        local retval = {}
        local nearby = obj.filterByDistance(coords, range)
        for i = 1, #nearby do
            local player = nearby[i]
            if QBCore.Functions.HasPermission(player, "mod") then
                table.insert(retval, player)
            end
        end
        return retval
    end

    return obj
end

---uses the given network id to create a table with all the needed player information
---@param netid any
---@return Player
function Server.players.single(netid, nearby)
    local obj = {}

    obj.id = type(netid) == "number" and netid or tonumber(netid)
    obj.name = GetPlayerName(obj.id)
    obj.ped = GetPlayerPed(obj.id)
    obj.coords = GetEntityCoords(obj.ped)
    obj.health = GetEntityHealth(obj.ped)
    obj.armor = GetPedArmour(obj.ped)
    obj.ping = GetPlayerPing(netid)
    obj.identifiers = getPlayerIdentifiers(obj.id)
    obj.steamProfile = steamProfileUrl(obj.identifiers.steam)

    if type(nearby) == "boolean" and not nearby then return obj end

    obj.nearby = {}
    obj.nearby.players = Server.players.all(false).filterByDistance(obj.coords, 100)
    obj.nearby.count = #obj.nearby.players
    obj.nearby.admins = Server.players.all(false).filterNearbyOperators(obj.coords, 100)

    return obj
end
