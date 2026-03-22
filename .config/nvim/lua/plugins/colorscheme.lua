return {
  -- 1. Добавляем сам плагин morhetz/gruvbox
  { "morhetz/gruvbox", priority = 1000 },

  -- 2. Настраиваем LazyVim на использование этой темы
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
