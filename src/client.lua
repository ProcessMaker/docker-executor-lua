require "luarocks.loader"

-- This helper allows the script user to get a pre-configured client instance
-- For example, users_api = client.make('users_api')
local function make(name)
    local api_class = require("pmsdk.api." .. name)

    local host = os.getenv("API_HOST")
    https, host, path = host:match("^(https?)://(.-)/(.*)$")

    local api_instance = api_class.new(host, '/' .. path, {https})
    api_instance.access_token = os.getenv('API_TOKEN')

    return api_instance
end

local function model(name)
    return require("pmsdk.model." .. name)
end

return {
    make = make,
    model = model
}