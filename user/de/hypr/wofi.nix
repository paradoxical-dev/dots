{ config, pkgs, ... }:
{
  programs.wofi = {
    enable = true;
    settings = {
      allow_markup = true;
      allow_images = true;
      term = "${pkgs.kitty}/bin/kitty";
      prompt = "where we droppin...";
    };
    style = ''
window {
  font-family: "JetBrains Mono";
  margin: 0px;
  border: 1px solid rgba(0, 0, 0, 0.9);
  background-color: rgba(221, 221, 221, 0.95);
  border-radius: 10px;
}

#input {
  margin: 5px;
  border: 1px solid rgba(0, 0, 0, 0.9);
  color: #000000;
  background-color: rgba(243, 244, 241, 0.95);
  font-family: "Victor Mono";
  font-style: italic;
}

#inner-box {
  margin: 5px;
  border: none;
  background-color: transparent;
}

#outer-box {
  margin: 5px;
  border: none;
  background-color: transparent;
}

#scroll {
  margin: 0px;
  border: none;
}

#text {
  margin: 5px;
  border: none;
  color: #656565;
}

#entry {
  border: none;
}

#entry:focus {
  border: none;
}

#entry:selected {
  background-color: rgba(243, 244, 241, 0.95);
  border-radius: 5px;
  border: 1px solid rgba(0, 0, 0, 0.9);
  color: #656565
}
    '';
  };
}
