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
            ":::::::::      :::     :::::::::   ::::::::       :::     ::: ::::::::::: ::::    ::::  "
            ":+:    :+:   :+: :+:   :+:    :+: :+:    :+:      :+:     :+:     :+:     +:+:+: :+:+:+ "
            "+:+    +:+  +:+   +:+  +:+    +:+ +:+             +:+     +:+     +:+     +:+ +:+:+ +:+ "
            "+#++:++#+  +#++:++#++: +#++:++#:  +#++:++#++      +#+     +:+     +#+     +#+  +:+  +#+ "
            "+#+    +#+ +#+     +#+ +#+    +#+        +#+       +#+   +#+      +#+     +#+       +#+ "
            "#+#    #+# #+#     #+# #+#    #+# #+#    #+#        #+#+#+#       #+#     #+#       #+# "
            "#########  ###     ### ###    ###  ########           ###     ########### ###       ### "
            "                 __                  __                 __"
            "       ___  .-~~'.      ___~~-_.-~~'.    ___~  ~~-.-~~'.  ___ -~  ~~-.-~~' ___"
            "      | ''|`-...--'    | ''|  `-...--'  | ''|    `-...-- | ''|      `-... | ''|"
            "      |' '| -'        _|' '| ..--'      |' '| _....--'   |' '| ___....--' |' '|"
            "      | ''|_   _     | | ''| _   _     || ''|  _   _     | ''|   _   _    | ''|"
            "      | ''| |_| |____| | ''|| |_| |____|| ''|_| |_| |____| ''||_| |_| |___| ''|"
            "      |'' | | | |    | |'' || | | |    ||'' | | | | |    |'' || | | | |   |'' |"
            "      | ''|____ |    | | ''|____  |    || ''|____ | |    | ''|____  | |   | ''|"
            "      | ' |'' '|_______| ' |'' '|_______| ' |'' '|_______| ' |'' '|_______| ' |"
            "      |' '|' ' |''''  '|' '|' ' |''''  '|' '|' ' |''''  '|' '|' ' |''''  '|' '|"
            "      | ' | '''| ''  ''| ' | '''| ''  ''| ' | '''| ''  ''| ' | '''| ''  ''| ' |"
            "      _________________________________________________________________________"
            "      #########################################################################"
            "      | \\#//  |'' '''  \\#//   |'' ''' \\#//    |'' '' \\#//     |'' ' \\#// |"
            "      |' |#| ''| ''''  | |#|  ''| ''''   |#|   ''| ''''  |#| |  ''| '''' |#| '|"
            "      |''|#| ' |'''   '|'|#| '' |'''   ' |#| ''' |'''    |#|'|''' |'''   |#| '|"
            "      |' |#|  '| '  '' |'|#| ' '| '  ''  |#|  ' '| '  '' |#|'| ' '| '  ' |#| '|"
            "         |#|             |#|             |#|             |#|             |#|"
            ""
            "                                                                DR J"
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
