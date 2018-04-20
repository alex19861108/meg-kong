---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by liuwei.
--- DateTime: 2018/4/17 17:13
---
local cjson = require("cjson")

local _M = {}

function _M.is_json_body(content_type)
  return content_type and string.find(string.lower(content_type), "application/json", nil, true)
end

function _M.transform_json_body(conf, buffered_data)
  math.randomseed(os.time())
  math.random()

  if conf.replace and math.random() <= conf.replace.rate then
    ngx.log(ngx.ERR, "mock replace")
    if _M.is_json_body(ngx.header["content-type"]) then
      local status, json_body = pcall(cjson.decode, buffered_data);
      if status == false or json_body == nil then
        return
      end
      local status, replace_body = pcall(cjson.decode, conf.replace.json);
      if status == false or replace_body == nil then
        return
      end
      for k,v in pairs(replace_body) do
        ngx.log(ngx.ERR, k)
        if json_body[k] then
          json_body[k] = v
        end
      end
      return cjson.encode(json_body)
    end
  end
  return
end

return _M
