{ ... }:

{
    enable = true;
    theme = null;
    settings = {
      layout = [
        {
          type = "padding";
          val = 4;
        }
        {
          type = "text";
          val = [
            ":::::::::      :::     :::::::::   ::::::::       :::     ::: ::::::::::: ::::    :::: "
            ":+:    :+:   :+: :+:   :+:    :+: :+:    :+:      :+:     :+:     :+:     +:+:+: :+:+:+"
            "+:+    +:+  +:+   +:+  +:+    +:+ +:+             +:+     +:+     +:+     +:+ +:+:+ +:+"
            "+#++:++#+  +#++:++#++: +#++:++#:  +#++:++#++      +#+     +:+     +#+     +#+  +:+  +#+"
            "+#+    +#+ +#+     +#+ +#+    +#+        +#+       +#+   +#+      +#+     +#+       +#+"
            "#+#    #+# #+#     #+# #+#    #+# #+#    #+#        #+#+#+#       #+#     #+#       #+#"
            "#########  ###     ### ###    ###  ########           ###     ########### ###       ###"
            ""
            ""
            ""
            ""
            "                                          Allen Mullen"
            "                     .......     -4$$e.                       ....... $$$$c"
            "                    .$$$$??$$$e.d$bec.CC..                  .e$$$???$$$eJ\"\"\"$ec"
            "                    4$$bd ..^?$$$e.$$$$$$$$$$$$$$$$eeed$P?.d$$$E..dbcJC$$$$$$$$P"
            "                 .  .3$$$.?$ ..\"\")C$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$PFF\"?\"?\"\""
            "               $$F d$$$$$$e   .z$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$P\"\".ee z$b e$"
            "               \"P  \"$$$$$$$$$$$$$$$$$$$$$$$$$$$P\"\"\" \"\"\"\"???????\"\"  $$$$P $$\"dF"
            "           .e$%.e$$$$$$$$$$$$$$$$$$$$$$$$$$P\"\" 4$$$   4$be   ee$P  4$$P\"z\" ^"
            "           \"P\"e$$$$$$$P\"CCC\"\"\"\"?$$$$$$$PF\".er   \"P\"   4P\"    $$\"   $P\""
            "             e$$$?3$F   ?$P    d$b  4ee   $P"
            "        .e$ 4$$$\"e$$      \"   ^\"    P\"        $$e     e."
            "        ^$$ $$$F $$$   d$. 4$.         $$=  ......   d$b     .dF   .$F e zr"
            "            ?$$$.`?f ......J\"?  .$$   ^Lz$$$$$$$$$$$$e..   'd$$% -d$$\" \"...e"
            "            `$$$$  z$$$$$$$$$e. \"\"\".zd$$$$$$$$$$$$$$$$$$$$$$eeeeeed$$$$$$$P\""
            "              ?$$$$$$$$$$$$$$$$$$$$$$$$P????????????\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\""
            "                `?$$$$$$$$$$$$$$$$$$P\".eeeeeeee$$$$$$\"\"\"\"\"\"\"\"\""
            "                    `\"\"????????\"\"..ed$$$$bK\"\"\"\"\"\"\""
            "                                \"\"\"\"\"\"\"\""
            ""
            ""
            ""
            ""
          ];
          opts = {
            position = "center";
            hl = "AlphaHeader";
          };
        }
        {
          type = "padding";
          val = 2;
        }
        {
          type = "button";
          val = "󰈞  Find File";
          on_press.__raw = "function() require('telescope.builtin').find_files() end";
          opts = {
            position = "center";
            shortcut = "SPC f f";
            width = 40;
            align_shortcut = "right";
            hl = "AlphaButtons";
          };
        }
        {
          type = "padding";
          val = 1;
        }
        {
          type = "button";
          val = "󰍉  Live Grep";
          on_press.__raw = "function() require('telescope.builtin').live_grep() end";
          opts = {
            position = "center";
            shortcut = "SPC f g";
            width = 40;
            align_shortcut = "right";
            hl = "AlphaButtons";
          };
        }
        {
          type = "padding";
          val = 1;
        }
        {
          type = "button";
          val = "󰙅  File Tree";
          on_press.__raw = "function() vim.cmd('Neotree toggle') end";
          opts = {
            position = "center";
            shortcut = "SPC e  ";
            width = 40;
            align_shortcut = "right";
            hl = "AlphaButtons";
          };
        }
        {
          type = "padding";
          val = 1;
        }
        {
          type = "button";
          val = "  Lazygit";
          on_press.__raw = "function() vim.cmd('LazyGit') end";
          opts = {
            position = "center";
            shortcut = "SPC l g";
            width = 40;
            align_shortcut = "right";
            hl = "AlphaButtons";
          };
        }
        {
          type = "padding";
          val = 1;
        }
        {
          type = "button";
          val = "󰫢  AI Assistant";
          on_press.__raw = builtins.readFile "${builtins.getEnv "FLAKE_PATH"}/nixvim/lua/toggle-ai-pane.lua";
          opts = {
            position = "center";
            shortcut = "SPC a i";
            width = 40;
            align_shortcut = "right";
            hl = "AlphaButtons";
          };
        }
        {
          type = "padding";
          val = 1;
        }
        {
          type = "button";
          val = "  Terminal";
          on_press.__raw = builtins.readFile "${builtins.getEnv "FLAKE_PATH"}/nixvim/lua/open-terminal.lua";
          opts = {
            position = "center";
            shortcut = "SPC h  ";
            width = 40;
            align_shortcut = "right";
            hl = "AlphaButtons";
          };
        }
      ];
    };
  }
