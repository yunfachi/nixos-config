# https://github.com/levnikmyskin/hyprland-virtual-desktops
{ pkgs, ... }:
let
  xdg_desktop_portals = [
    pkgs.xdg-desktop-portal-hyprland
    pkgs.xdg-desktop-portal-gtk
  ];
  xdg_desktop_portal_dir = pkgs.symlinkJoin {
    name = "xdg-portals";
    paths = xdg_desktop_portals;
  };
in
{
  os.environment.systemPackages = [ pkgs.hyprland ];

  os.xdg.portal = {
    enable = true;
    extraPortals = xdg_desktop_portals;
    config.common.default = [ "hyprland,gtk" ];
  };

  hm.wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      cursor.no_warps = true;
      env = [
        "XCURSOR_SIZE,24"

        "QT_QPA_PLATFORM,wayland"
        "XDG_CURRENT_DESKTOP,sway"
        "XDG_SESSION_DESKTOP,sway"
        "QT_QPA_PLATFORM_PLUGIN_PATH,${pkgs.qt5.qtbase.bin}/lib/qt-${pkgs.qt5.qtbase.version}/plugins/platforms"
        "XDG_DESKTOP_PORTAL_DIR,${xdg_desktop_portal_dir}/share/xdg-desktop-portal/portals"
      ];
    };
  };

  settings = {
    commands.screenshot = {
      region = ''${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" - | ${pkgs.swappy}/bin/swappy -f -'';
      full = ''${pkgs.grim}/bin/grim - | ${pkgs.swappy}/bin/swappy -f -'';
    };
  };
}
