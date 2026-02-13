#!/bin/bash
# Run on Ubuntu amd64 / arm64
sudo apt install build-essential git -y

git clone https://github.com/nebulabox/udp2raw-tunnel.git
cd udp2raw-tunnel
make

