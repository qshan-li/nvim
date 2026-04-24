local M = {}

function M.setup()
	if M.loaded then
		return
	end
	M.loaded = true

	local global = require("pure-nvim.core.global")

	local options = {
		-- viewdir = global.cache_dir .. "/view/",
		autoread = true,
		autowrite = true,
		backspace = "indent,eol,start",
		backup = false,
		backupdir = global.cache_dir .. "/backup//,.",
		backupskip = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim",
		breakat = [[\ \	;:,!?@*-+/]],
		breakindent = true,
		clipboard = "unnamedplus",
		cmdheight = 1, -- 0, 1, 2
		cmdwinheight = 5,
		complete = ".,w,b,k,kspell",
		completeopt = "fuzzy,menuone,noselect,popup",
		confirm = true,
		cursorcolumn = false,
		cursorline = true,
		diffopt = "filler,iwhite,internal,linematch:60,algorithm:patience",
		directory = global.cache_dir .. "/swap//",
		display = "lastline",
		encoding = "utf-8",
		equalalways = false,
		errorbells = true,
		fileencodings = "ucs-bom,utf-8,default,big5,latin1",
		fileformats = "unix,mac,dos",
		foldenable = true,
		foldexpr = "v:lua.vim.treesitter.foldexpr()",
		foldlevelstart = 99,
		foldmethod = "expr",
		formatoptions = "1jcroql",
		grepformat = "%f:%l:%c:%m",
		grepprg = "rg --hidden --vimgrep --smart-case --",
		helpheight = 12,
		hidden = true,
		history = 2000,
		ignorecase = true,
		inccommand = "nosplit",
		incsearch = true,
		infercase = true,
		jumpoptions = "stack,view",
		laststatus = 3,
		linebreak = true,
		linespace = 3,
		list = true,
		listchars = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←",
		magic = true,
		mouse = "a",
		mousescroll = "ver:3,hor:6",
		number = true,
		previewheight = 12,
		-- Do NOT adjust the following option (pumblend) if you're using transparent background
		pumblend = 0,
		pumheight = 15,
		redrawtime = 1500,
		relativenumber = true,
		ruler = true,
		scrolloff = 3,
		sessionoptions = "buffers,curdir,folds,help,tabpages,winpos,winsize",
		shada = "!,'500,<50,@100,s10,h",
		shiftround = true,
		shortmess = "aoOTIcF",
		showbreak = "↳  ",
		showcmd = false,
		showmode = false,
		showtabline = 2,
		sidescrolloff = 5,
		signcolumn = "yes",
		smartcase = true,
		smarttab = true,
		smoothscroll = true,
		softtabstop = 4,
		spellfile = global.vim_path .. "/spell/en.utf-8.add",
		spelllang = "en_us,cjk",
		splitbelow = true,
		splitkeep = "screen",
		splitright = true,
		startofline = false,
		swapfile = false,
		switchbuf = "usetab,uselast",
		synmaxcol = 2500,
		tabstop = 4,
		termguicolors = true,
		textwidth = 80,
		timeout = true,
		timeoutlen = 300,
		ttimeout = true,
		ttimeoutlen = 10,
		undodir = global.cache_dir .. "/undo//",
		undofile = true,
		-- Please do NOT set `updatetime` to above 500, otherwise most plugins may not function correctly
		updatetime = 200,
		virtualedit = "block",
		visualbell = true,
		viewoptions = "folds,cursor,curdir,slash,unix",
		whichwrap = "h,l,<,>,[,],~",
		wildignore = ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**",
		wildignorecase = true,
		-- Do NOT adjust the following option (winblend) if you're using transparent background
		winblend = 0,
		winminwidth = 10,
		winwidth = 30,
		wrap = false,
		wrapscan = true,
		writebackup = true,
		-- bw local --
		autoindent = true,
		breakindentopt = "shift:2,min:20",
		concealcursor = "niv",
		conceallevel = 0,
		expandtab = true,
		shiftwidth = 4,
	}

	-- Newtrw liststyle: https://medium.com/usevim/the-netrw-style-options-3ebe91d42456
	vim.g.netrw_liststyle = 3
	vim.g.have_nerd_font = true

	for name, value in pairs(options) do
		vim.api.nvim_set_option_value(name, value, {})
	end
end

return M
