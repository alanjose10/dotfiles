return {
	"goolord/alpha-nvim",
	event = 'VimEnter',
    config = function()
        local alpha = require('alpha')
        local dashboard = require('alpha.themes.dashboard')
        local pokemon = require('pokemon')
        pokemon.setup({
            number = 'random',
            size = 'auto',
        })
        dashboard.section.header.val = pokemon.header()
        alpha.setup(dashboard.config)
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons', 'ColaMint/pokemon.nvim' } }
}
