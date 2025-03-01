# Docker container stack: hostapd + dhcp server + VPN 

## OPENVPN - new addition!

This container starts wireless access point (hostap) and dhcp server in docker
container. It supports both host networking and network interface reattaching
to container network namespace modes (host and guest).


THIS IS A MODIFIED VERSION OF docker-ap. It sets up OpenVPN and passes the VPN
connection through the hotspot. For the hotspot, the environment variables stay
the same, except that OUTGOINGS is set by default to "tun0".

For OpenVPN, it looks by default for configurations in /ovpn and loads any file
that ends in .ovpn.

## Environment variables for VPN:
* **VPN_PATH**: Path where you added the config files. Default is /ovpn
* **CONFIG**: Partial or full name of the config you want to load, just
              enough info to filter out a single file in the folder.

## NOTE: this container is not set up to accept username and password as an input.
You must create a file containing the username and password and modify your .ovpn
file in order to look for that file and load the credentials automatically.
More info can be found here: https://forums.openvpn.net/viewtopic.php?t=11342


## HOTSPOT

On the host system install required wifi drivers, then make sure your wifi adapter
supports AP mode:

```
# iw list
...
        Supported interface modes:
                 * IBSS
                 * managed
                 * AP
                 * AP/VLAN
                 * WDS
                 * monitor
                 * mesh point
...
```

Set country regulations, for example, for Spain set:

```
# iw reg set ES
country ES: DFS-ETSI
        (2400 - 2483 @ 40), (N/A, 20), (N/A)
        (5150 - 5250 @ 80), (N/A, 23), (N/A), NO-OUTDOOR
        (5250 - 5350 @ 80), (N/A, 20), (0 ms), NO-OUTDOOR, DFS
        (5470 - 5725 @ 160), (N/A, 26), (0 ms), DFS
        (57000 - 66000 @ 2160), (N/A, 40), (N/A)
```

## Build / run

* Using host networking:

```
sudo docker run -i -t -e INTERFACE=wlan1 -e OUTGOINGS=wlan0 --net host --privileged won10/hostapd
```

* Using network interface reattaching:

```
sudo docker run -d -t -e INTERFACE=wlan0 -v /var/run/docker.sock:/var/run/docker.sock --privileged offlinehacker/docker-ap
```

This mode requires access to docker socket, so it can run a short lived
container that reattaches network interface to network namespace of this
container. It also renames wifi interface to **wlan0**, so you get
deterministic networking environment. This mode can be usefull for example for
pentesting, where can you use docker compose to run other wifi hacking tools
and have deterministic environment with wifi interface.

## Environment variables

* **INTERFACE**: name of the interface to use for wifi access point (default: wlan0)
* **OUTGOINGS**: outgoing network interface (default: eth0)
* **CHANNEL**: WIFI channel (default: 6)
* **SUBNET**: Network subnet (default: 192.168.254.0)
* **AP_ADDR**: Access point address (default: 192.168.254.1)
* **SSID**: Access point SSID (default: docker-ap)
* **WPA_PASSPHRASE**: WPA password (default: passw0rd)
* **HW_MODE**: WIFI mode to use (default: g) 
* **DRIVER**: WIFI driver to use (default: nl80211)
* **HT_CAPAB**: WIFI HT capabilities for 802.11n (default: [HT40-][SHORT-GI-20][SHORT-GI-40]) 
* **MODE**: Mode to run in guest/host (default: host)

## License

MIT

## Author

Jaka Hudoklin <jakahudoklin@gmail.com>

Thanks to https://github.com/sdelrio/rpi-hostap for providing original
implementation.
