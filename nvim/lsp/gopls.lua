return {
	settings = {
		gopls = {
			directoryFilters = {
				"-plz-out",
				"-.plz-cache",
				"-node_modules",
				"-third_party",
				"-vendor",
				"-**/testdata",
			},
			-- Uncomment if gopls is slow/memory-heavy:
			-- analyses = {
			-- 	unusedparams = false,
			-- 	shadow = false,
			-- },
			-- staticcheck = false,
		},
	},
}
