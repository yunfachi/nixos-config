{ inputs, pkgs, ... }:
let
  agsPackage = inputs.ags.packages.${pkgs.system}.default;
  mvts = [
    {
      left = "left";
      right = "right";
      up = "up";
      down = "down";
    }
    {
      left = "H";
      right = "L";
      up = "K";
      down = "J";
    }
  ];
in {
  hm.wayland.windowManager.hyprland.settings = {
    bind = [
      "$mod SHIFT, R, exec, hyprctl reload"
      # "$mod, M, exit,"
      "$mod, D, exec, $menu"
      # "$mod SHIFT, D, exec, ags -r \"globalThis.confirmSubject.setValue('shutdown')\""
      ''
        $mod SHIFT, D, exec, ${agsPackage}/bin/ags -r "globalThis.confirmSubject.setValue('shutdown')"''
      # "$mod SHIFT, S, exec, grim -g \"$(slurp)\" - | swappy -f -"
      # "ALT, tab, hycov:toggleoverview"
      # "ALT, grave, hycov:toggleoverview, forceall"
      ''
        $mod SHIFT, S, exec, ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" - | ${pkgs.swappy}/bin/swappy -f -''
      # "$mod CONTROL, V, exec, firefox"
      # "$mod CONTROL, C, exec, $terminal nvim"
      # "$mod CONTROL, D, exec, vesktop"
      "$mod CONTROL, V, exec, ${pkgs.firefox}/bin/firefox"
      # "$mod CONTROL, C, exec, $terminal ${pkgs.neovim}/bin/nvim"
      "$mod CONTROL, C, exec, ${pkgs.neovide}/bin/neovide"
      "$mod CONTROL, D, exec, ${pkgs.vesktop}/bin/vesktop"

      "$mod, Return, exec, $terminal"
      "$mod, B, hy3:makegroup, v"
      "$mod, N, hy3:makegroup, h"
      "$mod, E, hy3:changegroup, opposite"
      # "$mod, W, togglegroup"
      "$mod, W, hy3:changegroup, toggletab"
      "$mod SHIFT, W, hy3:makegroup, tab"
      "$mod, A, hy3:changefocus, raise"
      "$mod, F, fullscreen,"
      "$mod SHIFT, F, togglefloating,"
      "$mod, minus, pin"
      "$mod, mouse_down, workspace, e+1"
      "$mod, mouse_up, workspace, e-1"
    ] ++ (builtins.concatLists (builtins.genList (x:
      let ws = builtins.toString (x + 1);
      in [
        "$mod, ${ws}, workspace, ${ws}"
        "$mod SHIFT, ${ws}, movetoworkspacesilent, ${ws}"
      ]) 9));
    binde = [
      "$mod SHIFT, Q, killactive,"
      "$mod, comma, workspace, e-1"
      "$mod, period, workspace, e+1"
    ] ++ (builtins.concatLists (builtins.map (x: [
      "$mod CONTROL, ${x.left}, resizeactive, -10 0"
      "$mod CONTROL, ${x.right}, resizeactive, 10 0"
      "$mod CONTROL, ${x.up}, resizeactive, 0 -10"
      "$mod CONTROL, ${x.down}, resizeactive, 0 10"
      # "$mod, ${x.left}, movefocus, l"
      # "$mod, ${x.right}, movefocus, r"
      # "$mod, ${x.up}, movefocus, u"
      # "$mod, ${x.down}, movefocus, d"
      # "$mod SHIFT, ${x.left}, movewindoworgroup, l"
      # "$mod SHIFT, ${x.right}, movewindoworgroup, r"
      # "$mod SHIFT, ${x.up}, movewindoworgroup, u"
      # "$mod SHIFT, ${x.down}, movewindoworgroup, d"
      "$mod, ${x.left}, hy3:movefocus, l"
      "$mod, ${x.right}, hy3:movefocus, r"
      "$mod, ${x.up}, hy3:movefocus, u"
      "$mod, ${x.down}, hy3:movefocus, d"
      "$mod SHIFT, ${x.left}, hy3:movewindow, l"
      "$mod SHIFT, ${x.right}, hy3:movewindow, r"
      "$mod SHIFT, ${x.up}, hy3:movewindow, u"
      "$mod SHIFT, ${x.down}, hy3:movewindow, d"
    ]) mvts));
    bindel = [
      ", XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise"
      ", XF86AudioLowerVolume, exec, swayosd-client --output-volume lower"
      ", XF86AudioMute, exec, swayosd-client --output-volume mute-toggle"
      ", XF86AudioMicMute, exec, swayosd-client --input-volume mute-toggle"
      ", XF86MonBrightnessUp, exec, swayosd-client --brightness raise"
      ", XF86MonBrightnessDown, exec, swayosd-client --brightness lower"
    ];
    bindi = [
      ''
        , Caps_Lock, exec, ags -r "globalThis.isCapsLock.value = !globalThis.isCapsLock.value"''
      ''
        , Num_Lock, exec, ags -r "globalThis.isNumLock.value = !globalThis.isNumLock.value"''
    ];
    bindm = [ "$mod, mouse:272, movewindow" "$mod, mouse:273, resizewindow" ];
    bindn = [ ", mouse:272, hy3:focustab, mouse" ];
  };
}
