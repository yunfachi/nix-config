{
  option-functions,
  host,
  ...
}:
with option-functions;
  option "programs" "wpaperd" {
    enable = enableOption "wpaperd" host.isDesktop;
    wallpapers =
      listOption "wallpapers" [
        {
          url = "https://w.wallhaven.cc/full/qd/wallhaven-qdxpjd.jpg";
          hash = "sha256-BjtBgoSROvnwMAPd9tx7v4Cw/VaVtWxISvWZnIYjH/o=";
        }
        {
          url = "https://w.wallhaven.cc/full/qd/wallhaven-qdqdzr.png";
          hash = "sha256-MqftVWnDcSN78el1Ky3tbBXkMOMNEVk3k5fG1xSjU2g=";
        }
        {
          url = "https://w.wallhaven.cc/full/pk/wallhaven-pkeg53.jpg";
          hash = "sha256-I1FAUkDe3fswwm2VYICK4V6GoHI0fkLEbzwgcJXJWi8=";
        }
        {
          url = "https://w.wallhaven.cc/full/1p/wallhaven-1pdwow.jpg";
          hash = "sha256-WvJYjml+47/ktEq7caXiKkQZKE29d+JwpWJFNkGa2HE=";
        }
        {
          url = "https://w.wallhaven.cc/full/x6/wallhaven-x65x6d.jpg";
          hash = "sha256-2/GgpniFTbUBsBC8sBqkeoYErwLagcgTA/NNvgqI1/c=";
        }
        {
          url = "https://w.wallhaven.cc/full/x1/wallhaven-x1rkev.jpg";
          hash = "sha256-hgXYheeDjWuDIvyF1DWYKiysd77NJyX8Qfn53/6tbbE=";
        }
        {
          url = "https://w.wallhaven.cc/full/ym/wallhaven-ymm6kl.png";
          hash = "sha256-rVYSgxkTY2Nu36mb+Wgd0L0izyTNQ1RGcvpudHzgmAM=";
        }
        {
          url = "https://w.wallhaven.cc/full/gj/wallhaven-gjooee.jpg";
          hash = "sha256-msx7Id2OD889lBeLEIkdYOYK3K77yDp88axCXBM+Fac=";
        }
      ]
      (submoduleOption {
        url = textOption "wallpaper url" null;
        hash = textOption "wallpaper hash" "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
      });
  }
