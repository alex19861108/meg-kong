local BasePlugin = require "kong.plugins.base_plugin"
local access = require "kong.plugins.network-jitter.access"
local header_filter = require "kong.plugins.network-jitter.header_filter"
local body_filter = require "kong.plugins.network-jitter.body_filter"

local NetWorkJitterHandler = BasePlugin:extend()

function NetWorkJitterHandler:new()
  NetWorkJitterHandler.super.new(self, "network-jitter")
end

function NetWorkJitterHandler:access(conf)
  NetWorkJitterHandler.super.access(self)
  access.execute(conf)

  local ctx = ngx.ctx
  ctx.rt_body_chunks = {}
  ctx.rt_body_chunk_number = 1
end

function NetWorkJitterHandler:header_filter(conf)
  NetWorkJitterHandler.super.header_filter(self)
  header_filter.transform_headers(conf, ngx.header)
end

function NetWorkJitterHandler:body_filter(conf)
  NetWorkJitterHandler.super.body_filter(self)

  if header_filter.is_body_transform_set(conf) and header_filter.is_json_body(ngx.header["content-type"]) then
    local ctx = ngx.ctx
    local chunk, eof = ngx.arg[1], ngx.arg[2]
    if eof then
      local body = body_filter.transform_json_body(conf, table.concat(ctx.rt_body_chunks))
      ngx.arg[1] = body
    else
      ctx.rt_body_chunks[ctx.rt_body_chunk_number] = chunk
      ctx.rt_body_chunk_number = ctx.rt_body_chunk_number + 1
      ngx.arg[1] = nil
    end
  end
end

function NetWorkJitterHandler:log(conf)
  NetWorkJitterHandler.super.log(self)
  ngx.log(ngx.ERR, "[done]")
end

NetWorkJitterHandler.PRIORITY = 1001
NetWorkJitterHandler.VERSION = "0.1.1"

return NetWorkJitterHandler
