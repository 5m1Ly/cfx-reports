Config = {}

Config.prefix = '^1[^rdx-reports^1] ^3'

Config.enableScreenshots = false -- Requires screenshot-basic - Defaults to false, set to true if you wish to enable.

Config.catagories = {
    "Player",
    "Unexpected Death",
    "Rule Breaking",
    "Cheating",
    "Exploiting",
    "Bug Report",
    "Bug Abuse",
}

Config.discord = {}

Config.discord.webhook = '' -- Do not forget to add a webhook.

Config.discord.roles = {
    moderator = 1297644191337414737,
    administrator = 1325111033802526730,
    management = 1294313350062276640,
    junior_developer = 1313166500273717248,
    developer = 1310988576317505628,
    senior_developer = 1291405122659811338
}

Config.discord.tags = {
    player = { "moderator", "administrator", "management" },
    unexpected_death = { "moderator", "administrator", "management", "junior_developer", "developer" },
    rule_breaking = { "moderator", "administrator", "management" },
    cheating = { "moderator", "administrator", "management", "developer", "senior_developer" },
    exploiting = { "moderator", "administrator", "management", "developer", "senior_developer" },
    bug_report = { "developer", "senior_developer" },
    bug_abuse = { "moderator", "administrator", "developer", "senior_developer" }
}

Config.discord.message = {
    content = "tags: %s",
    tts = false,
    embeds = {
        {
            id = 10674342,
            title = "Report details",
            description =
            "**Sender**\n- **name**: %s\n- **server id**: ```%s```\n- **citizen id**: ```%s```\n- **coords**: ```%s, %s, %s```\n- **health**: %s\n- **armor**: %s\n- **ping**: %sms\n\n\n**Surroundings**\n- **nearby players**: %s\n- **nearby admins**: %s\n",
            timestamp = "2025-02-28T11:00:00.000Z",
            color = 15446819,
            footer = {
                text = "General information linked to this report"
            },
            author = {
                name = "rdx-reports system message",
                icon_url = "https://winaero.com/blog/wp-content/uploads/2017/02/Settings-Gear-icon.png"
            },
            fields = {}
        },
        {
            id = 652627557,
            title = "subject: %s",
            timestamp = "2025-02-07T23:00:00.000Z",
            color = 2326507,
            footer = {
                text = "end of subject: %s",
                icon_url = "https://winaero.com/blog/wp-content/uploads/2017/02/Settings-Gear-icon.png"
            },
            author = {
                name = "%s -> steam link 📡",
                url = "",
                icon_url = "https://winaero.com/blog/wp-content/uploads/2017/02/Settings-Gear-icon.png"
            },
            fields = {
                {
                    id = 857498745,
                    name = "Title",
                    value = "%s"
                },
                {
                    id = 134478958,
                    name = "Catagory",
                    value = "%s"
                },
                {
                    id = 267538093,
                    name = "Description",
                    value = "%s"
                }
            }
        }
    },
    components = {},
    actions = {},
    username = "rdx-reports",
    avatar_url = "https://winaero.com/blog/wp-content/uploads/2017/02/Settings-Gear-icon.png"
}
