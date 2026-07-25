{
  services.searx = {
    enable = true;
    environmentFile = "/var/lib/searx/env";
    settings = {
      search = {
        autocomplete = "google";
        favicon_resolver = "google";
      };
      server = {
        image_proxy = true;
      };
      plugins = {
        "searx.plugins.infinite_scroll.SXNGPlugin".active = true;
      };

      # general = {
      #   debug = false;
      #   instance_name = "SearXNG";
      #   privacypolicy_url = false;
      #   donation_url = false;
      #   contact_url = false;
      #   enable_metrics = true;
      #   open_metrics = "";
      # };

      # brand = {
      #   docs_url = "https://docs.searxng.org/";
      #   public_instances = "https://searx.space";
      #   wiki_url = "https://github.com/searxng/searxng/wiki";
      #   issue_url = "https://github.com/searxng/searxng/issues";
      #   custom = {
      #     links = {
      #       Uptime = "https://uptime.searxng.org/history/darmarit-org";
      #       About = "https://searxng.org";
      #     };
      #   };
      #   pwa_colors = {
      #     theme_color_light = "#3050ff";
      #     background_color_light = "fff";
      #     theme_color_dark = "#58f";
      #     background_color_dark = "#222428";
      #     theme_color_black = "#3050ff";
      #     background_color_black = "#000";
      #   };
      # };

      # search = {
      #   safe_search = 0;
      #   autocomplete = "";
      #   autocomplete_min = 4;
      #   favicon_resolver = "";
      #   default_lang = "auto";
      #   max_page = 0;
      #   languages = [ "all" "en" "en-US" "de" "it-IT" "fr" "fr-BE" ];
      #   ban_time_on_fail = 5;
      #   max_ban_time_on_fail = 120;
      #   suspended_times = {
      #     SearxEngineAccessDenied = 180;
      #     SearxEngineCaptcha = 3600;
      #     SearxEngineTooManyRequests = 180;
      #     cf_SearxEngineCaptcha = 1296000;
      #     cf_SearxEngineAccessDenied = 86400;
      #     recaptcha_SearxEngineCaptcha = 604800;
      #   };
      #   formats = [ "html" ];
      # };

      # server = {
      #   port = 8888;
      #   bind_address = "127.0.0.1";
      #   base_url = false;
      #   limiter = false;
      #   public_instance = false;
      #   secret_key = "ultrasecretkey"; # Recommended to set via secret file
      #   image_proxy = false;
      #   http_protocol_version = "1.0";
      #   method = "POST";
      #   default_http_headers = {
      #     X-Content-Type-Options = "nosniff";
      #     X-Download-Options = "noopen";
      #     X-Robots-Tag = "noindex, nofollow";
      #     Referrer-Policy = "no-referrer";
      #   };
      # };

      # valkey = {
      #   url = false;
      # };

      # ui = {
      #   static_path = "";
      #   templates_path = "";
      #   query_in_title = false;
      #   default_theme = "simple";
      #   center_alignment = false;
      #   cache_url = "https://webcache.googleusercontent.com/search?q=cache:";
      #   default_locale = "";
      #   results_on_new_tab = false;
      #   theme_args = {
      #     simple_style = "auto";
      #   };
      #   search_on_category_select = true;
      #   hotkeys = "default";
      #   url_formatting = "pretty";
      # };

      # preferences = {
      #   lock = [ ];
      # };

      # outgoing = {
      #   request_timeout = 3.0;
      #   max_request_timeout = 10.0;
      #   useragent_suffix = "";
      #   pool_connections = 100;
      #   pool_maxsize = 20;
      #   enable_http2 = true;
      #   verify = "~/.mitmproxy/mitmproxy-ca-cert.cer";
      #   proxies = {
      #     "all://" = [
      #       "http://proxy1:8080"
      #       "http://proxy2:8080"
      #     ];
      #   };
      #   using_tor_proxy = true;
      #   extra_proxy_timeout = 10;
      #   source_ips = [
      #     "1.1.1.1"
      #     "1.1.1.2"
      #     "fe80::/126"
      #   ];
      # };

      # plugins = {
      #   "searx.plugins.calculator.SXNGPlugin".active = true;
      #   "searx.plugins.infinite_scroll.SXNGPlugin".active = false;
      #   "searx.plugins.hash_plugin.SXNGPlugin".active = true;
      #   "searx.plugins.self_info.SXNGPlugin".active = true;
      #   "searx.plugins.unit_converter.SXNGPlugin".active = true;
      #   "searx.plugins.ahmia_filter.SXNGPlugin".active = true;
      #   "searx.plugins.hostnames.SXNGPlugin".active = true;
      #   "searx.plugins.time_zone.SXNGPlugin".active = true;
      #   "searx.plugins.oa_doi_rewrite.SXNGPlugin".active = false;
      #   "searx.plugins.tor_check.SXNGPlugin".active = false;
      #   "searx.plugins.tracker_url_remover.SXNGPlugin".active = true;
      # };

      # categories_as_tabs = {
      #   general = { };
      #   images = { };
      #   videos = { };
      #   news = { };
      #   map = { };
      #   music = { };
      #   it = { };
      #   science = { };
      #   files = { };
      #   "social media" = { };
      # };

      # engines = lib.mapAttrsToList (name: value: { inherit name; } // value) {
      #   "360search"
      #   "360search videos"
      #   "500px"
      #   "9gag"
      #   "abcnyheter"
      #   "acfun"
      #   "adobe stock"
      #   "adobe stock video"
      #   "adobe stock audio"
      #   "astrophysics data system"
      #   "alpine linux packages"
      #   "annas archive"
      #   "ansa"
      #   "annas articles"
      #   "apk mirror"
      #   "apple app store"
      #   "ahmia"
      #   "anaconda"
      #   "arch linux wiki"
      #   "nixos wiki"
      #   "artic"
      #   "artstation"
      #   "arxiv"
      #   "avalw"
      #   "ayo"
      #   "azure"
      #   "base"
      #   "bandcamp"
      #   "baidu"
      #   "baidu images"
      #   "baidu kaifa"
      #   "wikipedia"
      #   "bilibili"
      #   "bing"
      #   "bing images"
      #   "bing news"
      #   "bing videos"
      #   "bitchute"
      #   "bitbucket"
      #   "boardreader"
      #   "bpb"
      #   "btdigg"
      #   "openverse"
      #   "media.ccc.de"
      #   "cachy os packages"
      #   "cara"
      #   "chatnoir"
      #   "chefkoch"
      #   "chinaso news"
      #   "cl0q"
      #   "cloudflareai"
      #   "core.ac.uk"
      #   "crossref"
      #   "crowdview"
      #   "yep"
      #   "currency"
      #   "deezer"
      #   "destatis"
      #   "deviantart"
      #   "devicons"
      #   "ddg definitions"
      #   "digbt"
      #   "docker hub"
      #   "encyclosearch"
      #   "erowid"
      #   "elasticsearch"
      #   "wikidata"
      #   "dogpile"
      #   "dogpile images"
      #   "dogpile videos"
      #   "dogpile news"
      #   "duckduckgo"
      #   "duckduckgo web"
      #   "duckduckgo images"
      #   "duckduckgo videos"
      #   "duckduckgo news"
      #   "duckduckgo weather"
      #   "apple maps"
      #   "emojipedia"
      #   "tineye"
      #   "etymonline"
      #   "ebay"
      #   "1x"
      #   "fastbot"
      #   "fdroid"
      #   "findfiles"
      #   "findfiles images"
      #   "findfiles videos"
      #   "findfiles music"
      #   "findthatmeme"
      #   "fireball"
      #   "fireball news"
      #   "fireball videos"
      #   "flaticon"
      #   "flickr"
      #   "flickr_api"
      #   "free software directory"
      #   "freesound"
      #   "frinkiac"
      #   "fynd"
      #   "fyyd"
      #   "gabanza"
      #   "geizhals"
      #   "genius"
      #   "gentoo"
      #   "giphy"
      #   "gitlab"
      #   "gnome"
      #   "github"
      #   "github code"
      #   "codeberg"
      #   "gitea.com"
      #   "gmx"
      #   "goodreads"
      #   "google"
      #   "google images"
      #   "google news"
      #   "google videos"
      #   "google cse"
      #   "google cse images"
      #   "google scholar"
      #   "google play apps"
      #   "google play movies"
      #   "grokipedia"
      #   "material icons"
      #   "habrahabr"
      #   "hackernews"
      #   "heexy"
      #   "heexy images"
      #   "hex"
      #   "crates.io"
      #   "hoogle"
      #   "iseek"
      #   "il post"
      #   "huggingface"
      #   "huggingface datasets"
      #   "huggingface spaces"
      #   "imdb"
      #   "imgur"
      #   "ina"
      #   "invidious"
      #   "ipernity"
      #   "iqiyi"
      #   "kagi"
      #   "kagi.news"
      #   "kagi.images"
      #   "kagi.videos"
      #   "kavunka demo"
      #   "kozmonavt"
      #   "jisho"
      #   "kickass"
      #   "kukei"
      #   "lemmy communities"
      #   "lemmy users"
      #   "lemmy posts"
      #   "lemmy comments"
      #   "library genesis"
      #   "z-library"
      #   "library of congress"
      #   "libretranslate"
      #   "lingva"
      #   "lobste.rs"
      #   "lucide"
      #   "luxxle"
      #   "luxxle images"
      #   "luxxle videos"
      #   "luxxle news"
      #   "magnific"
      #   "marginalia"
      #   "mastodon users"
      #   "mastodon hashtags"
      #   "matrixrooms"
      #   "mdn"
      #   "metacpan"
      #   "meilisearch"
      #   "microsoft learn"
      #   "mixcloud"
      #   "mymongo"
      #   "mozhi"
      #   "mwmbl"
      #   "neocities"
      #   "niconico"
      #   "npm"
      #   "nyaa"
      #   "mankier"
      #   "odysee"
      #   "ollama"
      #   "openairedatasets"
      #   "openairepublications"
      #   "openalex"
      #   "openclipart"
      #   "openlibrary"
      #   "openmeteo"
      #   "opensemanticsearch"
      #   "openstreetmap"
      #   "openrepos"
      #   "packagist"
      #   "pdbe"
      #   "pexels"
      #   "photon"
      #   "picjumbo"
      #   "pinterest"
      #   "piped"
      #   "piped.music"
      #   "piratebay"
      #   "pixabay images"
      #   "pixabay videos"
      #   "pixiv"
      #   "postgresql"
      #   "podchaser"
      #   "presearch"
      #   "presearch images"
      #   "presearch videos"
      #   "presearch news"
      #   "pub.dev"
      #   "public domain image archive"
      #   "pubmed"
      #   "pypi"
      #   "quark"
      #   "quark images"
      #   "qwant"
      #   "qwant news"
      #   "qwant images"
      #   "qwant videos"
      #   "library"
      #   "recoll library reference"
      #   "radio browser"
      #   "rawweb"
      #   "reddit"
      #   "reuters"
      #   "rottentomatoes"
      #   "myvalkey"
      #   "scanr structures"
      #   "searchmysite"
      #   "selfhst icons"
      #   "sepiasearch"
      #   "shopify stock"
      #   "sogou"
      #   "sogou images"
      #   "sogou videos"
      #   "sogou wechat"
      #   "soundcloud"
      #   "stackoverflow"
      #   "stocksnap"
      #   "askubuntu"
      #   "superuser"
      #   "discuss.python"
      #   "caddy.community"
      #   "pi-hole.community"
      #   "privacywall"
      #   "privacywall images"
      #   "privacywall videos"
      #   "searx"
      #   "seekninja"
      #   "semantic scholar"
      #   "spotify"
      #   "solr"
      #   "springer nature"
      #   "startpage"
      #   "startpage news"
      #   "startpage images"
      #   "steam"
      #   "tokyotoshokan"
      #   "solidtorrents"
      #   "mediathekview"
      #   "tagesschau"
      #   "tiger"
      #   "tiger news"
      #   "tmdb"
      #   "tonline"
      #   "tonline images"
      #   "tonline videos"
      #   "tonline news"
      #   "torch"
      #   "tubearchivist"
      #   "Torznab EZTV"
      #   "tusksearch"
      #   "tusksearch images"
      #   "tusksearch videos"
      #   "tusksearch news"
      #   "urbandictionary"
      #   "unsplash"
      #   "unobtanium"
      #   "yandex"
      #   "yandex images"
      #   "yandex music"
      #   "yahoo"
      #   "yahoo news"
      #   "youtube"
      #   "youtube_api"
      #   "dailymotion"
      #   "vimeo"
      #   "wiby"
      #   "wikibooks"
      #   "wikinews"
      #   "wikiquote"
      #   "wikisource"
      #   "wikispecies"
      #   "wiktionary"
      #   "wikiversity"
      #   "wikivoyage"
      #   "wikicommons.images"
      #   "wikicommons.videos"
      #   "wikicommons.audio"
      #   "wikicommons.files"
      #   "wolframalpha"
      #   "wolframalpha_api"
      #   "dictzone"
      #   "mymemory translated"
      #   "mysql"
      #   "mariadb"
      #   "1337x"
      #   "duden"
      #   "seznam"
      #   "deepl"
      #   "mojeek"
      #   "mojeek images"
      #   "mojeek news"
      #   "moviepilot"
      #   "national vulnerability database"
      #   "naver"
      #   "naver images"
      #   "naver news"
      #   "naver videos"
      #   "neosearch"
      #   "rubygems"
      #   "peertube"
      #   "mediathekviewweb"
      #   "yacy"
      #   "yacy images"
      #   "rumble"
      #   "reloado"
      #   "repology"
      #   "resulthunter"
      #   "resulthunter images"
      #   "searchch"
      #   "searchzee"
      #   "searchzee news"
      #   "startpagina"
      #   "startpagina images"
      #   "startpagina videos"
      #   "startpagina news"
      #   "swisscows"
      #   "swisscows images"
      #   "swisscows videos"
      #   "swisscows news"
      #   "wordnik"
      #   "woxikon.de synonyme"
      #   "tootfinder"
      #   "uxwing"
      #   "voidlinux"
      #   "vuhuv"
      #   "vuhuv images"
      #   "vuhuv videos"
      #   "wallhaven"
      #   "wikimini"
      #   "wttr.in"
      #   "xonaly"
      #   "zapmeta"
      #   "braveapi"
      #   "brave"
      #   "brave.images"
      #   "brave.videos"
      #   "brave.news"
      #   "brave.goggles"
      #   "lib.rs"
      #   "sourcehut"
      #   "bt4g"
      #   "pkg.go.dev"
      #   "senscritique"
      #   "minecraft wiki"
      #   "searchtoday"
      #   "sina"
      #   "webcrawler"
      #   "excite"
      #   "metacrawler"
      #   "infospace"
      #   "ubuntuwiki"
      #   "git grep"
      #   "locate"
      #   "find"
      #   "pattern search in files"
      #   "regex search in files"
      # };
    };
  };
}
