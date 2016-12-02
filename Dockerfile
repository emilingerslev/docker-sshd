FROM ubuntu:16.04

RUN apt-get update && apt-get install -y openssh-server curl
RUN mkdir /var/run/sshd

RUN sed -i 's/\#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

COPY start.sh /root/

EXPOSE 22
CMD ["/root/start.sh"]
