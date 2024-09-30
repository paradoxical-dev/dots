return {
  {
    "arakkkkk/kanban.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },

    config = function()
      require("kanban").setup {
        markdown = {
          description_folder = "./tasks/", -- Path to save the file corresponding to the task.
          list_head = "## ",
        },
      }
    end,
  },
}
