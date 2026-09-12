{
  config,
  pkgs,
  ...
}:

{
  programs.fish.enable = true;

  programs.starship = {
    enable = true;
    interactiveOnly = true;
    settings = {
      format = " $username$hostname$directory$git_branch$git_status$nix_shell$line_break$character";
      add_newline = true;
      scan_timeout = 10;

      directory = {
        style = "bold cyan";
        truncate_to_repo = true;
      };

      git_branch = {
        format = "on [$branch]($style) ";
        style = "bold magenta";
      };

      git_status = {
        disabled = false;
        style = "bold red";
        format = "([$all_status$ahead_behind]($style) )";
        conflicted = "!";
        ahead = "⇡";
        behind = "⇣";
        diverged = "⇕";
        modified = "*";
        staged = "+";
        renamed = "»";
        deleted = "✘";
        untracked = "";
        stashed = "";
      };

      nix_shell = {
        symbol = "❄️ ";
        format = "[$symbol]($style)";
        style = "bold blue";
      };

      username = {
        style_user = "white bold";
        style_root = "red bold";
        format = "[$user ]($style)";
        disabled = false;
        show_always = false;
      };

      hostname = {
        ssh_only = true;
        format = "@[$hostname]($style) ";
        style = "green bold";
        disabled = false;
      };

      character = {
        success_symbol = "[ ⬤](bold green)";
        error_symbol = "[ ⬤](bold red)";
      };
    };
  };

  programs.fzf = {
    fuzzyCompletion = true;
    keybindings = true;
  };

  programs.atuin = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      auto_sync = true;
      update_check = false;
      search_mode = "fuzzy";
      filter_mode = "global";
    };
  };

  programs.bash = {
    enable = true;
    vteIntegration = false;

    interactiveShellInit = ''
        export ATUIN_NOBIND="true"
        export STARSHIP_ASYNC="1"

        alias ssh="TERM=xterm-256color ssh"

            if grep -qv fish /proc/$PPID/comm && [[ $SHLVL == 1 ]]; then
        SHELL=${pkgs.fish}/bin/fish
        exec ${pkgs.fish}/bin/fish
      fi
    '';
  };

  programs.bash.completion.enable = true;
  #  programs.bash.promptInit = ''
  #    PS1='\n \[\e[1;34m\]\w/\[\e[0m\]\n\[\e[$(if [ $UID -eq 0 ]; then echo "1;31"; else echo "1;32"; fi)m\] \$ \[\e[0m\]'
  #  '';

  programs.bash.loginShellInit = ''
    if [[ -z "$DISPLAY" && -z "$WAYLAND_DISPLAY" && "$(tty)" == "/dev/tty1" ]]; then
      exec dbus-run-session sway
    fi
  '';

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    globals.mapleader = " ";

    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      tabstop = 2;
      expandtab = true;
      smartindent = true;
      timeoutlen = 200;
      termguicolors = true;
      clipboard = "unnamedplus";
      scrolloff = 8;
      cursorline = true;
      wrap = false;
      cmdheight = 1;
      laststatus = 3;
      hlsearch = false;
      incsearch = true;
      undofile = true;
    };

    colorschemes.catppuccin = {
      enable = true;
      settings.flavour = "mocha";
    };

    plugins = {
      luasnip.enable = true;
      friendly-snippets.enable = true;
      lsp-format.enable = true;

      lualine = {
        enable = true;
        settings = {
          sections.lualine_c = [
            ""
            {
              __unkeyed-1 = "filename";
              symbols = {
                modified = "●";
                readonly = "  ";
                unnamed = "[No Name]";
                newfile = "[New]";
              };
            }
            "%="
          ];
          options = {
            globalstatus = true;
            section_separators = {
              left = "";
              right = "";
            };
            component_separators = {
              left = "";
              right = "";
            };
          };
        };
      };

      web-devicons.enable = true;

      noice = {
        enable = true;
        settings = {
          cmdline.view = "cmdline";
          presets.command_palette = false;
          lsp.override = {
            "vim.lsp.util.convert_input_to_markdown_lines" = true;
            "vim.lsp.util.stylize_markdown" = true;
          };
          presets = {
            bottom_search = true;
            long_message_to_split = true;
          };
          views.cmdline_popup = {
            position = {
              row = "110%";
              col = "50%";
            };
          };
        };
      };

      notify.enable = true;
      nui.enable = true;

      telescope.enable = true;
      treesitter.enable = true;

      neo-tree = {
        enable = true;
        enableGitStatus = true;
        closeIfLastWindow = true;
      };

      oil = {
        enable = true;
        settings = {
          skip_confirm_for_simple_edits = true;
          view_options.show_hidden = true;
        };
      };

      flash = {
        enable = true;
        settings = {
          labels = "asdfghjklweruiovm";
          search.enabled = true;
        };
      };

      which-key.enable = true;

      lsp = {
        enable = true;
        servers = {
          nil_ls.enable = true;
          yamlls.enable = true;
          terraformls.enable = true;
          bashls.enable = true;
          dockerls.enable = true;
          gopls.enable = true;
        };
      };

      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "luasnip"; }
            { name = "buffer"; }
          ];
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = "cmp.mapping.confirm({ select = true })";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
          };
        };
      };

      gitsigns = {
        enable = true;
        settings = {
          current_line_blame = true;
          signs = {
            add = {
              text = "▎";
            };
            change = {
              text = "▎";
            };
          };
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>e";
        action = ":Neotree toggle<CR>";
        options.desc = "Открыть дерево файлов";
      }
      {
        mode = "n";
        key = "<leader>ff";
        action = ":Telescope find_files<CR>";
        options.desc = "Поиск файлов";
      }
      {
        mode = "n";
        key = "<leader>fg";
        action = ":Telescope live_grep<CR>";
        options.desc = "Поиск текста внутри файлов";
      }
      {
        mode = "n";
        key = "-";
        action = "<CMD>Oil<CR>";
        options.desc = "Open parent directory in Oil";
      }
      {
        mode = "n";
        key = "[d";
        action = "v.diagnostic.goto_prev";
        options.desc = "Предыдущая ошибка";
      }
      {
        mode = "n";
        key = "]d";
        action = "v.diagnostic.goto_next";
        options.desc = "Следующая ошибка";
      }
      {
        mode = "n";
        key = "<leader>gp";
        action = ":Gitsigns preview_hunk<CR>";
        options.desc = "Посмотреть изменения в блоке";
      }
      {
        mode = "n";
        key = "<leader>gr";
        action = ":Gitsigns reset_hunk<CR>";
        options.desc = "Откатить изменения в блоке";
      }
      {
        mode = [
          "n"
          "x"
          "o"
        ];
        key = "s";
        action = "<cmd>lua require('flash').jump()<cr>";
        options.desc = "Flash Jump";
      }
      {
        mode = [
          "n"
          "x"
          "o"
        ];
        key = "S";
        action = "<cmd>lua require('flash').treesitter()<cr>";
        options.desc = "Flash Treesitter";
      }
    ];
  };

  programs.mtr.enable = true;
  programs.ccache.enable = true;
  nix.settings.extra-sandbox-paths = [ config.programs.ccache.cacheDir ];
}
