#! /bin/bash

user=`whoami`

curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

# remove /etc/bash.bashrc

# nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz home-manager
# nix-channel --update

# nix run home-manager/release-24.05 -- init --switch


# ~/.local/bin/mise -y use -g java@temurin-8 maven@3 ant@latest

git config --global credential.helper 'store'
# git -C ~ clone https://github.com/apache/zookeeper.git
git -C ~ clone https://github.com/dParikesit/zookeeper.git
git -C ~ clone https://github.com/apache/cassandra.git
git -C ~ clone https://github.com/apache/hadoop.git
git -C ~ clone https://github.com/apache/hbase.git

cd ~/zookeeper
git checkout newbug

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