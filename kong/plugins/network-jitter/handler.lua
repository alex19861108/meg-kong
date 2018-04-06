local BasePlugin = require "kong.plugins.base_plugin"
local access = require "kong.plugins.network-jitter.access"

local NetWorkJitterHandler = BasePlugin:extend()

function NetWorkJitterHandler:new()
  NetWorkJitterHandler.super.new(self, "request-transformer")
end

function NetWorkJitterHandler:access(conf)
  NetWorkJitterHandler.super.access(self)
  access.execute(conf)
end

NetWorkJitterHandler.PRIORITY = 1001
NetWorkJitterHandler.VERSION = "0.1.0"

return NetWorkJitterHandler
