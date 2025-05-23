local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("cpp", {
  s("cf", {
    t({
      "#include<bits/stdc++.h>",
      "using namespace std;",
      "",
      "int main() {",
      " ios::sync_with_stdio(false); cin.tie(0);",
      " ",
    }),
    i(1),
    t({
      "",
      " return 0;",
      "}",
    }),
  }),
})
