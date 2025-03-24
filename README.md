# gitlab-url.nvim
Navigate from a file in neovim to GitLab

I hate manually navigating through GitLab to find the URL of a file I want to share with a colleague. That's why I wrote this plugin. When you call `open_current_in_gitlab` on an open file, it opens the corresponding GitLab URL in your browser.

**Setup Example (using [lazy.nvim](https://github.com/folke/lazy.nvim))**:
```lua
{
    "Speiser/gitlab-url.nvim",
    config = function()
        local gitlab = require("gitlab-url")
        vim.keymap.set("n", "<leader>gl", gitlab.open_current_in_gitlab, {})
    end,
}
```
