# yunfachi's nix-config

My [NixOS](https://nixos.org/) and [Home Manager](https://github.com/nix-community/home-manager) configuration for all my hosts, including servers, laptops, and desktops, built with [Denix](https://github.com/yunfachi/denix).

![](https://github.com/user-attachments/assets/fc5ab8bf-613e-496a-aec9-8418b5d06173)

## Features

- Only [Denix](https://github.com/yunfachi/denix) modules, hosts, and rices.
- [Home Manager](https://github.com/nix-community/home-manager) configuration instead of [NixOS](https://nixos.org/) where applicable.
- Options, [NixOS](https://nixos.org/) configuration, and [Home Manager](https://github.com/nix-community/home-manager) configuration can be written in a single file ([Denix](https://github.com/yunfachi/denix)).
- Multiple rices, switchable via `nixos-rebuild switch` and working across all hosts.
- Impermanence, Disko and ZFS on some hosts.
- Virtual private network between all hosts.
- Various infrastructures with all dependencies, including databases that can be enabled by a single option.
- All nix files from `./modules`, `./hosts`, and `./rices` are imported simultaneously.
- Declarative installation of one of the many base24 color schemes into most applications.

## Hosts

|                            | Dekomori                                    | Jakuzure                                      | Mitama                                        |
| -------------------------- | ------------------------------------------- | --------------------------------------------- | --------------------------------------------- |
| **Type**                   | Server                                      | Desktop                                       | Desktop                                       |
| **Default Rice**           | [Hito](./rices/hito/)                       | [Hito](./rices/hito/)                         | [Hito](./rices/hito/)                         |
| **Window Manager**         | -                                           | [Hyprland](./modules/programs/hyprland/)      | [Hyprland](./modules/programs/hyprland/)      |
| **Display Manager**        | -                                           | -                                             | -                                             |
| **Shell**                  | [Bash](./modules/programs/bash.nix)         | [Bash](./modules/programs/bash.nix)           | [Bash](./modules/programs/bash.nix)           |
| **Shell Promt**            | [Starship](./modules/programs/starship.nix) | [Starship](./modules/programs/starship.nix)   | [Starship](./modules/programs/starship.nix)   |
| **Input Method Framework** | -                                           | [Fcitx5](./modules/programs/fcitx5/)          | [Fcitx5](./modules/programs/fcitx5/)          |
| **Wallpaper Manager**      | -                                           | [Hyprpaper](./modules/services/hyprpaper.nix) | [Hyprpaper](./modules/services/hyprpaper.nix) |
| **File Manager**           | -                                           | [Nautilus](./modules/programs/nautilus.nix)   | [Nautilus](./modules/programs/nautilus.nix)   |
| **Media Player**           | -                                           | [Totem](./modules/programs/totem.nix)         | [Totem](./modules/programs/totem.nix)         |
| **Image Viewer**           | -                                           | [GThumb](./modules/programs/gthumb.nix)       | [GThumb](./modules/programs/gthumb.nix)       |

## Rices

|                      | Hito                                                                         | Marui | Yami                                                                         |
| -------------------- | ---------------------------------------------------------------------------- | ----- | ---------------------------------------------------------------------------- |
| **Inherits**         | Marui                                                                        | -     | Marui                                                                        |
| **Inheritance Only** | No                                                                           | Yes   | No                                                                           |
| **Color Scheme**     | [Coffee](./modules/config/colorschemes/schemes/coffee.nix)                   | -     | [Kanagawa Dragon](./modules/config/colorschemes/schemes/kanagawa-dragon.nix) |

