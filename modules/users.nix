{ inputs, pkgs, username, ... }:

{
    users.users.${username} = {
        hashedPasswordFile = "/nix/persist/passwd/${username}";
        isNormalUser = true;
        description = "Pascal";
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [
            home-manager
            nh
        ];
    };

    home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit inputs username; };
        users.${username} = {
            programs.home-manager.enable = true;
            home = {
                username = username;
                homeDirectory = "/home/${username}";
                stateVersion = "26.05";
            };
        };
    };

    # Make sure we always have a password
    system.activationScripts.passwordInit = {
        deps = [ "users" "groups" ];
        text = ''
            PASSWORD_FILE="/nix/persist/passwd/${username}"
            TARGET_USER=${username}

            if [ ! -f "$PASSWORD_FILE" ]; then
                echo ""
                echo "──────────────────────────────────────────────────────"
                echo "  Password creation for user: $TARGET_USER"
                echo "  No password file found at: $PASSWORD_FILE"
                echo "──────────────────────────────────────────────────────"

                mkdir -p "$(dirname "$PASSWORD_FILE")"

                while true; do
                    HASHED="$(${pkgs.mkpasswd}/bin/mkpasswd \
                        --method=yescrypt \
                        --rounds=3)" && break
                    echo "Password failed or cancelled. Try again" >&2
                done

                printf '%s\n' "$HASHED" > "$PASSWORD_FILE"
                chmod 0400 "$PASSWORD_FILE"

                printf '%s:%s\n' "$TARGET_USER" "$HASHED" | \
                    ${pkgs.shadow}/bin/chpasswd --encrypted

                printf 'root:%s\n' "$HASHED" | \
                    ${pkgs.shadow}/bin/chpasswd --encrypted

                echo "Password set and hash stored at $PASSWORD_FILE"
                echo ""
                unset $HASHED
            fi
        '';
    };
}
