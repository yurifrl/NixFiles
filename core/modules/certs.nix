{ pkgs, lib, fetchurl, ... }:

with import <nixpkgs> {};
with builtins;
with lib;
let
  #
  cert = builtins.fetchurl {
    url = "https://s3.amazonaws.com/dft-live-us-east-1-ca-root-certificates/dafiti_local.crt";
    sha256 = "16szqqvzfc146sc1ifa2w6i384bqmq1az7fi52wcg3xrk727sjx5";
  };
in {
  environment = {
    etc = {
      "ssl/certs/dafiti_local.crt".source = cert;
    };
  };
}
