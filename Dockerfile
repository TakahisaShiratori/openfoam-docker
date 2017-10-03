# OpenFOAM 4.1 and ParaView 5.0.1 on ubuntu 14.04
FROM ubuntu:trusty

MAINTAINER Hiroshi.Kobayashi

WORKDIR /root

RUN set -x && \

    # install openfoam
    sudo apt-get -y update && \
    sudo apt-get -y upgrade && \
    sudo apt-get -y install apt-file && \
    sudo apt-get -y install software-properties-common && \
    sudo add-apt-repository http://dl.openfoam.org/ubuntu && \
    sudo apt-get -y install wget && \
    sudo wget -O - http://dl.openfoam.org/gpg.key | apt-key add - && \
    sudo apt-get -y install apt-transport-https && \
    sudo apt-get -y update && \
    sudo apt-get -y install openfoam4 && \
    sudo echo "source /opt/openfoam4/etc/bashrc" >> /root/.bashrc && \

    # install awscli
    sudo curl -O https://bootstrap.pypa.io/get-pip.py && \
    sudo python3 get-pip.py --user && \
    export PATH=/root/.local/bin:$PATH && \
    /bin/bash -c "source /root/.bashrc" && \
    pip install awscli --upgrade --user

ENV AWS_DEFAULT_OUTPUT=json

#ADD https://raw.githubusercontent.com/porcaro33/openfoam-docker/master/openfoam_run.sh /root
ADD openfoam_run.sh /root
ADD U_template /root
RUN sudo chmod +x /root/openfoam_run.sh
#CMD ["/root/openfoam_run.sh"]
