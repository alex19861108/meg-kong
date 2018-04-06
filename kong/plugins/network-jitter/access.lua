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

local _M = {}

function _M.execute(conf)
  local jitter_rate = conf.jitter_rate
  math.randomseed(os.time())
  math.random()
  if math.random() < jitter_rate then
    ngx.status = ngx.HTTP_REQUEST_TIMEOUT
    ngx.header["Content-Type"] = "application/json; charset=utf-8";
    ngx.say("timeout")
    return ngx.exit(ngx.HTTP_REQUEST_TIMEOUT)
  end
end

return _M
