FROM alpine
RUN mkdir /appdata
WORKDIR /appdata

RUN apk upgrade
RUN apk add openssh openrc iproute2 tcpdump iperf
RUN mkdir /run/openrc
RUN touch /run/openrc/softlevel
RUN rc-status
RUN rc-update add sshd
COPY entrypoint.sh /appdata

#ENTRYPOINT /appdata/entrypoint.sh && /bin/sh
ENTRYPOINT /bin/sh
