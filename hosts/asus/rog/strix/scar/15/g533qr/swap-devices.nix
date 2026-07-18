{
  swapDevices = [
    {
      device = "/swap/swapfile";
      options = [ "discard" ];
      size = 32 * 1024;
    }
  ];
}
