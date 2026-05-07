{ inputs, lib, config, ... }:

{
    options.mySystem.enableWebserver = lib.mkEnableOption "My webserver";

    confif = lib.mkIf mySystem.enableWebserver {
        containers.webserver = {
            autoStart = true;
            privateNetwork = true;
            privateUsers = "pick";
            hostAddress = "10.0.0.1";
            localAddress = "10.0.0.2";
            restartIfChanged = true;
            config = inputs.website.nixosModules.webserver;
        };
    }
}
