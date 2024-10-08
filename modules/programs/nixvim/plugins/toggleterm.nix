{delib, ...}:
delib.module {
  name = "programs.nixvim.plugins.toggleterm";

  options = delib.singleEnableOption true;

  home.ifEnabled.programs.nixvim = {
    plugins.toggleterm = {
      enable = true;

      settings = {
        size = ''
          function(term)
            if term.direction == "horizontal" then
              return 15
            elseif term.direction == "vertical" then
              return vim.o.columns * 0.4
            end
          end
        '';
      };
    };

    keymaps = [
      {
        action = "<cmd>ToggleTerm direction=horizontal<cr>";
        key = "<C-t>";
        options = {
          silent = true;
          desc = "ToggleTerm horizontal";
        };
      }
      {
        action = "<cmd>ToggleTerm direction=vertical<cr>";
        key = "<C-A-t>";
        options = {
          silent = true;
          desc = "ToggleTerm vertical";
        };
      }
    ];
  };
}
