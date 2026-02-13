{ pkgs, username, config, lib, ... }:

{
    options.applications.fastfetch.enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        descripton = "Whether to enable my fastfetch module";
    };

    config = lib.mkIf config.applications.fastfetch.enable {
        home-manager.users.${username} = {
            programs.fastfetch = {
                enable = true;

                settings = {
                    logo = {
                        type = "file";
                        source = "/home/${username}/.config/fastfetch/fastfetch-logo.txt";
                        padding = {
                            top = 1;
                            left = 2;
                            right = 3;
                        };
                        color = {
                            "1" = "38;2;129;162;190";
                            "2" = "38;2;138;190;183";
                            "3" = "38;2;89;134;179";
                        };
                    };
                    modules = [
                        "break"
                        {
                            type = "custom";
                            format = "{##B0B0B0}┌─────────────────────────Hardware─────────────────────────┐";
                        }
                        {
                            type = "host";
                            key = "  PC";
                            keyColor = "green";
                        }
                        {
                            type = "cpu";
                            key = "│ ├ ";
                            keyColor = "green";
                        }
                        {
                            type = "gpu";
                            key = "│ ├ ";
                            keyColor = "green";
                        }
                        {
                            type = "memory";
                            key = "│ ├ ";
                            keyColor = "green";
                        }
                        {
                            type = "disk";
                            key = "└ └ ";
                            keyColor = "green";
                        }
                        {
                            type = "custom";
                            format = "{##B0B0B0}├─────────────────────────Software─────────────────────────┤";
                        }
                        {
                            type = "os";
                            key = " OS";
                            keyColor = "yellow";
                        }
                        {
                            type = "kernel";
                            key = "│ ├ ";
                            keyColor = "yellow";
                        }
                        {
                            type = "bios";
                            key = "│ ├ ";
                            keyColor = "yellow";
                        }
                        {
                            type = "packages";
                            key = "│ ├󰏖 ";
                            keyColor = "yellow";
                        }
                        {
                            type = "shell";
                            key = "└ └ ";
                            keyColor = "yellow";
                        }
                        "break"
                        {
                            type = "de";
                            key = " DE";
                            keyColor = "blue";
                        }
                        {
                            type = "lm";
                            key = "│ ├ ";
                            keyColor = "blue";
                        }
                        {
                            type = "wm";
                            key = "│ ├ ";
                            keyColor = "blue";
                        }
                        {
                            type = "wmtheme";
                            key = "│ ├󰉼 ";
                            keyColor = "blue";
                        }
                        {
                            type = "terminal";
                            key = "└ └ ";
                            keyColor = "blue";
                        }
                        {
                            type = "custom";
                            format = "{##B0B0B0}├───────────────────────Uptime / Age───────────────────────┤";
                        }

                        {
                            type = "command";
                            key = "  OS Age ";
                            keyColor = "magenta";
                            text = "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days";
                        }
                        {
                            type = "uptime";
                            key = "  Uptime ";
                            keyColor = "magenta";
                        }
                        {
                            type = "datetime";
                            key = "  DateTime ";
                            keyColor = "magenta";
                        }
                        {
                            type = "localip";
                            key = "  Local IP ";
                            keyColor = "magenta";
                        }
                        {
                            type = "custom";
                            format = "{##B0B0B0}└──────────────────────────────────────────────────────────┘";
                        }
                        "break"
                    ];
                };
            };

            home.file.".config/fastfetch/fastfetch-logo.txt".text = ''
                $1          ▗▄▄▄       $2▗▄▄▄▄    ▄▄▄▖
                $1          ▜███▙      $2 ▜███▙  ▟███▛
                $1           ▜███▙     $2  ▜███▙▟███▛
                $1            ▜███▙    $2   ▜██████▛
                $1     ▟█████████████████▙ $2▜████▛ $1    ▟▙
                $1    ▟███████████████████▙$2 ▜███▙ $1   ▟██▙
                $2           ▄▄▄▄▖         $2  ▜███▙$1  ▟███▛
                $2          ▟███▛          $2   ▜██▛$1 ▟███▛
                $2         ▟███▛           $2    ▜▛ $1▟███▛
                $2▟███████████▛            $1      ▟██████████▙
                $2▜██████████▛             $1     ▟███████████▛
                $2      ▟███▛$1 ▟▙           $1    ▟███▛
                $2     ▟███▛ $1▟██▙          $1   ▟███▛
                $2    ▟███▛  $1▜███▙         $1  ▝▀▀▀▀
                $2    ▜██▛   $1 ▜███▙ $2▜██████████████████▛
                $2     ▜▛    $1 ▟████▙$2 ▜████████████████▛
                $1           ▟██████▙   $2    ▜███▙
                $1          ▟███▛▜███▙  $2     ▜███▙
                $1         ▟███▛  ▜███▙ $2      ▜███▙
                $1         ▝▀▀▀    ▀▀▀▀▘$2       ▀▀▀▘
                $1   ███╗   ██╗██╗██╗  ██╗  ██████╗ ███████╗
                $1   ████╗  ██║██║╚██╗██╔╝ ██╔═══██╗██╔════╝
                $1   ██╔██╗ ██║██║ ╚███╔╝  ██║   ██║███████╗
                $1   ██║╚██╗██║██║ ██╔██╗  ██║   ██║╚════██║
                $1   ██║ ╚████║██║██╔╝ ██╗ ╚██████╔╝███████║
                $1   ╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝  ╚═════╝ ╚══════╝
            '';
        };
    };
}
