DOCKER = docker
DOCKERCP = $(DOCKER) compose
COMPOSE_FILE = srcs/docker-compose.yml

DOCKERCP += -f $(COMPOSE_FILE)

all :
	$(DOCKERCP) up

cp:
	$(DOCKERCP) $(filter-out $@, $(MAKECMDGOALS))

nginx:
	$(DOCKER) build srcs/$@

php-wordpress:
	$(DOCKER) build srcs/$@

list :
	$(DOCKER) images

stop :
	$(DOCKER) stop $$($(DOCKER) images -q)

rm_all:
	$(DOCKER) image rm -f $$($(CLI) images -q)
