#! /bin/bash

user=`whoami`

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
curl https://mise.run | sh
echo "eval \"\$(/users/$user/.local/bin/mise activate bash)\"" >> ~/.bashrc

~/.local/bin/mise settings set experimental true
~/.local/bin/mise -y use -g java@temurin-8 maven@3 ant@latest
~/.local/bin/mise -y use -g python@2

git config --global credential.helper 'store'
git -C ~ clone https://github.com/apache/zookeeper.git
git -C ~ clone https://github.com/apache/cassandra.git
git -C ~ clone https://github.com/apache/hadoop.git
git -C ~ clone https://github.com/apache/hbase.git
exit

# mise use -g cargo:cargo-binstall
# mise use -g cargo:zellij