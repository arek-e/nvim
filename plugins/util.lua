return {
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" } },
    config = function ()
      require("persistence").setup()
      require("core.utils").load_mappings "persistence"
    end
  },
}
