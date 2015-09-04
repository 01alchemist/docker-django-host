FROM phusion/baseimage:0.9.16
MAINTAINER 01 Alchemist "01@01alchemist.com"


#####
# Install packages
#####
RUN apt-get update
RUN apt-get install -y \
    python3.4-dev \
    libmysqlclient-dev \
    python-setuptools \
    nginx \
    libaio1 \
    alien

ADD ./packages/oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64.rpm /opt/packages/oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64.rpm
ADD ./packages/oracle-instantclient12.1-sqlplus-12.1.0.2.0-1.x86_64.rpm /opt/packages/oracle-instantclient12.1-sqlplus-12.1.0.2.0-1.x86_64.rpm
ADD ./packages/oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm /opt/packages/oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm

RUN alien -i /opt/packages/oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64.rpm
RUN alien -i /opt/packages/oracle-instantclient12.1-sqlplus-12.1.0.2.0-1.x86_64.rpm
RUN alien -i /opt/packages/oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm

ADD ./docker/config/oracle.sh /etc/profile.d/oracle.sh
ADD ./docker/config/oracle.conf /etc/ld.so.conf.d/oracle.conf
RUN ldconfig

#####
# Install and setup  PIP, uWSGI and virtualenv.
#####

# Install pip
#ADD https://raw.githubusercontent.com/pypa/pip/701a80f451a62aadf4eeb21f371b45424821582b/contrib/get-pip.py /opt/python/get-pip.py
ADD get-pip.py /opt/python/get-pip.py
RUN python3.4 /opt/python/get-pip.py
RUN pip install --upgrade pip

# Install application requirements
ADD ./requirements.txt /opt/config/requirements.txt
RUN pip3.4 install -r /opt/config/requirements.txt

#####
# Phusion: Clean up APT when done.
#####
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
