
DOCKER_BUILD_IMAGE := cwdapache:build
DOCKER_DEPLOY_IMAGE := cwdapache:deploy
DOCKER_NETWORK ?= host


# CROWD PLUGIN
# ------------

.PHONY: build-image
build-image: $(BUILD_DIR)/docker.build.marker

$(BUILD_DIR)/docker.build.marker: docker/build.DockerFile | $(BUILD_DIR)
	$(Q)docker build --network $(DOCKER_NETWORK) -f docker/build.DockerFile --tag $(DOCKER_BUILD_IMAGE) .
	touch $(@)

.PHONY clean: clean.docker.build
clean.docker.build:
	$(Q)rm -rf $(BUILD_DIR)/docker.build.marker

.PHONY purge: purge.docker.build
purge.docker.build:
	$(Q)docker rmi --force $(DOCKER_BUILD_IMAGE)


# APACHE SERVER
# -------------

.PHONY: deploy-image
deploy-image: $(BUILD_DIR)/docker.deploy.marker

$(BUILD_DIR)/docker.deploy.marker: docker/deploy.DockerFile apache2.conf | $(BUILD_DIR)
	$(Q)docker build --network $(DOCKER_NETWORK) -f docker/deploy.DockerFile --tag $(DOCKER_DEPLOY_IMAGE) .
	touch $(@)

.PHONY clean: clean.docker.deploy
clean.docker.deploy:
	$(Q)rm -rf $(BUILD_DIR)/docker.deploy.marker

.PHONY purge: purge.docker.deploy
purge.docker.deploy:
	$(Q)docker rmi --force $(DOCKER_DEPLOY_IMAGE)
