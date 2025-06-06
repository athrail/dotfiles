return {
	"rose-pine/neovim",
	name = "rose-pine",
	config = function()
    require("rose-pine").setup({
      styles = {
        italic = false,
        transparency = true,
      }
    })

    vim.cmd("colorscheme rose-pine")
    vim.cmd("highlight CursorLine ctermbg=NONE guibg=NONE")
	end
}
