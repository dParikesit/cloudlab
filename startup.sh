#!/bin/bash

user=`whoami`

# Test if startup service has run before.
if [ -f /local/startup_service_done ]; then
    # Configurations that need to be (re)done after each reboot

    # Sometimes (e.g. after each experiment extension) the CloudLab management
    # software will replace our authorized_keys settings; restore our settings
    # automatically after reboot.
    if [ "$user" = "root" ]; then
        ssh_dir=/root/.ssh
    else
        ssh_dir=/users/$user/.ssh
    fi

    if [ -f $ssh_dir/authorized_keys.old ]; then
        mv $ssh_dir/authorized_keys.old $ssh_dir/authorized_keys
    fi

    exit 0
fi

sudo apt update && sudo apt upgrade -y
sudo apt install build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev curl libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev -y

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
curl https://mise.run | sh
echo "eval \"\$(/users/$user/.local/bin/mise activate bash)\"" >> ~/.bashrc

/users/$user/.local/bin/mise activate bash
mise settings set experimental true
mise use -g java@temurin-8 maven@3 ant@latest python@2 cargo:cargo-binstall
mise use -g cargo:zellij