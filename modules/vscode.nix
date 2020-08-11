{ config, pkgs, ... }:

let
  mktplaceExt = [
    {
      name = "vscode-fish";
      publisher = "bmalehorn";
      version = "1.0.16";
      sha256 = "1fgz3fs4r8ilv2cqdw875isx9rqy8rssianxd6r4bmvxxz66ygar";
    }
    {
      name = "nixfmt-vscode";
      publisher = "brettm12345";
      version = "0.0.1";
      sha256 = "07w35c69vk1l6vipnq3qfack36qcszqxn8j3v332bl0w6m02aa7k";
    }
    {
      name = "i3";
      publisher = "dcasella";
      version = "0.0.1";
      sha256 = "0lv6slag3lc3idkkq9lllbyvm55p1b52dmrrysr922sf06gm0z9j";
    }
    {
      name = "ghcide";
      publisher = "DigitalAssetHoldingsLLC";
      version = "0.0.2";
      sha256 = "02gla0g11qcgd6sjvkiazzk3fq104b38skqrs6hvxcv2fzvm9zwf";
    }
    {
      name = "go";
      publisher = "golang";
      version = "0.15.1";
      sha256 = "1h7r781asl890n9fc0dh81l4ffx8xqd81d4hy2680dji8x390axz";
    }
    {
      name = "language-haskell";
      publisher = "justusadam";
      version = "3.3.0";
      sha256 = "1285bs89d7hqn8h8jyxww7712070zw2ccrgy6aswd39arscniffs";
    }
    {
      name = "cpp-costarter";
      publisher = "madopew";
      version = "0.1.1";
      sha256 = "1iylv69l8230w8mgbwim2aval8ax00x8klbl4sv4w4qmp4h1a6w4";
    }
    {
      name = "vscode-elixir";
      publisher = "mjmcloug";
      version = "1.1.0";
      sha256 = "0kj7wlhapkkikn1md8cknrffrimk0g0dbbhavasys6k3k7pk2khh";
    }
    {
      name = "vscode-docker";
      publisher = "ms-azuretools";
      version = "1.3.1";
      sha256 = "17q4727ah129hxdvrw1x0fcki7hidphmlnznxx7xvylcw937h6ch";
    }
    {
      name = "vsliveshare";
      publisher = "ms-vsliveshare";
      version = "1.0.2427";
      sha256 = "0nin085zw3f5swwd9bznvxg4i7gkbpgv6pjbhsf5iy2k5plc0bk9";
    }
    {
      name = "platformio-ide";
      publisher = "platformio";
      version = "1.10.0";
      sha256 = "1df37q5xcnwdcxxahrxhwr8h2wg42sd0kjl54v1hnrgjdg0c5nqw";
    }
    {
      name = "vscode-arduino";
      publisher = "vsciot-vscode";
      version = "0.3.1";
      sha256 = "0j7kzalhmnmqxgnsij64jkw97z3wwh3qx3j7rq5za9zfsa61jczs";
    }
    {
      name = "java";
      publisher = "redhat";
      version = "0.64.1";
      sha256 = "00z81j8rk2zbnwkl227wvfz7a4df7443zjlqbi9vh6ik71z9nwf1";
    }
    {
      name = "vscode-gradle";
      publisher = "richardwillis";
      version = "3.3.0";
      sha256 = "165031mfdqg9pkczz66l32yd37440sy2d3wx8p7rxnmxacybxp53";
    }
    {
      name = "scala";
      publisher = "scala-lang";
      version = "0.4.1";
      sha256 = "0wqc2m3psi2v853pfhd71y6wxv89b9hgy2v7j5hwrs0v901j0gi1";
    }
    {
      name = "metals";
      publisher = "scalameta";
      version = "1.9.1";
      sha256 = "0zs8lyyr8783zmg8pjv39xlw9rns70wmisn7f9aql7p375a6fipw";
    }
    {
      name = "trailing-spaces";
      publisher = "shardulm94";
      version = "0.3.1";
      sha256 = "0h30zmg5rq7cv7kjdr5yzqkkc1bs20d72yz9rjqag32gwf46s8b8";
    }
    {
      name = "vscodeintellicode";
      publisher = "VisualStudioExptTeam";
      version = "1.2.9";
      sha256 = "1ll61fqfcc0yygfk8hg72sx838649lj2qafclnrx11ai9248gb64";
    }
    {
      name = "vscode-java-debug";
      publisher = "vscjava";
      version = "0.26.0";
      sha256 = "1vymb8ivnv05jarjm2l03s9wsqmakgsrlvf3s3d43jd3ydpi2jfy";
    }
    {
      name = "vscode-java-dependency";
      publisher = "vscjava";
      version = "0.10.2";
      sha256 = "0g40vqs3qlkxhyvakzwn5dc8xsh138cx0aj4abs2csq9np1c0jaa";
    }
    {
      name = "vscode-java-pack";
      publisher = "vscjava";
      version = "0.9.1";
      sha256 = "14b65bpgy8r2qm6fr06ph81qpv69yxdxpgx1lbg6xfhf0rp9mafw";
    }
    {
      name = "vscode-java-test";
      publisher = "vscjava";
      version = "0.23.0";
      sha256 = "0j74hl7zcr77vhz4nik4idh2j4p556rfdinrxpji2hai7kk47zrm";
    }
    {
      name = "vscode-maven";
      publisher = "vscjava";
      version = "0.22.0";
      sha256 = "0fzh9m867kn6cc5d2vmmwq23vhlr80jazs01b8cxgpkipl1w3v4j";
    }
  ];

  extensions = (with pkgs.vscode-extensions; [
    ms-vscode.cpptools
    bbenoist.Nix
  ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace mktplaceExt;

  vscode-with-extensions = pkgs.vscode-with-extensions.override {
    vscodeExtensions = extensions;
  };
in {
  # nix-prefetch-url https://vsciot-vscode.gallery.vsassets.io/_apis/public/gallery/publisher/vsciot-vscode/extension/vscode-arduino/0.3.1/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage

  environment.systemPackages = [
    # unstable.vscode
    vscode-with-extensions
  ];
}
