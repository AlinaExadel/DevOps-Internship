FROM ubuntu:16.04

ENV DEVOPS="Alina Tkabladze"


RUN apt-get -y update 
RUN apt-get install -y apache2 
RUN echo "<html><h2>Alina Tkabladze Sandbox 2021!<br>$DEVOPS</h2><html>" > /var/www/html/index.html

CMD ["/usr/sbin/apache2ctl", "-DFOREGROUND"]

EXPOSE 80
