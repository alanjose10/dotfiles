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
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
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
