FROM alpine

MAINTAINER .BLANK.

RUN apk --no-cache upgrade && \
    apk add --no-cache bash hostapd iptables dhcp docker iproute2 iw openvpn
RUN echo "" > /var/lib/dhcp/dhcpd.leases
ADD ap_configuration.sh /bin/ap_configuration.sh
ADD vpn_configuration.sh /bin/vpn_configuration.sh

ENV ENV=/bin/vpn_configuration.sh

ENTRYPOINT [ "/bin/ap_configuration.sh" ]


