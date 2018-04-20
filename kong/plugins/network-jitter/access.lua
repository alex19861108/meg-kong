local multipart = require "multipart"
local socket = require "socket"
local responses = require "kong.tools.responses"

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

local function parse_url(host_url)
  local parsed_url = socket.url.parse(host_url)
  if not parsed_url.port then
    if parsed_url.scheme == "http" then
      parsed_url.port = 80
    elseif parsed_url.scheme == HTTPS then
      parsed_url.port = 443
    end
  end
  if not parsed_url.path then
    parsed_url.path = "/"
  end
  return parsed_url
end

function sleep(n)
  local timeout = math.ceil(n / 1000)
  local t0 = socket.gettime()
  while socket.gettime() - t0 <= timeout do
  end
end

local _M = {}

function _M.execute(conf)
  math.randomseed(os.time())
  math.random()
  if conf.connect_timeout and math.random() <= conf.connect_timeout.rate then
    ngx.log(ngx.ERR, "mock connect timeout")
    ngx.ctx.balancer_address.connect_timeout = 1
  end

  if conf.send_timeout and math.random() <= conf.send_timeout.rate then
    ngx.log(ngx.ERR, "mock send timeout")
    ngx.ctx.balancer_address.send_timeout = 1
  end

  if conf.read_timeout and math.random() <= conf.read_timeout.rate then
    ngx.log(ngx.ERR, "mock read timeout")
    ngx.ctx.balancer_address.read_timeout = 1
  end

  if conf.delay and math.random() <= conf.delay.rate then
    ngx.log(ngx.ERR, "mock delay")
    sleep(conf.delay.delay_time)
  end

  if conf.upstream_disconnect and math.random() <= conf.upstream_disconnect.rate then
    ngx.log(ngx.ERR, "mock upstream disconnect")
    ngx.exit(ngx.HTTP_CLOSE)
  end

  if conf.request_termination and math.random() <= conf.request_termination.rate then
    ngx.log(ngx.ERR, "mock request termination")
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
