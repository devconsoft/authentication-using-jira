
CWDAPACHE_GIT_REPO := https://github.com/fgimian/cwdapache.git

.PHONY: cwdapache
cwdapache: $(BUILD)/libapache2-mod-auth-crowd.deb

.PHONY: $(BUILD)/libapache2-mod-auth-crowd.deb
$(BUILD)/libapache2-mod-auth-crowd.deb: $(BUILD_DIR)/docker.build.marker build_apache_plugin.sh | $(BUILD_DIR)
	$(Q)test -d cwdapache || git clone $(CWDAPACHE_GIT_REPO) cwdapache
	$(Q)zebra \
		--network $(DOCKER_NETWORK) \
		--image-override cwdapache --tag build \
		--no-registry \
		--no-pull \
		--root \
		exec /zebra/workspace/apache/build_apache_plugin.sh
	# We only want the deb-file.
	$(Q)cp libapache2-mod-auth-crowd_*.deb $(BUILD_DIR)/$@
	$(Q)rm -f libapache2-mod-auth-crowd*


.PHONY clean: clean.cwdapache

clean.cwdapache:
	$(Q){ cd cwdapache && git clean -d -f -x; } || true
	$(Q)rm -f $(BUILD_DIR)/libapache2-mod-auth-crowd.deb
