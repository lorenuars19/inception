# slimmed out version of debian buster > > GOTTA GO FAST > >
FROM debian:10.12-slim

# install NGINX from the official repository
RUN apt-get update \
&& apt-get -y install openssl curl gnupg2 ca-certificates lsb-release debian-archive-keyring \
&& curl https://nginx.org/keys/nginx_signing.key \
	| gpg --dearmor \
	| tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null \
	echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
		http://nginx.org/packages/debian `lsb_release -cs` nginx" \
    |  tee /etc/apt/sources.list.d/nginx.list \
&& apt update && apt install -y nginx

# Generate Self-signed certificates with openssl
RUN mkdir -p /nginx/ && mkdir -p /etc/nginx/ssl \
&& openssl req -x509 -subj="/C=BE/ST=Brussels/L=s19/O=19/CN=s19" -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/self.key -out /etc/nginx/ssl/self.csr \
&& openssl x509 -days 365 -in /etc/nginx/ssl/self.csr -signkey /etc/nginx/ssl/self.key -out /etc/nginx/ssl/self.crt


# Create nginx user and allow access to /nginx
RUN useradd -M -s /usr/sbin/nologin -u 42 --user-group nginx \
&& chown -R nginx. /etc/nginx

USER nginx

ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
