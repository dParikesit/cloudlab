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

cd ~/zookeeper
git checkout tags/release-3.4.11

echo alias ntfyshort="\"curl "https://ntfy.tester.lol/research?auth=QmVhcmVyIHRrX3QzaDl2ZWV4bHk4cHFvMWxhN3A5b2VlNjhoZjBi" -d \"" >> ~/.bash_aliases

tee -a ~/.bash_aliases > /dev/null <<EOF
ntfy(){
  time_start=\$(date +%s)
  "\$@"
  time_end=\$(date +%s)
  diff=\$((\$time_end-\$time_start))
  curl -u :tk_t3h9veexly8pqo1la7p9oee68hf0b -d "'\$*' finished in \`date -u -d "@\${diff}" +%T\`" https://ntfy.tester.lol/research
}
EOF