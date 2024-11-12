#! /bin/bash

user=`whoami`

curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix > nix-installer.sh
chmod +x nix-installer.sh
./nix-installer.sh install --no-confirm

rm ./nix-installer.sh
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

curl https://mise.run | sh
echo 'eval "$(~/.local/bin/mise activate bash)"' >> ~/.bashrc

curl https://sh.rustup.rs -sSf | sh -s -- -y

# remove /etc/bash.bashrc

git -C ~ clone https://github.com/dParikesit/dotfiles.git
nix run home-manager/release-24.05 -- init --switch ~/dotfiles/cloudlab
home-manager switch --flake ~/dotfiles/cloudlab/


# ~/.local/bin/mise -y use -g java@temurin-8 maven@3 ant@latest

sudo git config --global credential.helper store
git -C ~ clone https://github.com/apache/zookeeper.git
# git -C ~ clone https://github.com/dParikesit/zookeeper.git
git -C ~ clone https://github.com/apache/cassandra.git
git -C ~ clone https://github.com/apache/hadoop.git
git -C ~ clone https://github.com/apache/hbase.git

git -C ~ clone https://github.com/OrderLab/OKLib.git

cd ~/zookeeper
git checkout tags/release-3.4.11

cd ~/cassandra
git checkout tags/cassandra-3.11.5

cd ~/hadoop
git checkout tags/rel/release-3.2.2

cd ~/hbase
git checkout tags/rel/2.4.0

tee -a ~/.bash_aliases > /dev/null <<EOF
ntfy(){
  curl -u :tk_ue81cput60a99oxonvysoue9rvkdb -d "$(hostname) '$@'" https://ntfy.tester.lol/research
}
EOF