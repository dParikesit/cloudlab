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

sudo apt install -y openjdk-8-jdk openjdk-8-dbg

sudo sh -c 'echo 1 > /proc/sys/kernel/perf_event_paranoid'
sudo sh -c 'echo 0 > /proc/sys/kernel/kptr_restrict'

wget https://dlcdn.apache.org/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.tar.gz
wget https://dlcdn.apache.org//ant/binaries/apache-ant-1.10.14-bin.tar.gz
tar xzvf apache-maven-3.9.6-bin.tar.gz
tar xzvf apache-ant-1.10.14-bin.tar.gz
sudo mv apache-maven-3.9.6 /opt
sudo mv apache-ant-1.10.14 /opt

sudo mkdir -p /etc/profile.d
sudo touch /etc/profile.d/java.sh
echo "PATH=$PATH:/opt/apache-maven-3.9.6/bin:/opt/apache-ant-1.10.14/bin" | sudo dd of=/etc/profile.d/java.sh oflag=append conv=notrunc
echo "JAVA_HOME=$(dirname $(dirname $(readlink -f $(which javac))))" | sudo dd of=/etc/profile.d/java.sh oflag=append conv=notrunc
echo "ANT_HOME=/opt/apache-ant-1.10.14"

# sudo apt install fzf -y

# git clone https://github.com/eth-p/bat-extras.git
# cd bat-extras
# ./build.sh --install

