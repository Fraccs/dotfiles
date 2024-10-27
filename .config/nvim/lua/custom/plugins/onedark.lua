return {
  'navarasu/onedark.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('onedark').setup {
      colors = {
        bg0 = '#000000',
        bg1 = '#111111',
        bg2 = '#353839',
        bg3 = '#808080',
        fg = '#ffffff'
      },
      style = 'dark',
      transparent = true
    }

    vim.cmd.colorscheme 'onedark'
  end
}
