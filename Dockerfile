FROM alpine

MAINTAINER .BLANK.

RUN apk --no-cache upgrade && \
    apk add --no-cache bash hostapd iptables dhcp docker iproute2 iw openvpn
RUN echo "" > /var/lib/dhcp/dhcpd.leases
ADD wlanstart.sh /bin/wlanstart.sh
ADD vpnconnect.sh /bin/vpnconnect.sh

ENTRYPOINT [ "/bin/wlanstart.sh" ]
ENTRYPOINT [ "/bin/vpnconnect.sh" ]


