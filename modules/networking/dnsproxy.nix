{ config, lib, ... }:
let
  cfg = config.modules.dns;
in
{
  config = lib.mkIf (cfg.type == "dnsproxy") {
    networking = {
      nameservers = [
        "127.0.0.1"
        "::1"
      ];
      networkmanager.dns = "none";
    };
    services.dnsproxy = {
      enable = true;
      settings = {
        listen-addrs = [
          "127.0.0.1"
          "::1"
        ];
        upstream = [ "quic://dns.adguard-dns.com" ];
        bootstrap = [
          "94.140.14.14:53"
          "94.140.15.15:53"
          "[2a10:50c0::ad1:ff]:53"
          "[2a10:50c0::ad2:ff]:53"
        ];
        fallback = [ "https://dns.adguard-dns.com/dns-query" ];
        ratelimit-subnet-len-ipv6 = 64;
        cache = true;

        # output = "";
        # tls-crt = "";
        # tls-key = "";
        # https-server-name = "dnsproxy";
        # https-userinfo = "";
        # dnscrypt-config = "";
        # edns-addr = "";
        # upstream-mode = "load_balance";
        # listen-addrs = [ ];
        # doh-routes = [ ];
        # listen-ports = [ ];
        # https-port = [ ];
        # tls-port = [ ];
        # quic-port = [ ];
        # dnscrypt-port = [ ];
        # upstream = [ ];
        # bootstrap = [ ];
        # fallback = [ ];
        # private-rdns-upstream = [ ];
        # dns64-prefix = [ ];
        # private-subnets = [ ];
        # bogus-nxdomain = [ ];
        # hosts-files = [ ];
        # timeout = "10s";
        # cache-min-ttl = 0;
        # cache-max-ttl = 0;
        # optimistic-answer-ttl = "30s";
        # optimistic-max-age = "12h";
        # cache-size = 65536;
        # ratelimit = 0;
        # ratelimit-subnet-len-ipv4 = 24;
        # ratelimit-subnet-len-ipv6 = 56;
        # udp-buf-size = 0;
        # max-go-routines = 0;
        # tls-min-version = 1.0;
        # tls-max-version = 1.3;
        # doh-insecure-enabled = false;
        # hosts-file-enabled = true;
        # pprof = false;
        # version = false;
        # verbose = false;
        # insecure = false;
        # ipv6-disabled = false;
        # http3 = false;
        # cache-optimistic = false;
        # cache = false;
        # refuse-any = false;
        # dnssec = true;
        # edns = false;
        # pending-requests-enabled = true;
        # dns64 = false;
        # use-private-rdns = false;
      };
    };
  };
}
