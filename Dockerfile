FROM ubuntu:trusty

MAINTAINER felipegaiacharly@gmail.com

RUN sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0x5a16e7281be7a449
RUN apt-get update && apt-get install -y software-properties-common nginx apache2 supervisor
RUN mkdir -p  /var/run/nginx /var/run/hhvm /var/log/supervisor
RUN sudo add-apt-repository "deb http://dl.hhvm.com/ubuntu $(lsb_release -sc) main"
RUN sudo apt-get update && sudo apt-get install hhvm -y
RUN sudo update-rc.d hhvm defaults

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

COPY ./nginx-conf/default       /etc/nginx/sites-available
COPY ./nginx-conf/nginx.conf    /etc/nginx/

EXPOSE 80

CMD ["/usr/bin/supervisord"]

