FROM debian:buster
MAINTAINER BIND 9 Developers <bind9-dev@isc.org>

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8

ARG DEB_VERSION=1:9.11.5.P4+dfsg-5.1+deb10u8

# Install add-apt-repository command
RUN apt-get -qqqy update
RUN apt-get -qqqy dist-upgrade
RUN apt-get -qqqy install --no-install-recommends apt-utils software-properties-common dctrl-tools gpg-agent
RUN apt-get -qqqy install bind9=$DEB_VERSION bind9utils=$DEB_VERSION

# Now remove the pkexec that got pulled as dependency to software-properties-common
RUN apt-get --purge -y autoremove policykit-1

RUN mkdir -p /etc/bind && chown root:root /etc/bind/ && chmod 755 /etc/bind
RUN mkdir -p /var/cache/bind && chown root:root /var/cache/bind && chmod 755 /var/cache/bind
RUN mkdir -p /var/lib/bind && chown root:root /var/lib/bind && chmod 755 /var/lib/bind
RUN mkdir -p /var/log/bind && chown root:root /var/log/bind && chmod 755 /var/log/bind
RUN mkdir -p /run/named && chown root:root /run/named && chmod 755 /run/named

VOLUME ["/etc/bind", "/var/cache/bind", "/var/lib/bind", "/var/log"]

EXPOSE 53/udp 53/tcp 953/tcp

CMD ["/usr/sbin/named", "-f", "-c", "/etc/bind/named.conf"]