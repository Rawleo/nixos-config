{ config, pkgs, lib, ... }:

let
  cutoffDate = "7 days ago";
  keepAtLeast = 3;

in {
  systemd.services.nixos-generation-cleaner = {
    description = "Cleanup old NixOS generations and update bootloader";
    
    path = with pkgs; [ nix gnused coreutils ];

    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };

    script = ''
      cutoff="$(date -d ${lib.escapeShellArg cutoffDate} '+%s')"
      keep=${toString keepAtLeast}
      ids_to_delete=""
      protected_count=0

      entries=$(nix-env --profile /nix/var/nix/profiles/system --list-generations | sed 's/ (current)//' | tac)

      while read -r id date time garbage; do
        if [ "$protected_count" -lt "$keep" ]; then
          protected_count=$((protected_count + 1))
          continue
        fi

        gen_ts=$(date -d "$date $time" '+%s')

        if [ "$gen_ts" -lt "$cutoff" ]; then
          ids_to_delete="$ids_to_delete $id"
        fi
      done <<< "$entries"

      if [ -n "$ids_to_delete" ]; then
        nix-env --profile /nix/var/nix/profiles/system --delete-generations $ids_to_delete
        nix-store --gc
        /run/current-system/bin/switch-to-configuration boot
      fi
    '';
  };

  systemd.timers.nixos-generation-cleaner = {
    wantedBy = [ "timers.target" ];
    partOf = [ "nixos-generation-cleaner.service" ];
    timerConfig = {
      OnCalendar = "Sun *-*-* 12:00:00";
      Persistent = true;
    };
  };
}
