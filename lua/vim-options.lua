vim.g.mapleader = " "

-- Configuration de la persistance de l'historique
local undodir = vim.fn.expand('~/.local/share/nvim/undodir')

-- Créer le répertoire s'il n'existe pas
if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir, 'p')
end

-- Activer la persistance de l'historique
vim.opt.undofile = true
vim.opt.undodir = undodir
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000
