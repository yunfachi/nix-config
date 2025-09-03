{ delib, ... }:
delib.module {
  name = "programs.nixvim.plugins.nvim-tree";

  options = delib.singleEnableOption true;

  home.ifEnabled.programs.nixvim = {
    plugins.nvim-tree = {
      enable = true;

      settings = {
        renderer = {
          root_folder_label = false;
          indent_markers.enable = true;
          hidden_display = "all";

          highlight_git = "name";
          highlight_hidden = "name";

          icons = {
            git_placement = "right_align";
            diagnostics_placement = "right_align";
            modified_placement = "signcolumn";

            show = {
              git = false; # maybe true
              modified = true;
              diagnostics = true;

              bookmarks = false;
              folder_arrow = false;
              hidden = false;
            };

            glyphs = {
              modified = "󰧞";

              git = {
                unstaged = "U";
                staged = "S";
                unmerged = "M";
                renamed = "R";
                untracked = "T";
                deleted = "D";
                ignored = "I";
              };
            };
          };
        };

        git = {
          enable = true;
          show_on_dirs = true;
          show_on_open_dirs = false;
        };

        diagnostics = {
          enable = true;
          show_on_dirs = true;
          show_on_open_dirs = false;

          icons = {
            hint = "H";
            info = "I";
            warning = "W";
            error = "E";
          };
        };

        modified = {
          enable = true;
          show_on_dirs = true;
          show_on_open_dirs = false;
        };
      };
    };

    keymaps = [
      {
        action = "<cmd>NvimTreeToggle<cr>";
        key = "<C-e>";
        mode = "n";
        options = {
          silent = true;
          desc = "Toggle NvimTree";
        };
      }
      {
        action = "<cmd>NvimTreeFocus<cr>";
        key = "e";
        mode = "n";
        options = {
          silent = true;
          desc = "Focus NvimTree";
        };
      }
    ];
  };
}
