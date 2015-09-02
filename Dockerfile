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
    nginx

#####
# Install and setup  PIP, uWSGI and virtualenv.
#####

# Install pip
#ADD https://raw.githubusercontent.com/pypa/pip/701a80f451a62aadf4eeb21f371b45424821582b/contrib/get-pip.py /root/get-pip.py
ADD get-pip.py /root/get-pip.py
RUN python3.4 /root/get-pip.py

# Install application requirements
ADD ./requirements.txt /srv/config/requirements.txt
RUN pip3.4 install -r /srv/config/requirements.txt

#####
# Phusion: Clean up APT when done.
#####
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
