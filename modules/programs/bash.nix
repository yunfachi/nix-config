{
  module-functions,
  hm,
  ...
}:
module-functions.module "programs" "bash" {
  hm.programs.bash = {
    enable = true;
  };
}
