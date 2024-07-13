#! /bin/bash

user=`whoami`

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
curl https://mise.run | sh
echo "eval \"\$(${HOME}/.local/bin/mise activate bash)\"" >> ~/.bashrc

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

# echo "alias du='dust -r'" >> ~/.bash_aliases
# echo "alias df='duf'" >> ~/.bash_aliases

# mise use -g cargo:cargo-binstall 
# mise use -g cargo:zellij cargo:dust go:github.com/muesli/duf.git