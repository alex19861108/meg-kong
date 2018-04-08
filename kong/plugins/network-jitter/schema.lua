
return {
  fields = {
    connect_timeout_rate = {type = "number", default = 0 },
    send_timeout_rate = {type = "number", default = 0 },
    read_timeout_rate = {type = "number", default = 0 },
    request_termination = {
      type = "table",
      schema = {
        fields = {
          request_termination_rate = {type = "number", default = 0},
          status_code = { type = "number", default = 503 },
          content_type = { type = "string" },
          body = { type = "string" },
        }
      }
    },
    upstream_disconnect_rate = {type = "number", default = 0 },
  },
  --self_check = function(schema, plugin_t, dao, is_update)
  --  if plugin_t.connect_timeout_rate then
  --    if plugin_t.connect_timeout_rate < 0 or plugin_t.connect_timeout_rate > 1 then
  --      return false, Errors.schema("connect_timeout_rate must be between 0 .. 1")
  --    end
  --  end
  --  if plugin_t.send_timeout_rate then
  --    if plugin_t.send_timeout_rate < 0 or plugin_t.send_timeout_rate > 1 then
  --      return false, Errors.schema("send_timeout_rate must be between 0 .. 1")
  --    end
  --  end
  --  if plugin_t.read_timeout_rate then
  --    if plugin_t.read_timeout_rate < 0 or plugin_t.read_timeout_rate > 1 then
  --      return false, Errors.schema("read_timeout_rate must be between 0 .. 1")
  --    end
  --  end
  --  if plugin_t.upstream_disconnect_rate then
  --    if plugin_t.upstream_disconnect_rate < 0 or plugin_t.upstream_disconnect_rate > 1 then
  --      return false, Errors.schema("upstream_disconnect_rate must be between 0 .. 1")
  --    end
  --  end
  --  if plugin_t.request_termination and plugin_t.request_termination.request_termination_rate then
  --    if plugin_t.request_termination.request_termination_rate < 0 or plugin_t.request_termination.request_termination_rate > 1 then
  --      return false, Errors.schema("request_termination_rate must be between 0 .. 1")
  --    end
  --  end
  --
  --  return true
  --end
}
