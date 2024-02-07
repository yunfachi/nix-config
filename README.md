# yunfachi's NixOS configuration

## Tree
<big><pre>
.
├── [hosts](./hosts/)
│   ├── [mitama](./hosts/mitama/)
│   │   ├── [default.nix](./hosts/mitama/default.nix)
│   │   └── [hardware.nix](./hosts/mitama/hardware.nix)
│   └── [default.nix](./hosts/default.nix)
├── [lib](./lib/)
│   ├── [module-functions.nix](./lib/module-functions.nix)
│   └── [option-functions.nix](./lib/option-functions.nix)
├── [modules](./modules/)
│   ├── [config](./modules/config/)
│   ├── [programs](./modules/programs/)
│   ├── [services](./modules/services/)
│   └── [system](./modules/system/)
├── [options](./options/)
│    ├── [config](./options/config/)
│    ├── [programs](./options/programs/)
│    ├── [services](./options/services/)
│    └── [system](./options/system/)
├── [constants.nix](./constants.nix)
└── [flake.nix](./flake.nix)
</pre></big>

## Examples
<details>
<summary>Module</summary>

| ⚠️ Warning | 
|:------------------------------------------:|
| Using the `config` variable in these examples will cause an infinite recursion |

If `config.yunfachi.programs.deshiro.enable` is set to `true`, then `programs.deshiro.enable` will also be set to `true`.
<table><tr><th>without parameters</th><th>with parameters</th></tr><tr><td><pre lang="nix">
{module-functions, ...}:
module-functions.module "programs" "deshiro" {
  programs.deshiro.enable = true;
}
</pre></td><td><pre lang="nix">
{module-functions, ...}:
module-functions.module "programs" "deshiro" (cfg: {
  programs.deshiro.enable = true;
})
</pre></td></tr></table>
<br>

If `config.yunfachi.programs.deshiro.enable` is set to `false`, then `programs.deshiro.enable` will be set to `true`.
<table><tr><th>without parameters</th><th>with parameters</th></tr><tr><td><pre lang="nix">
{module-functions, ...}:
module-functions.moduleIfDisabled "programs" "deshiro" {
  programs.deshiro.enable = true;
}
</pre></td><td><pre lang="nix">
{module-functions, ...}:
module-functions.moduleIfDisabled "programs" "deshiro" (cfg: {
  programs.deshiro.enable = true;
})
</pre></td></tr></table>
<br>

If `config.yunfachi.programs.deshiro.enable` is set to `true`, then `programs.deshiro.enable` will also be set to `true`. If it's set to `false`, then `programs.deshiro.enable` will also be set to `false`.
<table><tr><th>without parameters</th><th>with parameters</th></tr><tr><td><pre lang="nix">
{module-functions, ...}:
module-functions.moduleIfElse "programs" "deshiro" {
  programs.deshiro.enable = true;
} {
  programs.deshiro.enable = false;
}
</pre></td><td><pre lang="nix">
{module-functions, ...}:
module-functions.moduleIfElse "programs" "deshiro" (cfg: {
  programs.deshiro.enable = true;
}) (cfg: {
  programs.deshiro.enable = false;
})
</pre></td></tr></table>
<br>

If `config.yunfachi.programs.deshiro-gui.enable` is set to `true`, then `programs.deshiro-gui.enable` will also be set to `true`. If it's set to `false`, then `programs.deshiro-gui.enable` will also be set to `false`. In both cases, `programs.deshiro-server.enable` will be set to `true`.
<table><tr><th>without parameters</th><th>with parameters</th></tr><tr><td><pre lang="nix">
{module-functions, ...}:
module-functions.moduleIfElseFinally "programs" "deshiro-gui" {
  programs.deshiro-gui.enable = true;
} {
  programs.deshiro-gui.enable = false;
} {
  programs.deshiro-server.enable = true;
}
</pre></td><td><pre lang="nix">
{module-functions, ...}:
module-functions.moduleIfElseFinally "programs" "deshiro-gui"
(cfg: {
  programs.deshiro-gui.enable = true;
}) (cfg: {
  programs.deshiro-gui.enable = false;
}) (cfg: {
  programs.deshiro-server.enable = true;
})
</pre></td></tr></table>

</details>

<details>
<summary>Option</summary>

Simple option with only the option to enable it. By default `enable` will be `true` as specified
```nix
{option-functions, ...}:
with option-functions;
  option "programs" "deshiro" {
    enable = enableOption "deshiro" true;
  }
```
<br>

Option that uses all features. By default `enable` will be `true` as specified and mode will be `"client"`, its example will be `"server"` (automatically found)
```nix
{option-functions, ...}:
with option-functions;
  option "programs" "deshiro" {
    enable = enableOption "deshiro" true;
    mode = enumOption "mode" "client" ["client" "server"]
  }
```

</details>