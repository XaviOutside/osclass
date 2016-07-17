NAME=osclass

TERRAFORM_WORKDIR=$(shell echo $$TERRAFORM_HOME)

DOCKER=$(shell which docker)
DOCKER_AUTH=$(shell echo ~/.dockercfg)
DOCKERMACHINE=$(shell which docker-machine)
DOCKERCOMPOSE=$(shell which docker-compose)
DOCKERMACHINE_NAME=devenv-$(NAME)

# Set groups
osc: stop start

# Commands for docker-compose
start:
	$(DOCKERCOMPOSE) up -d
stop:
	$(DOCKERCOMPOSE) stop
rm:
	$(DOCKERCOMPOSE) rm -f
build:
	$(DOCKERCOMPOSE) build
logs:
	$(DOCKERCOMPOSE) logs
run:
	$(DOCKERCOMPOSE) run osclass bash
ssh:
	$(DOCKER) exec -it osclass_osclass_1 bash
clean:
	$(DOCKER) rmi $(docker images -f "dangling=true" -q)
	$(DOCKER) volume rm $(docker volume ls -qf "dangling=true")
import:
	tar -cf - migration | docker exec -i osclass_osclass_1 /bin/tar -C / -xf -
	docker exec -t osclass_osclass_1 bash /osclass_init.sh

# Commands for docker-machine
dmstart:
	$(DOCKERMACHINE) start $(DOCKERMACHINE_NAME) && \
	eval $$($(DOCKERMACHINE) env $(DOCKERMACHINE_NAME))
dmstop:
	$(DOCKERMACHINE) stop $(DOCKERMACHINE_NAME)
dmcreate:
	$(DOCKERMACHINE) create -driver virtualbox --virtualbox-memory "1024" $(DOCKERMACHINE_NAME) && \
	eval $$($(DOCKERMACHINE) env $(DOCKERMACHINE_NAME))
	$(DOCKERMACHINE) env $(DOCKERMACHINE_NAME)
dmdestroy:
	$(DOCKERMACHINE) rm $(DOCKERMACHINE_NAME)
