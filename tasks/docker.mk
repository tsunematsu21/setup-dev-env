DOCKER_GPG_DIR		:=	/etc/apt/keyrings
DOCKER_GPG				:=	$(DOCKER_GPG_DIR)/docker.gpg
DOCKER_LIST				:=	/etc/apt/sources.list.d/docker.list
DOCKER_GPG_PKGS		:=	ca-certificates curl gnupg lsb-release
DOCKER_OLD_PKGS		:=	docker docker-engine docker.io containerd runc
DOCKER_PKGS				:=	docker-ce docker-ce-cli containerd.io docker-compose-plugin

docker: install/docker ## Install docker and compose plugin

install:: install/docker
uninstall:: uninstall/docker
version:: version/docker

install/docker: common
ifeq ("$(wildcard $(DOCKER_GPG))","")
	echo '[$@] create $(DOCKER_GPG)...'
	sudo apt-get -y install $(DOCKER_GPG_PKGS) > /dev/null
	sudo mkdir -p $(DOCKER_GPG_DIR)
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o $(DOCKER_GPG)
endif

	echo '[$@] create $(DOCKER_LIST)...'
	echo \
		"deb [arch=$$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
		$$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

	echo '[$@] remove old packages...'
	sudo apt-get -y remove $(DOCKER_OLD_PKGS) > /dev/null

	echo '[$@] install packages...'
	sudo apt-get -y install $(DOCKER_PKGS) > /dev/null

	echo '[$@] add $(USER) to docker group...'
	getent group docker > /dev/null || sudo groupadd docker
	sudo usermod -aG docker $$USER

	echo '[$@] start docker service...'
	sudo service docker start > /dev/null || true

uninstall/docker:
	echo '[$@] purge packages...'
	sudo apt-get -y purge $(DOCKER_PKGS) > /dev/null

	echo '[$@] remove container image directories...'
	sudo rm -rf /var/lib/docker
	sudo rm -rf /var/lib/containerd

version/docker:
ifeq ($(shell command -v docker),)
	echo [docker] not installed
else
	echo [docker]
	echo "  docker client  : $$(docker version --format '{{.Client.Version}}')"
	echo "  docker server  : $$(docker version --format '{{.Server.Version}}')"
	echo "  docker compose : $$(docker compose version --short)"
endif
