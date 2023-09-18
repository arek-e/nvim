return {
{
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {},
    config = function ()
      require("core.utils").load_mappings "flash"
    end
}
}
