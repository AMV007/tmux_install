#!/bin/bash
#because tmux creator don't want add correct version to github sources of tmux
#this script detecting latest release version of tmux
#and building tmux sources with correct version
#so you will know version ot tmux if locally compiling and installing it

sudo apt update
sudo apt install -y git automake build-essential pkg-config libevent-dev libncurses5-dev

sudo apt purge -y tmux

rm -fr /tmp/tmux
git clone https://github.com/tmux/tmux.git /tmp/tmux
cd /tmp/tmux
# swtiching to tatest tag, because master tmux not supporting versioning
LATEST_TAG=$(git describe --tags)
git checkout ${LATEST_TAG}
#git checkout $(git describe --tags)
sh autogen.sh
./configure 
sed -i "s/master/${LATEST_TAG}-master/g" Makefile
make -j4
sudo make uninstall
sudo make install
cd -
rm -fr /tmp/tmux
