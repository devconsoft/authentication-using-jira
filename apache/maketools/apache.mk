
.PHONY: run
run: $(BUILD_DIR)/docker.deploy.marker $(BUILD_DIR)/libapache2-mod-auth-crowd.deb
	$(Q)docker run \
		--network $(DOCKER_NETWORK) \
		--rm \
		--name apache-container \
		-e APPLICATION_NAME=$(APPLICATION_NAME) \
		-e APPLICATION_PASSWORD=$(APPLICATION_PASSWORD) \
		-e JIRA_SERVER=$(JIRA_SERVER) \
		-e JIRA_GROUP=$(JIRA_GROUP) \
		cwdapache:deploy

.PHONY: stop
stop:
	$(Q)docker stop apache-container || true

.PHONY: shell
shell:
	$(Q)docker exec -it apache-container /bin/bash
