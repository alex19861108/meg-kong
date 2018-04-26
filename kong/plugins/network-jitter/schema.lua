local Errors = require "kong.dao.errors"

return {
  fields = {
    --keep_alive = {
    --  required = true,
    --  type = "boolean",
    --  default = true
    --},
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
    request_termination = {
      type = "table",
      schema = {
        fields = {
          rate = { type = "number", default = 0 },
          status_code = { type = "number", default = 503 },
          content_type = { type = "string" },
          body = { type = "string" },
        }
      }
    },
    delay = {
      type = "table",
      schema = {
        fields = {
          rate = { type = "number", default = 0 },
          delay_time = { type = "number", default = 1000 },
        }
      }
    },
    replace = {
      type = "table",
      schema = {
        fields = {
          rate = { type = "number", default = 0 },
          json = { type = "string", default = "" },
        }
      }
    },
  },

  self_check = function(schema, plugin_t, dao, is_updating)
    if plugin_t.connect_timeout ~= nil then
      if plugin_t.connect_timeout.rate < 0 or plugin_t.connect_timeout.rate > 1 then
        return false, Errors.schema("connect_timeout。rate must be between 0 .. 1")
      end
    end
    if plugin_t.send_timeout ~= nil then
      if plugin_t.send_timeout.rate < 0 or plugin_t.send_timeout.rate > 1 then
        return false, Errors.schema("send_timeout.rate must be between 0 .. 1")
      end
    end
    if plugin_t.read_timeout ~= nil then
      if plugin_t.read_timeout.rate < 0 or plugin_t.read_timeout.rate > 1 then
        return false, Errors.schema("read_timeout.rate must be between 0 .. 1")
      end
    end
    if plugin_t.upstream_disconnect ~= nil then
      if plugin_t.upstream_disconnect.rate < 0 or plugin_t.upstream_disconnect.rate > 1 then
        return false, Errors.schema("upstream_disconnect.rate must be between 0 .. 1")
      end
    end
    if plugin_t.request_termination ~= nil then
      if plugin_t.request_termination.rate < 0 or plugin_t.request_termination.rate > 1 then
        return false, Errors.schema("request_termination.rate must be between 0 .. 1")
      end
    end
    if plugin_t.delay ~= nil then
      if plugin_t.delay.rate < 0 or plugin_t.delay.rate > 1 then
        return false, Errors.schema("delay.rate must be between 0 .. 1")
      end
    end

    return true
  end
}
