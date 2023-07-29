local get_hex = require('cokeline/utils').get_hex

require('cokeline').setup({
  default_hl = {
    fg = function(buffer)
      return
        buffer.is_focused
        and get_hex('ColorColumn', 'bg')
         or get_hex('Normal', 'fg')
    end,
    bg = function(buffer)
      return
        buffer.is_focused
        and get_hex('Normal', 'fg')
         or get_hex('ColorColumn', 'bg')
    end,
  },

  components = {
    {
      text = function(buffer) return ' ' .. buffer.devicon.icon end,
      fg = function(buffer) return buffer.devicon.color end,
    },
    {
      text = function(buffer) return buffer.unique_prefix end,
      fg = get_hex('Comment', 'fg'),
      style = 'italic',
    },
    {
      text = function(buffer) return buffer.filename .. ' ' end,
    },
    {
      text = '',
      delete_buffer_on_left_click = true,
    },
    {
      text = ' ',
    }
  },
})
