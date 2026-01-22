{ pkgs, username, ... }:
let
    dim-screen = pkgs.writeShellApplication {
        name = "dim-screen";
        runtimeInputs = [ pkgs.brightnessctl pkgs.bc pkgs.coreutils ];
        text = builtins.readFile ../../assets/dim-screen-smooth.sh;
    };
in
{
    home-manager.users.${username} = {
        services.swayidle = {
            enable = true;
            timeouts = [
                {
                    timeout = 300;
                    command = "${dim-screen}/bin/dim-screen set 30%";
                    resumeCommand = "${pkgs.brightnessctl}/bin/brightnessctl -r";
                }
                {
                    timeout = 540;
                    command = "${dim-screen}/bin/dim-screen --no-save set 1%";
                }
                {
                    timeout = 600;
                    command = "${pkgs.systemd}/bin/systemctl suspend";
                }
            ];
        };
    };
}
