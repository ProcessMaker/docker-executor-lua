require "luarocks.loader"

-- Create our global variables
data = nil
config = nil
response = nil

do
  -- Import our dkjson module
  local json = require "dkjson"


  -- Read in our data through a scope
  do
    local f = assert(io.open("/opt/executor/data.json", "rb"))
    local content = f:read("*all")
    f:close()
    data = json.decode(content)
  end

  -- Read in our config through a scope
  do
    local f = assert(io.open("/opt/executor/config.json", "rb"))
    local content = f:read("*all")
    f:close()
    config = json.decode(content)
  end
end

-- Reimport our dkjson, but this can now be in local scope
local json = require "dkjson"

-- Add a client wrapper to get the pre-configured api and model instances from the sdk
client = require("client")

-- Do our script and get the response
response = dofile("/opt/executor/script.lua")

-- Encode
response = json.encode(response)

-- Write to our output file
local f = assert(io.open("/opt/executor/output.json", "wb"))
f:write(response)
f:close()

-- Bootstrap completed
