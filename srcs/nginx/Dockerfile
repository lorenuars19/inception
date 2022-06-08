# slimmed out version of debian buster > > GOTTA GO FAST > >
FROM debian:10.12-slim

# install NGINX from the official repository
RUN apt-get update \
&& apt-get -y install openssl nginx

# Generate Self-signed certificates with openssl
RUN mkdir -p /nginx/ && mkdir -p /etc/nginx/ssl \
&& openssl req -x509 -subj="/C=BE/ST=Brussels/L=s19/O=19/CN=s19" -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/self.key -out /etc/nginx/ssl/self.csr \
&& openssl x509 -days 365 -in /etc/nginx/ssl/self.csr -signkey /etc/nginx/ssl/self.key -out /etc/nginx/ssl/self.crt

CMD [ "/usr/sbin/nginx", "-g", "daemon off;" ]
