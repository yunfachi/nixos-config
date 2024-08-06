{ pkgs, ... }:
{
  os.environment.systemPackages = [ pkgs.pulseaudio ];
  os.services.pipewire = {
    enable = true;
    pulse.enable = true;
    jack.enable = true;
    alsa.enable = true;
  };

  settings.keymaps = [
    {
      key = "XF86AudioLowerVolume";
      command = "${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%";
    }
    {
      key = "XF86AudioRaiseVolume";
      command = "${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%";
    }
    {
      key = "XF86AudioMute";
      command = "${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";
    }
    {
      key = "XF86AudioMicMute";
      command = "${pkgs.pulseaudio}/bin/pactl set-source-mute @DEFAULT_SOURCE@ toggle";
    }
  ];
}
