CLI = docker
COMPOSE_FILE = srcs/docker-compose.yml

all :
	$(CLI) compose -f $(COMPOSE_FILE) up

stop :
