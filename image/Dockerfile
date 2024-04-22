FROM alpine
RUN mkdir /appdata
WORKDIR /appdata

RUN apk upgrade
RUN apk add openssh openrc iproute2 tcpdump iperf
RUN mkdir /run/openrc
RUN touch /run/openrc/softlevel
#RUN ssh-keygen -A
RUN addgroup vpn-users
RUN rc-status
RUN rc-update add sshd
COPY sshd_config /etc/ssh/sshd_config
COPY interfaces /etc/network/interfaces
COPY entrypoint.sh /appdata
COPY update_users.sh /appdata

ENTRYPOINT /appdata/entrypoint.sh #&& /bin/sh
