# A Maven environement
FROM ubuntu:18.04
MAINTAINER Tarek Ben Soltane
# Install Flask app dependencies.
RUN useradd -ms /bin/bash jenkins
USER root
WORKDIR /home/jenkins
RUN apt-get update
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:prapajas' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
RUN apt-get install -y python-pip
RUN apt-get install -y git
RUN apt-get install -y openjdk-8-jdk
RUN apt-get install -y maven
# Install playbook and run it.
#COPY playbook.yml /etc/ansible/playbook.yml
#COPY index.py.j2 /etc/ansible/index.py.j2
#COPY templates /etc/ansible/templates
#RUN mkdir -m 755 /opt/www
#RUN ansible-playbook /etc/ansible/playbook.yml --connection=local
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

