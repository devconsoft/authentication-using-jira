FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

# Apache ENVs
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2/apache2.pid
ENV APACHE_SERVER_NAME localhost

LABEL description="Apache2.4 on Ubuntu 18.04 with Single Sign-On integration with Atlassian Crowd/JIRA."

EXPOSE 80

RUN \
apt-get update && \
apt-get --yes -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" \
    install \
        apache2 \
        libapache2-mod-svn \
        libcurl3-gnutls \
        curl

COPY apache2.conf /etc/apache2/apache2.conf

COPY build/libapache2-mod-auth-crowd.deb /

RUN dpkg -i /libapache2-mod-auth-crowd.deb

COPY certs/* /usr/local/share/ca-certificates/
RUN update-ca-certificates

# Launch Apache
CMD ["/usr/sbin/apache2ctl", "-DFOREGROUND"]
