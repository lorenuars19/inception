
FROM debian:buster

# install NGINX from the official repository
RUN apt-get -y update && apt-get -y install nginx openssl zsh

# Generate Self-signed certificates with openssl
RUN mkdir -p /nginx/ && mkdir -p /etc/nginx/ssl \
&& openssl req -x509 -subj="/C=BE/ST=Brussels/L=s19/O=19/CN=s19" -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/self.key -out /etc/nginx/ssl/self.csr \
&& openssl x509 -days 365 -in /etc/nginx/ssl/self.csr -signkey /etc/nginx/ssl/self.key -out /etc/nginx/ssl/self.crt

COPY ./conf/nginx.conf /etc/nginx/sites-enabled/wordpress/nginx.conf

ENTRYPOINT [ "/usr/sbin/nginx", "-g", "daemon off;" ]
