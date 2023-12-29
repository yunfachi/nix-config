{
  description = "";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";

    nixpkgs-yunfachi = {
      url = "github:yunfachi/nixpkgs-yunfachi";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    xdph = {
      url = "github:hyprwm/xdg-desktop-portal-hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-yunfachi,
    pre-commit-hooks,
    ...
  }: let
    constants = import ./constants.nix;

    system = "x86_64-linux";

    specialArgs =
      rec {
        inherit inputs self;
        inherit system;

        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        pkgs-yunfachi = import nixpkgs-yunfachi {inherit nixpkgs system;};

        umport = pkgs-yunfachi.umport;
        sops-decrypt = path:
          pkgs-yunfachi.sops-decrypt {
            inherit path;
            publicAge = "age1pq18z8lvyzwzxqa0jgt8lxwxhfxdwdc4m2mpzawzwngpxwp2lwrf7fwql0al0ss7f0ezj6dzt8lely92uv6h3srfevf26sfrlzla56qnj54xla7fr7mp94jwfad3lud9eyw84ewx4wk4jr4dve7g5sw90j35gd39073ce5wav3mda5s2hxeh6hde867heng4837ue3xj42tmtesvl0nhdhk454ua9ywyjkqyhprew835zp26u3xj0dzznefk2fju82zgedam8vmnurlakvzprh4n40x4luw724e39eze2r2z3dtewa5apdn54s7t42ywpmyz4rxknl3uer3jp6vssfrn5z0wc2v9336rfhprftxf8pjlmnh5dltf7kflh6r95swpcshcafcwad8dhmsy3v3w3tt88vcsfdgenlqkptsa57009n63r34fwfqs7jwpcqce3sndwy3acds8kzrhka7psdlv0svxreclh62afq3rg5z5tcgpzfkls47tj7un6lq089h5nkfur3l0uuzpc6tqgustjtpmudmd7e7vjkcgyc9sngj9gh08802us8e35nql26whvyyjahgj3fgxlwazd2jtv9y8cgph0ft9zpwna5s988z7c9ylnvguzg0prxzh3n3rk8phdjhgjvpfqxxr5svapadzz2hwx9t9zddfzmjhykaxsvgsyj6vwjhm5f38fd3kheq9y2taj5a438malfpta98vfd8el73czajchky47n6nl70t7js5n5c5kh68d0vjuuqf70k2yp47jjr3e3tn907v0lp53azh0wrd98avlasdvnrwvpch5gghkgpxqhxdx5z3ex40l3s35y380pygt87zplssr26me9le9mjagatn2fwu6qgqrz7zpzaymv4w5rms9dagjn6kzn8vrnr7wv430phyze7avzahka3fmefj5r5zt25qwxc7j6zy3wdjpm5smruudf0tf68zaf0atp36l4ncylaurqxsljprewdul0fuft5vkvvvwvu5jgdw4ukeslk4hd03tkqzpvtgkldfzqnlqjhxxuwcalrgxcv7f74d4dnqtm3s6smyawqhxegmayhr9zez9vhakukmh3jlsl08ftz6tajmlffnkua50x8tx68wcmyzy72m4csntj9pvdtl3cmxs603htxxzhp7xun9nndmtjzqxzp6fdkqu2m9zz7pjz52agew5ycytju8x764af8nx2jmuz7uenwhku62y76a08xvwknygmsmfftsn7arth6ldntamzfhvfm0aympld2p9p7cnhzsemkwkazc4s6xj43preg7r47hn09zmp87cpqkhkxuryqgacl7nzpuw6lr3c7t84l8tgq28vulj299yl2zk5lfp93raejfxczkx29f424d7ezwxny8x9qq83tcav7xrretnqrqazva8ah6rs5wxrjn2k7n0xj9lls7gj9kmpm4qpghmzs3w23242mf4m9mcl8wazjsw62d4z0gn3rpdw50vkq6sqjgeffv4ge9zglz5r7g7028qj03d0x0m8209vhzg8ftl66998m9x9mcwkh7sgpkj6kqmn5ct3daeuhl7fy59tm4jynr9yqg46jhx5qk8ydjd6ch94xsnsjwuc58fkprm6smk5sns85qq0zgalmrunl8kffmqzku3k5qw5uwju27g9k7vunfw0ld4m7w8547hcx93fc42dq42tl2w4hlc2mzx5tmwjrhec0twk6lj57m9fty3r6efgjzku3a8kjwgp74xqxycgfyfl69xvp2gt9le3x7mjq4mm5pqd40fhrxrl8djpcuqz4qfj2dlumj7s8wp6vykqvc5f3kvwdv3cak4dm0cky3gncqlncwqzqweqhwspeh0azrulyhp5v89wpf6vlqwncwp0h45jwp828mm7gxy79crn2y6vpy3karvz98pfxc99vml63vyszutk9m39740k9664mttx7cn3l2";
            privateAgeFile = /home/${constants.username}/.config/sops/age/keys.txt;
          };
      }
      // constants;

    eachSystem = object: (nixpkgs.lib.genAttrs [system] object);
  in {
    nixosConfigurations = import ./hosts (
      {inherit specialArgs;} // {isNixOS = true;}
    );

    homeConfigurations = import ./hosts (
      {inherit specialArgs;} // {isNixOS = false;}
    );

    checks = eachSystem (system: {
      pre-commit-check = pre-commit-hooks.lib.${system}.run {
        src = ./.;
        hooks = {
          alejandra.enable = true;
          statix = {
            enable = true;
            excludes = [".lock"];
          };
          prettier = {
            enable = false;
            excludes = [".md"];
          };
        };
      };
    });
  };
}
