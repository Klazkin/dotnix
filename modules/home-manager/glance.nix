{ user, hostName, ... }: {
  services.glance = {
    enable = true;

    settings = {
      pages = [{
        columns = [{
          size = "full";
          widgets = [
            { type = "calendar"; }
            {
              location = "Tallinn, Estonia";
              type = "weather";
            }
          ];
        }];
        name = user + "/" + hostName;
      }];
      server = { port = 5678; };
    };
  };
}
