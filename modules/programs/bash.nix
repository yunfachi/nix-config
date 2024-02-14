{
  module-functions,
  hm,
  ...
}:
module-functions.module "programs" "bash" (cfg: {
  hm.programs.bash = {
    enable = true;
  };
})
