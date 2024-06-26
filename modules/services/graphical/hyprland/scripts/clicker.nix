{
  module-functions,
  hm,
  pkgs,
  ...
}:
module-functions.module "services" "hyprland" {
  hm.xdg.configFile."hypr/scripts/clicker.sh" = {
    executable = true;
    text = ''
      state=$(<~/.clicker.data)
      current=$1

      if [[ "''${state}" == "''${current} true" ]] ; then
        state="''${current} false";
      else
        state="''${current} true"
      fi
      echo "''${state}" > ~/.clicker.data

      if [[ "''${state}" == "''${current} true" ]] ; then
        if [[ $current == 1 ]]; then
          delay_range_start=40
          delay_range_end=80
        elif [[ $current == 3 ]]; then
          delay_range_start=28
          delay_range_end=39
        else
          printf "Invalid button specified!"
          exit 1
        fi

        while true; do
          delay=$((RANDOM % ($delay_range_end - $delay_range_start + 1) + $delay_range_start))
          ${pkgs.xdotool}/bin/xdotool click --repeat 4 --delay ''${delay} ''${current}
          state=$(<~/.clicker.data)
          if [[ "''${state}" != "''${current} true" ]] ; then
            break
          fi
        done
      fi
    '';
  };
}
