DOCKER = docker
DOCKERCP = $(DOCKER) compose
COMPOSE_FILE = srcs/docker-compose.yml

DOCKERCP += -f $(COMPOSE_FILE)

all :
	$(DOCKERCP) up

cp:
	-$(DOCKERCP) $(filter-out $@, $(MAKECMDGOALS))

nginx_build:
	$(DOCKER) build --progress tty -t nginxcont srcs/nginx

nginx_run:
	$(DOCKER) run -it -p 80:80 nginxcont /bin/zsh

ips:
	$(DOCKER) ps -aq
	$(DOCKER) inspect -f '{{.Name}} - {{.NetworkSettings.IPAddress }}' $(docker ps -aq)

php-wordpress:
	$(DOCKER) build srcs/$@

list :
	$(DOCKER) images

stop :
	$(DOCKER) stop $(shell docker images -q)

rm_all:
	$(DOCKER) image rm -f $(shell docker images -q)

clr:
	$(DOCKER) system prune -f
	$(DOCKER) image prune -f
	$(DOCKER) container prune -f
	$(DOCKER) builder prune -f
