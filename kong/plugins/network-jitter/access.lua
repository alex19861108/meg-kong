local multipart = require "multipart"
local cjson = require "cjson"

local table_insert = table.insert
local req_set_uri_args = ngx.req.set_uri_args
local req_get_uri_args = ngx.req.get_uri_args
local req_set_header = ngx.req.set_header
local req_get_headers = ngx.req.get_headers
local req_read_body = ngx.req.read_body
local req_set_body_data = ngx.req.set_body_data
local req_get_body_data = ngx.req.get_body_data
local req_clear_header = ngx.req.clear_header
local req_set_method = ngx.req.set_method
local encode_args = ngx.encode_args
local ngx_decode_args = ngx.decode_args
local type = type
local string_find = string.find
local pcall = pcall

local responses = require "kong.tools.responses"

local _M = {}

function _M.execute(conf)
  math.randomseed(os.time())
  math.random()
  if math.random() < conf.connect_timeout_rate then
    ngx.ctx.balancer_address.connect_timeout = 1
  end
  if math.random() < conf.send_timeout_rate then
    ngx.ctx.balancer_address.send_timeout = 1
  end
  if math.random() < conf.read_timeout_rate then
    ngx.ctx.balancer_address.read_timeout = 1
  end
  if math.random() < conf.upstream_disconnect_rate then
    ngx.exit()
  end
  if math.random() < conf.request_termination.request_termination_rate then
    local status_code = conf.request_termination.status_code
    local content_type = conf.request_termination.content_type
    local body = conf.request_termination.body

    ngx.status = status_code
    if not content_type then
      content_type = "application/json; charset=utf-8";
    end
    ngx.header["Content-Type"] = content_type
    ngx.header["Server"] = server_header

    ngx.say(body)

    return ngx.exit(status_code)
  end
end

return _M
