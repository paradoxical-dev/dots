{ pkgs }:

pkgs.python311Packages.withPackages (pythonPackages: with pythonPackages; [
    (pkgs.python311Packages.buildPythonPackage rec {
      pname = "open-webui";
      version = "latest";

      src = pkgs.fetchPypi {
        inherit pname version;
        sha256 = "6d37f1ca71de29fa447f207c4a36e22eed25e2ae8d0b970ca8f6a2cfa0980fb1";
      };

      doCheck = false;
    })
])
