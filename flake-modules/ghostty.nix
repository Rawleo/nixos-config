{ pkgs, ... }:

{
  programs.ghostty = {
    enable = true;

    package =
      if pkgs.stdenv.isDarwin
      then pkgs.ghostty-bin
      else pkgs.ghostty;

    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;

    settings = {
      # ── Appearance ─────────────────────────────────────────────
      theme = "Catppuccin Frappe";

      background-opacity = "0.92";
      background-blur-radius = "20";

      font-family = "JetBrains Mono";
      font-size = 14;

      # ── Spacing ────────────────────────────────────────────────
      window-padding-x = 14;
      window-padding-y = 12;

      # ── Cursor ────────────────────────────────────────────────
      cursor-style = "bar";
      cursor-style-blink = true;

      # ── Window ─────────────────────────────────────────────────
      window-decoration = true;
      window-save-state = "always";
      window-width = 120;
      window-height = 40;

      # ── Shell ──────────────────────────────────────────────────
      shell-integration-features = "cursor,sudo,title";

      # ── Quality of life ────────────────────────────────────────
      confirm-close-surface = false;
      copy-on-select = true;
      mouse-hide-while-typing = true;

      # ── Scrollback ─────────────────────────────────────────────
      scrollback-limit = 10000;

      # ── Links ──────────────────────────────────────────────────
      link-url = true;
    };
  };
}

