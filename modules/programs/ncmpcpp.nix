{
  module-functions,
  hm,
  pkgs,
  ...
}:
module-functions.module "programs" "ncmpcpp" {
  hm.programs.ncmpcpp = {
    enable = true;
    package = pkgs.ncmpcpp.override {visualizerSupport = true;};

    settings = {
    };
  };
}
