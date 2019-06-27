PRIVATE_IP := $(shell curl http://169.254.169.254/latest/meta-data/local-ipv4)
PUBLIC_HOSTNAME := $(shell curl http://169.254.169.254/latest/meta-data/public-hostname)
REGISTRY_USER?=testuser
REGISTRY_PASSWORD?=testpassword
CURRENT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

.PHONY: start-gitlab
start-gitlab:
	@sed -i -e 's#'"'"'http://<private_ip>'"'"'#'"'"'http://$(PRIVATE_IP)'"'"'#g' docker-compose.yml
	@docker-compose up -d
	@make start-registry
	@echo ==========================================================================
	@echo Gitlab login:
	@echo http://$(PUBLIC_HOSTNAME)
	@echo
	@echo Docker registry login:
	@echo docker login $(PUBLIC_HOSTNAME):5000
	@echo
	@echo Note: Gitlab may take a few minutes to spin up.
	@echo Keep reloading intermittently until the website is displayed.
	@echo ==========================================================================

.PHONY: start-registry
start-registry:
	@mkdir certs && mkdir auth
	@docker run --rm \
	--entrypoint htpasswd \
	registry:2 -Bbn $(REGISTRY_USER) $(REGISTRY_PASSWORD) > auth/htpasswd
	@openssl req \
	-newkey rsa:4096 -nodes -sha256 -keyout certs/domain.key \
	-subj "/CN=$(PUBLIC_HOSTNAME)" \
	-x509 -days 365 -out certs/domain.crt
	@sudo sh -c "echo '127.0.0.1   $(PUBLIC_HOSTNAME)' >> /etc/hosts"
	@sudo mkdir -p /etc/docker/certs.d/$(PUBLIC_HOSTNAME):5000
	@sudo cp certs/domain.crt /etc/docker/certs.d/$(PUBLIC_HOSTNAME)\:5000/ca.crt
	@docker run -d \
	-p 5000:5000 \
	--restart=always \
	--name registry \
	-v $(CURRENT_DIR)/auth:/auth \
	-e "REGISTRY_AUTH=htpasswd" \
	-e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm" \
	-e REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd \
	-v $(CURRENT_DIR)/certs:/certs \
	-e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/domain.crt \
	-e REGISTRY_HTTP_TLS_KEY=/certs/domain.key \
	registry:2

.PHONY: register-gitlab-runner
register-gitlab-runner:
	@echo Registering Gitlab runner...
	@docker exec -it gitlab-runner \
	gitlab-runner register -n \
	--url http://gitlab \
	--registration-token ${REGISTRATION_TOKEN} \
	--executor docker \
	--description "Gitlab Runner" \
	--docker-image "docker:stable" \
	--docker-privileged \
	--locked=false \
	> /dev/null;
