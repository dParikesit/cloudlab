#! /bin/bash

user=`whoami`

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
curl https://mise.run | sh
echo "eval \"\$(/home/dimas/.local/bin/mise activate bash)\"" >> ~/.bashrc

~/.local/bin/mise settings set experimental true
~/.local/bin/mise -y use -g python@2 go@latest

~/.local/bin/mise use -g cargo:cargo-binstall

# ~/.local/bin/mise -y use -g java@temurin-8 maven@3 ant@latest

git config --global credential.helper 'store'
# git -C ~ clone https://github.com/apache/zookeeper.git
git -C ~ clone https://github.com/dParikesit/zookeeper.git
git -C ~ clone https://github.com/apache/cassandra.git
git -C ~ clone https://github.com/apache/hadoop.git
git -C ~ clone https://github.com/apache/hbase.git

cd ~/zookeeper
git checkout newbug

# mise use -g cargo:cargo-binstall
~/.local/bin/mise use -g cargo:zellij cargo:dust go:github.com/muesli/duf.git
echo "alias du='dust -r'" >> ~/.bash_aliases
echo "alias df='duf'" >> ~/.bash_aliases