return {
	"numToStr/Comment.nvim",
	config = function()
		require("Comment").setup({
			-- Activation des mappings par défaut
			mappings = {
				basic = true,
				extra = true,
			},
			-- Définition des touches pour les commentaires
			toggler = {
				line = 'gcc',  -- Commenter/décommenter la ligne
				block = 'gbc', -- Commenter/décommenter le bloc
			},
			-- Touches pour les opérations de commentaire
			opleader = {
				line = 'gc',
				block = 'gb',
			},
		})
	end,
}
