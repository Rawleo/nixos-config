{pkgs, ...}: {
  home.packages = with pkgs; [
    blesh
  ];
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      [[ $- == *i* ]] && source -- "$(blesh-share)"/ble.sh --attach=none
      ...
      [[ ! ''${BLE_VERSION-} ]] || ble-attach
    '';
  };
}
