FROM jenkins/jenkins:latest

USER root

# Mise à jours des paquets + openssh-server
RUN apt-get update && apt-get install -y  \
    openssh-server \
    sudo \
    ansible \
    && apt-get clean

RUN echo 'jenkins ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/jenkins
RUN echo 'ansible ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/ansible

RUN chmod -R 777 /var/jenkins_home

RUN useradd -m -s /bin/bash ansible
RUN mkdir -p /home/ansible/.ssh/
COPY classe1 /home/ansible/.ssh/id_rsa
RUN chmod 600 /home/ansible/.ssh/id_rsa && \
    chown -R ansible:ansible /home/ansible/.ssh

USER ansible

WORKDIR /home/ansible

EXPOSE 22