#!/bin/sh
# container-git-clone/container-git-clone-profile.sh

vi-my-sh() {
    if [ -f "/etc/profile.d/container-git-clone-profile.sh" ]; then
        vi /etc/profile.d/container-git-clone-profile.sh
    else
        echo "err:"
    fi
}

my-sh-reload() {
    if [ -f "/etc/profile.d/container-git-clone-profile.sh" ]; then
        . /etc/profile.d/container-git-clone-profile.sh
    else
        echo "err:"
    fi
}

cd-project() {
    if [ -d "/home/project" ]; then
        cd /home/project
    else
        ls /home
    fi
}

cd-ncc() {
    if [ -d "/home/project/packages-ncc" ]; then
        cd /home/project/packages-ncc
    else
        cd-project
    fi
}

if [ -d "/home/project/packages-ncc" ]; then
    cd-ncc
fi

git-clone-packages-ncc() {
    cd-project
    git clone git@github.com:hungthuan-nguyenchicong1502/packages-ncc.git
}

git-pull-ncc() {
    cd-ncc
    git pull
}