{ pkgs, username, config, lib, ... }:
let
    hue = config.lib.stylix.colors;
in
{
    options.mySystem.applications.heroic.enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to enable my Heroic module";
    };

    config = lib.mkIf config.mySystem.applications.heroic.enable {
        environment.systemPackages = [ pkgs.heroic pkgs.wineWow64Packages.staging ];

        programs.gamemode = {
            enable = true;
            settings.general.renice = 10;
        };

        home-manager.users.${username} = {
            programs.mangohud = {
                enable = true;
                settings.preset = 3;
            };

            home.file.".config/heroic/themes/stylix.css".text = ''
                body.stylix {
                  --background: #${hue.base00-hex};
                  --background-darker: #${hue.base01-hex};
                  --background-secondary: #${hue.base01-hex};
                  --background-lighter: #${hue.base02-hex};
                  --accent: #${hue.base09-hex};
                  --accent-overlay: var(--accent);

                  --navbar-background: var(--background);
                  --body-background: var(--background-darker);
                  --current-background: var(--body-background);
                  --text-default: #${hue.base05-hex};
                  --text-secondary: var(--text-default);
                  --text-tertiary: var(--background);
                  --navbar-accent: #${hue.base04-hex};
                  --navbar-active: var(--accent);
                  --navbar-active-background: #${hue.base01-hex};
                  --success: #${hue.base0C-hex};
                  --success-hover: #${hue.base0B-hex};
                  --input-background: var(--background);
                  --modal-background: var(--body-background);
                  --modal-border: var(--body-background);
                  --primary: #${hue.base08-hex};
                  --primary-hover: #${hue.base09-hex};
                  --danger: #${hue.base0F-hex};
                  --danger-hover: #${hue.base08-hex};
                  --anticheat-denied: var(--danger);
                  --anticheat-broken: #${hue.base0A-hex};
                  --anticheat-running: var(--text-default);
                  --anticheat-supported: #${hue.base0B-hex};
                  --anticheat-planned: #${hue.base0E-hex};
                  --text-title: var(--text-default);
                  --icons-background: var(--background-lighter);
                  --action-icon: var(--navbar-accent);
                  --action-icon-hover: var(--text-default);
                  --action-icon-active: var(--accent);
                  --icon-disabled: #${hue.base04-hex};
                  --cancel-button: #${hue.base08-hex};
                  --neutral-06: var(--text-default);
                }
            '';

            home.file.".config/heroic/themes/stylix.json".text = ''
                {
                    "name": "Stylix",
                    "filename": "stylix.css",
                    "screenshots": [
                        "library.png",
                        "downloads.png"
                    ],
                    "author": "pascal"
                }
            '';
        };
    };
}
