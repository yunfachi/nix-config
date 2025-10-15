{
  delib,
  host,
  pkgs,
  homeconfig,
  colorscheme,
  ...
}:
delib.module {
  name = "programs.rofi";

  options = delib.singleEnableOption host.guiFeatured;

  home.ifEnabled = {
    programs.rofi =
      let
        inherit (homeconfig.lib.formats.rasi) mkLiteral;
      in
      {
        enable = true;
        plugins = with pkgs; [
          rofi-calc
        ];
        modes = [
          "drun"
          "calc"
        ];
        extraConfig = {
          modi = "drun,calc";
          show-icons = true;
          display-drun = "󱭼";
          display-calc = "󰃬";
          drun-display-format = "{name}";
        };
        theme = {
          "*" = {
            background = mkLiteral "${colorscheme.base00.hex}FF";
            background-alt = mkLiteral "${colorscheme.base01.hex}FF";
            foreground = mkLiteral "${colorscheme.base05.hex}FF";
            selected = mkLiteral "${colorscheme.base0B.hex}FF";
            active = mkLiteral "${colorscheme.base0B.hex}FF";
            urgent = mkLiteral "${colorscheme.base08.hex}FF";

            font = "Noto Sans CJK JP 15px";

            border-colour = mkLiteral "var(selected)";
            handle-colour = mkLiteral "var(selected)";
            background-colour = mkLiteral "var(background)";
            foreground-colour = mkLiteral "var(foreground)";
            alternate-background = mkLiteral "var(background-alt)";
            normal-background = mkLiteral "var(background)";
            normal-foreground = mkLiteral "var(foreground)";
            urgent-background = mkLiteral "var(urgent)";
            urgent-foreground = mkLiteral "var(background)";
            active-background = mkLiteral "var(active)";
            active-foreground = mkLiteral "var(background)";
            selected-normal-background = mkLiteral "var(selected)";
            selected-normal-foreground = mkLiteral "var(background)";
            selected-urgent-background = mkLiteral "var(active)";
            selected-urgent-foreground = mkLiteral "var(background)";
            selected-active-background = mkLiteral "var(urgent)";
            selected-active-foreground = mkLiteral "var(background)";
            alternate-normal-background = mkLiteral "var(background)";
            alternate-normal-foreground = mkLiteral "var(foreground)";
            alternate-urgent-background = mkLiteral "var(urgent)";
            alternate-urgent-foreground = mkLiteral "var(background)";
            alternate-active-background = mkLiteral "var(active)";
            alternate-active-foreground = mkLiteral "var(background)";
          };

          window = {
            # properties for window widget
            transparency = "real";
            location = mkLiteral "center";
            anchor = mkLiteral "center";
            fullscreen = mkLiteral "false";
            width = mkLiteral "600px";
            x-offset = mkLiteral "0px";
            y-offset = mkLiteral "0px";

            # properties for all widgets
            enabled = mkLiteral "true";
            margin = mkLiteral "0px";
            padding = mkLiteral "0px";
            border = mkLiteral "1.5px solid";
            border-radius = mkLiteral "10px";
            border-color = mkLiteral "@border-colour";
            cursor = "default";
            # Backgroud Colors
            background-color = mkLiteral "@background-colour";
            # Backgroud Image
            #background-image = mkLiteral "url(\"/path/to/image.png\", none)";
            # Simple Linear Gradient
            #background-image = mkLiteral "linear-gradient(red, orange, pink, purple)";
            # Directional Linear Gradient
            #background-image = mkLiteral "linear-gradient(to bottom, pink, yellow, magenta)";
            # Angle Linear Gradient
            #background-image = mkLiteral "linear-gradient(45, cyan, purple, indigo)";
          };

          mainbox = {
            enabled = mkLiteral "true";
            spacing = mkLiteral "10px";
            margin = mkLiteral "0px";
            padding = mkLiteral "10px";
            border = mkLiteral "0px solid";
            border-radius = mkLiteral "0px 0px 0px 0px";
            border-color = mkLiteral "@border-colour";
            background-color = mkLiteral "transparent";
            children = [
              "inputbar"
              "message"
              "listview"
            ];
          };

          inputbar = {
            enabled = mkLiteral "true";
            spacing = mkLiteral "0px";
            margin = mkLiteral "0px";
            padding = mkLiteral "0px";
            border = mkLiteral "0px solid";
            border-radius = mkLiteral "0px";
            border-color = mkLiteral "@border-colour";
            background-color = mkLiteral "inherit";
            text-color = mkLiteral "@foreground-colour";
            children = [
              "textbox-prompt-colon"
              "entry"
              "mode-switcher"
            ];
          };

          prompt = {
            enabled = mkLiteral "true";
            background-color = mkLiteral "inherit";
            text-color = mkLiteral "inherit";
          };
          textbox-prompt-colon = {
            enabled = mkLiteral "true";
            padding = mkLiteral "6px 4px 0px 6px";
            expand = mkLiteral "false";
            border-radius = mkLiteral "10px 0px 0px 10px";
            str = "󰍉";
            font = "Material Design Icons 20px";
            background-color = mkLiteral "var(alternate-background)";
            text-color = mkLiteral "inherit";
          };
          entry = {
            enabled = mkLiteral "true";
            padding = mkLiteral "3px 10px 6px 0px";
            background-color = mkLiteral "var(alternate-background)";
            border-radius = mkLiteral "0px 10px 10px 0px";
            text-color = mkLiteral "inherit";
            cursor = mkLiteral "text";
            placeholder = "Search...";
            placeholder-color = mkLiteral "inherit";
          };
          num-filtered-rows = {
            enabled = mkLiteral "true";
            expand = mkLiteral "false";
            background-color = mkLiteral "inherit";
            text-color = mkLiteral "inherit";
          };
          textbox-num-sep = {
            enabled = mkLiteral "true";
            expand = mkLiteral "false";
            str = "/";
            background-color = mkLiteral "inherit";
            text-color = mkLiteral "inherit";
          };
          num-rows = {
            enabled = mkLiteral "true";
            expand = mkLiteral "false";
            background-color = mkLiteral "inherit";
            text-color = mkLiteral "inherit";
          };
          case-indicator = {
            enabled = mkLiteral "true";
            background-color = mkLiteral "inherit";
            text-color = mkLiteral "inherit";
          };

          listview = {
            enabled = mkLiteral "true";
            columns = mkLiteral "1";
            lines = mkLiteral "8";
            cycle = mkLiteral "true";
            dynamic = mkLiteral "true";
            scrollbar = mkLiteral "true";
            layout = mkLiteral "vertical";
            reverse = mkLiteral "false";
            fixed-height = mkLiteral "true";
            fixed-columns = mkLiteral "true";

            spacing = mkLiteral "7.5px";
            margin = mkLiteral "0px";
            padding = mkLiteral "0px";
            border = mkLiteral "0px solid";
            border-radius = mkLiteral "0px";
            border-color = mkLiteral "@border-colour";
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "@foreground-colour";
            cursor = "default";
          };
          scrollbar = {
            handle-width = mkLiteral "5px";
            handle-color = mkLiteral "@handle-colour";
            border-radius = mkLiteral "2px";
            background-color = mkLiteral "@alternate-background";
          };

          element = {
            enabled = mkLiteral "true";
            spacing = mkLiteral "10px";
            margin = mkLiteral "0px";
            padding = mkLiteral "5px 10px";
            border = mkLiteral "0px solid";
            border-radius = mkLiteral "10px";
            border-color = mkLiteral "@border-colour";
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "@foreground-colour";
            cursor = mkLiteral "pointer";
          };
          "element normal.normal" = {
            background-color = mkLiteral "var(alternate-background)";
            text-color = mkLiteral "var(normal-foreground)";
          };
          "element normal.urgent" = {
            background-color = mkLiteral "var(urgent-background)";
            text-color = mkLiteral "var(urgent-foreground)";
          };
          "element normal.active" = {
            background-color = mkLiteral "var(active-background)";
            text-color = mkLiteral "var(active-foreground)";
          };
          "element selected.normal" = {
            background-color = mkLiteral "var(selected-normal-background)";
            text-color = mkLiteral "var(selected-normal-foreground)";
          };
          "element selected.urgent" = {
            background-color = mkLiteral "var(selected-urgent-background)";
            text-color = mkLiteral "var(selected-urgent-foreground)";
          };
          "element selected.active" = {
            background-color = mkLiteral "var(selected-active-background)";
            text-color = mkLiteral "var(selected-active-foreground)";
          };
          "element alternate.normal" = {
            background-color = mkLiteral "var(alternate-background)";
            text-color = mkLiteral "var(alternate-normal-foreground)";
          };
          "element alternate.urgent" = {
            background-color = mkLiteral "var(alternate-urgent-background)";
            text-color = mkLiteral "var(alternate-urgent-foreground)";
          };
          "element alternate.active" = {
            background-color = mkLiteral "var(alternate-active-background)";
            text-color = mkLiteral "var(alternate-active-foreground)";
          };
          element-icon = {
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "inherit";
            size = mkLiteral "24px";
            cursor = mkLiteral "inherit";
          };
          element-text = {
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "inherit";
            highlight = mkLiteral "inherit";
            cursor = mkLiteral "inherit";
            vertical-align = mkLiteral "0.5";
            horizontal-align = mkLiteral "0.0";
          };

          mode-switcher = {
            enabled = mkLiteral "true";
            spacing = mkLiteral "10px";
            margin = mkLiteral "0px 0px 0px 10px";
            padding = mkLiteral "0px";
            border = mkLiteral "0px solid";
            border-radius = mkLiteral "0px";
            border-color = mkLiteral "@border-colour";
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "@foreground-colour";
          };
          button = {
            font = "Material Design Icons 20px";
            padding = mkLiteral "2px 7px";
            border = mkLiteral "0px solid";
            border-radius = mkLiteral "10px";
            border-color = mkLiteral "@border-colour";
            background-color = mkLiteral "@alternate-background";
            text-color = mkLiteral "inherit";
            cursor = mkLiteral "pointer";
          };
          "button selected" = {
            background-color = mkLiteral "var(selected-normal-background)";
            text-color = mkLiteral "var(selected-normal-foreground)";
          };

          message = {
            enabled = mkLiteral "true";
            margin = mkLiteral "0px";
            padding = mkLiteral "0px";
            border = mkLiteral "0px solid";
            border-radius = mkLiteral "0px 0px 0px 0px";
            border-color = mkLiteral "@border-colour";
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "@foreground-colour";
          };
          textbox = {
            padding = mkLiteral "8px 10px";
            border = mkLiteral "0px solid";
            border-radius = mkLiteral "10px";
            border-color = mkLiteral "@border-colour";
            background-color = mkLiteral "@alternate-background";
            text-color = mkLiteral "@foreground-colour";
            vertical-align = mkLiteral "0.5";
            horizontal-align = mkLiteral "0.0";
            highlight = mkLiteral "none";
            placeholder-color = mkLiteral "@foreground-colour";
            blink = mkLiteral "true";
            markup = mkLiteral "true";
          };
          error-message = {
            padding = mkLiteral "10px";
            border = mkLiteral "2px solid";
            border-radius = mkLiteral "10px";
            border-color = mkLiteral "@border-colour";
            background-color = mkLiteral "@background-colour";
            text-color = mkLiteral "@foreground-colour";
          };
        };
      };
  };
}
