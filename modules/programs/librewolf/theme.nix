{
  delib,
  colorscheme,
  pkgs,
  lib,
  ...
}:
delib.module {
  name = "programs.librewolf";

  myconfig.ifEnabled.programs.librewolf = {
    settings."xpinstall.signatures.required" = 0;
    extensions =
      let
        addonId = "{93e99bda-4ca9-45ea-9c35-ffdd53ff4d5d}";
      in
      lib.singleton (
        pkgs.stdenv.mkDerivation {
          name = "custom-yunfachi-colorscheme.xpi";

          inherit addonId;
          meta.mozPermissions = [ ];

          src = pkgs.writeTextDir "custom-yunfachi-colorscheme/manifest.json" ''
            {
              "manifest_version": 2,
              "version": "1.0.0",
              "name": "custom yunfachi's colorscheme",
              "browser_specific_settings": {
                "gecko": {
                  "id": "${addonId}",
                  "strict_min_version": "50.0"
                },
                "gecko_android": {
                  "id": "${addonId}",
                  "strict_min_version": "54.0"
                }
              },
              "theme": {
                "images": {},
                "properties": {},
                "colors": {
                  "frame": "${colorscheme.base00.hex}",
                  "button_background_active": "${colorscheme.base02.hex}",
                  "button_background_hover": "${colorscheme.base01.hex}",
                  "icons": "${colorscheme.base05.hex}",
                  "icons_attention": "${colorscheme.base0D.hex}",
                  "ntp_background": "${colorscheme.base00.hex}",
                  "ntp_text": "${colorscheme.base05.hex}",
                  "tab_line": "${colorscheme.base0D.hex}",
                  "tab_loading": "${colorscheme.base0D.hex}",
                  "tab_selected": "${colorscheme.base00.hex}",
                  "tab_text": "${colorscheme.base05.hex}",
                  "tab_background_text": "${colorscheme.base05.hex}",
                  "toolbar": "${colorscheme.base00.hex}",
                  "popup": "${colorscheme.base00.hex}",
                  "popup_text": "${colorscheme.base05.hex}",
                  "popup_border": "${colorscheme.base00.hex}",
                  "popup_highlight": "${colorscheme.base02.hex}",
                  "popup_highlight_text": "${colorscheme.base06.hex}",
                  "tab_background_separator": "${colorscheme.base04.hex}",
                  "toolbar_bottom_separator": "${colorscheme.base01.hex}",
                  "toolbar_field": "${colorscheme.base01.hex}",
                  "toolbar_field_focus": "${colorscheme.base02.hex}",
                  "toolbar_field_text_focus": "${colorscheme.base06.hex}",
                  "toolbar_field_border": "${colorscheme.base00.hex}",
                  "toolbar_field_border_focus": "${colorscheme.base0D.hex}",
                  "toolbar_field_separator": "${colorscheme.base04.hex}",
                  "toolbar_field_text": "${colorscheme.base06.hex}",
                  "bookmark_text": "${colorscheme.base05.hex}",
                  "toolbar_top_separator": "${colorscheme.base01.hex}",
                  "toolbar_vertical_separator": "${colorscheme.base01.hex}"
                }
              }
            }
          '';

          buildInputs = with pkgs; [ zip ];

          installPhase = ''
            mkdir -p $out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}

            zip -r -j $out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}/${addonId}.xpi $src
          '';
        }
      );
  };
}
