{
  delib,
  colorscheme,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.anki";

  options = delib.singleEnableOption host.guiFeatured;

  myconfig.ifEnabled.persist.user.directories = [
    ".local/share/Anki2"
  ];

  home.ifEnabled.programs.anki = {
    enable = true;
    theme = colorscheme.polarity;
    addons = with pkgs.ankiAddons; [
      (anki-connect.withConfig {
        config = {
          apiKey = null;
          apiLogPath = null;
          webBindAddress = "127.0.0.1";
          webBindPort = 8765;
          webCorsOriginList = [
            "http://localhost"
            "https://www.immersionkit.com"
            "https://nadeshiko.co"
          ];
          ignoreOriginList = [ ];
        };
      })
      (recolor.withConfig {
        config = {
          colors = {
            ACCENT_CARD = [
              "Card mode"
              "#60a5fa"
              "#93c5fd"
              "--accent-card"
            ];
            ACCENT_DANGER = [
              "Danger"
              "#ef4444"
              "#f87171"
              "--accent-danger"
            ];
            ACCENT_NOTE = [
              "Note mode"
              "#22c55e"
              "#4ade80"
              "--accent-note"
            ];
            BORDER = [
              "Border"
              "#c4c4c4"
              "#202020"
              "--border"
            ];
            BORDER_FOCUS = [
              "Border (focused input)"
              "#3b82f6"
              "#3b82f6"
              "--border-focus"
            ];
            BORDER_STRONG = [
              "Border (strong)"
              "#858585"
              "#020202"
              "--border-strong"
            ];
            BORDER_SUBTLE = [
              "Border (subtle)"
              "#e4e4e4"
              "#252525"
              "--border-subtle"
            ];
            BUTTON_BG = [
              "Button background"
              "white"
              "#363636"
              "--button-bg"
            ];
            BUTTON_DISABLED = [
              "Button background (disabled)"
              "#d6d6d680"
              "#45454580"
              "--button-disabled"
            ];
            BUTTON_HOVER = [
              "Button background (hover)"
              "#f4f4f4"
              "#313131"
              [
                "--button-gradient-start"
                "--button-gradient-end"
              ]
            ];
            BUTTON_HOVER_BORDER = [
              "Button border (hover)"
              "#999999"
              "#141414"
              "--button-hover-border"
            ];
            BUTTON_PRIMARY_BG = [
              "Button Primary Bg"
              "#60a5fa"
              "#2f67e1"
              "--button-primary-bg"
            ];
            BUTTON_PRIMARY_DISABLED = [
              "Button Primary Disabled"
              "#93c5fd"
              "#4484ed"
              "--button-primary-disabled"
            ];
            BUTTON_PRIMARY_GRADIENT_END = [
              "Button Primary Gradient End"
              "#2563eb"
              "#2544a8"
              "--button-primary-gradient-end"
            ];
            BUTTON_PRIMARY_GRADIENT_START = [
              "Button Primary Gradient Start"
              "#60a5fa"
              "#2f67e1"
              "--button-primary-gradient-start"
            ];
            CANVAS = [
              "Background"
              "#f5f5f5"
              "#2c2c2c"
              [
                "--canvas"
                "--bs-body-bg"
              ]
            ];
            CANVAS_CODE = [
              "Code editor background"
              "white"
              "#252525"
              "--canvas-code"
            ];
            CANVAS_ELEVATED = [
              "Background (elevated)"
              "white"
              "#363636"
              "--canvas-elevated"
            ];
            CANVAS_GLASS = [
              "Background (transparent text surface)"
              "##ffffff66"
              "##36363666"
              "--canvas-glass"
            ];
            CANVAS_INSET = [
              "Background (inset)"
              "#eeeeee"
              "#252525"
              "--canvas-inset"
            ];
            CANVAS_OVERLAY = [
              "Background (menu & tooltip)"
              "#fcfcfc"
              "#2c2c2c"
              "--canvas-overlay"
            ];
            FG = [
              "Text"
              "#020202"
              "#fcfcfc"
              [
                "--fg"
                "--bs-body-color"
              ]
            ];
            FG_DISABLED = [
              "Text (disabled)"
              "#858585"
              "#737373"
              "--fg-disabled"
            ];
            FG_FAINT = [
              "Text (faint)"
              "#afafaf"
              "#545454"
              "--fg-faint"
            ];
            FG_LINK = [
              "Text (link)"
              "#1d4ed8"
              "#bfdbfe"
              "--fg-link"
            ];
            FG_SUBTLE = [
              "Text (subtle)"
              "#737373"
              "#858585"
              "--fg-subtle"
            ];
            FLAG_1 = [
              "Flag 1"
              "#ef4444"
              "#f87171"
              "--flag-1"
            ];
            FLAG_2 = [
              "Flag 2"
              "#fb923c"
              "#fdba74"
              "--flag-2"
            ];
            FLAG_3 = [
              "Flag 3"
              "#4ade80"
              "#86efac"
              "--flag-3"
            ];
            FLAG_4 = [
              "Flag 4"
              "#3b82f6"
              "#60a5fa"
              "--flag-4"
            ];
            FLAG_5 = [
              "Flag 5"
              "#e879f9"
              "#f0abfc"
              "--flag-5"
            ];
            FLAG_6 = [
              "Flag 6"
              "#2dd4bf"
              "#5eead4"
              "--flag-6"
            ];
            FLAG_7 = [
              "Flag 7"
              "#a855f7"
              "#c084fc"
              "--flag-7"
            ];
            HIGHLIGHT_BG = [
              "Highlight background"
              "#2563eb80"
              "#93c5fd80"
              "--highlight-bg"
            ];
            HIGHLIGHT_FG = [
              "Highlight text"
              "black"
              "white"
              "--highlight-fg"
            ];
            SCROLLBAR_BG = [
              "Scrollbar background"
              "#d6d6d6"
              "#363636"
              "--scrollbar-bg"
            ];
            SCROLLBAR_BG_ACTIVE = [
              "Scrollbar background (active)"
              "#afafaf"
              "#636363"
              "--scrollbar-bg-active"
            ];
            SCROLLBAR_BG_HOVER = [
              "Scrollbar background (hover)"
              "#c4c4c4"
              "#454545"
              "--scrollbar-bg-hover"
            ];
            SELECTED_BG = [
              "Selected Bg"
              "#d6d6d680"
              "#93c5fd80"
              "--selected-bg"
            ];
            SELECTED_FG = [
              "Selected Fg"
              "black"
              "white"
              "--selected-fg"
            ];
            SHADOW = [
              "Shadow"
              "#c4c4c4"
              "#202020"
              "--shadow"
            ];
            SHADOW_FOCUS = [
              "Shadow (focused input)"
              "#6366f1"
              "#6366f1"
              "--shadow-focus"
            ];
            SHADOW_INSET = [
              "Shadow (inset)"
              "#454545"
              "#202020"
              "--shadow-inset"
            ];
            SHADOW_SUBTLE = [
              "Shadow (subtle)"
              "#737373"
              "#363636"
              "--shadow-subtle"
            ];
            STATE_BURIED = [
              "Buried"
              "#f59e0b"
              "#92400e"
              "--state-buried"
            ];
            STATE_LEARN = [
              "Learn"
              "#dc2626"
              "#f87171"
              "--state-learn"
            ];
            STATE_MARKED = [
              "Marked"
              "#c7d2fe"
              "#a855f7"
              "--state-marked"
            ];
            STATE_NEW = [
              "New"
              "#3b82f6"
              "#93c5fd"
              "--state-new"
            ];
            STATE_REVIEW = [
              "Review"
              "#16a34a"
              "#22c55e"
              "--state-review"
            ];
            STATE_SUSPENDED = [
              "Suspended"
              "#facc15"
              "#fef9c3"
              "--state-suspended"
            ];
          };
          version = {
            major = 3;
            minor = 1;
          };
        };
      })
    ];
  };
}
