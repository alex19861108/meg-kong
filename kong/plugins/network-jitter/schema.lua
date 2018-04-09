
return {
  fields = {
    connect_timeout = {
      type = "table",
      schema = {
        fields = {
          rate = {type = "number", default = 0 },
        }
      }
    },
    send_timeout = {
      type = "table",
      schema = {
        fields = {
          rate = {type = "number", default = 0 },
        }
      }
    },
    read_timeout = {
      type = "table",
      schema = {
        fields = {
          rate = {type = "number", default = 0 },
        }
      }
    },
    upstream_disconnect = {
      type = "table",
      schema = {
        fields = {
          rate = {type = "number", default = 0 },
        }
      }
    },
    --request_termination = {
    --  type = "table",
    --  schema = {
    --    fields = {
    --      rate = { type = "number", default = 0 },
    --      status_code = { type = "number", default = 503 },
    --      content_type = { type = "string" },
    --      body = { type = "string" },
    --    }
    --  }
    --},
  },
  self_check = function(schema, plugin_t, dao, is_update)
    if plugin_t.connect_timeout then
      if plugin_t.connect_timeout.rate < 0 or plugin_t.connect_timeout.rate > 1 then
        return false, Errors.schema("connect_timeout_rate must be between 0 .. 1")
      end
    end
    if plugin_t.send_timeout then
      if plugin_t.send_timeout.rate < 0 or plugin_t.send_timeout.rate > 1 then
        return false, Errors.schema("send_timeout_rate must be between 0 .. 1")
      end
    end
    if plugin_t.read_timeout then
      if plugin_t.read_timeout.rate < 0 or plugin_t.read_timeout.rate > 1 then
        return false, Errors.schema("read_timeout_rate must be between 0 .. 1")
      end
    end
    if plugin_t.upstream_disconnect then
      if plugin_t.upstream_disconnect.rate < 0 or plugin_t.upstream_disconnect.rate > 1 then
        return false, Errors.schema("upstream_disconnect_rate must be between 0 .. 1")
      end
    end
    --if plugin_t.request_termination then
    --  if plugin_t.request_termination.rate < 0 or plugin_t.request_termination.rate > 1 then
    --    return false, Errors.schema("request_termination_rate must be between 0 .. 1")
    --  end
    --end

    return true
  end
}
