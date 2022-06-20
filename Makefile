DOCKER = docker
DOCKERCP = $(DOCKER) compose
COMPOSE_FILE = srcs/docker-compose.yml
ENV_FILE = srcs/.env_config
SECR_ENV_FILE = srcs/.env_secret

LOG_FILE= .log

DOCKERCP += --project-directory ./srcs/ -f ./srcs/docker-compose.yml --env-file $(ENV_FILE)

SHELL=/bin/bash

all: set_password
	$(DOCKERCP) up

set_password:
	@if [[ -f $(SECR_ENV_FILE) ]];then export $$(cat $(SECR_ENV_FILE) | xargs); fi ;\
		while [[ -z "$${PASSWD}" ]] ;do \
			echo "Please Enter Password : "; read PASSWD; echo "PASSWD=$${PASSWD}" > $(SECR_ENV_FILE);\
			if [[ -f $(SECR_ENV_FILE) ]];then export $$(cat $(SECR_ENV_FILE) | xargs); fi; cat $(SECR_ENV_FILE);\
		done
	$(DOCKERCP) config > $(LOG_FILE)_dockercp_config

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

wordpress_build:
	$(DOCKER) build --progress tty -t wordpresscont srcs/wordpress

wordpress_run:
	$(DOCKER) run -it -v $$PWD:/home -p 443:443 wordpresscont /bin/zsh

ips:
	$(DOCKER) ps -a
	-if [[ ! -z $$(docker ps -aq) ]];then $(DOCKER) inspect -f '{{.Name}} - {{.NetworkSettings.IPAddress }}' $(shell docker ps -aq); fi

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
	$(DOCKER) volume prune -f
	$(DOCKER) container prune -f
	$(DOCKER) builder prune -f
