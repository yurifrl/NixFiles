{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  version = "1.14.0";
  name = "kubefwd";
  owner = "txn2";
  src = fetchurl {
    url = "https://github.com/${owner}/${name}/releases/download/${version}/${name}_linux_amd64.tar.gz";
    sha256 = "0h1bqqgkj1vc542kbcxsh4p6c2d34q24lxkb1rg9qvxamqqa00pj";
  };

  sourceRoot = ".";

  installPhase = ''
    install -Dm755 $name -t "$out/bin"
  '';

  meta = with stdenv.lib; {
      description = "";
      homepage = "";
      maintainers = with maintainers; [ yurifrl ];
      license = licenses.gpl2;
      platforms = platforms.linux;
  };
}
