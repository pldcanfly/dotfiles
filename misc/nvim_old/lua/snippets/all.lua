local ls = require("luasnip")

return {
	ls.snippet("jstime", {
		ls.function_node(function()
			return tostring(os.time() * 1000) -- JavaScript uses milliseconds
		end, {}),
	}),
}
