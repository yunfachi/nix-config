{
  delib,
  nixvimLib,
  ...
}:
delib.module {
  name = "programs.nixvim.plugins.lualine";

  options = delib.singleEnableOption true;

  home.ifEnabled.programs.nixvim.plugins.lualine = {
    enable = true;

    settings = {
      options = {
        section_separators = "";
        component_separators = "|";

        #ignore_focus = ["NvimTree"];
        disabled_filetypes = ["NvimTree"];
      };

      sections = {
        lualine_a = ["mode"];
        lualine_b = nixvimLib.nixvim.emptyTable;
        lualine_c = ["filename"];

        lualine_x = [
          {
            __unkeyed-1 = "diagnostics";
            symbols = {
              error = "E-";
              warn = "W-";
              info = "I-";
              hint = "H-";
            };
          }
          {
            __unkeyed-1 = "diff";
            symbols = {
              added = "A-";
              modified = "C-";
              removed = "R-";
            };
          }
        ];
        lualine_y = [
          {
            __unkeyed-1 = "branch";
            icons_enabled = false;
          }
        ];
        lualine_z = ["location"];
      };

      inactive_sections = {
        lualine_a = nixvimLib.nixvim.emptyTable;
        lualine_b = nixvimLib.nixvim.emptyTable;
        lualine_c = ["filename"];
        lualine_x = ["location"];
        lualine_y = nixvimLib.nixvim.emptyTable;
        lualine_z = nixvimLib.nixvim.emptyTable;
      };
    };
  };
}
