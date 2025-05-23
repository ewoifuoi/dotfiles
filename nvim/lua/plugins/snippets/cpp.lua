
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

ls.add_snippets("cpp", {
  s("cf", {
    t({
      "#include<bits/stdc++.h>",
      "using namespace std;",
      "int main() {",
      " ios::sync__with_stdio(false); cin.tie(0);",
      " ",
      " return 0;",
      "}",
    }),
  }),
})
