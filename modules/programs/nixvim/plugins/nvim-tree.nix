{delib, ...}:
delib.module {
  name = "programs.nixvim.plugins.nvim-tree";

  options = delib.singleEnableOption true;

  home.ifEnabled.programs.nixvim = {
    plugins.nvim-tree = {
      enable = true;
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
