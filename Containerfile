# Use ubi8-init as the base image
FROM registry.access.redhat.com/ubi8/ubi-init

# Set environment variables for commands to run non-interactively
ENV DEBIAN_FRONTEND=noninteractive

# Install the necessary packages
RUN yum update -y && \
    yum install -y \
        git \
        automake \
        gcc \
        openssl \
        openssl-devel \
        vim \
        libnl3-devel \
        lsof \
        httpd \
    && yum clean all \
    && rm -rf /var/cache/yum

# Any additional custom setup can go here
RUN systemctl enable httpd;
RUN echo "Successful Web Server Test" > /var/www/html/index.html
RUN mkdir /etc/systemd/system/httpd.service.d/; echo -e '[Service]\nRestart=always' > /etc/systemd/system/httpd.service.d/httpd.conf
EXPOSE 80

# Command to run when the container starts
CMD ["/sbin/init"]

