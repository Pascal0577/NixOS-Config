{ inputs, lib, ... }:

{
    imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];

    boot = {
        loader.systemd-boot.enable = lib.mkForce false;
        bootspec.enable = true;

        lanzaboote = {
            enable = true;
            pkiBundle = "/var/lib/sbctl/";
        };
    };
}

# More work needs to be done if I want to enable secure boot.
# Here's a quick summary of what I need to do:
# sudo nix-shell -p sbctl
# sudo sbctl create-keys
# Clear all the secure boot keys in the UEFI and enable secure boot there
# sudo sbctl enroll-keys --microsoft
# Re-enable secure boot in UEFI if needed
