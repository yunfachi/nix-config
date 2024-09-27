{
  delib,
  colorscheme,
  ...
}:
delib.module {
  name = "programs.fcitx5";

  home.ifEnabled.home.file = {
    ".local/share/fcitx5/themes/nix-colorscheme/arrow.png".source = ./arrow.png;
    ".local/share/fcitx5/themes/nix-colorscheme/radio.png".source = ./radio.png;
    ".local/share/fcitx5/themes/nix-colorscheme/theme.conf".text = ''
      [Metadata]
      Name=Nix Colorscheme
      Version=1.0
      Author=yunfachi
      Description=Nix Generated Color Theme
      ScaleWithDPI=True

      [InputPanel]
      Font=Sans 13
      NormalColor=${colorscheme.base05.hex}
      HighlightCandidateColor=${colorscheme.base14.hex}
      HighlightColor=${colorscheme.base14.hex}
      HighlightBackgroundColor=${colorscheme.base01.hex}

      Spacing=3

      [InputPanel/TextMargin]
      Left=10
      Right=10
      Top=6
      Bottom=6

      [InputPanel/Background]
      Color=${colorscheme.base01.hex}
      BorderColor=${colorscheme.base01.hex}
      BorderWidth=2

      [InputPanel/Background/Margin]
      Left=2
      Right=2
      Top=2
      Bottom=2

      [InputPanel/Highlight]
      Color=${colorscheme.base01.hex}

      [InputPanel/Highlight/Margin]
      Left=10
      Right=10
      Top=7
      Bottom=7

      [Menu]
      Font=Sans 10
      NormalColor=${colorscheme.base05.hex}
      Spacing=3

      [Menu/Background]
      Color=${colorscheme.base01.hex}

      [Menu/Background/Margin]
      Left=2
      Right=2
      Top=2
      Bottom=2

      [Menu/ContentMargin]
      Left=2
      Right=2
      Top=2
      Bottom=2

      [Menu/Highlight]
      Color=${colorscheme.base05.hex}

      [Menu/Highlight/Margin]
      Left=10
      Right=10
      Top=5
      Bottom=5

      [Menu/Separator]
      Color=${colorscheme.base02.hex}

      [Menu/CheckBox]
      Image=radio.png

      [Menu/SubMenu]
      Image=arrow.png

      [Menu/TextMargin]
      Left=5
      Right=5
      Top=5
      Bottom=5
    '';
  };
}
