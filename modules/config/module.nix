{ lib, ... }:
with lib;
{
  options = {
    settings = {
      commands =
        let
          mkCommandOption =
            name:
            mkOption {
              type = with types; nullOr str;
              default = null;
              description = "${name} command";
            };
        in
        {
          screenshot = mkCommandOption "Screenshot";
          shutdownConfirm = mkCommandOption "Shutdown";
          applauncher = mkCommandOption "Applauncher";
          terminal = mkCommandOption "Terminal";
          browser = mkCommandOption "Browser";
          editor = mkCommandOption "Editor";
        };
      keymaps = mkOption {
        type =
          with types;
          listOf (
            nullOr (submodule {
              options = {
                super = mkOption {
                  type = bool;
                  description = "Super";
                  default = false;
                };
                alt = mkOption {
                  type = bool;
                  description = "Alt";
                  default = false;
                };
                control = mkOption {
                  type = bool;
                  description = "Control";
                  default = false;
                };
                shift = mkOption {
                  type = bool;
                  description = "Shift";
                  default = false;
                };
                lockscreen = mkOption {
                  type = bool;
                  description = "Lockscreen";
                  default = false;
                };
                key = mkOption {
                  type = str;
                  description = "Key";
                };
                command = mkOption {
                  type = str;
                  description = "Command";
                };
              };
            })
          );
        default = [ ];
        description = "Keymaps";
      };
      touchmaps = mkOption {
        type =
          with types;
          listOf (
            nullOr (submodule {
              options = {
                fingers = mkOption {
                  type = with types; int;
                  description = "Number of fingers";
                };
                direction = mkOption {
                  type =
                    with types;
                    enum [
                      "up"
                      "down"
                      "left"
                      "right"
                    ];
                  description = "Direction";
                };
                command = mkOption {
                  type = with types; str;
                  description = "Command";
                };
              };
            })
          );
        default = [ ];
        description = "Touchmaps";
      };
      autostart = mkOption {
        type =
          with types;
          listOf (
            either str (submodule {
              options = {
                command = mkOption {
                  type = with types; str;
                  description = "Command";
                };
                allowReload = mkOption {
                  type = with types; bool;
                  description = "Allow reload";
                  default = false;
                };
              };
            })
          );
        default = [ ];
        description = "Autostart";
      };

      windows = {
        noBar = mkOption {
          type = with types; listOf str;
          default = [ ];
          description = "Windows without bar";
        };
      };
    };
  };
}
