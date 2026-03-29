{ config, pkgs, ...}:

{
  home.username = "fomar";
  home.homeDirectory = "/home/fomar";

  home.packages = with pkgs; [

  neofetch
  yazi

  # Archives
  p7zip
  zip
  unzip
  xz
  
  # Utils
  ripgrep
  jq
  eza
  fzf
  
  # Networking tools
  mtr # A network diagnostic tool

  # misc
  which
  tree
  zstd

  # nix related
  #
  # it provides the command `nom` works just like `nix`
  # with more details log output
  nix-output-monitor

  # productivity
  glow # markdown previewer in terminal
  btop # process and system monitor
  ];

  # Basic configuration of git
  programs.git = {
    enable = true;
    settings = {
      user = {
        Name = "Jitu Maat";
        Email = "jitumaat@protonmail.com";
      };
    };
  };
  # starship - a customizable prompt for any shell
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      aws.disabled = true;
      # disable line break between first and second prompt lines
      line_break.disabled = true;  

    };
  };
  programs.bash = {
    enable = true;
    enableCompletion = true;
    # TODO add my custom bashrc here
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    '';

    shellAliases = {
     ls = "eza";
     grep = "rg";
    };
  };

  home.stateVersion = "25.11";
}
