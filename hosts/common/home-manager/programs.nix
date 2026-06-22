{
  programs.firefox = {
    enable = true;
    profiles.default = {
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "ui.key.menuAccessKeyFocuses" = false;
      };
      userChrome = "#vertical-spacer { display: none !important; }";
    };
  };
}
