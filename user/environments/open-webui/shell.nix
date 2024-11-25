{ pkgs }:
pkgs.mkShell {
  buildInputs = [
    pkgs.python311
    pkgs.python311Packages.pip
    pkgs.python311Packages.onnxruntime
  ];
  shellHook = ''
  if [ ! -d "venv" ]; then
    echo "Creating and activating virtual environment"
    python3 -m venv venv
    source venv/bin/activate
  else
    echo "Activating virtual environment"
    source venv/bin/activate
  fi
  '';
}
