local config = {}

function config.open(fileName)
    config.file = fileName
    config.value = {}
    if not file.open(fileName) then
        return false
    end
    line = file.readline()
    while line do
        line = string.gsub(line, "%s+", "")
        match = string.gmatch(line, "[^=]+")
        setting = match()
        value = match()
        if setting then
            config.value[setting] = value
        end
        line = file.readline()
    end
    file.close()
    return true
end

function config.set(key, value)
    config.value[key] = value
end

function config.get(key)
    return config.value[key]
end

function config.show()
    str = ''
    for k, v in pairs(config.value) do
        str = str .. k .. " = " .. v .. "\n";
    end
    return str
end

function config.write()
    if not config.file or not file.open(config.file, "w+") then
        return false
    end
    for k, v in pairs(config.value) do
        print("wl: " .. k)
        file.writeline(k .. "=" .. v)
    end
    file.flush()
    file.close()
    return true
end

return config
