
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
    request_termination = {
      type = "table",
      schema = {
        fields = {
          rate = {type = "number", default = 0},
          status_code = { type = "number", default = 503 },
          content_type = { type = "string" },
          body = { type = "string" },
        }
      }
    },
  }
}
