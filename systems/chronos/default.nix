{ lib, ... }:

{
    mySystem = {
        desktop.oxwm.enable = true;
        theme.everforest.enable = true;
        applications = {
            terminal.alacritty.enable = true;
            file-manager.yazi.enable = true;
            launcher.dmenu.enable = true;
            helix.enable = true;
            heroic.enable = false;
            mathematica.enable = false;
            virt-manager.enable = false;
        };
    };

    users.users.pascal = {
        hashedPasswordFile = lib.mkForce null; # this shit is too much of a headache
        initialHashedPassword = "$y$j9T$bRiCoHV9zdD//1ENQqKaZ/$he7h3zl7IAzZLaiOK2zyy6WtBlu.1lJFmlVfBT9IzS2";
    };
}
