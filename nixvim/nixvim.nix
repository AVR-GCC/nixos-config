{ pkgs, ... }:

{
    enable = true;
    colorschemes.tokyonight.enable = true;

    clipboard = {
      register = "unnamedplus";
      providers.xclip.enable = true;
    };

    opts = {
      number = true;
      relativenumber = true;
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
    };

    globals.mapleader = " ";

    keymaps = [
      {
        mode = "n";
        key = "<leader>e";
        action = ":Neotree toggle<CR>";
        options.desc = "Toggle file tree";
      }
      {
        mode = "n";
        key = "<leader>h";
        action.__raw = ''
        function()
          vim.cmd("botright " .. math.floor(vim.o.lines * 0.3) .. "split")
          vim.cmd("terminal")
          vim.defer_fn(function()
            vim.cmd("startinsert")
          end, 1)
        end
        '';
        options.desc = "Open horizontal terminal";
      }
      {
        mode = "t";
        key = "<C-w>";
        action.__raw = ''
        function()
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", false)
        end
        '';
        options.desc = "Exit terminal mode";
      }
      {
        mode = "n";
        key = "<Tab>";
        action = ":bnext<CR>";
        options.desc = "Next buffer";
      }
      {
        mode = "n";
        key = "<S-Tab>";
        action = ":bprev<CR>";
        options.desc = "Previous buffer";
      }
      {
        mode = "n";
        key = "<leader>lg";
        action = ":LazyGit<CR>";
        options.desc = "Lazy git";
      }
      {
        mode = "n";
        key = "<Esc>";
        action = ":noh<CR>";
        options.desc = "Clear search highlights";
      }
      {
        mode = "n";
        key = "<leader>x";
        action.__raw = ''
          function()
            local buffers = vim.fn.getbufinfo({ buflisted = 1 })
            local is_empty = vim.fn.bufname() == ''' and vim.fn.getbufvar(vim.fn.bufnr(), '&modified') == 0
            if is_empty and #buffers <= 1 then
              return
            elseif #buffers > 1 then
              vim.cmd('bp | bd #')
            else
              vim.cmd('enew | bd #')
            end
          end
        '';
        options.desc = "Close tab";
      }
      {
        mode = "n";
        key = "<leader>ai";
        action.__raw = ''
          function()
            local cwd = vim.fn.getcwd()
            local check = vim.fn.system("tmux list-panes -a -F '#{pane_current_command}' | grep -c opencode")
            check = check:gsub("%s+", "")
            if check ~= "0" then
              vim.fn.system("tmux list-panes -a -F '#{pane_id} #{pane_current_command}' | grep opencode | awk '{print $1}' | xargs tmux kill-pane -t")
            else
              vim.fn.system("tmux split-window -h -l 25% -c '" .. cwd .. "' 'opencode'")
            end
          end
        '';
        options.desc = "Toggle opencode tmux pane";
      }
    ];

    extraPackages = with pkgs; [ nixd ripgrep opencode lsof ];

    plugins = {
      lsp = {
        enable = true;
        servers.nixd.enable = true;
      };
      cmp = {
        enable = true;
        settings.sources = [
          { name = "nvim_lsp"; }
          { name = "buffer"; }
          { name = "path"; }
        ];
        settings.mapping = {
          "<C-Space>" = "cmp.mapping.complete()";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<Tab>" = "cmp.mapping.select_next_item()";
          "<S-Tab>" = "cmp.mapping.select_prev_item()";
          "<C-e>" = "cmp.mapping.abort()";
        };
      };
      lualine.enable = true;
      neo-tree.enable = true;
      lazygit.enable = true;
      web-devicons.enable = true;
      bufferline.enable = true;
      telescope = {
        enable = true;
        keymaps = {
          "<leader>ff" = "find_files";
          "<leader>fw" = "live_grep";
          "<leader>fb" = "buffers";
          "<leader>fh" = "help_tags";
        };
      };
      which-key.enable = true;
      treesitter = {
        enable = true;
        settings.indent.enable = true;
      };
    };

    extraConfigLua = ''
      vim.g.opencode_opts = { port = 4321 }
    '';
  }
