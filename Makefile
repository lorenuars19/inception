DOCKER = docker
DOCKERCP = $(DOCKER) compose
COMPOSE_FILE = srcs/docker-compose.yml

DOCKERCP += -f $(COMPOSE_FILE)

SHELL=/bin/bash

all :
	$(DOCKERCP) up

cp:
	-$(DOCKERCP) $(filter-out $@, $(MAKECMDGOALS))

nginx_build:
	$(DOCKER) build --progress tty -t nginxcont srcs/nginx

nginx_run:
	$(DOCKER) run -it -v $$PWD:/home -p 443:443 nginxcont /bin/zsh

database_build:
	$(DOCKER) build --progress tty -t databasecont srcs/database

database_run:
	$(DOCKER) run -it -v $$PWD:/home -p 443:443 databasecont /bin/zsh

ips:
	$(DOCKER) ps -a
	$(DOCKER) inspect -f '{{.Name}} - {{.NetworkSettings.IPAddress }}' $(shell docker ps -aq)

list :
	$(DOCKER) images

stop :
	$(DOCKER) stop $(shell docker images -q)

rm_all:
	-if [[ ! -z $$(docker ps -aq) ]];then $(DOCKER) stop $(shell docker ps -aq) ;fi
	-if [[ ! -z $$(docker images -q) ]];then $(DOCKER) image rm -f $(shell docker images -q) ;fi

clr: rm_all
	$(DOCKER) system prune -f
	$(DOCKER) image prune -f
	$(DOCKER) container prune -f
	$(DOCKER) builder prune -f
