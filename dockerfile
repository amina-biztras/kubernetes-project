FROM centos:7.9.2009

MAINTAINER docker

# Fix CentOS 7 repo (since the standard mirrors no longer work)
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*.repo && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*.repo

# Install necessary packages
RUN yum install -y java httpd zip unzip curl && \
    yum clean all

# Download template zip
RUN curl -L -o /tmp/photogenic.zip https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip

# Unzip and move contents to Apache web root
RUN unzip /tmp/photogenic.zip -d /tmp && \
    cp -rvf /tmp/photogenic/* /var/www/html/ && \
    rm -rf /tmp/photogenic /tmp/photogenic.zip

# Expose Apache port
EXPOSE 80

# Start Apache in foreground
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
