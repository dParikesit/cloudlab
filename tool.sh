#! /bin/bash

user=`whoami`

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
curl https://mise.run | sh
echo "eval \"\$(/users/$user/.local/bin/mise activate bash)\"" >> ~/.bashrc

~/.local/bin/mise settings set experimental true
~/.local/bin/mise -y use -g java@temurin-8 maven@3 ant@latest python@2 cargo:cargo-binstall
exit

# ~/.local/bin/mise -y use -g cargo:cargo-binstall
# ~/.local/bin/mise -y use -g cargo:zellij