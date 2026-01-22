{ pkgs, username, ... }:
let
    dim-screen = pkgs.stdenv.mkDerivation {
        name = "dim-screen";
        src = ../../assets/dim-screen-smooth.sh;
        
        installPhase = ''
            mkdir -p $out/bin
            cp ${../../assets/dim-screen-smooth.sh} $out/bin/dim-screen
            chmod +x $out/bin/dim-screen
        '';
    };
in
{
    home-manager.users.${username} = {
        services.swayidle = {
            enable = true;
            timeouts = [
                {
                    timeout = 600;
                    command = "${pkgs.systemd}/bin/systemctl suspend";
                }
                {
                    timeout = 300;
                    command = "${dim-screen}/bin/dim-screen set 30%";
                }
            ];
        };
    };
}
