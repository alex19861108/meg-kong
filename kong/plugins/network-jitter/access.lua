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
  local jitter_rate = conf.jitter_rate
  math.randomseed(os.time())
  math.random()
  if math.random() < jitter_rate then

    --local ok, err
    --local parsed_url = parse_url(conf.http_endpoint)
    --local host = parsed_url.host
    --local port = tonumber(parsed_url.port)
    --
    --local sock = ngx.socket.tcp()
    --sock:settimeout(conf.timeout)
    --
    --ok, err = sock:connect(host, port)
    --if not ok then
    --  ngx.log(ngx.ERR, name .. "failed to connect to " .. host .. ":" .. tostring(port) .. ": ", err)
    --  return responses.send(ngx.HTTP_REQUEST_TIMEOUT, err)
    --end
    --
    --if parsed_url.scheme == HTTPS then
    --  local _, err = sock:sslhandshake(true, host, false)
    --  if err then
    --    ngx.log(ngx.ERR, name .. "failed to do SSL handshake with " .. host .. ":" .. tostring(port) .. ": ", err)
    --  end
    --end
    --
    --ok, err = sock:send(generate_post_payload(conf.method, conf.content_type, parsed_url, body))
    --if not ok then
    --  ngx.log(ngx.ERR, name .. "failed to send data to " .. host .. ":" .. tostring(port) .. ": ", err)
    --end
    ngx.ctx.balancer_address.connect_timeout = 1
    ngx.ctx.balancer_address.send_timeout = 1
    ngx.ctx.balancer_address.read_timeout = 1
  end
end

return _M
