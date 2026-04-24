return function()
	vim.g.matchup_transmute_enabled = 1
	vim.g.matchup_surround_enabled = 1
	vim.g.matchup_matchparen_offscreen = { method = "popup" }
	vim.g.matchup_treesitter_disabled = { "vue" }
end
