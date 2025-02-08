--- ### player functions ### ---

---get a table with identifiers of a player by their network id
---@param netid number|string
---@return Identifiers
local function getPlayerIdentifiers(netid)
    local raw = GetPlayerIdentifiers(netid)
    local identifiers = {}
    for i = 1, #raw do
        local id = raw[i]
        local type, value = string.split(id, ":", true)
        identifiers[type] = value
    end
    return identifiers
end

---generates steam hexadecimal identifier
---@param steamid string
---@return string
local function steamProfileId(steamid)
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
        obj.store[i] = Server.players.single(obj.store[i], details)
    end

    function obj.map(callback)
        local output = {}
        for index = 1, #obj.store do
            table.insert(output, callback(obj.store[index], index, obj.store))
        end
        return output
    end

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
        local function filter(player)
            return math.in_range(GetEntityCoords(GetPlayerPed(player)), coords, range)
        end
        return obj.filter(filter)
    end

    return obj
end

---uses the given network id to create a table with all the needed player information
---@param netid any
---@return Player
function Server.players.single(netid, nearby)
    local obj = {}

    obj.id = netid
    obj.name = GetPlayerName(netid)
    obj.ped = GetPlayerPed(netid)
    obj.coords = GetEntityCoords(obj.ped)
    obj.health = GetEntityHealth(obj.ped)
    obj.armor = GetPedArmour(obj.ped)
    obj.ping = GetPlayerPing(netid)
    obj.identifiers = getPlayerIdentifiers(netid)
    obj.steamProfile = steamProfileUrl(obj.identifiers.steam)

    if type(nearby) == "boolean" and not nearby then return obj end

    obj.nearby = {}
    obj.nearby.players = Server.players.all(false).filterByDistance(obj.coords, 100)
    obj.nearby.count = #obj.nearby.players
    obj.nearby.admins = Server.players.all(false).filter(function(player)
        return IsPlayerAceAllowed(player, "hp-reports.view")
    end)

    return obj
end
