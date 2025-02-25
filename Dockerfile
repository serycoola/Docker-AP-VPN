FROM alpine:3.19

MAINTAINER .BLANK.

RUN apk --no-cache upgrade && \
    apk add --no-cache bash hostapd iptables dhcp docker iproute2 iw openvpn
RUN echo "" > /var/lib/dhcp/dhcpd.leases
ADD ap_configuration.sh /bin/ap_configuration.sh
ADD vpn_configuration.sh /bin/vpn_configuration.sh

CMD /bin/ap_configuration.sh & /bin/vpn_configuration.sh


