local miniNotify = require("mini.notify")

local config = {
    content = {
    -- Function which formats the notification message
    -- By default prepends message with notification time
    format = function(notif) 
      local n = {
        level = notif.level,
        msg = notif.msg,
        tsAdd = notif.ts_add,
        hlGroup = notif.hl_group
      }

      return string.gsub("$level \n\n$msg", "%$(%w+)", n)
    end,

    -- Function which orders notification array from most to least important
    -- By default orders first by level and then by update timestamp
    sort = nil,
  },
}

miniNotify.setup(config)



vim.notify = miniNotify.make_notify({
  ERROR = { duration = 5000 },
  WARN = { duration = 4000 },
  INFO = { duration = 3000 }
})
