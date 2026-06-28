{ inputs, ... }:

{
  imports = [
    inputs.nixcord.homeModules.nixcord
  ];

  programs.nixcord = {
    enable = true;

    discord.vencord.enable = true;
    
    # vesktop.enable = true;

    config = {
      frameless = true; 
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
