{
  pkgs,
  ...
}:

{
  fonts.packages = with pkgs; [
    nerd-fonts.terminess-ttf
    gohufont
    nerd-fonts.gohufont
    nerd-fonts.hack
    source-code-pro
    tamsyn
    terminus_font
    font-awesome
    noto-fonts
    termsyn
    dina-font
    cascadia-code
    fira-code
    fira-code-symbols
  ];

  fonts.fontconfig = {
    enable = true;
    antialias = true;
    allowBitmaps = true;

    hinting = {
      enable = true;
      style = "full";
    };

    subpixel = {
      lcdfilter = "default";
      rgba = "rgb";
    };

    localConf = ''
      <match target="font">
        <test name="family" compare="contains">
          <string>Termsyn</string>
        </test>
        <test name="family" compare="contains">
          <string>Dina</string>
        </test>
        <test name="family" compare="contains">
          <string>Ohsnap</string>
        </test>
        <edit name="antialias" mode="assign">
          <bool>false</bool>
        </edit>
      </match>
    '';
  };
}
