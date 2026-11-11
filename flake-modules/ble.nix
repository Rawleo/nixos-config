{pkgs, ...}: {
  home.packages = with pkgs; [
    blesh
  ];
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      [[ $- == *i* ]] && source -- "${pkgs.blesh}/share/blesh/ble.sh" --attach=none

      # Your other bashrc settings here...

      [[ ! ''${BLE_VERSION-} ]] || ble-attach
    '';
  };
}
