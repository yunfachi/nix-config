{flatpak, ...}: {
  services.flatpak = {
    enableModule = true;
    packages = [
      #"flathub:runtime/org.freedesktop.Platform.VulkanLayer.MangoHud//21.08:9ee91f5c7944516169bb7a327d81ac7b08b149b3cd238b7a11a61bc1abe28ba9"
      "flathub:app/io.github.vinegarhq.Vinegar//master"
    ];
    remotes = {
      "flathub" = "https://flathub.org/repo/flathub.flatpakrepo";
    };
  };
}
