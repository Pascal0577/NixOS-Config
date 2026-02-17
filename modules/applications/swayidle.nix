{ pkgs, username, config, lib, ... }:
let
    dim-screen = pkgs.writeShellApplication {
        name = "dim-screen";
        runtimeInputs = [ pkgs.brightnessctl pkgs.bc pkgs.coreutils ];
        text = builtins.readFile ../../assets/dim-screen-smooth.sh;
    };
in
{
    options.mySystem.applications.swayidle.enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to enable my swayidle module";
    };

    config = lib.mkIf config.mySystem.applications.swayidle.enable {
        # https://github.com/NixOS/nixpkgs/pull/297434#issuecomment-2348783988
        systemd.services.display-manager.environment.XDG_CURRENT_DESKTOP = "X-NIXOS-SYSTEMD-AWARE";

        home-manager.users.${username} = {
            services.swayidle = {
                enable = true;
                timeouts = [
                    {
                        timeout = 120;
                        command = "${dim-screen}/bin/dim-screen set 30%";
                        resumeCommand = "${pkgs.brightnessctl}/bin/brightnessctl -r";
                    }
                    {
                        timeout = 240;
                        command = "${dim-screen}/bin/dim-screen --no-save set 1%";
                    }
                    {
                        timeout = 300;
                        command = "${pkgs.systemd}/bin/systemctl suspend";
                    }
                ];
            };
        };
    };
}
