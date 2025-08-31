{ pkgs, username, ... }:

{
services.mullvad-vpn.enable = true;

  users.users.${username}.packages =  with pkgs; [
    mullvad-vpn
  ];
}
