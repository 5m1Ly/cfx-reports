--- ### math functions ### ---

---calculates the sum of all given numbers
---@param ... number[]
---@return number
function math.sum(...)
    local values = table.pack(...)
    local result = 0
    for i = 1, values.n do result += values[i] end
    return result
end

---calculates the distance between two vectors
---@param x vector
---@param y vector
---@return integer
function math.distance(x, y)
    return #(x - y)
end

---calculates if a given vector is in range of another vector
---@param x vector
---@param y vector
---@param range integer
---@return boolean
function math.in_range(x, y, range)
    return math.distance(x, y) <= range
end

--- ### string functions ### ---

---split string based on delimiter and return a table with the seperated strings. when there is no delimiter given it wil use a space as delimiter
---@param input string
---@param delimiter? string | " "
---@param unpack? boolean
---@return string|string[]
function string.split(input, delimiter, unpack)
    local matcher = ("([^%s]+)"):format(delimiter or " ")
    local output = {}
    for value in string.gmatch(input, matcher) do
        table.insert(output, value)
    end
    return not unpack and output or table.unpack(output)
end

---generate a random uuid
---@return string, integer
function string.uuid()
    local template = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    return string.gsub(template, '[xy]', function(c)
        local v = (c == 'x') and math.random(0, 0xf) or math.random(8, 0xb)
        return string.format('%x', v)
    end)
end
