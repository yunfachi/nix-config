{delib, ...}:
delib.module {
  name = "programs.nixvim.plugins.barbar";

  options = delib.singleEnableOption true;

  home.ifEnabled.programs.nixvim.plugins.barbar = {
    enable = true;

    settings = {
      sidebar_filetypes = {
        # NvimTree.text = nixvimLib.mkRaw "print(vim.fn.fnamemodify(vim.fn.getcwd(), ':t'))";
        NvimTree = true;
      };
    };
  };
}
