{ inputs, ... }:

{
  imports = [
    inputs.nixcord.homeModules.nixcord
  ];

  programs.nixcord = {
    enable = true;

    discord.vencord.enable = true;
    
    vesktop.enable = true;

    quickCss = "
    /* ===== Balanced Dark Glass Theme ===== */

    :root {
        --background-primary: #0e111a;
        --background-secondary: rgba(20, 24, 36, 0.7);
        --background-tertiary: rgba(16, 19, 30, 0.85);

        --accent: #6c7cff;
        --accent-soft: #4fd1c5;

        --text-normal: #e4e6eb;
        --text-muted: #9aa4b2;
    }

    /* App background */
    .appMount_fae9dd {
        background: linear-gradient(135deg, #0e111a, #111827);
    }

    /* Panels (subtle glass effect) */
    .sidebar_a4d4d9,
    .container_c48ade,
    .chatContent_a7d72e {
        background: rgba(20, 24, 36, 0.55) !important;
        backdrop-filter: blur(12px);
    }

    /* Messages hover */
    .messageListItem_d5deea:hover {
        background: rgba(108, 124, 255, 0.08);
    }

    /* Links */
    a,
    .mention {
        color: var(--accent-soft) !important;
    }

    /* Buttons */
    button {
        border-radius: 8px !important;
    }

    /* Scrollbar */
    ::-webkit-scrollbar {
        width: 8px;
    }

    ::-webkit-scrollbar-thumb {
        background: var(--accent);
        border-radius: 8px;
    }
    ";

    config = {
      frameless = true; 
      useQuickCss = true;
      themeLinks = [
        "https://mwittrien.github.io/BetterDiscordAddons/Themes/DiscordRecolor/DiscordRecolor.theme.css"
      ];
      plugins = {
        fakeNitro = {
          enable = true;
        };
      };
    };
  };
}
