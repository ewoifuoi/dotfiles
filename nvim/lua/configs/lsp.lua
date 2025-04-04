local lspconfig = require "lspconfig"
local mr = require "mason-registry"

local nvlsp = require "nvchad.configs.lspconfig"

local eagerly_installed_langs = { "diff", "Lua", "Vim", "Markdown", "markdown_inline" }
local ensure_installed = {
  ["*"] = { "typos_lsp" },
  Agda = { "agda_ls" },
  Angular = { "angularls" },
  Arduino = { "arduino_language_server" },
  Astro = { "astro", "stylelint_lsp", "tailwindcss" },
  AWK = { "awk_ls" },
  Bash = { "bashls", "shellcheck", "shfmt" },
  ["BUILD.Bazel"] = { "starlark_rust" }, -- Bazel
  bzl = { "starlark_rust" }, -- Bazel
  C = { "clangd", "clang-format" },
  Clojure = { "clojure_lsp", "zprint", "clj-kondo" },
  CMake = { "cmake" },
  CMakeCache = { "cmake" },
  COBOL = { "cobol_ls" },
  conf = { "autotools_ls" }, -- Autoconf
  ConTeXt = { "texlab" },
  Coq = { "coq_lsp" },
  Cpp = { "clangd", "clang-format" },
  Crystal = { "crystalline" },
  Cucumber = { "cucumber_language_server" },
  Cypher = { "cypher_ls" },
  csh = { "bashls", "shellcheck", "beautysh" },
  CS = { "ominisharp", "csharpier" }, -- C#
  CSS = { "cssls", "stylelint_lsp", "tailwindcss" },
  D = { "serve_d" },
  Dart = { "dartls" },
  Dhall = { "dhall_lsp_server", "purescriptls", "purescript-tidy" },
  Dockerfile = { "dockerls", "docker_compose_language_service" },
  Dot = { "dotls" },
  Elixir = { "lexical" },
  Elm = { "elmls", "elm-format" },
  Erlang = { "elp" },
  Erg = { "erg_language_server" },
  Fennel = { "fennel_ls" },
  Flux = { "flux_lsp" },
  Fortran = { "fortls" },
  FSharp = { "fsautocomplete" }, -- F#
  genie = { "vala_ls" }, -- Vala
  Go = { "gopls", "goimports", "golangci_lint_ls" },
  GraphQL = { "graphql" },
  Groovy = { "groovyls", "gralde_ls" },
  Hack = { "hhvm" },
  Haskell = { "hls", "ormolu", "hlint" },
  Haxe = { "haxe_language_server" },
  Helm = { "helm_ls" },
  Hoon = { "hoon_ls" },
  HTML = { "html", "angularls", "tailwindcss" },
  Hyprlang = { "hyprls" },
  Idris2 = { "idris2_lsp" },
  Java = { "jdtls", "checkstyle", "google-java-format" },
  JavaScript = { "vtsls", "prettierd", "eslint_d", "eslint", "stylelint_lsp", "tailwindcss" },
  JavaScriptReact = { "vtsls", "prettierd", "eslint_d", "eslint", "stylelint_lsp", "tailwindcss" },
  Jinja = { "jinja_lsp" },
  jq = { "jqls" },
  JSON = { "jsonls", "spectral" },
  Jsonnet = { "jsonnet_ls" },
  Julia = { "julials" },
  Kotlin = { "kotlin_language_server", "gradle_ls" },
  ksh = { "bashls", "shellcheck", "beautysh" },
  LaTeX = { "texlab" },
  libsonnet = { "jsonnet_ls" },
  Lean = { "leanls" },
  Lean3 = { "lean-language-server", "lean3ls" },
  Less = { "cssls", "stylelint_lsp", "tailwindcss" },
  Lua = { "lua_ls", "stylua" },
  Luau = { "luau_lsp", "stylua" },
  Make = { "autotools_ls" },
  Markdown = { "marksman" },
  ["Markdown.MDX"] = { "mdx_analyzer" },
  Matlab = { "matlab_ls" },
  Meson = { "mesonlsp" },
  mksh = { "bashls", "shellcheck", "shfmt" },
  Move = { "move_analyzer" },
  ncl = { "nickel_ls" }, -- Nickel
  Nginx = { "nginx_language_server" },
  Nickel = { "nickel_ls" },
  Nim = { "nim_langserver" },
  Ninja = { "autotools_ls" },
  Nix = { "nil_ls" },
  OCaml = { "ocamllsp", "ocamlformat" },
  p8 = { "pico8_ls" }, -- PICO-8
  Perl = { "perlnavigator", "raku_navigator" },
  pest = { "pest_ls" },
  PHP = { "phpactor", "psalm" },
  PlainTeX = { "texlab" },
  PowerShell = { "powershell_es" },
  Prisma = { "prismals" },
  Proto = { "pbls" }, -- Protobuf
  PureScript = { "purescriptls", "purescript-tidy" },
  Python = { "pyright", "ruff" },
  R = { "r_language_server" },
  Raku = { "raku_navigator" },
  Reason = { "reason_ls" },
  Rego = { "regal" },
  ReScript = { "rescriptls" },
  rst = { "esbonio" }, -- Sphinx
  Ruby = { "solargraph", "rubocop", "sorbet" },
  Rust = { "rust_analyzer" },
  Scala = { "metals" },
  SCSS = { "cssls", "stylelint_lsp", "tailwindcss" },
  sh = { "bashls", "shellcheck", "shfmt" },
  Slint = { "slint_lsp" },
  Smithy = { "smithy_ls" },
  SML = { "millet" },
  Solidity = { "solidity", "solang" },
  SQL = { "sqls" },
  star = { "starlark_rust" }, -- Bazel
  Svelte = { "svelte", "stylelint_lsp", "tailwindcss" },
  SystemVerilog = { "verible", "hdl_checker" },
  tcsh = { "bashls", "shellcheck", "beautysh" },
  Teal = { "teal_ls" },
  Terraform = { "terraformls", "tflint" },
  TeX = { "texlab" },
  Thrift = { "thriftls" },
  TOML = { "taplo" },
  TypeScript = { "vtsls", "prettierd", "eslint_d", "eslint", "angularls", "stylelint_lsp", "tailwindcss" },
  TypeScriptReact = { "vtsls", "prettierd", "eslint_d", "eslint", "stylelint_lsp", "tailwindcss" },
  Typst = { "typst_lsp" },
  V = { "v_analyzer" },
  Vala = { "vala_ls" },
  VB = { "ominisharp" },
  Verilog = { "verible", "hdl_checker" },
  Veryl = { "veryl_ls" },
  VHDL = { "vhdl_ls", "hdl_checker" },
  Vim = { "vimls" },
  Vlang = { "v_analyzer" },
  Vue = { "volar", "stylelint_lsp", "tailwindcss" },
  WGSL = { "wgsl_analyzer" },
  XML = { "lemminx" },
  YAML = { "yamlls", "spectral", "docker_compose_language_service", "azure_pipelines_ls" },
  YML = { "yamlls", "spectral", "docker_compose_language_service", "azure_pipelines_ls" },
  Zig = { "zls" },
  Zsh = { "bashls", "shellcheck", "beautysh" },
}

---@type MasonLspconfigSettings
local options = {
  handlers = {
    function(server_name)
      ---@diagnostic disable-next-line: underdefined-field
      lspconfig[server_name].setup {
        on_attach = nvlsp.on_attach,
        on_init = nvlsp.on_init,
        capabilities = nvlsp.capabilities,
      }
    end,
  },
}

--- Start: Implementation of auto-installation of language servers
---
local ensure_lang_installed = (function()
  local mason_registry_refreshing = true
  mr.refresh(function()
    mason_registry_refreshing = false
  end)

  local installing = false

  ---@type string[]
  local installed_langs = {}
  ---@type string|nil
  local installing_lang = nil
  ---@type string[]
  local queued_langs = {}

  local show = vim.schedule_wrap(function(format, ...)
    vim.notify(string.format(format, ...), vim.log.levels.INFO, { title = "LSP" })
  end)
  local show_error = vim.schedule_wrap(function(format, ...)
    vim.notify(string.format(format, ...), vim.log.levels.ERROR, { title = "LSP" })
  end)

  -- Checks if parser is installed with nvim-treesitter
  -- See: https://github.com/nvim-treesitter/nvim-treesitter/blob/master/lua/nvim-treesitter/install.lua
  ---@param lang string
  ---@return boolean
  local is_treesitter_installed = function(lang)
    local clean_path = function(input)
      local path = vim.fn.fnamemodify(input, ":p")
      if vim.fn.has "win32" == 1 then
        path = path:gsub("/", "\\")
      end
      return path
    end

    local matched_parsers = vim.api.nvim_get_runtime_file("parser/" .. lang .. ".so", true) or {}
    local install_dir = require("nvim-treesitter.configs").get_parser_install_dir()
    if not install_dir then
      return false
    end
    install_dir = clean_path(install_dir)
    for _, path in ipairs(matched_parsers) do
      local abspath = clean_path(path)
      if vim.startswith(abspath, install_dir) then
        return true
      end
    end
    return false
  end

  local find_lspconfig = (function()
    ---@type table<string, any>
    local cache = {}

    ---@param server_name string
    return function(server_name)
      if cache[server_name] then
        return cache[server_name]
      end

      local found, config = pcall(require, "lspconfig.configs." .. server_name)
      if found then
        cache[server_name] = config
        return config
      end

      cache[server_name] = nil
      return nil
    end
  end)()

  ---@alias PackageType "lspconfig"|"mason"|"mason-lspconfig"|"treesitter"

  ---@param name string
  ---@return PackageType, string
  local parse_name = function(name)
    local parts = vim.split(name, "/")

    -- Guess type of the package
    if #parts == 1 then
      if find_lspconfig(name) then
        if require("mason-lspconfig").get_mappings().lspconfig_to_mason[name] then
          return "mason-lspconfig", require("mason-lspconfig").get_mappings().lspconfig_to_mason[name]
        end
        return "lspconfig", name
      end
      if require("mason-lspconfig").get_mappings().mason_to_lspconfig[name] then
        return "mason-lspconfig", name
      end
      if require("nvim-treesitter.parsers").get_parser_configs()[name] then
        return "treesitter", name
      end
      return "mason", name
    end

    local type_matches = {
      lspconfig = "lspconfig",
      mason = "mason",
      ts = "treesitter",
    }
    if #parts == 2 then
      local type = type_matches[parts[1]]
      if not type then
        local message =
          string.format("Failed to parse package name '%s': '%s' is not a valid package type", name, parts[1])
        show_error("[LSP] " .. message)
        error(message)
      end
      if type == "lspconfig" and not find_lspconfig(parts[2]) then
        local message =
          string.format("Failed to parse package name '%s': '%s' is not a valid lspconfig server", name, parts[2])
        show_error("[LSP] " .. message)
        error(message)
      end
      if type == "treesitter" and not require("nvim-treesitter.parsers").get_parser_configs()[parts[2]] then
        local message =
          string.format("Failed to parse package name '%s': '%s' is not a valid treesitter parser", name, parts[2])
        show_error("[LSP] " .. message)
        error(message)
      end
      if type == "lspconfig" and require("mason-lspconfig").get_mappings().lspconfig_to_mason[parts[2]] then
        return "mason-lspconfig", require("mason-lspconfig").get_mappings().lspconfig_to_mason[parts[2]]
      end
      if type == "mason" and require("mason-lspconfig").get_mappings().mason_to_lspconfig[parts[2]] then
        return "mason-lspconfig", parts[2]
      end
      return type, parts[2]
    end

    local message = string.format("Failed to parse package name '%s': Invalid format", name)
    show_error("[LSP] " .. message)
    error(message)
  end

  ---@class TreesitterPackageDescription
  ---@field type "treesitter"
  ---@field name string
  ---@field on_success? function
  ---@field on_failed? function

  ---@class LspconfigPackageDescription
  ---@field type "lspconfig"
  ---@field name string
  ---@field setup? function

  ---@class MasonPackageDescription
  ---@field type "mason"
  ---@field pkg Package
  ---@field on_success? function
  ---@field on_failed? function

  ---@alias PackageDescription TreesitterPackageDescription|LspconfigPackageDescription|MasonPackageDescription

  ---@param lang string
  ---@param cb function
  local install_lang = function(lang, cb)
    ---@type PackageDescription[]
    local queued_pkgs = {}

    -- Try adding treesitter to install list if possible
    ensure_installed[lang] = ensure_installed[lang] or {}
    local treesitter_available = require("nvim-treesitter.parsers").get_parser_configs()[lang:lower()]
    if treesitter_available then
      local to_add = "ts/" .. lang:lower()
      for _, unparsed_name in ipairs(ensure_installed[lang]) do
        if unparsed_name == to_add then
          break
        end
      end
      table.insert(ensure_installed[lang], 1, to_add)
    end

    for _, unparsed_name in ipairs(ensure_installed[lang]) do
      ---@return PackageDescription|nil
      local get_pkg_description = function()
        local type, name = parse_name(unparsed_name)

        if type == "treesitter" then
          if is_treesitter_installed(name) then
            return
          end

          return {
            type = "treesitter",
            name = name,
          }
        end

        if type == "lspconfig" then
          local setup = function()
            lspconfig[name].setup {
              on_attach = nvlsp.on_attach,
              on_init = nvlsp.on_init,
              capabilities = nvlsp.capabilities,
            }
          end

          if #queued_pkgs > 0 then
            -- Delay setup of lspconfig packages until all mason packages are installed
            return {
              type = "lspconfig",
              name = name,
              setup = setup,
            }
          end

          setup()
          return
        end

        ---@type boolean, Package
        local found_in_mason_registry, pkg = pcall(mr.get_package, name)

        if found_in_mason_registry then
          if pkg:is_installed() then
            return
          end

          return {
            type = "mason",
            pkg = pkg,
          }
        end

        if type == "mason-lspconfig" then
          show_error("[LSP] Network error: failed to find package for '%s' in Mason registry", unparsed_name)
          return
        end

        show_error(
          "[LSP] Failed to find package for '%s' in Mason registry. Check your network connection or typos in the package name",
          unparsed_name
        )
      end

      local pkg = get_pkg_description()
      if pkg then
        table.insert(queued_pkgs, pkg)
      end
    end

    if #queued_pkgs == 0 then
      if cb then
        cb()
      end
      return
    end

    if lang ~= "*" then
      show("[LSP] [%s/%s] Installing language server for %s...", 0, #queued_pkgs, lang)
    end

    ---@param i integer
    local function install_pkg(i)
      if i > #queued_pkgs then
        vim.cmd "LspStart"

        if cb then
          cb()
        end

        return
      end

      local desc = queued_pkgs[i]

      if desc.type == "treesitter" then
        show("[LSP] [%s/%s] Installing Treesitter for %s...", i, #queued_pkgs, lang == "*" and desc.name or lang)

        local start = os.clock()
        local timeout_ms = 8000

        vim.cmd("TSInstall " .. desc.name)

        local function go()
          if is_treesitter_installed(desc.name) then
            show("[LSP] [%s/%s] Installed Treesitter for %s", i, #queued_pkgs, lang == "*" and desc.name or lang)
            if desc.on_success then
              desc.on_success()
            end
            install_pkg(i + 1)
            return
          end

          if os.clock() - start > timeout_ms / 1000 then
            show_error(
              "[LSP] [%s/%s] Error: Timed out while installing Treesitter for %s",
              i,
              #queued_pkgs,
              lang == "*" and desc.name or lang
            )
            if desc.on_failed then
              desc.on_failed()
            end
            install_pkg(i + 1)
            return
          end

          vim.defer_fn(go, 100)
        end

        vim.defer_fn(go, 100)
        return
      end

      if desc.type == "lspconfig" then
        show(
          "[LSP] [%s/%s] Setting up lspconfig '%s'%s...",
          i,
          #queued_pkgs,
          lang == "*" and desc.name or " for " .. lang
        )
        if desc.setup then
          desc.setup()
        end
        show("[LSP] [%s/%s] Set up lspconfig '%s'%s", i, #queued_pkgs, lang == "*" and desc.name or " for " .. lang)
        vim.schedule(function()
          install_pkg(i + 1)
        end)
        return
      end

      local pkg = desc.pkg

      show("[LSP] [%s/%s] Installing %s%s...", i, #queued_pkgs, pkg.name, lang == "*" and "" or " for " .. lang)

      pkg:once("install:success", function()
        table.insert(installed_langs, lang)
        show("[LSP] [%s/%s] Installed %s%s", i, #queued_pkgs, pkg.name, lang == "*" and "" or " for " .. lang)
        if desc.on_success then
          desc.on_success()
        end
        vim.schedule(function()
          install_pkg(i + 1)
        end)
      end)
      pkg:once("install:failed", function()
        table.insert(installed_langs, lang)
        show_error(
          "[LSP] [%s/%s] Failed to install %s%s",
          i,
          #queued_pkgs,
          pkg.name,
          lang == "*" and "" or " for " .. lang
        )
        if desc.on_failed then
          desc.on_failed()
        end
        vim.schedule(function()
          install_pkg(i + 1)
        end)
      end)

      pkg:install()
    end

    install_pkg(1)
  end

  ---@param lang string
  return function(lang)
    for key in pairs(ensure_installed) do
      if lang:lower() == key:lower() then
        lang = key
        break
      end
    end

    if not ensure_installed[lang] and not require("nvim-treesitter.parsers").get_parser_configs()[lang:lower()] then
      return
    end

    if installed_langs[lang] then
      return
    end

    if installing_lang == lang then
      return
    end

    for _, l in ipairs(queued_langs) do
      if l == lang then
        return
      end
    end

    table.insert(queued_langs, lang)
    if not installing then
      local function go()
        if #queued_langs == 0 then
          installing = false
          return
        end

        if mason_registry_refreshing then
          vim.defer_fn(go, 100)
          return
        end

        installing_lang = table.remove(queued_langs, 1)
        vim.schedule(function()
          install_lang(installing_lang, function()
            table.insert(installed_langs, installing_lang)
            installing_lang = nil
            vim.schedule(go)
          end)
        end)
      end

      installing = true
      vim.schedule(go)
    end
  end
end)()

vim.api.nvim_create_autocmd({ "BufReadPost", "FileType" }, {
  pattern = "*",
  callback = function()
    ensure_lang_installed(vim.bo.filetype)
  end,
})

ensure_lang_installed "*"
for _, lang in ipairs(eagerly_installed_langs) do
  ensure_lang_installed(lang)
end
--- End: Implementation of auto-installation of language servers

return options
