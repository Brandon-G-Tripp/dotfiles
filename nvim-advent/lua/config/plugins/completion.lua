return {
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = { 'rafamadriz/friendly-snippets' },

    -- use a release tag to download pre-built binaries
    version = '1.*',
    opts = {
      keymap = {
        -- Inherit default mappings
        preset = 'default',
      },
      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      -- (Default) Only show the documentation popup when manually triggered
      fuzzy = { implementation = "prefer_rust_with_warning" },
      completion = {
        accept = {
          auto_brackets = { enabled = false },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 1000,
        },
        menu = {
          draw = {
            columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 }, { 'kind' } },
          },
        },
      },
      signature = {
        enabled = true,
        trigger = {
          enabled = true,
          show_on_insert = true,
        },
        window = {
          border = 'rounded',
        },
      },
    },
    config = function(_, opts)
      local blink = require('blink.cmp')
      blink.setup(opts)
    end,
    opts_extend = { "sources.default" }
  },
}

