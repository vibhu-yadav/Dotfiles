-- Keymaps loaded first since it has mapleader
require("config.keymaps")
require("config.options")
require("config.autocmd")
require("config.runCode")

-- Load Lazy at last since it might require some of the above and further calls plugins
require("config.lazy")
