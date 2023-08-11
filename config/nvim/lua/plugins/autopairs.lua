local npairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")

local brackets = { { "(", ")" }, { "[", "]" }, { "{", "}" } }

npairs.setup({
	ignored_next_char = "[%w%.]",
	check_ts = true,
	ts_config = {
		lua = { "string" },
	},
	fast_wrap = {
		map = "<C-e>",
		chars = { "{", "[", "(", '"', "'", "`", "<" },
		pattern = [=[[%'%"%>%]%)%}%,]]=],
		offset = -1,
		end_key = "$",
		keys = "asetniol",
		check_comma = true,
		highlight = "Search",
		highlight_grey = "Comment",
	},
})

npairs.add_rules({
	Rule(" ", " "):with_pair(function(opts)
		local pair = opts.line:sub(opts.col - 1, opts.col)
		return vim.tbl_contains({
			brackets[1][1] .. brackets[1][2],
			brackets[2][1] .. brackets[2][2],
			brackets[3][1] .. brackets[3][2],
		}, pair)
	end),
})
for _, bracket in pairs(brackets) do
	npairs.add_rules({
		Rule(bracket[1] .. " ", " " .. bracket[2])
			:with_pair(function()
				return false
			end)
			:with_move(function(opts)
				return opts.prev_char:match(".%" .. bracket[2]) ~= nil
			end)
			:use_key(bracket[2]),
	})
end

local get_closing_for_line = function(line)
	local i = -1
	local clo = ""

	while true do
		i, _ = string.find(line, "[%(%)%{%}%[%]]", i + 1)
		if i == nil then
			break
		end
		local ch = string.sub(line, i, i)
		local st = string.sub(clo, 1, 1)

		if ch == "{" then
			clo = "}" .. clo
		elseif ch == "}" then
			if st ~= "}" then
				return ""
			end
			clo = string.sub(clo, 2)
		elseif ch == "(" then
			clo = ")" .. clo
		elseif ch == ")" then
			if st ~= ")" then
				return ""
			end
			clo = string.sub(clo, 2)
		elseif ch == "[" then
			clo = "]" .. clo
		elseif ch == "]" then
			if st ~= "]" then
				return ""
			end
			clo = string.sub(clo, 2)
		end
	end

	return clo
end

npairs.add_rule(Rule("[%(%{%[]", "")
	:use_regex(true)
	:replace_endpair(function(opts)
		return get_closing_for_line(opts.line)
	end)
	:end_wise(function(opts)
		-- Do not endwise if there is no closing
		return get_closing_for_line(opts.line) ~= ""
	end))
