{
  delib,
  spicetifyPkgs,
  colorscheme,
  ...
}:
delib.module {
  name = "programs.spicetify";

  home.ifEnabled.programs.spicetify = {
    theme = spicetifyPkgs.themes.text;
    colorScheme = "custom";
    customColorScheme = with colorscheme; {
      accent = base0B.value;
      accent-active = base0B.value;
      accent-inactive = base00.value;
      banner = base0B.value;
      border-active = base0B.value;
      border-inactive = base03.value;
      header = base04.value;
      highlight = base04.value;
      main = base00.value;
      notification = base0D.value;
      notification-error = base08.value;
      subtext = base06.value;
      text = base05.value;
    };

    enabledSnippets = with spicetifyPkgs.snippets; [
      hideFriendActivityButton
      hideFullScreenButton
      roundedImages
      ".Root__top-container:has([class*='yourLibraryX']) { padding-top: 16px; }"
      "button.encore-text-body-medium-bold.encore-over-media-set > figure > div > img { border-radius: 50% !important; }"
      ".player-controls__buttons,.main-nowPlayingBar-extraControls { opacity: .4; }"
    ];
  };
}
