{ config, lib, ... }:
let
  cfg = config.modules.dns;
in
{
  config = lib.mkIf (cfg.type == "dnscrypt-proxy") {
    networking = {
      nameservers = [
        "127.0.0.1"
        "::1"
      ];
      networkmanager.dns = "none";
    };
    services.dnscrypt-proxy = {
      enable = true;
      settings = {
        listen_addresses = [
          "127.0.0.1:53"
          "[::1]:53"
        ];
        ipv6_servers = true;
        require_dnssec = true;

        ###############################################################################
        #                               GLOBAL SETTINGS                               #
        ###############################################################################
        # server_names = [ "scaleway-fr" "google" "yandex" "cloudflare" ];
        # listen_addresses = [ "127.0.0.1:53" ];
        # max_clients = 250;
        # user_name = "nobody";

        ###############################################################################
        #                              SERVER SELECTION                               #
        ###############################################################################
        # ipv4_servers = true;
        # ipv6_servers = false;
        # dnscrypt_servers = true;
        # doh_servers = true;
        # odoh_servers = false;
        # require_dnssec = false;
        # require_nolog = true;
        # require_nofilter = true;
        # disabled_server_names = [ ];

        ###############################################################################
        #                             CONNECTION SETTINGS                             #
        ###############################################################################
        # force_tcp = false;
        # http3 = false;
        # http3_probe = false;
        # proxy = "socks5://dnscrypt:dnscrypt@127.0.0.1:9050";
        # http_proxy = "http://127.0.0.1:8888";
        # timeout = 5000;
        # keepalive = 30;
        # edns_client_subnet = [ "0.0.0.0/0" "2001:db8::/32" ];
        # blocked_query_response = "refused";

        ###############################################################################
        #                        LOAD BALANCING & PERFORMANCE                         #
        ###############################################################################
        # lb_strategy = "wp2";
        # lb_estimator = true;
        # timeout_load_reduction = 0.75;
        # enable_hot_reload = false;

        ###############################################################################
        #                                   LOGGING                                   #
        ###############################################################################
        # log_level = 2;
        # log_file = "dnscrypt-proxy.log";
        # log_file_latest = true;
        # use_syslog = true;
        # log_files_max_size = 10;
        # log_files_max_age = 7;
        # log_files_max_backups = 1;

        ###############################################################################
        #                           CERTIFICATE MANAGEMENT                            #
        ###############################################################################
        # cert_refresh_concurrency = 10;
        # cert_refresh_delay = 240;
        # cert_ignore_timestamp = false;
        # dnscrypt_ephemeral_keys = false;
        # pqdnscrypt = true;
        # tls_disable_session_tickets = false;
        # tls_prefer_rsa = false;
        # tls_key_log_file = "/tmp/keylog.txt";

        ###############################################################################
        #                              STARTUP & NETWORK                              #
        ###############################################################################
        # bootstrap_resolvers = [ "9.9.9.11:53" "8.8.8.8:53" ];
        # ignore_system_dns = true;
        # netprobe_timeout = 60;
        # netprobe_address = "9.9.9.9:53";
        # offline_mode = false;
        # query_meta = [ "key1:value1" "key2:value2" "token:MySecretToken" ];

        ###############################################################################
        #                                   FILTERS                                   #
        ###############################################################################
        # block_ipv6 = false;
        # block_unqualified = true;
        # block_undelegated = true;
        # reject_ttl = 10;

        ###############################################################################
        #                                 FORWARDING                                  #
        ###############################################################################
        # forwarding_rules = "forwarding-rules.txt";

        ###############################################################################
        #                                  CLOAKING                                   #
        ###############################################################################
        # cloaking_rules = "cloaking-rules.txt";
        # cloak_ttl = 600;
        # cloak_ptr = false;

        ###############################################################################
        #                                  DNS CACHE                                  #
        ###############################################################################
        # cache = true;
        # cache_size = 4096;
        # cache_min_ttl = 2400;
        # cache_max_ttl = 86400;
        # cache_neg_min_ttl = 60;
        # cache_neg_max_ttl = 600;

        ###############################################################################
        #                           CAPTIVE PORTAL HANDLING                           #
        ###############################################################################
        # captive_portals = { map_file = "example-captive-portals.txt"; };

        ###############################################################################
        #                              LOCAL DOH SERVER                               #
        ###############################################################################
        # local_doh = {
        #   listen_addresses = [ "127.0.0.1:3000" ];
        #   path = "/dns-query";
        #   cert_file = "localhost.pem";
        #   cert_key_file = "localhost.pem";
        # };

        ###############################################################################
        #                                QUERY LOGGING                                #
        ###############################################################################
        # query_log = {
        #   file = "query.log";
        #   format = "tsv";
        #   ignored_qtypes = [ "DNSKEY" "NS" ];
        # };

        ###############################################################################
        #                         SUSPICIOUS QUERIES LOGGING                          #
        ###############################################################################
        # nx_log = {
        #   file = "nx.log";
        #   format = "tsv";
        # };

        ###############################################################################
        #                     PATTERN-BASED BLOCKING (BLOCKLISTS)                     #
        ###############################################################################
        # blocked_names = {
        #   blocked_names_file = "blocked-names.txt";
        #   log_file = "blocked-names.log";
        #   log_format = "tsv";
        # };

        ###############################################################################
        #                  PATTERN-BASED IP BLOCKING (IP BLOCKLISTS)                  #
        ###############################################################################
        # blocked_ips = {
        #   blocked_ips_file = "blocked-ips.txt";
        #   log_file = "blocked-ips.log";
        #   log_format = "tsv";
        # };

        ###############################################################################
        #                PATTERN-BASED ALLOW LISTS (BLOCKLISTS BYPASS)                #
        ###############################################################################
        # allowed_names = {
        #   allowed_names_file = "allowed-names.txt";
        #   log_file = "allowed-names.log";
        #   log_format = "tsv";
        # };

        ###############################################################################
        #             PATTERN-BASED ALLOWED IPS LISTS (BLOCKLISTS BYPASS)             #
        ###############################################################################
        # allowed_ips = {
        #   allowed_ips_file = "allowed-ips.txt";
        #   log_file = "allowed-ips.log";
        #   log_format = "tsv";
        # };

        ###############################################################################
        #                          TIME ACCESS RESTRICTIONS                           #
        ###############################################################################
        # schedules = {
        #   time-to-sleep = {
        #     mon = [ { after = "21:00"; before = "7:00"; } ];
        #     tue = [ { after = "21:00"; before = "7:00"; } ];
        #     wed = [ { after = "21:00"; before = "7:00"; } ];
        #     thu = [ { after = "21:00"; before = "7:00"; } ];
        #     fri = [ { after = "23:00"; before = "7:00"; } ];
        #     sat = [ { after = "23:00"; before = "7:00"; } ];
        #     sun = [ { after = "21:00"; before = "7:00"; } ];
        #   };
        #
        #   work = {
        #     mon = [ { after = "9:00"; before = "18:00"; } ];
        #     tue = [ { after = "9:00"; before = "18:00"; } ];
        #     wed = [ { after = "9:00"; before = "18:00"; } ];
        #     thu = [ { after = "9:00"; before = "18:00"; } ];
        #     fri = [ { after = "9:00"; before = "17:00"; } ];
        #   };
        # };

        ###############################################################################
        #                                   SERVERS                                   #
        ###############################################################################
        # sources = {
        #   public-resolvers = {
        #     urls = [
        #       "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
        #       "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        #       "https://cdn.jsdelivr.net/gh/DNSCrypt/dnscrypt-resolvers@master/v3/public-resolvers.md"
        #     ];
        #     cache_file = "public-resolvers.md";
        #     minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
        #     refresh_delay = 73;
        #     prefix = "";
        #   };
        #
        #   relays = {
        #     urls = [
        #       "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/relays.md"
        #       "https://download.dnscrypt.info/resolvers-list/v3/relays.md"
        #       "https://cdn.jsdelivr.net/gh/DNSCrypt/dnscrypt-resolvers@master/v3/relays.md"
        #     ];
        #     cache_file = "relays.md";
        #     minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
        #     refresh_delay = 73;
        #     prefix = "";
        #   };
        #
        #   odoh-servers = {
        #     urls = [
        #       "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/odoh-servers.md"
        #       "https://download.dnscrypt.info/resolvers-list/v3/odoh-servers.md"
        #       "https://cdn.jsdelivr.net/gh/DNSCrypt/dnscrypt-resolvers@master/v3/odoh-servers.md"
        #     ];
        #     cache_file = "odoh-servers.md";
        #     minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
        #     refresh_delay = 73;
        #     prefix = "";
        #   };
        #
        #   odoh-relays = {
        #     urls = [
        #       "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/odoh-relays.md"
        #       "https://download.dnscrypt.info/resolvers-list/v3/odoh-relays.md"
        #       "https://cdn.jsdelivr.net/gh/DNSCrypt/dnscrypt-resolvers@master/v3/odoh-relays.md"
        #     ];
        #     cache_file = "odoh-relays.md";
        #     minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
        #     refresh_delay = 73;
        #     prefix = "";
        #   };
        #
        #   quad9-resolvers = {
        #     urls = [ "https://quad9.net/dnscrypt/quad9-resolvers.md" ];
        #     minisign_key = "RWQBphd2+f6eiAqBsvDZEBXBGHQBJfeG6G+wJPPKxCZMoEQYpmoysKUN";
        #     cache_file = "quad9-resolvers.md";
        #     prefix = "quad9-";
        #   };
        #
        #   parental-control = {
        #     urls = [
        #       "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/parental-control.md"
        #       "https://download.dnscrypt.info/resolvers-list/v3/parental-control.md"
        #       "https://cdn.jsdelivr.net/gh/DNSCrypt/dnscrypt-resolvers@master/v3/parental-control.md"
        #     ];
        #     cache_file = "parental-control.md";
        #     minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
        #   };
        #
        #   dnscry-pt-resolvers = {
        #     urls = [ "https://www.dnscry.pt/resolvers.md" ];
        #     minisign_key = "RWQM31Nwkqh01x88SvrBL8djp1NH56Rb4mKLHz16K7qsXgEomnDv6ziQ";
        #     cache_file = "dnscry.pt-resolvers.md";
        #     refresh_delay = 73;
        #     prefix = "dnscry.pt-";
        #   };
        # };

        ###############################################################################
        #                           SERVERS WITH KNOWN BUGS                           #
        ###############################################################################
        # broken_implementations = {
        #   fragments_blocked = [
        #     "cisco"
        #     "cisco-ipv6"
        #     "cisco-familyshield"
        #     "cisco-familyshield-ipv6"
        #     "cisco-sandbox"
        #     "cleanbrowsing-adult"
        #     "cleanbrowsing-adult-ipv6"
        #     "cleanbrowsing-family"
        #     "cleanbrowsing-family-ipv6"
        #     "cleanbrowsing-security"
        #     "cleanbrowsing-security-ipv6"
        #   ];
        # };

        ###############################################################################
        #               CERTIFICATE-BASED CLIENT AUTHENTICATION FOR DOH               #
        ###############################################################################
        # doh_client_x509_auth.creds = [
        #   {
        #     server_name = "*";
        #     client_cert = "client.crt";
        #     client_key = "client.key";
        #   }
        # ];

        ###############################################################################
        #                               ANONYMIZED DNS                                #
        ###############################################################################
        # anonymized_dns = {
        #   routes = [
        #     { server_name = "example-server-1"; via = [ "anon-example-1" "anon-example-2" ]; }
        #     { server_name = "example-server-2"; via = [ "sdns://gRIxMzcuNzQuMjIzLjIzNDo0NDM" ]; }
        #   ];
        #   skip_incompatible = false;
        #   direct_cert_fallback = true;
        # };

        ###############################################################################
        #                                    DNS64                                    #
        ###############################################################################
        # dns64 = {
        #   prefix = [ "64:ff9b::/96" ];
        #   resolver = [ "[2606:4700:4700::64]:53" "[2001:4860:4860::64]:53" ];
        # };

        ###############################################################################
        #                                IP ENCRYPTION                                #
        ###############################################################################
        # ip_encryption = {
        #   algorithm = "none";
        #   key = "";
        # };

        ###############################################################################
        #                                MONITORING UI                                #
        ###############################################################################
        # monitoring_ui = {
        #   enabled = false;
        #   listen_address = "127.0.0.1:8080";
        #   username = "admin";
        #   password = "changeme";
        #   tls_certificate = "";
        #   tls_key = "";
        #   enable_query_log = true;
        #   privacy_level = 1;
        #   max_query_log_entries = 100;
        #   max_memory_mb = 1;
        #   prometheus_enabled = false;
        #   prometheus_path = "/metrics";
        # };

        ###############################################################################
        #                               STATIC ENTRIES                                #
        ###############################################################################
        # static.myserver.stamp = "sdns://AQcAAAAAAAAAAAAQMi5kbnNjcnlwdC1jZXJ0Lg";
      };
    };
  };
}
