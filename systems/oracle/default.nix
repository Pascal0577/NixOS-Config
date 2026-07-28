{ lib, inputs, ... }:

{
    mySystem = {
        ZFS.enable = true;
        impermanence.enable = false;
        server.enable = true;
	    applications.helix.enable = true;
	    theme = "everforest";
    };

    imports = [
        inputs.website.nixosModules.webserver
        inputs.dorg.nixosModules.matrix
    ];
    pscl-webserver = {
        enable = false;
        interface = "enp0s6";
        extraModules = [ ../../modules/security.nix ];
    };

    users.users.pascal = {
        hashedPassword = lib.mkForce "$y$j9T$msWpSYvdV4RrhlUF4spuX1$BBoDphEyTcg4yOIsPJFQk7FFR8xOoLaBf22FeXUZ3I9";
        hashedPasswordFile = lib.mkForce null; # this shit is too much of a headache
    };

    documentation.enable = false;
}
