#!/bin/bash -e

# Default path for OpenVPN configs
true ${VPN_PATH:="/ovpn"}
# Set path for OpenVPN configs.
vpn_path=${VPN_PATH}

# Change directory to working path (in order to avoid OpenVPN looking for credentials in /)
cd "$vpn_path"

# Default config to load
true ${CONFIG:=".ovpn"}
# Partial or full name of the config you want to load, just enough info to be able to identify a single file in the folder when using *
config=${CONFIG} 

# Connect to VPN
openvpn --auth-nocache --config *"$config"*


