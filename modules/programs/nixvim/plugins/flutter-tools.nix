{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.nixvim.plugins.flutter-tools";

  options = delib.singleEnableOption true;

  home.ifEnabled.programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [flutter-tools-nvim plenary-nvim];
    extraConfigLua = ''
      require("flutter-tools").setup {}
    '';
  };
}
