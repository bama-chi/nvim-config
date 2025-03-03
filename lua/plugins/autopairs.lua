return {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = function()
        local npairs = require("nvim-autopairs")
        local Rule = require('nvim-autopairs.rule')

        npairs.setup({
            check_ts = true, -- Utilise treesitter pour vérifier le contexte
            disable_filetype = { "TelescopePrompt" }, -- Désactive dans certains contextes
            enable_check_bracket_line = true,  -- Vérifie la ligne pour les paires
            ignored_next_char = "[%w%.]", -- Ne pas ajouter de paire si le prochain caractère est une lettre
            fast_wrap = {
                map = '<M-e>', -- Alt-e pour wrapper rapidement
                chars = { '{', '[', '(', '"', "'" },
                pattern = [=[[%'%"%>%]%)%}%,]]=],
                end_key = '$',
                keys = 'qwertyuiopzxcvbnmasdfghjkl',
                check_comma = true,
                highlight = 'Search',
                highlight_grey='Comment'
            },
        })

        -- Règles spéciales pour certains langages
        npairs.add_rules({
            -- Ajoute un espace entre les parenthèses
            Rule(' ', ' ')
                :with_pair(function(opts)
                    local pair = opts.line:sub(opts.col - 1, opts.col)
                    return vim.tbl_contains({ '()', '[]', '{}' }, pair)
                end),
            -- Supprime l'espace quand on tape dans les parenthèses vides
            Rule('', ' )')
                :with_pair(function() return false end)
                :with_move(function(opts)
                    return opts.prev_char:match('.%)') ~= nil
                end)
                :use_key(')'),
            -- Même chose pour les crochets
            Rule('', ' ]')
                :with_pair(function() return false end)
                :with_move(function(opts)
                    return opts.prev_char:match('.%]') ~= nil
                end)
                :use_key(']'),
            -- Et les accolades
            Rule('', ' }')
                :with_pair(function() return false end)
                :with_move(function(opts)
                    return opts.prev_char:match('.%}') ~= nil
                end)
                :use_key('}'),
        })
    end
}
