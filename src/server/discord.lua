---generates a string with all the discord tags related to the catagory
---@param catagoryName string
---@return string
function Server.discord.tags(catagoryName)
    local index = catagoryName:lower():gsub(" ", "_")
    local tags = Config.discord.tags[index]
    local str = ""
    for i = 1, #tags do
        local role = tags[i]
        if i > 1 then str = str .. ", " end
        str = str .. ("<@&%s>"):format(Config.discord.roles[role])
    end
    return str
end

---get the discord message object
---@param report Report
---@return string
function Server.discord.message(report)
    local title = report.getTitle()
    local catagory = report.getCatagoryName()
    local description = report.getDescription()
    local timestamp = report.getCreatedTime()

    local sender = report.getSender()

    local msg = Config.discord.message

    -- add the roles related to the report catagory
    local tags = Server.discord.tags(catagory)
    msg.content = msg.content:format(tags)

    msg.embeds[1].description = msg.embeds[1].description:format(
        sender.name,
        sender.id,
        sender.citizenid,
        tostring(sender.coords.x), tostring(sender.coords.y), tostring(sender.coords.z),
        tostring(sender.health),
        tostring(sender.armor),
        tostring(sender.ping),
        tostring(sender.nearby.count),
        tostring(#sender.nearby.admins)
    )

    -- add timestamp
    msg.embeds[1].timestamp = timestamp

    -- add subject title
    msg.embeds[2].title = msg.embeds[2].title:format(title)

    -- add timestamp
    msg.embeds[2].timestamp = timestamp

    -- add footer text
    msg.embeds[2].footer.text = msg.embeds[2].footer.text:format(title)

    -- add author steam name
    msg.embeds[2].author.name = msg.embeds[2].author.name:format(sender.name)

    -- add author steam url
    msg.embeds[2].author.url = msg.embeds[2].author.url:format(sender.steamProfile)

    -- add fields title, catagory, description
    msg.embeds[2].fields[1].value = msg.embeds[2].fields[1].value:format(title)
    msg.embeds[2].fields[2].value = msg.embeds[2].fields[2].value:format(catagory)
    msg.embeds[2].fields[3].value = msg.embeds[2].fields[3].value:format(description)

    return json.encode(msg)
end

function Server.discord.send(report)
    PerformHttpRequest(Config.discord.webhook, function(status, body, headers, errorData)
        print("discord response")
        if status > 0 then print(("status: %s"):format(status)) end
        if body then print(("body: %s"):format(body)) end
        if headers then print(("headers: %s"):format(json.encode(headers))) end
        if errorData then print(("error data: %s"):format(json.encode(errorData))) end
    end, 'POST', Server.discord.message(report), { ['Content-Type'] = 'application/json' })
end
