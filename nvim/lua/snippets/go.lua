local ls = require("luasnip")

-- return fmt.Errorf("w%",err)
return {
	ls.snippet("iferr", {
		ls.text_node({ "if err != nil {", "\t" }),
		ls.text_node({ 'return fmt.Errorf("' }),
		ls.insert_node(1, "this is an error"),
		ls.text_node({ ': %w", err)' }),
		ls.text_node({ "", "}" }),
	}),
}
