/*
List of IP addresses to be included/excluded in wireguard
*/
let
  ips = {
    /*
    curl -s "https://api.github.com/meta" | jq '.hooks[]'
    */
    github_copilot = [
      "192.30.252.0/22"
      "185.199.108.0/22"
      "140.82.112.0/20"
      "143.55.64.0/20"
      "2a0a:a440::/29"
      "2606:50c0::/32"

      "20.199.39.224/32"
      "20.250.119.64/32"
    ];

    fantia = [
      "35.241.8.68/32"
    ];

    /*
    curl -s "https://api.cloudflare.com/client/v4/ips" | jq '.result.ipv4_cidrs[], .result.ipv6_cidrs[]'
    */
    cloudflare = [
      "173.245.48.0/20"
      "103.21.244.0/22"
      "103.22.200.0/22"
      "103.31.4.0/22"
      "141.101.64.0/18"
      "108.162.192.0/18"
      "190.93.240.0/20"
      "188.114.96.0/20"
      "197.234.240.0/22"
      "198.41.128.0/17"
      "162.158.0.0/15"
      "104.16.0.0/13"
      "104.24.0.0/14"
      "172.64.0.0/13"
      "131.0.72.0/22"
      "2400:cb00::/32"
      "2606:4700::/32"
      "2803:f800::/32"
      "2405:b500::/32"
      "2405:8100::/32"
      "2a06:98c0::/29"
      "2c0f:f248::/32"
    ];

    /*
    https://github.com/lord-alfred/ipranges/blob/main/twitter/ipv4_merged.txt
    https://github.com/lord-alfred/ipranges/blob/main/twitter/ipv6_merged.txt
    */
    twitter = [
      "8.25.194.0/23"
      "8.25.196.0/23"
      "64.63.0.0/18"
      "69.12.56.0/21"
      "69.195.160.0/19"
      "103.252.112.0/22"
      "104.244.40.0/21"
      "185.45.4.0/22"
      "188.64.224.0/21"
      "192.44.68.0/23"
      "192.48.236.0/23"
      "192.133.76.0/22"
      "199.16.156.0/22"
      "199.59.148.0/22"
      "199.69.58.0/23"
      "199.96.56.0/21"
      "202.160.128.0/22"
      "209.237.192.0/19"
      "2a04:9d40::/29"
      "2400:6680::/32"
      "2606:1f80::/32"
      "103.252.112.0/23"
      "103.252.114.0/23"
      "104.244.40.0/24"
      "104.244.41.0/24"
      "104.244.42.0/24"
      "104.244.44.0/24"
      "104.244.45.0/24"
      "104.244.46.0/24"
      "104.244.47.0/24"
      "2400:6680:f000::/36"
      "2606:1f80:f000::/36"
      "2a04:9d40:f000::/36"
      "152.199.21.0/24"
    ];
  };
in
  builtins.concatLists (builtins.attrValues ips)
