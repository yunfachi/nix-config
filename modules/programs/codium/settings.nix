{delib, ...}:
delib.module {
  name = "programs.codium";

  home.ifEnabled = {
    programs.vscode.userSettings = let
      icon = "https://user-images.githubusercontent.com/36299870/105232957-165bc380-5b61-11eb-8da4-37870387857f.png";
      work = "{git_owner}/{workspace} - {file_name}{file_extension}";
      idle = "idle ( ´ ▿ ` )";
    in {
      "breadcrumbs.enabled" = false;
      "editor.fontFamily" = "'Droid Sans Mono', 'monospace'";
      "editor.minimap.enabled" = false;
      "editor.stickyScroll.enabled" = true;
      "explorer.compactFolders" = false;
      "explorer.decorations.badges" = false;
      "vscord.app.id" = "1152314975466029187";
      "vscord.app.name" = "Custom";
      "vscord.ignore.workspacesText" = "";
      "vscord.status.buttons.button1.git.active.label" = "Github Repository";
      "vscord.status.buttons.button1.git.idle.label" = "Github Repository";
      "vscord.status.buttons.button1.git.inactive.label" = "Github Repository";
      "vscord.status.details.text.debugging" = work;
      "vscord.status.details.text.editing" = work;
      "vscord.status.details.text.idle" = idle;
      "vscord.status.details.text.notInFile" = idle;
      "vscord.status.details.text.noWorkSpaceText" = idle;
      "vscord.status.details.text.viewing" = work;
      "vscord.status.image.large.debugging.key" = icon;
      "vscord.status.image.large.debugging.text" = "";
      "vscord.status.image.large.editing.key" = icon;
      "vscord.status.image.large.editing.text" = "";
      "vscord.status.image.large.idle.key" = icon;
      "vscord.status.image.large.idle.text" = "";
      "vscord.status.image.large.notInFile.key" = icon;
      "vscord.status.image.large.viewing.key" = icon;
      "vscord.status.image.large.viewing.text" = "";
      "vscord.status.image.small.debugging.key" = "";
      "vscord.status.image.small.debugging.text" = "";
      "vscord.status.image.small.editing.key" = "";
      "vscord.status.image.small.editing.text" = "";
      "vscord.status.image.small.idle.key" = "";
      "vscord.status.image.small.idle.text" = "";
      "vscord.status.image.small.notInFile.key" = "";
      "vscord.status.image.small.notInFile.text" = "";
      "vscord.status.image.small.viewing.key" = "";
      "vscord.status.image.small.viewing.text" = "";
      "vscord.status.problems.text" = "";
      "vscord.status.state.text.debugging" = "";
      "vscord.status.state.text.editing" = "";
      "vscord.status.state.text.noWorkspaceFound" = "";
      "vscord.status.state.text.viewing" = "";
      "window.commandCenter" = false;
      "window.titleBarStyle" = "custom";
      "workbench.activityBar.location" = "hidden";
      "workbench.colorTheme" = "nypkgs-base24";
      "workbench.editor.decorations.badges" = false;
      "workbench.editor.decorations.colors" = false;
      "workbench.iconTheme" = "bearded-icons";
      "workbench.layoutControl.enabled" = false;
    };
  };
}
