{ config, lib, pkgs, modulesPath, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs.librewolf;
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      
      Cookies = {
        Allow = [
          "https://google.com"
          "https://www.google.com"
          "https://duosecurity.com"
          "https://moodle.carleton.edu"
          "https://www.myworkday.com" 
        ];
      };
      # ------------------------------

      Preferences = {
        "cookiebanners.service.mode.privateBrowsing" = 2;
        "cookiebanners.service.mode" = 2;
        "privacy.donottrackheader.enabled" = true;
        "privacy.fingerprintingProtection" = true;
        "privacy.resistFingerprinting" = true;
        "privacy.trackingprotection.emailtracking.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.fingerprinting.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "webgl.disabled" = false;
      };
      ExtensionSettings = {
        "jid1-ZAdIEUB7XOzOJw@jetpack" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/duckduckgo-for-firefox/latest.xpi";
          installation_mode = "force_installed";
        };
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4633659/bitwarden_password_manager-2025.11.2.xpi";
          installation_mode = "force_installed";
        };
        "{60f82f00-9ad5-4de5-b31c-b16a47c51558}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/3343599/cookie_quick_manager-0.5rc2.xpi";
          installation_mode = "force_installed";
        };
        "{5adf2485-4acd-42a8-b04c-1b0a6b03ddd0}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4061627/purple_starfield_animated-1.0.xpi";
          installation_mode = "force_installed";
        };
        "{CanvasBlocker@kkapsner.de}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4413485/canvasblocker-1.11.xpi";
          installation_mode = "force_installed";
        };
        "{addon@darkreader.org}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4638146/darkreader-4.9.118.xpi";
          installation_mode = "force_installed";
        };
      };
    };
  };

  environment.etc."firefox/policies/policies.json".target = "librewolf/policies/policies.json";
}
