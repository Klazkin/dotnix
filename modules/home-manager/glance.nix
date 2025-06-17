{ ... }: {
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
        name = "Home";
      }];
      server = { port = 5678; };
    };
  };
}
