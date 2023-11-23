# Project tree
* [home](./home)
  * [core](./home/core.nix) - core, used in server and desktop
  * [server](./home/server) - server for my user
  * [desktop](./home/desktop) - desktop for my user
    * [xmonad](./home/desktop/xmonad) - xmonad configuration
    * [eww](./home/desktop/eww) - eww configuration
    * [tools](./home/desktop/tools) - programs such as kitty or firefox
    * [gaming](./home/desktop/tools) - steam, minecraft, genshin impact and other games
    * [editors](./home/desktop/editors) - text editors, IDEs
      * [idea](./home/desktop/editors/idea) - intellij idea
      * [vscodium](./home/desktop/editors/vscodium) - vscodium with configuration and extensions
* [hosts](./hosts)
  * [dekomori](./hosts/dekomori) - my main computer
  * [mitama](./hosts/mitama) - my server
* [modules](./modules)
  * [core.nix](./modules/core.nix) - core module, used in server and desktop
  * [server.nix](./modules/server.nix) - server module
  * [desktop.nix](./modules/desktop.nix) - desktop module
  * [user.nix](./modules/user.nix) - my user settings
  * [xmonad.nix](./modules/xmonad.nix) - xmonad installation
* [flake.nix](./flake.nix) - my flake